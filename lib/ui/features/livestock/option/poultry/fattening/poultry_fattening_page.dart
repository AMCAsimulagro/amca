import 'package:amca/ui/features/livestock/option/poultry/fattening/create_poultry_fattening_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/fattening/poultry_fattening_detail_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class PoultryFatteningPage extends StatelessWidget {
  const PoultryFatteningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.poultryFattening),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationHelper.push(
            const CreatePoultryFatteningPage(),
            context,
          );
        },
        backgroundColor: AmcaPalette.lightGreen,
        child: const Icon(Icons.add),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // TODO: Connect to real data source
    final List<Map<String, dynamic>> dummyBatches = [
      {
        'batchName': 'Lote Enero 2024',
        'farmName': 'Finca La Esperanza',
        'startDate': '15/01/2024',
        'initialQuantity': 500,
      },
      {
        'batchName': 'Galpón 2',
        'farmName': 'Finca El Retiro',
        'startDate': '01/02/2024',
        'initialQuantity': 1000,
      },
    ];

    if (dummyBatches.isEmpty) {
      return const Center(
        child: Text(AmcaWords.noBatches),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: dummyBatches.length,
      itemBuilder: (context, index) {
        final batch = dummyBatches[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              batch['batchName'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text('${AmcaWords.farmName}: ${batch['farmName']}'),
                Text('${AmcaWords.startDate}: ${batch['startDate']}'),
                Text('${AmcaWords.initialQuantity}: ${batch['initialQuantity']}'),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              NavigationHelper.push(
                PoultryFatteningDetailPage(batchName: batch['batchName']),
                context,
              );
            },
          ),
        );
      },
    );
  }
}
