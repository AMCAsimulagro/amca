import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:amca/ui/features/livestock/option/poultry/fattening/create_poultry_fattening_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/fattening/poultry_fattening_detail_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/fattening/poultry_fattening_list_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PoultryFatteningPage extends StatelessWidget {
  static ChangeNotifierProvider<PoultryFatteningListVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (_) => PoultryFatteningListVM()..init(),
        child: PoultryFatteningPage._(key: key),
      );

  const PoultryFatteningPage._({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.poultryFattening),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePoultryFatteningPage.create(),
            ),
          ).then((value) async {
            if (value != null && value is bool && value) {
              await Provider.of<PoultryFatteningListVM>(
                context,
                listen: false,
              ).init();
            }
          });
        },
        backgroundColor: AmcaPalette.lightGreen,
        child: const Icon(Icons.add),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<PoultryFatteningListVM>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.batches.isEmpty) {
          return const Center(
            child: Text(AmcaWords.noBatches),
          );
        }

        return RefreshIndicator(
          onRefresh: vm.init,
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: vm.batches.length,
            itemBuilder: (context, index) {
              final batch = vm.batches[index];
              return _buildBatchCard(context, vm, batch);
            },
          ),
        );
      },
    );
  }

  Widget _buildBatchCard(
    BuildContext context,
    PoultryFatteningListVM vm,
    PoultryFatteningBatch batch,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          batch.batchName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('${AmcaWords.farmName}: ${batch.farmName}'),
            Text(
              '${AmcaWords.startDate}: ${DateFormat('dd/MM/yyyy').format(batch.startDate)}',
            ),
            Text('${AmcaWords.initialQuantity}: ${batch.initialQuantity}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreatePoultryFatteningPage.create(batch: batch),
                  ),
                ).then((value) async {
                  if (value != null && value is bool && value) {
                    await vm.init();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                Dialogs.showSuccessDialogWithOptions(
                  context,
                  AmcaWords.areYouSureToDeleteThisCostOrExpense,
                  onTap: () async {
                    await CallsWithDialogs.call(context, () async {
                      await vm.deleteBatch(batch.id ?? '');
                    });
                  },
                );
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PoultryFatteningDetailPage.create(batchId: batch.id ?? ''),
            ),
          ).then((value) async {
            if (value != null && value is bool && value) {
              await vm.init();
            }
          });
        },
      ),
    );
  }
}
