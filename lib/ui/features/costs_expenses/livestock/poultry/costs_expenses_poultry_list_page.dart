/// {@category Features CostExpense}
/// UI-only list page for poultry (broiler) costs and expenses.
library;

import 'package:amca/ui/features/costs_expenses/livestock/poultry/manage/manage_poultry_cost_expense_page.dart';
import 'package:amca/ui/features/costs_expenses/livestock/poultry/poultry_costs_expenses_list_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CostsExpensesPoultryListPage extends StatelessWidget {
  static ChangeNotifierProvider<PoultryCostsExpensesListVM> create({
    Key? key,
    required String batchId,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (_) => PoultryCostsExpensesListVM(batchId: batchId)..init(),
        child: CostsExpensesPoultryListPage._(key: key),
      );

  const CostsExpensesPoultryListPage._({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.costsAndExpenses),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<PoultryCostsExpensesListVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.costsAndExpenses.isEmpty) {
            return _buildEmptyState(context, vm);
          }

          return RefreshIndicator(
            onRefresh: vm.init,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: vm.costsAndExpenses.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = vm.costsAndExpenses[index];
                return ListTile(
                  title: Text(
                    '${item.productOrService} - ${item.description}',
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.costOrExpense}: \$${item.price}',
                        ),
                      ),
                      Text(DateFormat('yyyy-MM-dd').format(item.recordDate)),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ManagePoultryCostExpensePage.create(
                          batchId: vm.batchId,
                          costExpense: item,
                        ),
                      ),
                    ).then((value) async {
                      if (value != null && value is bool && value) {
                        await vm.init();
                      }
                    });
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Consumer<PoultryCostsExpensesListVM>(
        builder: (context, vm, _) {
          if (vm.costsAndExpenses.isEmpty) {
            return const SizedBox.shrink();
          }
          return FloatingActionButton(
            tooltip: AmcaWords.addCostOrExpense,
            backgroundColor: AmcaPalette.lightGreen,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManagePoultryCostExpensePage.create(
                    batchId: vm.batchId,
                  ),
                ),
              ).then((value) async {
                if (value != null && value is bool && value) {
                  await vm.init();
                }
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    PoultryCostsExpensesListVM vm,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AmcaWords.costsAndExpensesHaveNotBeenCreated,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            AmcaButton(
              text: AmcaWords.addCostOrExpense,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManagePoultryCostExpensePage.create(
                      batchId: vm.batchId,
                    ),
                  ),
                ).then((value) async {
                  if (value != null && value is bool && value) {
                    await vm.init();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
