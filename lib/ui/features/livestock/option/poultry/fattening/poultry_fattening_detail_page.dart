import 'package:amca/ui/features/livestock/option/poultry/fattening/add_poultry_tracking_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class PoultryFatteningDetailPage extends StatelessWidget {
  final String batchName;

  const PoultryFatteningDetailPage({
    super.key,
    required this.batchName,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(batchName),
          backgroundColor: AmcaPalette.lightGreen,
          bottom: const TabBar(
            tabs: [
              Tab(text: AmcaWords.tracking),
              Tab(text: AmcaWords.chart),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            _buildTrackingList(context),
            _buildCharts(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingList(BuildContext context) {
    // TODO: Connect to real tracking data
    final List<Map<String, dynamic>> dummyTracking = [
      {
        'week': 1,
        'date': '22/01/2024',
        'weight': 0.150,
        'feed': 50,
        'mortality': 2,
      },
      {
        'week': 2,
        'date': '29/01/2024',
        'weight': 0.350,
        'feed': 120,
        'mortality': 1,
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text(AmcaWords.addWeeklyRecord),
              style: ElevatedButton.styleFrom(
                backgroundColor: AmcaPalette.lightGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                NavigationHelper.push(
                  const AddPoultryTrackingPage(),
                  context,
                );
              },
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: dummyTracking.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final track = dummyTracking[index];
              return ListTile(
                title: Text('${AmcaWords.week} ${track['week']} - ${track['date']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('${AmcaWords.averageWeight}: ${track['weight']} ${AmcaWords.kG}'),
                    Text('${AmcaWords.feedConsumed}: ${track['feed']} ${AmcaWords.kG}'),
                    Text('${AmcaWords.mortality}: ${track['mortality']}'),
                  ],
                ),
                trailing: const Icon(Icons.edit, color: Colors.grey),
                onTap: () {
                  // TODO: Navigate to edit tracking
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCharts() {
    return const Center(
      child: Text(AmcaWords.buildingThis),
    );
  }
}
