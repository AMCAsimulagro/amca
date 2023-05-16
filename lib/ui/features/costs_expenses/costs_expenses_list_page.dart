import 'package:amca/ui/features/costs_expenses/costs_expenses_list_vm.dart';
import 'package:amca/ui/features/costs_expenses/manage/manage_cost_expense_screen.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                              ManageCostExpenseScreen.create(
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
                    AmcaWords.costsAndExpensesHaveBeenCreated,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaButton(
                    text: AmcaWords.seeProductions,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ManageCostExpenseScreen.create(
                            farmingId: vm.farmingId!,
                          ),
                        ),
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
              tooltip: 'Agregar costo o gasto',
              onPressed: () {
                final costExpensesList = Provider.of<CostsExpensesListVM>(
                  context,
                  listen: false,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        ManageCostExpenseScreen.create(
                      farmingId: costExpensesList.farmingId!,
                    ),
                  ),
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
