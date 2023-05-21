import 'dart:developer';

import 'package:amca/domain/model/production.dart';
import 'package:amca/ui/features/production/manage_production_vm.dart';
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
  final _productOrServiceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String createdDate = '';

  @override
  void initState() {
    isEditMode = widget.production != null;
    //_preloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(isEditMode ? AmcaWords.editProduction : AmcaWords.production),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<ManageProductionVM>(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Lote: ${vm.transitoryFarming?.partName ?? ''}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Cultivo: ${vm.transitoryFarming?.crop ?? ''}',
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
                    textEditingController: _productOrServiceController,
                    options: Constants.unitOfMeasurement,
                    validator: (farming) {
                      if (farming != null && farming.isEmpty) {
                        return AmcaWords.pleaseSelectAUnitMeasurement;
                      }
                      return null;
                    },
                    optionSelected: (optionSelected) {
                      /*  if (optionSelected !=
                          (vm.productOrServiceSelected?.productOrServiceName ??
                              '')) {
                        _descriptionController.clear();
                        vm.descriptionSelected = null;
                      }
                      vm.setProductOrServiceSelected(optionSelected);*/
                    },
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
                text:
                    isEditMode ? AmcaWords.update : AmcaWords.createProduction,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createProduction();
                  }
                },
              ),
              if (isEditMode)
                AmcaButton(
                  text: AmcaWords.delete,
                  type: AmcaButtonType.destroy,
                  onPressed: () {
                    //  deleteTransitoryFarming(widget.costAndExpense!.id!);
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
      partName: manageVM.transitoryFarming?.partName,
      price: _priceController.text,
      id: isEditMode ? widget.production!.id : null,
      transitoryFarmingId: manageVM.farmingId ?? '',
      quantity: _quantityController.text,
      unitOfMeasurement: '',
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
}
