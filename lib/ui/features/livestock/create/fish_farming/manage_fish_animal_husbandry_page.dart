/// {@category Features Farming Create}
/// /// This file contains the implementation of the [ManageFishHusbandry] class, which provides a user interface
/// for creating and managing permanent farming activities. It includes form fields for inputting details such as
/// date, part name, crop type, crop, sown area, sown type, format, amount sown, value, and comments. Users can
/// create, update, and delete permanent farming activities. It interacts with the [CreateFishHusbandryVM]
/// ViewModel to handle business logic related to permanent farming. Dependencies include various UI widgets,
/// [FishHusbandry] model, and ViewModels such as [CreateFishHusbandryVM] and [FarmingHistoryVM].
library;

// ignore_for_file: use_build_context_synchronously

import 'package:amca/domain/model/livestock/fish_husbandry/fish_husbandry.dart';
import 'package:amca/ui/features/charts_cost_expenses/fish_husbandry/charts_costs_expenses_page_fish_a_h.dart';
import 'package:amca/ui/features/costs_expenses/livestock/fishHusbandry/costs_expenses_fish_husbandry_list_page.dart';
import 'package:amca/ui/features/livestock/create/fish_farming/create_fish_husbandry_vm.dart';
import 'package:amca/ui/features/main_navigation/main_navigation_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/features/production/livestock/fish_husbandry/manage_production_fish_husbandry_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_date_picker_field.dart'; //
import 'package:amca/ui/widgets/amca_download_button.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:amca/ui/widgets/amca_select_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// StatefulWidget for creating and managing permanent farming activities.
class ManageFishHusbandry extends StatefulWidget {
  /// Creates a [ManageFishHusbandry] instance with an optional [fishHusbandry] and [fishType].
  static ChangeNotifierProvider<CreateFishHusbandryVM> create(
          {Key? key, FishHusbandry? fishHusbandry, String? fishType}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => CreateFishHusbandryVM()
          ..init(
            fishHusbandry: fishHusbandry,
            fishType: fishType,
          ),
        child: ManageFishHusbandry._(
          key: key,
          fishHusbandry: fishHusbandry,
          fishType: fishType,
        ),
      );

  /// Constructs a [ManageFishHusbandry] widget.
  const ManageFishHusbandry._({
    super.key,
    this.fishHusbandry,
    this.fishType,
  });

  /// The permanent farming activity.
  final FishHusbandry? fishHusbandry;

  /// The type of fish (tilapia or cachama)
  final String? fishType;

  @override
  State<ManageFishHusbandry> createState() => _ManageFishHusbandryState();
}

/// State class associated with [ManageFishHusbandry] widget.
class _ManageFishHusbandryState extends State<ManageFishHusbandry> {
  final _formKey = GlobalKey<FormState>();
  final _farmNameController = TextEditingController();
  final _animalNumbersController = TextEditingController();
  final _pondLengthController = TextEditingController();
  final _pondWidthController = TextEditingController();
  final _pondDepthController = TextEditingController();
  final _pondVolumeController = TextEditingController();
  final _valueController = TextEditingController();
  final _commentController = TextEditingController();
  static const _locale = 'en';
  String createdDate = '';
  String? _selectedFishType;
  final TextEditingController _fishTypeController = TextEditingController();
  static const List<String> _fishTypesList = [
    'Bocachico',
    'Bagre',
    'Capaz',
    'Nicuro',
    'Yamu',
    'Cachama',
    'Tambaqui',
    'Tilapia',
    'Trucha',
    'Mojarra',
  ];

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  /// Calcula el área del estanque (Largo × Ancho)
  void _calculatePondArea() {
    final length = double.tryParse(_pondLengthController.text) ?? 0;
    final width = double.tryParse(_pondWidthController.text) ?? 0;
    final depth = double.tryParse(_pondDepthController.text) ?? 0;
    final area = length * width * depth;

    if (area > 0) {
      _pondVolumeController.text = area.toStringAsFixed(2);
    } else {
      _pondVolumeController.text = '';
    }
  }

  @override
  void initState() {
    _preloadData();
    // Agregar listeners para recalcular área cuando cambien largo o ancho
    _pondLengthController.addListener(_calculatePondArea);
    _pondDepthController.addListener(_calculatePondArea);
    _pondWidthController.addListener(_calculatePondArea);
    // Si el widget recibió un tipo de pez por navegación, usarlo por defecto
    final incoming = widget.fishType;
    if (incoming != null && _fishTypesList.contains(incoming)) {
      _selectedFishType = incoming;
      _fishTypeController.text = incoming;
    }
    super.initState();
  }

  @override
  void dispose() {
    _farmNameController.dispose();
    _animalNumbersController.dispose();
    _pondLengthController.dispose();
    _pondWidthController.dispose();
    _pondDepthController.dispose();
    _pondVolumeController.dispose();
    _fishTypeController.dispose();
    _valueController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateFishHusbandryVM>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(vm.isEditMode ? AmcaWords.edit : AmcaWords.fishFarming),
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
                // Selector para tipo de pez (estilo 'Unidad de medida')
                AmcaSelectFormField(
                  labelText: AmcaWords.typeOfFish,
                  textEditingController: _fishTypeController,
                  options: _fishTypesList,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Por favor seleccione un tipo de pez';
                    }
                    return null;
                  },
                  optionSelected: (option) {
                    setState(() {
                      _selectedFishType = option;
                      _fishTypeController.text = option;
                    });
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaTextFormField(
                  textEditingController: _animalNumbersController,
                  textInputType: TextInputType.number,
                  labelText: AmcaWords.fishNumber,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return AmcaWords.pleaseFishNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaTextFormField(
                  textEditingController: _pondLengthController,
                  textInputType: TextInputType.number,
                  labelText: AmcaWords.alongThePond,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return AmcaWords.pleaseFishNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaTextFormField(
                  textEditingController: _pondWidthController,
                  textInputType: TextInputType.number,
                  labelText: AmcaWords.pondWidth,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return AmcaWords.pleaseFishNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaTextFormField(
                  textEditingController: _pondDepthController,
                  textInputType: TextInputType.number,
                  labelText: AmcaWords.pondDepth,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return AmcaWords.pleaseFishNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                AmcaTextFormField(
                  textEditingController: _pondVolumeController,
                  textInputType: TextInputType.number,
                  labelText: '${AmcaWords.pondVolume} (${AmcaWords.fishCM})',
                  readOnly: true,
                  enabled: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (value) {
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
                    FilteringTextInputFormatter.digitsOnly,
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
                                          vm.currentFishHusbandry?.id ?? '',
                                    ),
                                  ),
                                ).then((value) async {
                                  Dialogs.showLoading(context);
                                  await vm.getFishHusbandry();
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
                              text: vm.currentFishHusbandry?.production == null
                                  ? AmcaWords.createProduction
                                  : AmcaWords.seeProduction,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<bool>(
                                    builder: (BuildContext context) =>
                                        ManageProductionPage.create(
                                      farmingId:
                                          vm.currentFishHusbandry?.id ?? '',
                                      production:
                                          vm.currentFishHusbandry?.production,
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
                                  ChartsCostsExpensesFishHusbandryPage.create(
                                fishHusbandryId: vm.currentFishHusbandry!.id!,
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
                          showDialog(
                            context: context,
                            builder: (_) => AmcaDownloadButton(
                                data: widget.fishHusbandry!.toReportData()),
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
    final createFishHusbandryVm = Provider.of<CreateFishHusbandryVM>(
      context,
      listen: false,
    );
    DateTime date = DateFormat('yyyy-MM-dd').parse(createdDate);
    final fishHusbandry = FishHusbandry(
      createDate: date,
      totalProfit: "",
      farmName: _farmNameController.text,
      numberAnimals: _animalNumbersController.text,
      value: _valueController.text,
      uidOwner: createFishHusbandryVm.currentFishHusbandry?.uidOwner,
      comment: _commentController.text,
      fishType: _selectedFishType ??
          widget.fishType ??
          createFishHusbandryVm.fishType,
      pondLength: _pondLengthController.text,
      pondWidth: _pondWidthController.text,
      pondDepth: _pondDepthController.text,
      pondVolume: _pondVolumeController.text,
      costsAndExpenses:
          createFishHusbandryVm.currentFishHusbandry?.costsAndExpenses,
      production: createFishHusbandryVm.currentFishHusbandry?.production,
      id: createFishHusbandryVm.isEditMode
          ? createFishHusbandryVm.currentFishHusbandry!.id
          : null,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createFishHusbandryVm.createFishHusbandry(fishHusbandry);
        final farmingHistoryVM = Provider.of<FarmingHistoryVM>(
          context,
          listen: false,
        );

        Dialogs.showSuccessDialogWithMessage(
          context,
          createFishHusbandryVm.isEditMode
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
    final createPermanentVm = Provider.of<CreateFishHusbandryVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await createPermanentVm.deleteFishHusbandry();
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
    bool isEditMode = widget.fishHusbandry != null;
    if (isEditMode) {
      final preloadFishHusbandry = widget.fishHusbandry;
      _pondVolumeController.text =
          preloadFishHusbandry?.pondVolume ?? '';
      _farmNameController.text = preloadFishHusbandry?.farmName ?? '';
      _animalNumbersController.text = preloadFishHusbandry?.numberAnimals ?? '';
      _valueController.text = preloadFishHusbandry?.value ?? '';
      _commentController.text = preloadFishHusbandry?.comment ?? '';
      _pondLengthController.text = preloadFishHusbandry?.pondLength ?? '';
      _pondWidthController.text = preloadFishHusbandry?.pondWidth ?? '';
      _pondDepthController.text = preloadFishHusbandry?.pondDepth ?? '';
      _selectedFishType = preloadFishHusbandry?.fishType ?? _selectedFishType;
      if (preloadFishHusbandry?.fishType != null &&
          _fishTypesList.contains(preloadFishHusbandry?.fishType)) {
        _fishTypeController.text = preloadFishHusbandry?.fishType ?? '';
      }
      createdDate = DateFormat('yyyy-MM-dd')
          .format(preloadFishHusbandry?.createDate ?? DateTime.now());
      // Calcular área después de cargar los datos
      Future.delayed(const Duration(milliseconds: 100), _calculatePondArea);
    }
  }
}
