/// {@category Menu fishes admin}
library;

import 'dart:developer';

import 'package:amca/domain/model/livestock/fish_husbandry/fish_type.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/fishes_admin/fishes_admin_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/dialogs.dart';
// imports kept minimal for this page
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FishesAdminPage extends StatelessWidget {
  static ChangeNotifierProvider<FishesAdminVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => FishesAdminVM()..init(),
        child: FishesAdminPage._(key: key),
      );

  const FishesAdminPage._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar especies piscicolas'),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<FishesAdminVM>(builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (vm.fishes.isEmpty) {
          return const Center(child: Text('Aún no hay especies registradas'));
        }
        return RefreshIndicator(
          onRefresh: () async => vm.init(),
          child: ListView.separated(
            itemCount: vm.fishes.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final fish = vm.fishes[index];
              return ListTile(
                title: Text(fish.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showFishDialog(context, vm, fish: fish);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        Dialogs.showSuccessDialogWithOptions(
                          context,
                          '¿Deseas eliminar esta especie?',
                          onTap: () async {
                            try {
                              await vm.deleteFishType(fish);
                            } catch (e) {
                              log(e.toString());
                              await Dialogs.showErrorDialogWithMessage(context, 'No se pudo eliminar la especie');
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
                onTap: () => _showFishDialog(context, vm, fish: fish),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar especie',
        onPressed: () => _showFishDialog(context, Provider.of<FishesAdminVM>(context, listen: false)),
        backgroundColor: AmcaPalette.lightGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showFishDialog(BuildContext context, FishesAdminVM vm, {FishType? fish}) {
    final isEdit = fish != null;
    // Mostrar un diálogo modal centrado (no bottom sheet). Gestionamos un indicador
    // de guardado local para no usar el diálogo de carga global de la app desde aquí.
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        final controller = TextEditingController(text: fish?.name ?? '');
        final formKey = GlobalKey<FormState>();
        bool isSaving = false;
        return StatefulBuilder(builder: (ctx2, setState) {
          return AlertDialog(
            title: Text(isEdit ? 'Editar especie' : 'Agregar especie'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: controller,
                      maxLength: 30,
                      decoration: const InputDecoration(labelText: 'Especie'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Por favor ingresa el nombre de la especie';
                        final val = value.trim();
                        if (isEdit) {
                          final existing = fish.name;
                          if (val.toLowerCase() == existing.trim().toLowerCase()) return null;
                        }
                        if (vm.validateFish(val)) return 'Esta especie ya existe';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (isSaving)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar'),
                onPressed: isSaving ? null : () => Navigator.of(ctx2).pop(),
              ),
              ElevatedButton(
                child: const Text('Guardar'),
                onPressed: isSaving
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;
                        final value = controller.text.trim();
                        try {
                          setState(() => isSaving = true);
                          await vm.createFishType(FishType(id: fish?.id, name: value));
                          // cerramos el diálogo localmente después de la operación
                          Navigator.of(ctx2).pop();
                        } catch (e) {
                          log(e.toString());
                          // mostramos un mensaje de error usando el helper de diálogos
                          await Dialogs.showErrorDialogWithMessage(context, 'No se pudo guardar la especie');
                        } finally {
                          // aseguramos que el indicador local se quite si el diálogo sigue abierto
                          try {
                            setState(() => isSaving = false);
                          } catch (_) {}
                        }
                      },
              ),
            ],
          );
        });
      },
    );
  }
}
