/// {@category Features Farming Create}
/// /// This file contains the implementation of the [ManageMeetAnimalHusbandry] class, which provides a user interface
/// for creating and managing permanent farming activities. It includes form fields for inputting details such as
/// date, part name, crop type, crop, sown area, sown type, format, amount sown, value, and comments. Users can
/// create, update, and delete permanent farming activities. It interacts with the [CreateMeetAnimalHusbandryVM]
/// ViewModel to handle business logic related to permanent farming. Dependencies include various UI widgets,
/// [MilkAnimalHusbandry] model, and ViewModels such as [CreateMeetAnimalHusbandryVM] and [FarmingHistoryVM].
library;

// ignore_for_file: use_build_context_synchronously

import 'package:amca/domain/model/livestock/animal_husbandry/meet/meet_animal_husbandry.dart';
import 'package:amca/ui/features/charts_cost_expenses/charts_costs_expenses_page_meet_animal_husbandry.dart';
import 'package:amca/ui/features/costs_expenses/costs_expenses_list_page.dart';
import 'package:amca/ui/features/livestock/create/animal_husbandry/meet/create_meet_animal_husbandry_vm.dart';
import 'package:amca/ui/features/main_navigation/main_navigation_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/features/production/manage_permanent_production_page.dart';
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

/// StatefulWidget for creating and managing permanent farming activities.
class ManageMeetAnimalHusbandry extends StatefulWidget {
  /// Creates a [ManageMeetAnimalHusbandry] instance with an optional [animalHusbandry].
  static ChangeNotifierProvider<CreateMeetAnimalHusbandryVM> create(
          {Key? key, MeetAnimalHusbandry? animalHusbandry}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => CreateMeetAnimalHusbandryVM()
          ..init(
            animalHusbandry: animalHusbandry,
          ),
        child: ManageMeetAnimalHusbandry._(
            key: key, animalHusbandry: animalHusbandry),
      );

  /// Constructs a [ManageMeetAnimalHusbandry] widget.
  const ManageMeetAnimalHusbandry._({
    super.key,
    this.animalHusbandry,
  });

  /// The permanent farming activity.
  final MeetAnimalHusbandry? animalHusbandry;

  @override
  State<ManageMeetAnimalHusbandry> createState() =>
      _ManageMeetAnimalHusbandryState();
}

/// State class associated with [ManageMeetAnimalHusbandry] widget.
class _ManageMeetAnimalHusbandryState extends State<ManageMeetAnimalHusbandry> {
  final _formKey = GlobalKey<FormState>();
  final _farmNameController = TextEditingController();
  final _animalNumbersController = TextEditingController();
  final _productionTypeController = TextEditingController();
  final _descriptionTypeController = TextEditingController();
  final _expensiveTypeController = TextEditingController();
  final _typeController = TextEditingController();
  final _amountController = TextEditingController();
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
    return Consumer<CreateMeetAnimalHusbandryVM>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          title:
              Text(vm.isEditMode ? AmcaWords.edit : AmcaWords.animalHusbandry),
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
                  textEditingController: _animalNumbersController,
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
                AmcaSelectFormField(
                  labelText: AmcaWords.productionType,
                  textEditingController: _productionTypeController,
                  options: vm.productionTypes,
                  validator: (farming) {
                    if (farming != null && farming.isEmpty) {
                      return AmcaWords.pleaseSelectProductionType;
                    }
                    return null;
                  },
                  optionSelected: (optionSelected) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaSelectFormField(
                  labelText: AmcaWords.description,
                  textEditingController: _descriptionTypeController,
                  options: vm.descriptionTypes,
                  validator: (farming) {
                    if (farming != null && farming.isEmpty) {
                      return AmcaWords.pleaseSelectDescriptionType;
                    }
                    return null;
                  },
                  optionSelected: (optionSelected) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaSelectFormField(
                  labelText: AmcaWords.expensiveType,
                  textEditingController: _expensiveTypeController,
                  options: vm.expensiveTypes,
                  validator: (farming) {
                    if (farming != null && farming.isEmpty) {
                      return AmcaWords.pleaseSelectExpensiveType;
                    }
                    return null;
                  },
                  optionSelected: (optionSelected) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaTextFormField(
                  labelText: AmcaWords.type,
                  textEditingController: _typeController,
                  validator: (farming) {
                    if (farming != null && farming.isEmpty) {
                      return AmcaWords.pleaseSelectType;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaTextFormField(
                  textEditingController: _amountController,
                  textInputType: TextInputType.number,
                  labelText: AmcaWords.amount,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return AmcaWords.pleaseAddAmount;
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
                                      farmingId:
                                          vm.currentAnimalHusbandry?.id ?? '',
                                    ),
                                  ),
                                ).then((value) async {
                                  Dialogs.showLoading(context);
                                  await vm.getAnimalHusbandry();
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
                              text:
                                  vm.currentAnimalHusbandry?.production == null
                                      ? AmcaWords.createProduction
                                      : AmcaWords.seeProduction,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<bool>(
                                    builder: (BuildContext context) =>
                                        ManageProductionPage.create(
                                            farmingId:
                                                vm.currentAnimalHusbandry?.id ??
                                                    '',
                                            production: //TODO - Cambiar poss Esto es para modificar
                                                null //vm.currentAnimalHusbandry?.production?[0],
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
                                  ChartsCostsExpensesMettAnimalHusbandryPage
                                      .create(
                                animalHusbandryId:
                                    vm.currentAnimalHusbandry!.id!,
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
                  text: vm.isEditMode ? AmcaWords.update : AmcaWords.create,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createAnimalHusbandry();
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

  Future<void> createAnimalHusbandry() async {
    final createMeetAnimalHusbandryMv =
        Provider.of<CreateMeetAnimalHusbandryVM>(
      context,
      listen: false,
    );
    DateTime date = DateFormat('yyyy-MM-dd').parse(createdDate);
    final animalHusbandry = MeetAnimalHusbandry(
      createDate: date,
      farmName: _farmNameController.text,
      productionType: _productionTypeController.text,
      descriptionType: _descriptionTypeController.text,
      totalProfit: "",
      numberAnimals: _animalNumbersController.text,
      expensiveType: _expensiveTypeController.text,
      format: _typeController.text,
      amount: _amountController.text,
      value: _valueController.text,
      comment: _commentController.text,
      costsAndExpenses:
          createMeetAnimalHusbandryMv.currentAnimalHusbandry?.costsAndExpenses,
      production:
          createMeetAnimalHusbandryMv.currentAnimalHusbandry?.production,
      id: createMeetAnimalHusbandryMv.isEditMode
          ? createMeetAnimalHusbandryMv.currentAnimalHusbandry!.id
          : null,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createMeetAnimalHusbandryMv
            .createAnimalHusbandry(animalHusbandry);
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );

        Dialogs.showSuccessDialogWithMessage(
          context,
          createMeetAnimalHusbandryMv.isEditMode
              ? AmcaWords.yourAnimalHusbandryHasBeenUpdated
              : AmcaWords.yourAnimalHusbandryHasBeenCreated,
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

  Future<void> deleteAnimalHusbandry() async {
    final createPermanentVm = Provider.of<CreateMeetAnimalHusbandryVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createPermanentVm.deleteAnimalHusbandry();
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );
        await farmingHistoryVM.init();
        await Dialogs.showSuccessDialogWithMessage(
            context, AmcaWords.yourAnimalHusbandryHasBeenDeleted);
        Navigator.pop(context);
      });
    } catch (_) {}
  }

  Future<void> showOptionDialog(BuildContext context) async {
    await Dialogs.showSuccessDialogWithOptions(
        context, AmcaWords.areYouSureToDeleteThisAnimalHusbandry,
        onTap: () async {
      await deleteAnimalHusbandry();
    });
  }

  void _preloadData() {
    bool isEditMode = widget.animalHusbandry != null;
    if (isEditMode) {
      final preloadAnimalHusbandry = widget.animalHusbandry;
      _farmNameController.text = preloadAnimalHusbandry?.farmName ?? '';
      _productionTypeController.text =
          preloadAnimalHusbandry?.productionType ?? '';
      _descriptionTypeController.text =
          preloadAnimalHusbandry?.descriptionType ?? '';
      _animalNumbersController.text =
          preloadAnimalHusbandry?.numberAnimals ?? '';
      _expensiveTypeController.text =
          preloadAnimalHusbandry?.expensiveType ?? '';
      _typeController.text = preloadAnimalHusbandry?.format ?? '';
      _amountController.text = preloadAnimalHusbandry?.amount ?? '';
      _valueController.text = preloadAnimalHusbandry?.value ?? '';
      _commentController.text = preloadAnimalHusbandry?.comment ?? '';
      createdDate = DateFormat('yyyy-MM-dd')
          .format(preloadAnimalHusbandry?.createDate ?? DateTime.now());
    }
  }
}
