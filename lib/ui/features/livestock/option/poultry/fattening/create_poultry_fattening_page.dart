import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:amca/ui/features/livestock/option/poultry/fattening/create_poultry_fattening_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_date_picker_field.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreatePoultryFatteningPage extends StatefulWidget {
  static ChangeNotifierProvider<CreatePoultryFatteningVM> create({
    Key? key,
    PoultryFatteningBatch? batch,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (_) => CreatePoultryFatteningVM()..init(batch: batch),
        child: CreatePoultryFatteningPage._(key: key, batch: batch),
      );

  const CreatePoultryFatteningPage._({super.key, this.batch});

  final PoultryFatteningBatch? batch;

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
  final TextEditingController _averageWeightController =
      TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _customBreedController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final List<String> _broilerBreeds = const [
    'Ross 308',
    'Cobb 500',
    'Arbor Acres',
    'Hubbard',
    'Otro',
  ];

  final List<String> _productionStages = const [
    'Arranque',
    'Crecimiento',
    'Engorde',
    'Finalización',
  ];

  String? _selectedBreed;
  String? _selectedProductionStage;
  late final bool _isEditMode;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.batch != null;
    _preloadData();
  }

  @override
  void dispose() {
    _farmNameController.dispose();
    _batchNameController.dispose();
    _quantityController.dispose();
    _averageWeightController.dispose();
    _breedController.dispose();
    _customBreedController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode ? AmcaWords.edit : AmcaWords.createBatch,
        ),
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
              AmcaTextFormField(
                textEditingController: _averageWeightController,
                labelText: '${AmcaWords.averageWeight} (${AmcaWords.kG})',
                textInputType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseAddAverageWeight;
                  }
                  final parsed = double.tryParse(value.replaceAll(',', '.'));
                  if (parsed == null || parsed <= 0) {
                    return AmcaWords.pleaseAddAverageWeight;
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
              DropdownButtonFormField<String>(
                value: _selectedProductionStage,
                decoration: const InputDecoration(
                  labelText: AmcaWords.productionStage,
                ),
                items: _productionStages
                    .map(
                      (stage) => DropdownMenuItem<String>(
                        value: stage,
                        child: Text(stage),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProductionStage = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseSelectProductionStage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedBreed,
                decoration: const InputDecoration(
                  labelText: AmcaWords.breed,
                ),
                items: _broilerBreeds
                    .map(
                      (breed) => DropdownMenuItem<String>(
                        value: breed,
                        child: Text(breed),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBreed = value;
                    _breedController.text = value ?? '';
                    if (value != 'Otro') {
                      _customBreedController.clear();
                    }
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseSelectType;
                  }
                  return null;
                },
              ),
              if (_selectedBreed == 'Otro') ...[
                const SizedBox(height: 16),
                AmcaTextFormField(
                  textEditingController: _customBreedController,
                  labelText: AmcaWords.breed,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AmcaWords.pleaseAddName;
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 32),
              AmcaButton(
                text: _isEditMode ? AmcaWords.update : AmcaWords.create,
                onPressed: _saveBatch,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveBatch() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final vm = Provider.of<CreatePoultryFatteningVM>(
      context,
      listen: false,
    );
    final startDate = DateFormat('yyyy-MM-dd').parse(_dateController.text);
    final averageWeight =
        double.parse(_averageWeightController.text.replaceAll(',', '.'));
    final batch = PoultryFatteningBatch(
      id: widget.batch?.id,
      uidOwner: widget.batch?.uidOwner ?? '',
      farmName: _farmNameController.text.trim(),
      batchName: _batchNameController.text.trim(),
      initialQuantity: int.parse(_quantityController.text.trim()),
      averageWeight: averageWeight,
      productionStage: _selectedProductionStage ?? '',
      breed: _selectedBreed ?? '',
      customBreed: _selectedBreed == 'Otro'
          ? _customBreedController.text.trim()
          : null,
      startDate: startDate,
      expectedSaleDate: widget.batch?.expectedSaleDate,
      creationDate: widget.batch?.creationDate ?? DateTime.now(),
      tracking: widget.batch?.tracking ?? const [],
      costsAndExpenses: widget.batch?.costsAndExpenses ?? const [],
    );

    await CallsWithDialogs.call(context, () async {
      await vm.saveBatch(batch);
      await Dialogs.showSuccessDialogWithMessage(
        context,
        _isEditMode
            ? AmcaWords.yourPoultryFatteningHasBeenUpdated
            : AmcaWords.yourPoultryFatteningHasBeenCreated,
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    });
  }

  void _preloadData() {
    final batch = widget.batch;
    if (batch == null) {
      return;
    }
    _farmNameController.text = batch.farmName;
    _batchNameController.text = batch.batchName;
    _quantityController.text = batch.initialQuantity.toString();
    _averageWeightController.text = batch.averageWeight.toString();
    _dateController.text = DateFormat('yyyy-MM-dd').format(batch.startDate);
    _selectedProductionStage = batch.productionStage;
    _selectedBreed = batch.breed;
    if (batch.customBreed != null && batch.customBreed!.isNotEmpty) {
      _customBreedController.text = batch.customBreed!;
      _selectedBreed = 'Otro';
    }
  }
}
