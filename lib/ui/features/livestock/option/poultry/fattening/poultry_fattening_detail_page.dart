import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_tracking.dart';
import 'package:amca/ui/features/costs_expenses/livestock/poultry/costs_expenses_poultry_list_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/fattening/add_poultry_tracking_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/fattening/poultry_fattening_detail_vm.dart';
import 'package:amca/ui/features/charts_cost_expenses/widgets/chart_card.dart';
import 'package:amca/ui/features/charts_cost_expenses/widgets/chart_card_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PoultryFatteningDetailPage extends StatelessWidget {
  static ChangeNotifierProvider<PoultryFatteningDetailVM> create({
    Key? key,
    required String batchId,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (_) => PoultryFatteningDetailVM(batchId)..init(),
        child: PoultryFatteningDetailPage._(key: key, batchId: batchId),
      );

  const PoultryFatteningDetailPage._({
    super.key,
    required this.batchId,
  });

  final String batchId;

  @override
  Widget build(BuildContext context) {
    return Consumer<PoultryFatteningDetailVM>(
      builder: (context, vm, _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(vm.batch?.batchName ?? AmcaWords.tracking),
              backgroundColor: AmcaPalette.lightGreen,
              bottom: const TabBar(
                tabs: [
                  Tab(text: AmcaWords.tracking),
                  Tab(text: AmcaWords.chart),
                ],
                indicatorColor: Colors.white,
              ),
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      _buildTrackingList(context, vm),
                      _buildCharts(vm),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildTrackingList(
    BuildContext context,
    PoultryFatteningDetailVM vm,
  ) {
    final tracking = vm.batch?.tracking ?? [];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.attach_money),
              label: const Text(AmcaWords.costsAndExpenses),
              style: ElevatedButton.styleFrom(
                backgroundColor: AmcaPalette.lightGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CostsExpensesPoultryListPage.create(batchId: batchId),
                  ),
                ).then((value) async {
                  if (value != null && value is bool && value) {
                    await vm.init();
                  }
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text(AmcaWords.addWeeklyRecord),
              style: ElevatedButton.styleFrom(
                backgroundColor: AmcaPalette.lightGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPoultryTrackingPage.create(batchId: batchId),
                  ),
                ).then((value) async {
                  if (value != null && value is bool && value) {
                    await vm.init();
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: tracking.isEmpty
              ? const Center(child: Text(AmcaWords.buildingThis))
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                  itemCount: tracking.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final track = tracking[index];
                    return ListTile(
                      title: Text(
                        '${AmcaWords.week} ${track.weekNumber} - ${DateFormat('dd/MM/yyyy').format(track.recordDate)}',
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          if (track.finalAverageWeight != null)
                            Text(
                              '${AmcaWords.finalAverageWeight}: ${track.finalAverageWeight} ${AmcaWords.kG}',
                            ),
                          Text(
                            '${AmcaWords.feedConsumed}: ${track.feedConsumed} ${AmcaWords.kG}',
                          ),
                          Text('${AmcaWords.mortality}: ${track.mortality}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.grey),
                            onPressed: () {
                              _showEditTrackingDialog(context, vm, track);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              Dialogs.showSuccessDialogWithOptions(
                                context,
                                AmcaWords.areYouSureToDeleteThisCostOrExpense,
                                onTap: () async {
                                  await CallsWithDialogs.call(context,
                                      () async {
                                    await vm.deleteTracking(track.id ?? '');
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showEditTrackingDialog(
    BuildContext context,
    PoultryFatteningDetailVM vm,
    PoultryFatteningTracking track,
  ) {
    final dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(track.recordDate));
    final weightController =
        TextEditingController(text: track.finalAverageWeight?.toString() ?? '');
    final feedController =
        TextEditingController(text: track.feedConsumed.toString());
    final mortalityController =
        TextEditingController(text: track.mortality.toString());

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${AmcaWords.edit} ${AmcaWords.week} ${track.weekNumber}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: AmcaWords.date),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText:
                        '${AmcaWords.finalAverageWeight} (${AmcaWords.kG})',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: feedController,
                  decoration: InputDecoration(
                    labelText: '${AmcaWords.feedConsumed} (${AmcaWords.kG})',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: mortalityController,
                  decoration:
                      const InputDecoration(labelText: AmcaWords.mortality),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(AmcaWords.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                final recordDate =
                    DateFormat('yyyy-MM-dd').parse(dateController.text);
                final feedConsumed =
                    double.tryParse(feedController.text) ?? track.feedConsumed;
                final mortality =
                    int.tryParse(mortalityController.text) ?? track.mortality;
                final finalAverageWeight = weightController.text.isEmpty
                    ? null
                    : double.tryParse(weightController.text);

                await CallsWithDialogs.call(context, () async {
                  await vm.saveTracking(
                    track.copyWith(
                      recordDate: recordDate,
                      feedConsumed: feedConsumed,
                      mortality: mortality,
                      finalAverageWeight: finalAverageWeight,
                    ),
                  );
                });

                if (!context.mounted) return;
                Navigator.pop(context);
              },
              child: const Text(AmcaWords.update),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCharts(PoultryFatteningDetailVM vm) {
    final tracking = vm.batch?.tracking ?? [];
    final weightSpots = _weightSpots(
      vm.batch?.averageWeight ?? 0,
      tracking,
    );
    if (tracking.isEmpty) {
      return const Center(
        child: Text(AmcaWords.buildingThis),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        ChartCard(
          title: AmcaWords.averageWeight,
          dateSelected: (_) {},
          child: weightSpots.length < 2
              ? const Center(child: Text(AmcaWords.finalizationChartDataPending))
              : LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: _maxSpotX(weightSpots),
                    minY: 0,
                    lineBarsData: [
                      LineChartBarData(
                        spots: weightSpots,
                        isCurved: true,
                        color: AmcaPalette.lightGreen,
                        barWidth: 3,
                        dotData: FlDotData(show: true),
                      ),
                    ],
                    gridData: const FlGridData(show: true),
                    titlesData: const FlTitlesData(
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true),
                  ),
                ),
        ),
        ChartCard(
          title: AmcaWords.feedConsumed,
          dateSelectedType: DateSelectedType.semester,
          dateSelected: (_) {},
          child: BarChart(
            BarChartData(
              barGroups: _feedBarGroups(tracking),
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
        ChartCard(
          title: AmcaWords.mortality,
          dateSelectedType: DateSelectedType.semester,
          dateSelected: (_) {},
          child: BarChart(
            BarChartData(
              barGroups: _mortalityBarGroups(tracking),
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _weightSpots(
    double initialAverageWeight,
    List<PoultryFatteningTracking> tracking,
  ) {
    final spots = <FlSpot>[];
    if (initialAverageWeight > 0) {
      spots.add(FlSpot(0, initialAverageWeight));
    }
    spots.addAll(
      tracking
          .where((item) => item.finalAverageWeight != null)
          .map(
            (item) => FlSpot(
              item.weekNumber.toDouble(),
              (item.finalAverageWeight ?? 0).toDouble(),
            ),
          ),
    );
    return spots..sort((a, b) => a.x.compareTo(b.x));
  }

  double _maxSpotX(List<FlSpot> spots) {
    var maxX = 0.0;
    for (final spot in spots) {
      if (spot.x > maxX) {
        maxX = spot.x;
      }
    }
    return maxX == 0 ? 1 : maxX;
  }

  List<BarChartGroupData> _feedBarGroups(
    List<PoultryFatteningTracking> tracking,
  ) {
    return tracking
        .map(
          (item) => BarChartGroupData(
            x: item.weekNumber,
            barRods: [
              BarChartRodData(
                toY: item.feedConsumed.toDouble(),
                width: 14,
                borderRadius: BorderRadius.circular(4),
                color: AmcaPalette.lightGreen,
              ),
            ],
          ),
        )
        .toList();
  }

  List<BarChartGroupData> _mortalityBarGroups(
    List<PoultryFatteningTracking> tracking,
  ) {
    return tracking
        .map(
          (item) => BarChartGroupData(
            x: item.weekNumber,
            barRods: [
              BarChartRodData(
                toY: item.mortality.toDouble(),
                width: 14,
                borderRadius: BorderRadius.circular(4),
                color: AmcaPalette.lightGreen,
              ),
            ],
          ),
        )
        .toList();
  }
}
