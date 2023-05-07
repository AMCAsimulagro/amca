import 'package:amca/domain/model/transitory_farming.dart';
import 'package:amca/ui/features/farming/create/create_transitory_farming_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_date_picker_field.dart';
import 'package:amca/ui/widgets/amca_select_form_field.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageTransitoryFarming extends StatefulWidget {
  static ChangeNotifierProvider<CreateTransitoryFarmingVM> create(
          {Key? key, TransitoryFarming? transitoryFarming}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => CreateTransitoryFarmingVM()..init(),
        child: ManageTransitoryFarming._(
            key: key, transitoryFarming: transitoryFarming),
      );

  const ManageTransitoryFarming._({
    super.key,
    this.transitoryFarming,
  });

  final TransitoryFarming? transitoryFarming;

  @override
  State<ManageTransitoryFarming> createState() =>
      _ManageTransitoryFarmingState();
}

class _ManageTransitoryFarmingState extends State<ManageTransitoryFarming> {
  late final bool isEditMode;
  final _formKey = GlobalKey<FormState>();
  final _partNameController = TextEditingController();
  final _cropTypeController = TextEditingController();
  final _cropController = TextEditingController();
  final _sownAreaController = TextEditingController();
  final _sownTypeController = TextEditingController();
  final _formatController = TextEditingController();
  final _amountSownController = TextEditingController();
  final _valueController = TextEditingController();
  final _commentController = TextEditingController();
  static const _locale = 'en';
  String createdDate = '';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  void initState() {
    isEditMode = widget.transitoryFarming != null;
    _preloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isEditMode ? AmcaWords.editFarming : AmcaWords.transitoryFarming),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<CreateTransitoryFarmingVM>(
        builder: (context, vm, _) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 20.0,
                right: 16.0,
                left: 16.0,
                bottom: 100,
              ),
              child: Column(
                children: [
                  AmcaDatePickerField(
                    labelText: AmcaWords.date,
                    initialDate: createdDate,
                    onChanged: (String date) {
                      createdDate = date;
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleaseAddDate;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaTextFormField(
                    textEditingController: _partNameController,
                    labelText: AmcaWords.partName,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleasePartName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaSelectFormField(
                    labelText: AmcaWords.cropType,
                    textEditingController: _cropTypeController,
                    options: vm.cropTypes.map((e) => e.tipo).toList(),
                    validator: (farming) {
                      if (farming != null && farming.isEmpty) {
                        return AmcaWords.pleaseSelectCropType;
                      }
                      return null;
                    },
                    optionSelected: (optionSelected) {
                      _cropController.clear();
                      vm.onCropType(optionSelected);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaSelectFormField(
                    labelText: AmcaWords.crop,
                    textEditingController: _cropController,
                    options: vm.crop,
                    validator: (farming) {
                      if (farming != null && farming.isEmpty) {
                        return AmcaWords.pleaseSelectCrop;
                      }
                      return null;
                    },
                    enabled: _cropTypeController.text.isNotEmpty,
                    optionSelected: (optionSelected) {
                      //  vm.setState(optionSelected);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaTextFormField(
                    textEditingController: _sownAreaController,
                    textInputType: TextInputType.number,
                    labelText: AmcaWords.sownArea,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleaseSownArea;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaSelectFormField(
                    labelText: AmcaWords.sownType,
                    textEditingController: _sownTypeController,
                    options: vm.sownTypes,
                    validator: (farming) {
                      if (farming != null && farming.isEmpty) {
                        return AmcaWords.pleaseSelectSownType;
                      }
                      return null;
                    },
                    optionSelected: (optionSelected) {
                      //  vm.setState(optionSelected);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaSelectFormField(
                    labelText: AmcaWords.format,
                    textEditingController: _formatController,
                    options: const [
                      AmcaWords.units,
                      AmcaWords.kG,
                    ],
                    validator: (farming) {
                      if (farming != null && farming.isEmpty) {
                        return AmcaWords.pleaseSelectFormat;
                      }
                      return null;
                    },
                    optionSelected: (optionSelected) {
                      //  vm.setState(optionSelected);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaTextFormField(
                    textEditingController: _amountSownController,
                    textInputType: TextInputType.number,
                    labelText: AmcaWords.amountSown,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleaseAddAmountSown;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaTextFormField(
                    textEditingController: _valueController,
                    textInputType: TextInputType.number,
                    labelText: AmcaWords.value,
                    prefixText: '\$',
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    onChanged: (value) {
                      value = _formatNumber(value.replaceAll(',', ''));
                      _valueController.value = TextEditingValue(
                        text: value,
                        selection:
                            TextSelection.collapsed(offset: value.length),
                      );
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleaseAddValue;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaTextFormField(
                    textEditingController: _commentController,
                    maxLength: 100,
                    labelText: AmcaWords.comment,
                    validator: (value) {
                      return null;
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AmcaButton(
                text: isEditMode ? AmcaWords.update : AmcaWords.createFarming,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createTransitoryFarming();
                  }
                },
              ),
              if (isEditMode)
                AmcaButton(
                  text: AmcaWords.delete,
                  type: AmcaButtonType.destroy,
                  onPressed: () {
                    deleteTransitoryFarming(widget.transitoryFarming!.id!);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTransitoryFarming() async {
    final createTransitoryVm = Provider.of<CreateTransitoryFarmingVM>(
      context,
      listen: false,
    );
    DateTime date = DateFormat('yyyy-MM-dd').parse(createdDate);
    final transitoryFarming = TransitoryFarming(
      createDate: date,
      partName: _partNameController.text,
      cropType: _cropTypeController.text,
      crop: _cropController.text,
      sownArea: _sownAreaController.text,
      sownType: _sownTypeController.text,
      format: _formatController.text,
      amountSown: _amountSownController.text,
      value: _valueController.text,
      comment: _commentController.text,
      id: isEditMode ? widget.transitoryFarming!.id : null,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        final result =
            await createTransitoryVm.createTransitoryFarming(transitoryFarming);
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );
        await farmingHistoryVM.init();
        await Dialogs.showSuccessDialogWithMessage(
          context,
          isEditMode
              ? AmcaWords.yourTransitoryFarmingHasBeenUpdated
              : AmcaWords.yourTransitoryFarmingHasBeenCreated,
        );
        Navigator.pop(context);
      });
    } catch (_) {}
  }

  Future<void> deleteTransitoryFarming(String id) async {
    final createTransitoryVm = Provider.of<CreateTransitoryFarmingVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createTransitoryVm.deleteTransitoryFarming(id);
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );
        await farmingHistoryVM.init();
        await Dialogs.showSuccessDialogWithMessage(
          context,
          AmcaWords.yourTransitoryFarmingHasBeenDeleted
        );
        Navigator.pop(context);
      });
    } catch (_) {}
  }

  void _preloadData() {
    if (isEditMode) {
      final preloadTransitoryFarming = widget.transitoryFarming;
      _partNameController.text = preloadTransitoryFarming?.partName ?? '';
      _cropTypeController.text = preloadTransitoryFarming?.cropType ?? '';
      _cropController.text = preloadTransitoryFarming?.crop ?? '';
      _sownAreaController.text = preloadTransitoryFarming?.sownArea ?? '';
      _sownTypeController.text = preloadTransitoryFarming?.sownType ?? '';
      _formatController.text = preloadTransitoryFarming?.format ?? '';
      _amountSownController.text = preloadTransitoryFarming?.amountSown ?? '';
      _valueController.text = preloadTransitoryFarming?.value ?? '';
      _commentController.text = preloadTransitoryFarming?.comment ?? '';
      createdDate = DateFormat('yyyy-MM-dd')
          .format(preloadTransitoryFarming?.createDate ?? DateTime.now());
    }
  }
}
