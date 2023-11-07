import 'package:amca/ui/features/charts_cost_expenses/widgets/chart_card_vm.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({
    super.key,
    required this.child,
    required this.title,
    required this.dateSelected,
    this.dateSelectedType = DateSelectedType.month,
  });

  final Widget child;
  final String title;
  final DateSelectedType dateSelectedType;
  final Function(Jiffy) dateSelected;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => ChartCardVM(
        dateSelectedType: dateSelectedType,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(title),
            ),
            Card(
              elevation: 10,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<ChartCardVM>(
                    builder: (BuildContext context, vm, Widget? child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                vm.decreaseDate();
                                dateSelected(vm.currentDateTime);
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          SizedBox(
                            width: 130,
                            child: Text(
                              vm.currentDateFormatted,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                vm.increaseDate();
                                dateSelected(vm.currentDateTime);
                              },
                              icon: const Icon(Icons.arrow_forward_ios)),
                        ],
                      );
                    },
                  ),
                  AspectRatio(
                    aspectRatio: 1.1,
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
