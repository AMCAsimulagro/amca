import 'package:amca/ui/features/farming/create/manage_transitory_farming_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/widgets/amca_container_button.dart';
import 'package:flutter/material.dart';

class OptionFarmingPage extends StatelessWidget {
  const OptionFarmingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.transitoryFarming),
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
                  text: AmcaWords.createFarming,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>  ManageTransitoryFarming.create(),
                      ),
                    );
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
