import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_padding.dart';
import '../../../../../core/presentation/utils/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../getx/sales_controller.dart';
class SalesFilter extends StatelessWidget {
  const SalesFilter({super.key,required this.controller});

  final SalesController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
              child: Text('Filter',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const AppSpacing(v: 20),
            GetBuilder<SalesController>(
              id: 'filter',
              builder: (controller) {
                return ExpansionPanelList(
                  expansionCallback: (int panelIndex, bool isExpanded) =>
                      controller.onExpansionCallBack(panelIndex),
                  materialGapSize: 10,
                  expandedHeaderPadding: EdgeInsets.zero,
                  children: controller.expandableList.isEmpty
                      ? <ExpansionPanel>[]
                      : <ExpansionPanel>[
                    _buildExpansionPanel(
                      context,
                      isExpanded:
                      controller.expandableList.first.isExpanded,
                      title: controller.expandableList.first.headerValue,
                      icon: controller.expandableList.first.icon,
                      body: Obx(
                            () => ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller
                              .expandableList.first.body.length,
                          separatorBuilder: (_, __) =>
                          const Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(
                                  () => ListTile(
                                onTap: () =>
                                    controller.onFilteredDriverSelected(
                                      controller.expandableList.first
                                          .body[index].id,
                                    ),
                                trailing: controller
                                    .filteredDriverId.value ==
                                    controller.expandableList.first
                                        .body[index].id
                                    ? const Icon(Icons.check_circle)
                                    : null,
                                title: Text(
                                  '${controller.expandableList.first.body[index].firstName} '
                                      '${controller.expandableList.first.body[index].lastName}',
                                  style:
                                  const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      isLoading:
                      controller.isDriversLoading.value,
                    ),
                    _buildExpansionPanel(
                      context,
                      isExpanded:
                      controller.expandableList.last.isExpanded,
                      title: controller.expandableList.last.headerValue,
                      icon: controller.expandableList.last.icon,
                      body: Obx(
                            () => ListView.separated(
                          shrinkWrap: true,
                          itemCount:
                          controller.expandableList.last.body.length,
                          separatorBuilder: (_, __) =>
                          const Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(
                                  () => ListTile(
                                onTap: () =>
                                    controller.onFilteredVehicleSelected(
                                      controller.expandableList.last
                                          .body[index].id,
                                    ),
                                trailing: controller
                                    .filteredVehicleId.value ==
                                    controller.expandableList.last
                                        .body[index].id
                                    ? const Icon(Icons.check_circle)
                                    : null,
                                visualDensity: const VisualDensity(
                                    vertical: -4, horizontal: -4),
                                title: Text(
                                  '${controller.expandableList.last.body[index].model ?? ''} '
                                      '${controller.expandableList.last.body[index].make ?? ''} '
                                      '${controller.expandableList.last.body[index].color ?? ''} '
                                      '${controller.expandableList.last.body[index].year ?? ''}',
                                  style:
                                  const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      isLoading: controller.isVehiclesLoading.value,
                    ),
                  ],
                );
              },
            ),
            const AppSpacing(v: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.resetFilters,
                    child: const Text('Reset'),
                  ),
                ),
                const AppSpacing(h: 10),
                Expanded(
                  child: AppButton(
                    padding: const EdgeInsets.all(12),
                    onPressed: () {
                      controller.pagingController.refresh();
                      controller.getWebSales(1, refresh: true);
                      Get.back();
                    },
                    text: 'Apply',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  ExpansionPanel _buildExpansionPanel(
      BuildContext context, {
        required bool isExpanded,
        required String title,
        required IconData icon,
        required Widget body,
        required bool isLoading,
      }) {
    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: isExpanded,
      backgroundColor: context.colorScheme.surface,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Padding(
          padding: AppPaddings.mA,
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(child: Icon(icon)),
                const WidgetSpan(child: AppSpacing(h: 10)),
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : body,
    );
  }
}
