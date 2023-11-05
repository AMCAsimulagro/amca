import 'package:amca/ui/features/charts_profile/widgets/chart_card_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => ChartCardVM()..init(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Card(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back_ios)),
                      Consumer<ChartCardVM>(
                        builder: (BuildContext context, vm, Widget? child) {
                          return Text(vm.currentDateFormatted);
                        },
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                  AspectRatio(
                    aspectRatio: 1.5,
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
