/// {@category Features CostExpense}
/// This file contains the implementation of the [CostsExpensesListPage] widget,
/// which displays a list of costs and expenses related to farming activities.
/// It allows users to view, add, and manage their costs and expenses.
/// This page utilizes [ChangeNotifierProvider] to manage the state using [CostsExpensesListVM].
/// It also includes UI elements such as buttons and a floating action button.
library;

/// Imports of Bookstores and Resources
import 'package:amca/ui/features/costs_expenses/livestock/pigfarmig/costs_expenses_pigfarming_list_vm.dart';
import 'package:amca/ui/features/costs_expenses/livestock/pigfarmig/manage/manage_meat_pigfarming_cost_expense_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// This class displays a list of costs and expenses related to agricultural activities.
class CostsExpensesListPage extends StatelessWidget {
  static ChangeNotifierProvider<CostsExpensesListVM> create(
          {Key? key, required String farmingId}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => CostsExpensesListVM(farmingId: farmingId)..init(),
        child: CostsExpensesListPage._(
          key: key,
        ),
      );

  const CostsExpensesListPage._({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.costsAndExpenses),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<CostsExpensesListVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (vm.costsAndExpenses.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await vm.init();
              },
              child: ListView.separated(
                itemCount: vm.costsAndExpenses.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  final costAndExpenseItem = vm.costsAndExpenses[index];
                  return ListTile(
                    title: Text(
                        '${costAndExpenseItem.productOrService} - ${costAndExpenseItem.description.description}'),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Text(
                              '${costAndExpenseItem.description.costOrExpense}: \$${costAndExpenseItem.price}'),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd')
                              .format(costAndExpenseItem.createDate),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ManageCostExpensePage.create(
                            farmingId: vm.farmingId!,
                            costAndExpense: costAndExpenseItem,
                          ),
                        ),
                      ).then(
                        (value) async {
                          if (value != null && (value as bool)) {
                            await vm.init();
                          }
                        },
                      );
                    },
                  );
                },
              ),
            );
          }
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
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaButton(
                    text: AmcaWords.addCostOrExpense,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ManageCostExpensePage.create(
                            farmingId: vm.farmingId!,
                          ),
                        ),
                      ).then(
                            (value) async {
                          if (value != null && (value as bool)) {
                            await vm.init();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: validateIfEmpty(context)
          ? FloatingActionButton(
              tooltip: AmcaWords.addCostOrExpense,
              onPressed: () {
                final costExpensesList = Provider.of<CostsExpensesListVM>(
                  context,
                  listen: false,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ManageCostExpensePage.create(
                      farmingId: costExpensesList.farmingId!,
                    ),
                  ),
                ).then(
                      (value) async {
                    if (value != null && (value as bool)) {
                      await costExpensesList.init();
                    }
                  },
                );
              },
              backgroundColor: AmcaPalette.lightGreen,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  bool validateIfEmpty(BuildContext context) {
    final vm = Provider.of<CostsExpensesListVM>(
      context,
      listen: true,
    );
    return vm.costsAndExpenses.isNotEmpty;
  }
}
