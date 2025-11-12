import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_select_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_area_productions_vm.dart';

/// Pantalla base para reportes por área/municipio.
class AllAreaProductionsPage extends StatelessWidget {
  const AllAreaProductionsPage._({super.key, required this.ownerId});

  /// Fábrica para crear el provider y la pantalla.
  static ChangeNotifierProvider<AllAreaProductionsVm> create({
    Key? key,
    required String ownerId,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => AllAreaProductionsVm(ownerId: ownerId)..init(),
        child: AllAreaProductionsPage._(key: key, ownerId: ownerId),
      );

  final String ownerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte por municipio'),
      ),
      body: Consumer<AllAreaProductionsVm>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Propietario: $ownerId',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                // Departamento (filtro para limitar ciudades)
                AmcaSelectFormField(
                  labelText: 'Departamento',
                  textEditingController: vm.departmentController,
                  options: vm.departments,
                  optionSelected: (d) => vm.selectDepartment(d),
                ),
                const SizedBox(height: 12),

                // Ciudad (dropdown principal recuperada a partir del departamento seleccionado)
                AmcaSelectFormField(
                  labelText: 'Ciudad',
                  textEditingController: vm.cityController,
                  options: vm.cities,
                  optionSelected: (c) => vm.selectCity(c),
                ),
                const SizedBox(height: 12),

                // Filtro por tipo de producto
                AmcaSelectFormField(
                  labelText: 'Tipo de producto',
                  textEditingController: vm.productTypeController,
                  options: vm.productTypes,
                  optionSelected: (p) => vm.selectProductType(p),
                ),
                const SizedBox(height: 16),

                // Botón para refrescar métricas
                AmcaButton(
                  text: 'Refrescar métricas',
                  onPressed: () => vm.loadMetrics(),
                ),

                const SizedBox(height: 16),

                // Muestra de métricas según tipo
                Expanded(
                  child: _MetricsArea(vm: vm),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MetricsArea extends StatelessWidget {
  const _MetricsArea({required this.vm});

  final AllAreaProductionsVm vm;

  @override
  Widget build(BuildContext context) {
    if (vm.metrics.isEmpty) {
      return const Center(child: Text('No hay métricas para mostrar')); 
    }

    final type = vm.selectedProductType ?? '';

    if (type == 'Agrícola') {
      final area = vm.metrics['areaSembrada'] ?? 0.0;
      return ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text('Área sembrada'),
              subtitle: Text('$area ha'),
            ),
          ),
        ],
      );
    }

    if (type == 'Piscicultura') {
      final num = vm.metrics['numPorMunicipio'] ?? 0;
      final area = vm.metrics['areaTotalProduccion'] ?? 0.0;
      return ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text('Número (pisciculturas / unidades)'),
              subtitle: Text('$num'),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Área total de producción'),
              subtitle: Text('$area ha'),
            ),
          ),
        ],
      );
    }

    // Ganadería: lechera, porcicola, cárnicos
    final numAnimales = vm.metrics['numAnimales'] ?? 0;
    final areaTotal = vm.metrics['areaTotalProduccion'] ?? 0.0;
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: const Text('Número de animales por municipio'),
            subtitle: Text('$numAnimales'),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Área total de producción por municipio'),
            subtitle: Text('$areaTotal ha'),
          ),
        ),
      ],
    );
  }
}
