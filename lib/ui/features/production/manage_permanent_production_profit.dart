/// {@category Manage Production}

/// Import statements for necessary libraries

import 'dart:developer';

import 'package:amca/domain/model/production_permanent.dart';
import 'package:amca/ui/features/production/manage_permanent_production_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/utils/extensions/string_extensions.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_date_picker_field.dart';
import 'package:amca/ui/widgets/amca_select_form_field.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageProductionPageProfit extends StatefulWidget {
  static ChangeNotifierProvider<ManageProductionVM> create({
    Key? key,
    required String farmingId,
    Production? production,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ManageProductionVM(farmingId: farmingId)..init(),
        child: ManageProductionPageProfit._(
          key: key,
          production: production,
        ),
      );

  const ManageProductionPageProfit._({
    super.key,
    required this.production,
  });

  final Production? production;

  @override
  State<ManageProductionPageProfit> createState() =>
      _ManageProductionPageState();
}

class _ManageProductionPageState extends State<ManageProductionPageProfit> {
  late final bool isEditMode;
  final _formKey = GlobalKey<FormState>();
  final _unitOfMeasureController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String createdDate = '';

  @override
  void initState() {
    isEditMode = widget.production != null;
    _preloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Producciones"),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<ManageProductionVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Lote: ${vm.permanentFarming?.partName ?? ''}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Cultivo: ${vm.permanentFarming?.crop ?? ''}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  //!SECTION if comentado
                  // if (vm.permanentFarming?.production != null) ...[
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: [
                  //       Text(
                  //         'Inversion Inicial: \$${vm.permanentFarming?.value ?? ''}',
                  //         style: Theme.of(context).textTheme.titleMedium,
                  //       ),
                  //       Text(
                  //         'Total Costos y Gastos del cultivo: \$${vm.permanentFarming?.calculateTotalCostAndExpense().toString().formatNumberToColombianPesos() ?? ''}',
                  //         style: Theme.of(context).textTheme.titleMedium,
                  //       ),
                  //       const SizedBox(
                  //         height: 12,
                  //       ),
                  //       Text(
                  //         //TODO - Cambiar
                  //         'Ganancia del cultivo: \$${vm.permanentFarming?.totalProfit.formatNumberToColombianPesos() ?? ''}',
                  //         style:
                  //             Theme.of(context).textTheme.titleMedium?.copyWith(
                  //                   color: _getEarningsColors(vm),
                  //                 ),
                  //       ),
                  //       const SizedBox(
                  //         height: 12,
                  //       ),
                  //     ],
                  //   ),
                  // ]

                  if (vm.permanentFarming?.production != null) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Inversion Inicial: \$${vm.permanentFarming?.value ?? ''}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Total Costos y Gastos del cultivo: \$${vm.permanentFarming?.calculateTotalCostAndExpense().toString().formatNumberToColombianPesos() ?? ''}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // Check if production list is not null before iterating
                        Text(
                          '${int.parse(vm.permanentFarming!.totalProfit) > 0 ? "Ganancia del Culttivo" : int.parse(vm.permanentFarming!.totalProfit)== 0 ? "Punto Muerto Económico" : "Perdida del Cultivo"}: \$${vm.permanentFarming?.totalProfit.formatNumberToColombianPesos() ?? ''}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: _getEarningsColors(vm),
                                  ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        if (vm.permanentFarming?.production != null)
                          for (var item in vm.permanentFarming!.production!
                              .toList()
                              .reversed) ...[
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.createDate.month}/${item.createDate.day}/${item.createDate.year}', // Display month, day, and year
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.local_shipping,
                                                color: Color.fromARGB(255, 116, 116, 116)), // Green money icon
                                            SizedBox(width: 4),
                                            Text(
                                              '${item.quantity} ${item.unitOfMeasurement}${int.parse(item.quantity) > 1 ? "s":""}', // Display item price
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: const Color.fromARGB(255, 116, 116, 116)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.attach_money,
                                                color: Colors
                                                    .green), // Green money icon
                                            SizedBox(width: 4),
                                            Text(
                                              'Venta: \$${item.price}', // Display item price
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ],
                                      
                                    ),
                                  ),
                                  // IconButton(
                                  //   icon: Icon(Icons.delete, color: Colors.red),
                                  //   onPressed: () {
                                  //     deleteProduction(0);
                                  //   },
                                  // ),
                                  
                                  //if (vm.permanentFarming!.production!.length > 1)
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      // Obtener el índice del elemento actual en la lista
                                      int index = vm
                                              .permanentFarming?.production
                                              ?.indexOf(item) ??
                                          -1;
                                      deleteProduction(index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                      ],
                    ),
                  ]

                  //!SECTION

                  else ...[
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
                    AmcaSelectFormField(
                      labelText: AmcaWords.unitOfMeasurement,
                      textEditingController: _unitOfMeasureController,
                      options: Constants.unitOfMeasurement,
                      validator: (farming) {
                        if (farming != null && farming.isEmpty) {
                          return AmcaWords.pleaseSelectAUnitMeasurement;
                        }
                        return null;
                      },
                      optionSelected: (optionSelected) {},
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AmcaTextFormField(
                      textEditingController: _quantityController,
                      textInputType: TextInputType.number,
                      labelText: AmcaWords.quantity,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return AmcaWords.pleaseAddQuantity;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AmcaTextFormField(
                      textEditingController: _priceController,
                      textInputType: TextInputType.number,
                      labelText: AmcaWords.value,
                      prefixText: '\$',
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      onChanged: (value) {
                        value = (value.replaceAll(',', ''))
                            .formatNumberToColombianPesos();
                        _priceController.value = TextEditingValue(
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
                      height: 24,
                    ),
                    AmcaButton(
                      text: isEditMode
                          ? AmcaWords.update
                          : AmcaWords.createProduction,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          createProduction();
                        }
                      },
                    )
                  ],
                ],
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: Theme.of(context).scaffoldBackgroundColor,
      //       boxShadow: const <BoxShadow>[
      //         BoxShadow(
      //           color: Colors.grey,
      //           blurRadius: 5,
      //         ),
      //       ],
      //     ),
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         AmcaButton(
      //           text:
      //               isEditMode ? AmcaWords.update : AmcaWords.createProduction,
      //           onPressed: () {
      //             if (_formKey.currentState!.validate()) {
      //               createProduction();
      //             }
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  bool validateIfEmpty(BuildContext context) {
    final vm = Provider.of<ManageProductionVM>(
      context,
      listen: true,
    );
    return vm.partProductions.isNotEmpty;
  }

  Future<void> createProduction() async {
    final manageVM = Provider.of<ManageProductionVM>(
      context,
      listen: false,
    );
    DateTime date = DateFormat('yyyy-MM-dd').parse(createdDate);
    final production = Production(
      createDate: date,
      partName: manageVM.permanentFarming?.partName,
      price: _priceController.text,
      id: isEditMode ? widget.production!.id : null,
      transitoryFarmingId: manageVM.farmingId ?? '', // Permanent
      quantity: _quantityController.text,
      unitOfMeasurement: _unitOfMeasureController.text,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.createProduction(production);
        await Dialogs.showSuccessDialogWithMessage(
          context,
          isEditMode
              ? AmcaWords.yourProductionHasBeenUpdated
              : AmcaWords.yourProductionHasBeenCreated,
        );
        //Navigator.pop(context);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<void> deleteProduction() async {
  //   final manageVM = Provider.of<ManageProductionVM>(
  //     context,
  //     listen: false,
  //   );
  //   try {
  //     await CallsWithDialogs.call(context, () async {
  //       await manageVM.deleteProduction();
  //       await Dialogs.showSuccessDialogWithMessage(
  //         context,
  //         AmcaWords.yourProductionHasBeenDeleted,
  //       );
  //       Navigator.pop(context);
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> deleteProduction(int index) async {
    final manageVM = Provider.of<ManageProductionVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.deleteProduction(index);
        await Dialogs.showSuccessDialogWithMessage(
          context,
          AmcaWords.yourProductionHasBeenDeleted,
        );
        //Navigator.pop(context);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void _preloadData() {
    if (isEditMode) {
      final preloadProduction = widget.production;
      createdDate = DateFormat('yyyy-MM-dd')
          .format(preloadProduction?.createDate ?? DateTime.now());
      _unitOfMeasureController.text =
          preloadProduction?.unitOfMeasurement ?? '';
      _quantityController.text = preloadProduction?.quantity ?? '';
      _priceController.text = preloadProduction?.price ?? '';
    }
  }

  Color _getEarningsColors(ManageProductionVM vm) {
    final value = int.parse(//TODO - cambiar pos
        vm.permanentFarming?.totalProfit.replaceAll(',', '') ?? '0');
    return value < 0
        ? Colors.red
        : value == 0
            ? Color.fromRGBO(255, 102, 0, 1)
            : AmcaPalette.lightGreen;
  }
}
