import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_tracking.dart';
import 'package:amca/ui/features/livestock/option/poultry/fattening/add_poultry_tracking_vm.dart';
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

class AddPoultryTrackingPage extends StatefulWidget {
  static ChangeNotifierProvider<AddPoultryTrackingVM> create({
    Key? key,
    required String batchId,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (_) => AddPoultryTrackingVM(batchId)..init(),
        child: AddPoultryTrackingPage._(key: key, batchId: batchId),
      );

  const AddPoultryTrackingPage._({super.key, required this.batchId});

  final String batchId;

  @override
  State<AddPoultryTrackingPage> createState() => _AddPoultryTrackingPageState();
}

class _AddPoultryTrackingPageState extends State<AddPoultryTrackingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _feedController = TextEditingController();
  final TextEditingController _mortalityController = TextEditingController();
  final TextEditingController _finalAverageWeightController =
      TextEditingController();

  final List<String> _recordTypes = const [
    AmcaWords.trackingRecord,
    AmcaWords.finishingRecord,
  ];

  String? _selectedRecordType;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    _dateController.dispose();
    _feedController.dispose();
    _mortalityController.dispose();
    _finalAverageWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.addWeeklyRecord),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<AddPoultryTrackingVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final recordTypes = _availableRecordTypes(vm);
          return SingleChildScrollView(
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
                  DropdownButtonFormField<String>(
                    initialValue: _selectedRecordType,
                    decoration: const InputDecoration(
                      labelText: AmcaWords.recordType,
                    ),
                    items: recordTypes
                        .map(
                          (type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRecordType = value;
                        if (value != AmcaWords.finishingRecord) {
                          _finalAverageWeightController.clear();
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AmcaWords.pleaseSelectRecordType;
                      }
                      return null;
                    },
                  ),
                  if (_selectedRecordType == AmcaWords.finishingRecord) ...[
                    const SizedBox(height: 16),
                    AmcaTextFormField(
                      key: const ValueKey('finalAverageWeightField'),
                      textEditingController: _finalAverageWeightController,
                      labelText:
                          '${AmcaWords.finalAverageWeight} (${AmcaWords.kG})',
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AmcaWords.pleaseAddFinalAverageWeight;
                        }
                        final parsed =
                            double.tryParse(value.replaceAll(',', '.'));
                        if (parsed == null || parsed <= 0) {
                          return AmcaWords.pleaseAddFinalAverageWeight;
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 16),
                  AmcaTextFormField(
                    key: const ValueKey('feedConsumedField'),
                    textEditingController: _feedController,
                    labelText: '${AmcaWords.feedConsumed} (${AmcaWords.kG})',
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AmcaWords.pleaseAddValue;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AmcaTextFormField(
                    key: const ValueKey('mortalityField'),
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
                    onPressed: () => _saveTracking(vm),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveTracking(AddPoultryTrackingVM vm) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final recordDate = DateFormat('yyyy-MM-dd').parse(_dateController.text);
    final feedConsumed = double.parse(_feedController.text.replaceAll(',', '.'));
    final mortality = int.parse(_mortalityController.text.trim());
    final finalAverageWeight = _selectedRecordType == AmcaWords.finishingRecord
        ? double.tryParse(
            _finalAverageWeightController.text.replaceAll(',', '.'),
          )
        : null;

    if (_selectedRecordType == AmcaWords.finishingRecord &&
        _hasFinishingRecord(vm)) {
      await Dialogs.showSuccessDialogWithMessage(
        context,
        AmcaWords.finalizationRecordAlreadyExists,
      );
      return;
    }

    final tracking = PoultryFatteningTracking(
      recordDate: recordDate,
      weekNumber: (vm.batch?.tracking.length ?? 0) + 1,
      recordType: _selectedRecordType ?? AmcaWords.trackingRecord,
      feedConsumed: feedConsumed,
      mortality: mortality,
      finalAverageWeight: finalAverageWeight,
      notes: '',
    );

    await CallsWithDialogs.call(context, () async {
      await vm.addTracking(tracking);
      await Dialogs.showSuccessDialogWithMessage(
        context,
        AmcaWords.yourCostOrExpenseHaveBeenCreated,
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    });
  }

  List<String> _availableRecordTypes(AddPoultryTrackingVM vm) {
    if (_hasFinishingRecord(vm)) {
      return const [AmcaWords.trackingRecord];
    }
    return _recordTypes;
  }

  bool _hasFinishingRecord(AddPoultryTrackingVM vm) {
    return vm.batch?.tracking.any(
          (item) => item.recordType == AmcaWords.finishingRecord,
        ) ??
        false;
  }
}
