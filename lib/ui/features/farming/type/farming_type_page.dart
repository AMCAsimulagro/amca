import 'package:amca/ui/features/farming/option/option_farming_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:amca/ui/widgets/amca_container_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmingTypePage extends StatelessWidget {
  const FarmingTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.farmingType),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: AmcaContainerButton(
                  text: AmcaWords.transitory,
                  onTap: () {
                    NavigationHelper.push(
                      const OptionFarmingPage(),
                      context,
                    );
                  },
                ),
              ),
               Expanded(
                child: AmcaContainerButton(
                  text: AmcaWords.permanent,
                  onTap: () async {
                    final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
                      context,
                      listen: false,
                    );
                    await farmingHistoryVM.init();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
