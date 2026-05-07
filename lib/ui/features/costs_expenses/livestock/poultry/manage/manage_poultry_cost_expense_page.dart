/// {@category Features CostExpense Manage}
/// UI-only form page for managing poultry (broiler) costs and expenses.
library;

import 'dart:developer';

import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_cost_expense.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/ui/features/costs_expenses/livestock/poultry/manage/manage_poultry_cost_expense_vm.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
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

class ManagePoultryCostExpensePage extends StatefulWidget {
  static ChangeNotifierProvider<ManagePoultryCostExpenseVM> create({
    Key? key,
    PoultryFatteningCostExpense? costExpense,
    required String batchId,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (_) => ManagePoultryCostExpenseVM(batchId)..init(),
        child: ManagePoultryCostExpensePage._(
          key: key,
          costExpense: costExpense,
        ),
      );

  const ManagePoultryCostExpensePage._({super.key, this.costExpense});

  final PoultryFatteningCostExpense? costExpense;

  @override
  State<ManagePoultryCostExpensePage> createState() =>
      _ManagePoultryCostExpensePageState();
}

class _ManagePoultryCostExpensePageState
    extends State<ManagePoultryCostExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _productOrServiceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _commentController = TextEditingController();
  String createdDate = '';

  ProductOrService? _selectedProductOrService;
  Description? _selectedDescription;
  late final bool _isEditMode;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.costExpense != null;
    _preloadData();
  }

  @override
  void dispose() {
    _productOrServiceController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode
              ? AmcaWords.editCostAndExpense
              : AmcaWords.costsAndExpenses,
        ),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<ManagePoultryCostExpenseVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
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
                  const SizedBox(height: 12),
                  AmcaSelectFormField(
                    labelText: AmcaWords.productOrService.toUpperCase(),
                    textEditingController: _productOrServiceController,
                    options: ProductServiceData.productServiceList
                        .map((e) => e.productOrServiceName)
                        .toList(),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleaseSelectProductOrService;
                      }
                      return null;
                    },
                    optionSelected: (optionSelected) {
                      if (optionSelected !=
                          (_selectedProductOrService?.productOrServiceName ??
                              '')) {
                        _descriptionController.clear();
                        _selectedDescription = null;
                      }
                      setState(() {
                        _selectedProductOrService =
                            ProductServiceData.productServiceList.firstWhere(
                          (element) =>
                              optionSelected == element.productOrServiceName,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  AmcaSelectFormField(
                    labelText: AmcaWords.description,
                    textEditingController: _descriptionController,
                    enabled: _selectedProductOrService != null,
                    options: _selectedProductOrService?.description
                            .map((e) => e.description)
                            .toList() ??
                        [],
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleaseSelectADescription;
                      }
                      return null;
                    },
                    optionSelected: (optionSelected) {
                      setState(() {
                        _selectedDescription =
                            _selectedProductOrService?.description.firstWhere(
                          (element) => optionSelected == element.description,
                        );
                      });
                    },
                  ),
                  const _DescriptionSelected(),
                  if (_selectedDescription == null)
                    const SizedBox(height: 12),
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
                  const SizedBox(height: 12),
                  AmcaTextFormField(
                    textEditingController: _priceController,
                    textInputType: TextInputType.number,
                    labelText: AmcaWords.value,
                    prefixText: '\$',
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return AmcaWords.pleaseAddValue;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  AmcaTextFormField(
                    textEditingController: _commentController,
                    maxLength: 100,
                    labelText: AmcaWords.comment,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
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
                text: _isEditMode
                    ? AmcaWords.update
                    : AmcaWords.createCostAndExpense,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveCostExpense();
                  }
                },
              ),
              if (_isEditMode)
                AmcaButton(
                  text: AmcaWords.delete,
                  type: AmcaButtonType.destroy,
                  onPressed: () {
                    Dialogs.showSuccessDialogWithOptions(
                      context,
                      AmcaWords.areYouSureToDeleteThisCostOrExpense,
                      onTap: () async {
                        await _deleteCostExpense();
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveCostExpense() async {
    final vm = Provider.of<ManagePoultryCostExpenseVM>(
      context,
      listen: false,
    );
    DateTime date = DateFormat('yyyy-MM-dd').parse(createdDate);
    final costExpense = PoultryFatteningCostExpense(
      recordDate: date,
      productOrService: _productOrServiceController.text,
      description: _descriptionController.text,
      costOrExpense: _selectedDescription?.costOrExpense ?? '',
      type: _selectedDescription?.type ?? '',
      quantity: _quantityController.text,
      price: _priceController.text,
      comment: _commentController.text,
      id: _isEditMode ? widget.costExpense?.id : null,
    );

    try {
      await CallsWithDialogs.call(context, () async {
        await vm.addCostExpense(costExpense);
        await Dialogs.showSuccessDialogWithMessage(
          context,
          _isEditMode
              ? AmcaWords.yourCostOrExpenseHaveBeenUpdated
              : AmcaWords.yourCostOrExpenseHaveBeenCreated,
        );
        if (!mounted) return;
        Navigator.pop(context, true);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _deleteCostExpense() async {
    final vm = Provider.of<ManagePoultryCostExpenseVM>(
      context,
      listen: false,
    );
    await CallsWithDialogs.call(context, () async {
      await vm.deleteCostExpense(widget.costExpense?.id ?? '');
      await Dialogs.showSuccessDialogWithMessage(
        context,
        AmcaWords.yourCostOrExpenseHaveBeenDeleted,
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    });
  }

  void _preloadData() {
    final costExpense = widget.costExpense;
    if (costExpense == null) {
      return;
    }
    createdDate = DateFormat('yyyy-MM-dd').format(costExpense.recordDate);
    _productOrServiceController.text = costExpense.productOrService;
    if (_productOrServiceController.text.isNotEmpty) {
      _selectedProductOrService = ProductServiceData.productServiceList
          .firstWhere(
              (element) => element.productOrServiceName ==
                  _productOrServiceController.text,
              orElse: () => ProductServiceData.productServiceList.first);
    }
    _descriptionController.text = costExpense.description;
    if (_selectedProductOrService != null &&
        _descriptionController.text.isNotEmpty) {
      _selectedDescription = _selectedProductOrService?.description.firstWhere(
        (element) => element.description == _descriptionController.text,
        orElse: () => _selectedProductOrService!.description.first,
      );
    }
    _quantityController.text = costExpense.quantity;
    _priceController.text = costExpense.price;
    _commentController.text = costExpense.comment ?? '';
  }
}

class _DescriptionSelected extends StatelessWidget {
  const _DescriptionSelected();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<
        _ManagePoultryCostExpensePageState>();
    final description = state?._selectedDescription;
    return description != null
        ? Container(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 12,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.4),
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
                  'Costo o Gasto: ${description.costOrExpense}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Tipo: ${description.type}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
