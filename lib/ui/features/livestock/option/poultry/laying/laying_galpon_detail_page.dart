/// {@category Features Poultry Laying}
/// Detail view for a laying galpon with daily records.
library;

import 'package:amca/domain/model/livestock/poultry_laying/laying_daily_record.dart';
import 'package:amca/domain/model/livestock/poultry_laying/laying_galpon.dart';
import 'package:amca/ui/features/livestock/option/poultry/laying/laying_daily_record_form.dart';
import 'package:amca/ui/features/livestock/option/poultry/laying/laying_galpon_detail_vm.dart';
import 'dart:math' as math;

import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayingGalponDetailPage extends StatelessWidget {
  const LayingGalponDetailPage._({super.key});

  static Route<void> createRoute({required LayingGalpon galpon}) {
    return MaterialPageRoute<void>(
      builder: (_) => ChangeNotifierProvider(
        lazy: false,
        create: (_) => LayingGalponDetailVM(galpon),
        child: LayingGalponDetailPage._(
          key: ValueKey(galpon.id ?? galpon.name),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LayingGalponDetailVM>(
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(vm.galpon.name),
            backgroundColor: AmcaPalette.lightGreen,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildEfficiencyBoard(vm),
                const SizedBox(height: 12),
                _buildStateActionRow(vm, context),
                const SizedBox(height: 24),
                _buildProductionChart(vm),
                const SizedBox(height: 24),
                if (vm.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      vm.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                Text(
                  AmcaWords.layingDailyRecord,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        LayingDailyRecordForm(
                          key: ValueKey(vm.editingRecord?.id ?? 'new-record'),
                          galponId: vm.galpon.id ?? vm.galpon.name,
                          recordDate: DateTime.now(),
                          initialRecord: vm.editingRecord,
                          onSaved: (record) async {
                            await CallsWithDialogs.call(context, () async {
                              await vm.saveRecord(record.copyWith(
                                galponId: vm.galpon.id ?? vm.galpon.name,
                                date: record.date,
                              ));
                            });
                            await Dialogs.showSuccessDialogWithMessage(
                              context,
                              AmcaWords.recordSavedSuccess,
                            );
                          },
                        ),
                        if (vm.editingRecord != null)
                          TextButton(
                            onPressed: vm.clearEditing,
                            child: const Text('Cancelar edición'),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Historial',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 12),
                if (vm.records.isEmpty)
                  const Center(child: Text('Sin registros aún'))
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vm.records.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final record = vm.records[index];
                      return _buildRecordCard(context, vm, record);
                    },
                  ),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecordCard(BuildContext context, LayingGalponDetailVM vm,
      LayingDailyRecord record) {
    final totalProduction = record.totalProduction;
    return Card(
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          '${record.date.day.toString().padLeft(2, '0')}/${record.date.month.toString().padLeft(2, '0')}/${record.date.year}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Producción total: $totalProduction huevos'),
            Text('Rotoss: ${record.brokenEggs}, sucios: ${record.dirtyEggs}'),
            Text('Alimento: ${record.foodConsumedKg} Kg, Mortalidad: ${record.mortality} aves'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey),
          onPressed: () => vm.selectRecord(record),
        ),
      ),
    );
  }

  Widget _buildEfficiencyBoard(LayingGalponDetailVM vm) {
    return Row(
      children: [
        _buildEfficiencyCard(
          label: 'Producción día',
          value: '${vm.totalProductionToday} huevos',
          accent: AmcaPalette.lightGreen,
        ),
        const SizedBox(width: 10),
        _buildEfficiencyCard(
          label: 'Postura',
          value: '${vm.posturePercentage.toStringAsFixed(1)}%',
          accent: Colors.orange,
        ),
        const SizedBox(width: 10),
        _buildEfficiencyCard(
          label: 'Censo vivo',
          value: '${vm.currentCensus} aves',
          accent: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildEfficiencyCard({
    required String label,
    required String value,
    required Color accent,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: accent.withOpacity(0.9))),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProductionChart(LayingGalponDetailVM vm) {
    final history = vm.records.take(7).toList().reversed.toList();
    if (history.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AmcaPalette.lightGreen.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Registra producción para ver la gráfica'),
      );
    }
    final maxProduction = history
        .map((record) => record.totalProduction)
        .fold<int>(0, (prev, value) => math.max(prev, value));
    const chartHeight = 110.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Tendencia de producción',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              SizedBox(
                height: chartHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: history.map((record) {
                    final production = record.totalProduction;
                    final normalized = maxProduction > 0
                        ? production / maxProduction
                        : 0.0;
                    final barHeight = normalized * chartHeight;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: barHeight + 8,
                            decoration: BoxDecoration(
                              color: AmcaPalette.lightGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: history.map((record) {
                      return Text(
                        '${record.date.day.toString().padLeft(2, '0')}/${record.date.month.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 12),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Huevos por día',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Max ${maxProduction} huevos',
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStateActionRow(LayingGalponDetailVM vm, BuildContext context) {
    final isActive = vm.galpon.state == LayingGalponState.active;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estado',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Chip(
                backgroundColor:
                    isActive ? AmcaPalette.lightGreen : Colors.orange.shade200,
                label: Text(
                  isActive ? AmcaWords.galponStateActive : AmcaWords.galponStateFinalized,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isActive ? AmcaPalette.darkGreen : Colors.orange.shade700,
            ),
            onPressed: () async {
              await CallsWithDialogs.call(context, () async {
                if (isActive) {
                  await vm.finalizeGalpon();
                } else {
                  await vm.reactivateGalpon();
                }
              });
              await Dialogs.showSuccessDialogWithMessage(
                context,
                isActive
                    ? AmcaWords.galponFinalizedSuccess
                    : AmcaWords.galponReactivatedSuccess,
              );
            },
            child: Text(isActive
                ? AmcaWords.finalizeGalpon
                : AmcaWords.reactivateGalpon),
          ),
        ],
      ),
    );
  }
}
