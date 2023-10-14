import 'package:amca/ui/features/frequent_questions/frequent_questions_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FrequentQuestionsPage extends StatelessWidget {
  static ChangeNotifierProvider<FrequentQuestionsVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => FrequentQuestionsVM()..init(),
        child: FrequentQuestionsPage._(key: key),
      );

  const FrequentQuestionsPage._({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.frequentQuestions),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<FrequentQuestionsVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (vm.frequentQuestions.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: vm.frequentQuestions.length,
              itemBuilder: (BuildContext context, int index) {
                final frequentQuestion = vm.frequentQuestions[index];
                return ExpansionTile(
                  title: Text(frequentQuestion.title),
                  children: [
                    ListTile(
                      title: Text(frequentQuestion.content),
                    ),
                  ],
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AmcaWords.virtualSupport,
        onPressed: () async {
          _launchWhatsapp(context);
        },
        backgroundColor: AmcaPalette.lightGreen,
        child: const Icon(
          Icons.perm_phone_msg,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _launchWhatsapp(BuildContext context) async {
    var whatsapp = "+573012523459";
    var whatsappAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsapp&text=${AmcaWords.supportDefaultMessage}");
    if (await canLaunchUrl(whatsappAndroid)) {
      launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No tienes instalado WhatsApp en tu celular"),
        ),
      );
    }
  }
}
