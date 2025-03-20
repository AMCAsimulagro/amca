/// {@category Features CostExpense Manage}
/// This file contains the implementation of a Flutter page for managing agricultural costs and expenses.
/// It provides fields to input information such as date, product or service, description, quantity, price, and comments.
/// The page utilizes the Provider pattern to manage the application state and displays dialogs for user interaction.
library;

/// Imports of Bookstores and Resources
import 'dart:developer';

import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/ui/features/costs_expenses/manage/manage_permanent_cast_expense_vm.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
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

// This class represents the main page for managing costs and expenses.
class ManageCostExpensePage extends StatefulWidget {

  // Static method to create an instance of ChangeNotifierProvider for this page.
  static ChangeNotifierProvider<ManageCostExpenseVM> create(
          {Key? key,
          CostAndExpense? costAndExpense,
          required String farmingId}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ManageCostExpenseVM(farmingId ?? '')..init(),
        
        // Constructor for the ManageCostExpensePage.
        child: ManageCostExpensePage._(
          key: key,
          costAndExpense: costAndExpense,
        ),
      );

// Private constructor for the ManageCostExpensePage.
  const ManageCostExpensePage._({
    super.key,
    this.costAndExpense,
  });

// Property to store the current cost or expense, if in edit mode.
  final CostAndExpense? costAndExpense;

// Method to create the state of the widget.
  @override
  State<ManageCostExpensePage> createState() => _ManageCostExpensePageState();
}

// Class representing the state of the page for managing costs and expenses.
class _ManageCostExpensePageState extends State<ManageCostExpensePage> {
  late final bool isEditMode;
  final _formKey = GlobalKey<FormState>();
  final _productOrServiceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _commentController = TextEditingController();
  static const _locale = 'en';
  String createdDate = '';

// Method called when initializing the state of the widget.
  @override
  void initState() {
    isEditMode = widget.costAndExpense != null;
    _preloadData();
    super.initState();
  }

 // Method to build the user interface of the page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode
            ? AmcaWords.editCostAndExpense
            : AmcaWords.costsAndExpenses),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<ManageCostExpenseVM>(
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
                    labelText: AmcaWords.productOrService.toUpperCase(),
                    textEditingController: _productOrServiceController,
                    options: ProductServiceData.productServiceList
                        .map((e) => e.productOrServiceName)
                        .toList(),
                    validator: (farming) {
                      if (farming != null && farming.isEmpty) {
                        return AmcaWords.pleaseSelectProductOrService;
                      }
                      return null;
                    },
                    optionSelected: (optionSelected) {
                      if (optionSelected !=
                          (vm.productOrServiceSelected?.productOrServiceName ??
                              '')) {
                        _descriptionController.clear();
                        vm.descriptionSelected = null;
                      }
                      vm.setProductOrServiceSelected(optionSelected);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AmcaSelectFormField(
                    labelText: AmcaWords.description,
                    textEditingController: _descriptionController,
                    enabled: vm.productOrServiceSelected != null,
                    options: vm.productOrServiceSelected?.description
                            .map((e) => e.description)
                            .toList() ??
                        [],
                    validator: (farming) {
                      if (farming != null && farming.isEmpty) {
                        return AmcaWords.pleaseSelectADescription;
                      }
                      return null;
                    },
                    optionSelected: (optionSelected) {
                      vm.setDescriptionSelected(optionSelected);
                    },
                  ),
                  const _DescriptionSelected(),
                  if (vm.descriptionSelected == null)
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
                ],
              ),
            ),
          );
        },
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
                text: isEditMode
                    ? AmcaWords.update
                    : AmcaWords.createCostAndExpense,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createCostAndExpense();
                  }
                },
              ),
              if (isEditMode)
                AmcaButton(
                  text: AmcaWords.delete,
                  type: AmcaButtonType.destroy,
                  onPressed: () {
                    showOptionDialog(
                      widget.costAndExpense!.id!,
                      context,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

 // Method to create or update the cost or expense.
  Future<void> createCostAndExpense() async {
    final manageVM = Provider.of<ManageCostExpenseVM>(
      context,
      listen: false,
    );
    DateTime date = DateFormat('yyyy-MM-dd').parse(createdDate);
    final costAndExpense = CostAndExpense(
      createDate: date,
      partName: manageVM.permanentFarming?.partName,
      price: _priceController.text,
      comment: _commentController.text,
      id: isEditMode ? widget.costAndExpense!.id : null,
      transitoryFarmingId: manageVM.farmingId,
      description: manageVM.descriptionSelected!,
      quantity: _quantityController.text,
      productOrService:
          manageVM.productOrServiceSelected?.productOrServiceName ?? '',
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.addCostAndExpenseToFarming(costAndExpense);
        await Dialogs.showSuccessDialogWithMessage(
          context,
          isEditMode
              ? AmcaWords.yourCostOrExpenseHaveBeenUpdated
              : AmcaWords.yourCostOrExpenseHaveBeenCreated,
        );
        Navigator.pop(context);
      });
    } catch (e) {
      log(e.toString());
    }
  }

// Method to display a confirmation dialog before deleting a cost or expense.
  Future<void> showOptionDialog(String id, BuildContext context) async {
    await Dialogs.showSuccessDialogWithOptions(
        context, AmcaWords.areYouSureToDeleteThisCostOrExpense,
        onTap: () async {
      await deleteCostOrExpense(id);
    });
  }

// Method to delete a cost or expense.
  Future<void> deleteCostOrExpense(String id) async {
    final manageVM = Provider.of<ManageCostExpenseVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.deleteCostAndExpensePermanent(id);
        await Dialogs.showSuccessDialogWithMessage(
            context, AmcaWords.yourCostOrExpenseHaveBeenDeleted);
        Navigator.pop(context);
      });
    } catch (_) {}
  }

// Method to preload data if the page is in edit mode.
  void _preloadData() {
    if (isEditMode) {
      final manageCostVM = Provider.of<ManageCostExpenseVM>(
        context,
        listen: false,
      );
      final preloadCostAndExpense = widget.costAndExpense;
      _priceController.text = preloadCostAndExpense?.price ?? '';
      _commentController.text = preloadCostAndExpense?.comment ?? '';
      _quantityController.text = preloadCostAndExpense?.quantity ?? '';
      _productOrServiceController.text =
          preloadCostAndExpense?.productOrService ?? '';
      manageCostVM.setProductOrServiceSelected(_productOrServiceController.text,
          updateScreen: false);
      _descriptionController.text =
          preloadCostAndExpense?.description.description ?? '';
      manageCostVM.setDescriptionSelected(_descriptionController.text,
          updateScreen: false);
      createdDate = DateFormat('yyyy-MM-dd')
          .format(preloadCostAndExpense?.createDate ?? DateTime.now());
    }
  }
}

// Widget to display the selected description of the product or service.
class _DescriptionSelected extends StatelessWidget {
  const _DescriptionSelected({super.key});

  @override
  Widget build(BuildContext context) {
    final manageCostVM = Provider.of<ManageCostExpenseVM>(
      context,
      listen: true,
    );
    return manageCostVM.descriptionSelected != null
        ? Container(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 12,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            margin: const EdgeInsets.only(
              bottom: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Costo o Gasto: ${manageCostVM.descriptionSelected!.costOrExpense}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Tipo: ${manageCostVM.descriptionSelected!.type}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
