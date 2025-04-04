/// {@category Features Farming Create}
/// /// This file contains the implementation of the [ManagePermanentFarming] class, which provides a user interface
/// for creating and managing Permanent farming activities. It includes form fields for inputting details such as
/// date, part name, crop type, crop, sown area, sown type, format, amount sown, value, and comments. Users can
/// create, update, and delete Permanent farming activities. It interacts with the [CreatePermanentFarmingVM]
/// ViewModel to handle business logic related to Permanent farming. Dependencies include various UI widgets,
/// [PermanentFarming] model, and ViewModels such as [CreatePermanentFarmingVM] and [FarmingHistoryVM].
library;

// ignore_for_file: use_build_context_synchronously

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/permanent_farming.dart';
import 'package:amca/ui/features/charts_cost_expenses/charts_costs_expenses_page_permanent.dart';
import 'package:amca/ui/features/costs_expenses/costs_permanent_expenses_list_page.dart';
import 'package:amca/ui/features/farming/create/create_permanent_farming_vm.dart';
import 'package:amca/ui/features/main_navigation/main_navigation_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/features/production/manage_permanent_production_page.dart';
import 'package:amca/ui/features/production/manage_permanent_production_profit.dart';
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

/// StatefulWidget for creating and managing Permanent farming activities.
class ManagePermanentFarming extends StatefulWidget {
  /// Creates a [ManagePermanentFarming] instance with an optional [permanentFarming].
  static ChangeNotifierProvider<CreatePermanentFarmingVM> create(
          {Key? key, PermanentFarming? permanentFarming}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => CreatePermanentFarmingVM()
          ..init(
            permanentFarming: permanentFarming,
          ),
        child: ManagePermanentFarming._(
            key: key, permanentFarming: permanentFarming),
      );

  /// Constructs a [ManagePermanentFarming] widget.
  const ManagePermanentFarming._({
    super.key,
    this.permanentFarming,
  });

  /// The Permanent farming activity.
  final PermanentFarming? permanentFarming;

  @override
  State<ManagePermanentFarming> createState() => _ManagePermanentFarmingState();
}

/// State class associated with [ManagePermanentFarming] widget.
class _ManagePermanentFarmingState extends State<ManagePermanentFarming> {
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
    _preloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePermanentFarmingVM>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(vm.isEditMode
              ? AmcaWords.editFarming
              : AmcaWords.permanentFarming),
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
                  labelText: '${AmcaWords.sownArea} (m²)',
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
                                      farmingId: vm.permanentFarming?.id ?? '',
                                    ),
                                  ),
                                ).then((value) async {
                                  Dialogs.showLoading(context);
                                  await vm.getPermanentFarming();
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
                              text: AmcaWords
                                  .createProduction, // Delete validation structurue of the production => alway text is `create`
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<bool>(
                                    builder: (BuildContext context) =>
                                        ManageProductionPage.create(
                                      farmingId: vm.permanentFarming?.id ?? '',
                                      production://TODO -  Cambiar la poss
                                          vm.permanentFarming?.production?.isEmpty == true ? vm.permanentFarming!.production![0] : null,
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
                        text: AmcaWords.seeProduction, // Delete validation structurue of the production => alway text is `create`
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<bool>(
                              builder: (BuildContext context) =>
                                  ManageProductionPageProfit.create(
                                farmingId: vm.permanentFarming?.id ?? '',
                                production: vm.permanentFarming?.production?.isEmpty == true ? vm.permanentFarming!.production![0] : null,//TODO - cambiar Poss
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
                                  ChartsCostsExpensesPage.create(
                                permanentFarmingId: vm.permanentFarming!.id!,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AmcaButton(
                        text: AmcaWords.downloadReport,
                        onPressed: () {
                          // TODO Pendiente logica para descargar reporte
                          Dialogs.showErrorDialogWithMessage(
                              context, AmcaWords.buildingThis);
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
                      : AmcaWords.createFarming,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createPermanentFarming();
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

  Future<void> createPermanentFarming() async {
    final createPermanentVm = Provider.of<CreatePermanentFarmingVM>(
      context,
      listen: false,
    );
    DateTime date = DateFormat('yyyy-MM-dd').parse(createdDate);
    final permanentFarming = PermanentFarming(
      createDate: date,
      partName: _partNameController.text,
      cropType: _cropTypeController.text,
      crop: _cropController.text,
      totalProfit: "",
      sownArea: _sownAreaController.text,
      sownType: _sownTypeController.text,
      format: _formatController.text,
      amountSown: _amountSownController.text,
      value: _valueController.text,
      comment: _commentController.text,
      costsAndExpenses: createPermanentVm.permanentFarming?.costsAndExpenses,
      production: createPermanentVm.permanentFarming?.production,
      id: createPermanentVm.isEditMode
          ? createPermanentVm.permanentFarming!.id
          : null,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createPermanentVm.createPermanentFarming(permanentFarming);
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );

        Dialogs.showSuccessDialogWithMessage(
          context,
          createPermanentVm.isEditMode
              ? AmcaWords.yourPermanentFarmingHasBeenUpdated
              : AmcaWords.yourPermanentFarmingHasBeenCreated,
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

  Future<void> deletePermanentFarming() async {
    final createPermanentVm = Provider.of<CreatePermanentFarmingVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createPermanentVm.deletePermanentFarming();
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );
        await farmingHistoryVM.init();
        await Dialogs.showSuccessDialogWithMessage(
            context, AmcaWords.yourPermanentFarmingHasBeenDeleted);
        Navigator.pop(context);
      });
    } catch (_) {}
  }

  Future<void> showOptionDialog(BuildContext context) async {
    await Dialogs.showSuccessDialogWithOptions(
        context, AmcaWords.areYouSureToDeleteThisPermanentFarming,
        onTap: () async {
      await deletePermanentFarming();
    });
  }

  void _preloadData() {
    bool isEditMode = widget.permanentFarming != null;
    if (isEditMode) {
      final preloadPermanentFarming = widget.permanentFarming;
      _partNameController.text = preloadPermanentFarming?.partName ?? '';
      _cropTypeController.text = preloadPermanentFarming?.cropType ?? '';
      _cropController.text = preloadPermanentFarming?.crop ?? '';
      _sownAreaController.text = preloadPermanentFarming?.sownArea ?? '';
      _sownTypeController.text = preloadPermanentFarming?.sownType ?? '';
      _formatController.text = preloadPermanentFarming?.format ?? '';
      _amountSownController.text = preloadPermanentFarming?.amountSown ?? '';
      _valueController.text = preloadPermanentFarming?.value ?? '';
      _commentController.text = preloadPermanentFarming?.comment ?? '';
      createdDate = DateFormat('yyyy-MM-dd')
          .format(preloadPermanentFarming?.createDate ?? DateTime.now());
    }
  }
}
