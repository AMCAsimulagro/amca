/// {@category Features Farming Create}
/// /// This file contains the implementation of the [ManagePigFarmingCostAndExpenses] class, which provides a user interface
/// for creating and managing permanent farming activities. It includes form fields for inputting details such as
/// date, part name, crop type, crop, sown area, sown type, format, amount sown, value, and comments. Users can
/// create, update, and delete permanent farming activities. It interacts with the [CreatePigFarmingVM]
/// ViewModel to handle business logic related to permanent farming. Dependencies include various UI widgets,
/// [PigFarming] model, and ViewModels such as [CreatePigFarmingVM] and [FarmingHistoryVM].
library;

// ignore_for_file: use_build_context_synchronously

import 'package:amca/domain/model/livestock/pig_farming/pig_farming.dart';

/// Imports of Bookstores and Resources

import 'package:amca/ui/features/charts_cost_expenses/pig_farming/charts_costs_expenses_page_pig_farming.dart';
import 'package:amca/ui/features/costs_expenses/costs_expenses_list_page.dart';
import 'package:amca/ui/features/livestock/create/pig_farming/create_pig_farming_vm.dart';
import 'package:amca/ui/features/main_navigation/main_navigation_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/features/production/manage_permanent_production_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_date_picker_field.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// StatefulWidget for creating and managing permanent farming activities.
class ManagePigFarmingCostAndExpenses extends StatefulWidget {
  /// Creates a [ManagePigFarmingCostAndExpenses] instance with an optional [pigFarming].
  static ChangeNotifierProvider<CreatePigFarmingVM> create(
          {Key? key, PigFarming? pigFarming}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => CreatePigFarmingVM()
          ..init(
            pigFarming: pigFarming,
          ),
        child:
            ManagePigFarmingCostAndExpenses._(key: key, pigFarming: pigFarming),
      );

  /// Constructs a [ManagePigFarmingCostAndExpenses] widget.
  const ManagePigFarmingCostAndExpenses._({
    super.key,
    this.pigFarming,
  });

  /// The permanent farming activity.
  final PigFarming? pigFarming;

  @override
  State<ManagePigFarmingCostAndExpenses> createState() =>
      _ManagePigFarmingCostAndExpensesState();
}

/// State class associated with [ManagePigFarmingCostAndExpenses] widget.
class _ManagePigFarmingCostAndExpensesState
    extends State<ManagePigFarmingCostAndExpenses> {
  final _formKey = GlobalKey<FormState>();
  final _farmNameController = TextEditingController();
  final _numberAnimalsController = TextEditingController();
  // final _productionTypeController = TextEditingController();
  // final _cropController = TextEditingController();
  // final _sownAreaController = TextEditingController();
  // final _sownTypeController = TextEditingController();
  // final _formatController = TextEditingController();
  // final _amountSownController = TextEditingController();
  final _valueController = TextEditingController();
  final _commentController = TextEditingController();
  static const _locale = 'en';
  String createdDate = '';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  void initState() {
    _preloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePigFarmingVM>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              vm.isEditMode ? AmcaWords.edit : AmcaWords.pigFarming),
          backgroundColor: AmcaPalette.lightGreen,
        ),
        body: Form(
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
                  textEditingController: _farmNameController,
                  labelText: AmcaWords.farmName,
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
                AmcaTextFormField(
                  textEditingController: _numberAnimalsController,
                  textInputType: TextInputType.number,
                  labelText: AmcaWords.animalNumber,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return AmcaWords.pleaseAnimalNumber;
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
                      selection: TextSelection.collapsed(offset: value.length),
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
                const SizedBox(
                  height: 24,
                ),
                if (vm.isEditMode)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AmcaButton(
                              text: AmcaWords.seeCostsAndExpenses,
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CostsExpensesListPage.create(
                                      farmingId: vm.currentPigFarming?.id ?? '',
                                    ),
                                  ),
                                ).then((value) async {
                                  Dialogs.showLoading(context);
                                  await vm.getPigFarming();
                                  Dialogs.close(context);
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: AmcaButton(
                              text: vm.currentPigFarming?.production == null
                                  ? AmcaWords.createProduction
                                  : AmcaWords.seeProduction,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<bool>(
                                    builder: (BuildContext context) =>
                                        ManageProductionPage.create(
                                      farmingId: vm.currentPigFarming?.id ?? '',
                                      production: //TODO - Cambiar poss Esto es para modificar
                                          null//vm.currentPigFarming?.production?[0],
                                    ),
                                  ),
                                ).then((value) async {
                                  if (value ?? false) {
                                    final farmingHistoryVM =
                                        Provider.of<FarmingHistoryVM>(
                                      context,
                                      listen: false,
                                    );
                                    await farmingHistoryVM.init();
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AmcaButton(
                        text: AmcaWords.seeCharts,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  ChartsCostsExpensesPigPage.create(
                                    pigFarmingId: vm.currentPigFarming!.id!,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
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
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AmcaButton(
                  text: vm.isEditMode
                      ? AmcaWords.update
                      : AmcaWords.createProduction,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createPigFarming();
                    }
                  },
                ),
                if (vm.isEditMode)
                  AmcaButton(
                    text: AmcaWords.delete,
                    type: AmcaButtonType.destroy,
                    onPressed: () {
                      showOptionDialog(context);
                    },
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> createPigFarming() async {
    final createPermanentVm = Provider.of<CreatePigFarmingVM>(
      context,
      listen: false,
    );
    DateTime date = DateFormat('yyyy-MM-dd').parse(createdDate);
    final pigFarming = PigFarming(
      createDate: date,
      farmName: _farmNameController.text,
      totalProfit: "",
      numberAnimals: _numberAnimalsController.text,
      // productionType: _productionTypeController.text,
      // sownArea: _sownAreaController.text,
      // sownType: _sownTypeController.text,
      // format: _formatController.text,
      // amountSown: _amountSownController.text,
      value: _valueController.text,
      comment: _commentController.text,
      costsAndExpenses: createPermanentVm.currentPigFarming?.costsAndExpenses,
      production: createPermanentVm.currentPigFarming?.production,
      id: createPermanentVm.isEditMode
          ? createPermanentVm.currentPigFarming!.id
          : null,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createPermanentVm.createPigFarming(pigFarming);
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );

        Dialogs.showSuccessDialogWithMessage(
          context,
          createPermanentVm.isEditMode
              ? AmcaWords.yourPigFarmingHasBeenUpdated
              : AmcaWords.yourPigFarmingHasBeenCreated,
        ).then((value) {
          final mainNavigationVM = Provider.of<MainNavigationVM>(
            context,
            listen: false,
          );
          mainNavigationVM.changePage(1);
          farmingHistoryVM.init();
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      });
    } catch (_) {}
  }

  Future<void> deletePigFarming() async {
    final createPermanentVm = Provider.of<CreatePigFarmingVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createPermanentVm.deletePigFarming();
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );
        await farmingHistoryVM.init();
        await Dialogs.showSuccessDialogWithMessage(
            context, AmcaWords.yourPigFarmingHasBeenDeleted);
        Navigator.pop(context);
      });
    } catch (_) {}
  }

  Future<void> showOptionDialog(BuildContext context) async {
    await Dialogs.showSuccessDialogWithOptions(
        context, AmcaWords.areYouSureToDeleteThisPigFarming, onTap: () async {
      await deletePigFarming();
    });
  }

  void _preloadData() {
    bool isEditMode = widget.pigFarming != null;
    if (isEditMode) {
      final preloadPigFarming = widget.pigFarming;
      _farmNameController.text = preloadPigFarming?.farmName ?? '';
      _numberAnimalsController.text = preloadPigFarming?.numberAnimals ?? '';
      // _productionTypeController.text = preloadPigFarming?.productionType ?? '';
      // _sownAreaController.text = preloadPigFarming?.sownArea ?? '';
      // _sownTypeController.text = preloadPigFarming?.sownType ?? '';
      // _formatController.text = preloadPigFarming?.format ?? '';
      // _amountSownController.text = preloadPigFarming?.amountSown ?? '';
      _valueController.text = preloadPigFarming?.value ?? '';
      _commentController.text = preloadPigFarming?.comment ?? '';
      createdDate = DateFormat('yyyy-MM-dd')
          .format(preloadPigFarming?.createDate ?? DateTime.now());
    }
  }
}
