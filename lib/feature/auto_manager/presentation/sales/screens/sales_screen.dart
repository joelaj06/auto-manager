

import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales(10)'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(IconlyLight.calendar),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyLight.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyLight.filter),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: AppPaddings.mH,
              child: SizedBox(
                height: context.height * 0.08,
                child: _buildTotalAmountCard(context),
              ),
            ),
          ),
          Expanded(
            child: _buildSalesList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesList(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTableHeader(context),
        Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return _buildSalesListTile(context, index);
                }))
      ],
    );
  }

  Widget _buildSalesListTile(BuildContext context, int index) {
    return Padding(
      padding: AppPaddings.mH,
      child: Column(
        children: <Widget>[
          Padding(
            padding: AppPaddings.lV,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'SA-000${index + 1}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('2022-01-01'),
                    ],
                  ),
                ),
                const Expanded(
                  child: Column(
                    children: <Widget>[
                      Text('Stephen Asiedu'),
                      Text('Kia Matiz Blue 2022',
                      overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      '600',
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: AppPaddings.mH.add(AppPaddings.sV),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: AppBorderRadius.largeAll,
                      ),
                      child: const Text(
                        'Approved',
                        style: TextStyle(color: Colors.green,
                        fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: context.colorScheme.outlineVariant,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text('ID'),
            ),
            Expanded(
              child: Center(
                child: Text('Driver'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Amount(GHS)'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Status'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmountCard(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'GHS 125,484.00',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
         Chip(
          backgroundColor: context.colorScheme.background,
          label: const Text(
            'From November 1, 2024 to November 30, 2024',
          ),
        ),
      ],
    );
  }
}
