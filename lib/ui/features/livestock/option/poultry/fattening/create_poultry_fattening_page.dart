import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_date_picker_field.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';

class CreatePoultryFatteningPage extends StatefulWidget {
  const CreatePoultryFatteningPage({super.key});

  @override
  State<CreatePoultryFatteningPage> createState() =>
      _CreatePoultryFatteningPageState();
}

class _CreatePoultryFatteningPageState
    extends State<CreatePoultryFatteningPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _batchNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _farmNameController.dispose();
    _batchNameController.dispose();
    _quantityController.dispose();
    _breedController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.createBatch),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AmcaTextFormField(
                textEditingController: _farmNameController,
                labelText: AmcaWords.farmName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseFarmName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AmcaTextFormField(
                textEditingController: _batchNameController,
                labelText: AmcaWords.batchName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleasePartName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AmcaTextFormField(
                textEditingController: _quantityController,
                labelText: AmcaWords.initialQuantity,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseAddQuantity;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AmcaDatePickerField(
                labelText: AmcaWords.startDate,
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
                textEditingController: _breedController,
                labelText: AmcaWords.breed,
              ),
              const SizedBox(height: 32),
              AmcaButton(
                text: AmcaWords.create,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement save logic
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
