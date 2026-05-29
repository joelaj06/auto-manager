import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';
import '../../../data/model/model.dart';
import '../getx/rental_controller.dart';
import 'rental_detail_drawer.dart';
import 'rental_web_toolbar.dart';

class WebRentalLayout extends StatefulWidget {
  const WebRentalLayout({super.key, required this.controller});

  final RentalController controller;

  @override
  State<WebRentalLayout> createState() => _WebRentalLayoutState();
}

class _WebRentalLayoutState extends State<WebRentalLayout> {
  RentalController get ctrl => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getRentalsWeb(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RentalWebToolbar(controller: ctrl),
        Expanded(
          child: Obx(() {
            final List<Rental> rentals = ctrl.currentPageRentals;
            final bool isLoading = ctrl.isWebLoading.value && rentals.isEmpty;
            final bool isError = ctrl.webError.value != null && rentals.isEmpty;
            final bool hasData = rentals.isNotEmpty;

            return AppDataTable<Rental>(
              columns: <AppTableColumn>[
                AppTableColumn(
                  key: 'id',
                  label: 'ID',
                  minWidth: 100,
                ),
                AppTableColumn(
                  key: 'customer',
                  label: 'Customer',
                  minWidth: 160,
                ),
                AppTableColumn(
                  key: 'vehicle',
                  label: 'Vehicle',
                  minWidth: 180,
                ),
                AppTableColumn(
                  key: 'dates',
                  label: 'Duration',
                  minWidth: 200,
                ),
                AppTableColumn(
                  key: 'amount',
                  label: 'Total/Paid',
                  minWidth: 120,
                  alignment: Alignment.centerRight,
                ),
              ],
              rows: hasData
                  ? rentals.map((Rental rental) {
                      return AppTableRow<Rental>(
                        cells: <String, Widget>{
                          'id': Text(
                            rental.rentalCode,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          'customer': Text(
                            rental.renter?.name ?? '--',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          'vehicle': Text(
                            '${rental.vehicle?.make ?? ''} ${rental.vehicle?.model ?? ''} ${rental.vehicle?.year ?? ''}',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          'dates': Text(
                            '${DataFormatter.formatDate(rental.startDate ?? '')} - ${DataFormatter.formatDate(rental.endDate ?? '')}',
                            style: const TextStyle(fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                          ),
                          'amount': Container(
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  (rental.totalAmount ?? 0).toStringAsFixed(2),
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  (rental.amountPaid ?? 0).toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: (rental.balance ?? 0) < 0 ? Colors.red : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        },
                        data: rental,
                      );
                    }).toList()
                  : <AppTableRow<Rental>>[],
              totalCount: ctrl.totalCount.value,
              rowsPerPage: 10,
              isLoading: isLoading,
              error: ctrl.webError.value,
              onRetry: () => ctrl.getRentalsWeb(1),
              onPageChanged: (int pageIndex) async {
                await ctrl.getRentalsWeb(pageIndex + 1);
              },
              detailDrawerBuilder: (dynamic data, VoidCallback onClose) {
                return RentalDetailDrawer(
                  rental: data as Rental,
                  controller: ctrl,
                  onClose: onClose,
                );
              },
              drawerWidth: 320,
            );
          }),
        ),
      ],
    );
  }
}
