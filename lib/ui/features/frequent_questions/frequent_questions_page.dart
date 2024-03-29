/// {@category Frequent Questions}
/// This file contains the implementation of the page for managing frequently asked questions in a Flutter application.
/// The page allows for creating, editing, and deleting frequently asked questions, displaying a form for entering the title and content of the question.
/// It also provides functionality for displaying a confirmation dialog when attempting to delete a frequently asked question.

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/frequent_question.dart';
import 'package:amca/ui/features/frequent_questions/frequent_questions_vm.dart';
import 'package:amca/ui/features/frequent_questions/manage_frequent_question/manage_frequent_question_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget representing the page for displaying frequently asked questions.
class FrequentQuestionsPage extends StatelessWidget {

  /// Static method to create an instance of ChangeNotifierProvider that wraps this page.
  /// Allows specifying whether the user is an administrator to enable additional functionality.
  static ChangeNotifierProvider<FrequentQuestionsVM> create(
          {Key? key, bool? isAdmin}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => FrequentQuestionsVM()..init(),
        child: FrequentQuestionsPage._(
          key: key,
          isAdmin: isAdmin ?? false,
        ),
      );

  /// Private constructor for the FrequentQuestionsPage class.
  const FrequentQuestionsPage._({
    super.key,
    this.isAdmin = false,
  });

  /// Flag indicating whether the user is an administrator.
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.frequentQuestions),
        backgroundColor: AmcaPalette.lightGreen,
        actions: [
          // Add button for administrators to add new questions.
          if (isAdmin)
            IconButton(
              tooltip: AmcaWords.addQuestion,
              onPressed: () async {
                // Add button for administrators to add new questions.
                Navigator.push(
                  context,
                  MaterialPageRoute<bool?>(
                    builder: (BuildContext context) =>
                        ManageFrequentQuestionPage.create(),
                  ),
                ).then((value) {
                  if (value != null) {
                    // Refresh the page after adding a new question.
                    final manageVM = Provider.of<FrequentQuestionsVM>(
                      context,
                      listen: false,
                    );
                    manageVM.init();
                  }
                });
              },
              icon: const Icon(Icons.add),
            )
        ],
      ),
      body: Consumer<FrequentQuestionsVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            // Show loading indicator while data is being loaded.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (vm.frequentQuestions.isNotEmpty) {
            // Display the list of frequently asked questions.
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: vm.frequentQuestions.length,
              itemBuilder: (BuildContext context, int index) {
                final frequentQuestion = vm.frequentQuestions[index];
                return ExpansionTile(
                  title: Text(frequentQuestion.title),
                  subtitle: isAdmin
                      ? _EditFrequentQuestion(
                          frequentQuestion: frequentQuestion,
                        )
                      : null,
                  children: [
                    ListTile(
                      title: Text(frequentQuestion.content),
                    ),
                  ],
                );
              },
            );
          }
          // Show an empty container if there are no frequent questions.
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AmcaWords.virtualSupport,
        onPressed: () async {
          // Launch WhatsApp to contact support.
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

  /// Method to launch WhatsApp to contact support.
  Future<void> _launchWhatsapp(BuildContext context) async {
    var supportNumber = "3012523459";
    var whatsappAndroid = Uri.parse(
        "https://wa.me/57$supportNumber?text=${AmcaWords.supportDefaultMessage}");
    if (await canLaunchUrl(whatsappAndroid)) {
      // Launch WhatsApp if the URL can be launched
      launchUrl(whatsappAndroid);
    } else {
      // Show error message if WhatsApp cannot be launched.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro al contactar soporte, llamar a $supportNumber"),
        ),
      );
    }
  }
}

/// Widget for editing a frequent question.
class _EditFrequentQuestion extends StatelessWidget {
  /// Constructor for the _EditFrequentQuestion class.
  const _EditFrequentQuestion({
    super.key,
    required this.frequentQuestion,
  });

  /// The frequent question being edited.
  final FrequentQuestion frequentQuestion;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the manage frequent question page to edit the question.
        Navigator.push(
          context,
          MaterialPageRoute<bool?>(
            builder: (BuildContext context) =>
                ManageFrequentQuestionPage.create(
              frequentQuestion: frequentQuestion,
            ),
          ),
        ).then((value) {
          if (value != null) {
            // Refresh the page after editing the question.
            final manageVM = Provider.of<FrequentQuestionsVM>(
              context,
              listen: false,
            );
            manageVM.init();
          }
        });
      },
      child: const Text(
        AmcaWords.edit,
        style: TextStyle(color: Colors.lightBlue),
      ),
    );
  }
}
