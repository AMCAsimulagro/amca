/// {@category Features Poultry Laying}
/// Listing and navigation for laying galpones.
library;

import 'package:amca/domain/model/livestock/poultry_laying/laying_galpon.dart';
import 'package:amca/ui/features/livestock/option/poultry/laying/laying_galpon_form_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/laying/laying_galpon_list_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/features/livestock/option/poultry/laying/laying_galpon_detail_page.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayingGalponListPage extends StatelessWidget {
  const LayingGalponListPage._({super.key});

  static ChangeNotifierProvider<LayingGalponListVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (_) => LayingGalponListVM()..init(),
        child: LayingGalponListPage._(key: key),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.layingGalpons),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'laying-galpon-add',
        onPressed: () {
          Navigator.push<LayingGalpon?>(
            context,
            LayingGalponFormPage.create(),
          ).then((value) {
            if (value != null) {
              final vm = Provider.of<LayingGalponListVM>(context, listen: false);
              vm.saveGalpon(value);
            }
          });
        },
        backgroundColor: AmcaPalette.lightGreen,
        child: const Icon(Icons.add),
      ),
      body: Consumer<LayingGalponListVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.galpons.isEmpty) {
            return const Center(child: Text('Aún no tienes galpones'));
          }

          return RefreshIndicator(
            onRefresh: vm.init,
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: vm.galpons.length,
              itemBuilder: (context, index) {
                final galpon = vm.galpons[index];
                return _buildGalponCard(context, galpon, vm);
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGalponCard(BuildContext context, LayingGalpon galpon,
      LayingGalponListVM vm) {
    final stateColor = galpon.state == LayingGalponState.active
        ? AmcaPalette.lightGreen
        : Colors.grey;
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          LayingGalponDetailPage.createRoute(galpon: galpon),
        );
        await vm.refreshGalpon(galpon.id);
      },
      child: Card(
        elevation: 2,
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            galpon.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildStateChip(stateColor, galpon.state),
              const SizedBox(height: 8),
              Text(
                '${AmcaWords.startDate}: ${_formatDate(galpon.startDate)}',
              ),
              Text('${AmcaWords.populationInitial}: ${galpon.populationInitial}'),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit, color: Colors.grey),
            onPressed: () => _openForm(context, vm, galpon),
          ),
        ),
      ),
    );
  }

  Widget _buildStateChip(Color color, LayingGalponState state) {
    final label = state == LayingGalponState.active
        ? AmcaWords.galponStateActive
        : AmcaWords.galponStateFinalized;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _openForm(BuildContext context, LayingGalponListVM vm, LayingGalpon galpon) {
    Navigator.push<LayingGalpon?>(
      context,
      LayingGalponFormPage.create(galpon: galpon),
    ).then((value) {
      if (value != null) {
        vm.saveGalpon(value);
      }
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
