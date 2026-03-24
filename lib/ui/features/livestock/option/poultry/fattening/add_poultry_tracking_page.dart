import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_date_picker_field.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';

class AddPoultryTrackingPage extends StatefulWidget {
  const AddPoultryTrackingPage({super.key});

  @override
  State<AddPoultryTrackingPage> createState() => _AddPoultryTrackingPageState();
}

class _AddPoultryTrackingPageState extends State<AddPoultryTrackingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _feedController = TextEditingController();
  final TextEditingController _mortalityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateTime.now().toString().split(' ')[0]; // Simple init
  }

  @override
  void dispose() {
    _dateController.dispose();
    _weightController.dispose();
    _feedController.dispose();
    _mortalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.addWeeklyRecord),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AmcaDatePickerField(
                labelText: AmcaWords.date,
                initialDate: _dateController.text,
                onChanged: (val) => _dateController.text = val,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseAddDate;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AmcaTextFormField(
                textEditingController: _weightController,
                labelText: '${AmcaWords.averageWeight} (${AmcaWords.kG})',
                textInputType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseAddValue;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AmcaTextFormField(
                textEditingController: _feedController,
                labelText: '${AmcaWords.feedConsumed} (${AmcaWords.kG})',
                textInputType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseAddValue;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AmcaTextFormField(
                textEditingController: _mortalityController,
                labelText: AmcaWords.mortality,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseAddQuantity;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              AmcaButton(
                text: AmcaWords.create,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement logic
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
