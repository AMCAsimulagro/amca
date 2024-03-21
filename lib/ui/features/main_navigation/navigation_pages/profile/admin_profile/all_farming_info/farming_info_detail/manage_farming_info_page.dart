/// {@category Menu farming info}

import 'dart:developer';

import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_farming_info/farming_info_detail/manage_farming_info_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageFarmingInfoPage extends StatefulWidget {
  static ChangeNotifierProvider<ManageFarmingInfoVM> create({
    Key? key,
    CropTypes? cropType,
    required List<CropTypes> allCropTypes,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ManageFarmingInfoVM(),
        child: ManageFarmingInfoPage._(
          key: key,
          cropType: cropType,
          allCropTypes: allCropTypes,
        ),
      );

  const ManageFarmingInfoPage._({
    super.key,
    required this.cropType,
    required this.allCropTypes,
  });

  final CropTypes? cropType;
  final List<CropTypes> allCropTypes;

  @override
  State<ManageFarmingInfoPage> createState() => _ManageFarmingInfoPageState();
}

class _ManageFarmingInfoPageState extends State<ManageFarmingInfoPage> {
  late final bool isEditMode;
  final _formKey = GlobalKey<FormState>();
  final _cropNameController = TextEditingController();

  @override
  void initState() {
    isEditMode = widget.cropType != null;
    _preloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? AmcaWords.editCropType : AmcaWords.cropType),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<ManageFarmingInfoVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 20.0,
                right: 16.0,
                left: 16.0,
                bottom: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AmcaTextFormField(
                    textEditingController: _cropNameController,
                    textInputType: TextInputType.text,
                    labelText: AmcaWords.cropType,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleaseAddCropType;
                      }
                      if (isEditMode &&
                          vm.cropAlreadyExist(widget.allCropTypes, value ?? '',
                              widget.cropType!)) {
                        return 'Este tipo de cultivo ya existe';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (vm.crops.isEmpty)
                    const Text(
                        'Aun no has agregado ningun cultivo, dale en el botón de + para agregar uno'),
                  Column(
                    children: vm.crops
                        .map(
                          (e) => ListTile(
                            title: Text(e),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.edit,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                InkWell(
                                  onTap: () {
                                    Dialogs.showSuccessDialogWithOptions(
                                        context,
                                        '¿Deseas eliminar este cultivo?',
                                        onTap: () {
                                      vm.deleteCrop(e);
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              _showCropDialog(
                                context,
                                value: e,
                                isEdit: true,
                              );
                            },
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AmcaWords.addCrop,
        onPressed: () {
          _showCropDialog(
            context,
          );
        },
        backgroundColor: AmcaPalette.lightGreen,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AmcaButton(
                text: isEditMode ? AmcaWords.update : AmcaWords.createCropType,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createCropType();
                  }
                },
              ),
              if (isEditMode)
                AmcaButton(
                  text: AmcaWords.delete,
                  type: AmcaButtonType.destroy,
                  onPressed: () {
                    Dialogs.showSuccessDialogWithOptions(
                        context, '¿Deseas eliminar este tipo de cultivo?',
                        onTap: () async {
                      await deleteCropType();
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCropDialog(
    BuildContext context, {
    String? value,
    bool isEdit = false,
  }) {
    final manageVM = Provider.of<ManageFarmingInfoVM>(
      context,
      listen: false,
    );
    Dialogs.showSuccessDialogWithTextField(
        context,
        title: isEdit ? 'Editar cultivo' : 'Agregar cultivo',
        'Cultivo',
        value: value, onTap: (cultivo) {
      if (cultivo.isNotEmpty) {
        if (!isEdit) {
          manageVM.addCrop(cultivo);
          return;
        }
        manageVM.replaceValue(value ?? '', cultivo);
      }
    }, validator: (value) {
      if (value != null && value.isEmpty) {
        return AmcaWords.pleaseAddCropType;
      }
      if (manageVM.validateCrop(value ?? '')) {
        return 'Este cultivo ya existe';
      }
      return null;
    });
  }

  Future<void> deleteCropType() async {
    final manageVM = Provider.of<ManageFarmingInfoVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.deleteCropType(widget.cropType);
        await Dialogs.showSuccessDialogWithMessage(
          context,
          AmcaWords.yourCropTypeHasBeenDeleted,
        );
        Navigator.pop(context);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void _preloadData() {
    if (isEditMode) {
      final manageVM = Provider.of<ManageFarmingInfoVM>(
        context,
        listen: false,
      );
      final cropType = widget.cropType;
      _cropNameController.text = cropType?.tipo ?? '';
      manageVM.crops.addAll(cropType?.cultivo ?? []);
    }
  }

  Future<void> createCropType() async {
    final manageVM = Provider.of<ManageFarmingInfoVM>(
      context,
      listen: false,
    );
    try {
      if (manageVM.crops.isEmpty) {
        Dialogs.showErrorDialogWithMessage(
            context, 'No puedes crear un tipo de cultivo sin cultivos');
      } else {
        await CallsWithDialogs.call(context, () async {
          final cropType = CropTypes(
              id: widget.cropType?.id,
              cultivo: manageVM.crops,
              tipo: _cropNameController.text);
          await manageVM.createCropType(cropType);
          await Dialogs.showSuccessDialogWithMessage(
            context,
            isEditMode
                ? AmcaWords.yourCropTypeHasBeenUpdated
                : AmcaWords.yourCropTypeHasBeenCreated,
          );
          Navigator.pop(context);
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
