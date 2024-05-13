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

class ManageProductionPage extends StatefulWidget {
  static ChangeNotifierProvider<ManageProductionVM> create({
    Key? key,
    required String farmingId,
    Production? production,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ManageProductionVM(farmingId: farmingId)..init(),
        child: ManageProductionPage._(
          key: key,
          production: production,
        ),
      );

  const ManageProductionPage._({
    super.key,
    required this.production,
  });

  final Production? production;

  @override
  State<ManageProductionPage> createState() => _ManageProductionPageState();
}

class _ManageProductionPageState extends State<ManageProductionPage> {
  late final bool isEditMode;
  final _formKey = GlobalKey<FormState>();
  final _unitOfMeasureController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String createdDate = '';

  @override
  void initState() {
    isEditMode = widget.production != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AmcaWords.production),
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
                text: AmcaWords.createProduction,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createProduction();
                  }
                },
              ),
            ],
          ),
        ),
      ),
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
      transitoryFarmingId: manageVM.farmingId ?? '',
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
        Navigator.pop(context);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteProduction() async {
    final manageVM = Provider.of<ManageProductionVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.deleteProduction();
        await Dialogs.showSuccessDialogWithMessage(
          context,
          AmcaWords.yourProductionHasBeenDeleted,
        );
        Navigator.pop(context);
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

  // Color _getEarningsColors(ManageProductionVM vm) {
  //   final value = int.parse(
  //       vm.permanentFarming?.production?.totalValue?.replaceAll(',', '') ??
  //           '0');
  //   return value < 0 ? Colors.red : AmcaPalette.lightGreen;
  // }
}
