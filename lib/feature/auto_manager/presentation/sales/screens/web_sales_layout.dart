import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/core.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../data/model/response/sale/sales_model.dart';
import '../getx/sales_controller.dart';
import '../widgets/sales_detail_drawer.dart';
import '../widgets/sales_filter.dart';
import '../widgets/web_toolbar.dart';

class WebSalesLayout extends StatefulWidget {
  const WebSalesLayout({super.key, required this.controller});

  final SalesController controller;

  @override
  State<WebSalesLayout> createState() => _WebSalesLayoutState();
}

class _WebSalesLayoutState extends State<WebSalesLayout> {
  Sale? _selectedSale;
  late _SalesDataGridSource _dataSource;
  final DataPagerController _dataPagerController = DataPagerController();
  static const int _rowsPerPage = 25;

  SalesController get ctrl => widget.controller;

  @override
  void initState() {
    super.initState();
    _dataSource = _SalesDataGridSource(
      controller: ctrl,
      rowsPerPage: _rowsPerPage,
      onPageLoad: _loadPage,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPage(0));
  }

  Future<void> _loadPage(int pageIndex) async {
    ctrl.getWebSales(pageIndex + 1);
  }

  @override
  void dispose() {
    _dataPagerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Column(
      children: <Widget>[
        WebToolbar(
          controller: ctrl,
          onFilterTap: () => _showWebFilterSheet(context),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ── Master table ───────────────────────────────────────────────
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Obx(() {
                        final bool isFirstPageLoading =
                            ctrl.isWebLoading.value &&
                            ctrl.currentPageSales.isEmpty;
                        final bool isFirstPageError =
                            ctrl.webError.value != null &&
                            ctrl.currentPageSales.isEmpty;
                        final bool isEmpty =
                            !ctrl.isWebLoading.value &&
                            ctrl.webError.value == null &&
                            ctrl.currentPageSales.isEmpty;
                        final bool hasData = ctrl.currentPageSales.isNotEmpty;

                        // ── Loading state ────────────────────────────────────
                        if (isFirstPageLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        // ── Error state ──────────────────────────────────────
                        if (isFirstPageError) {
                          return ErrorIndicator(
                            error: ctrl.webError.value as Failure,
                            onTryAgain: () => ctrl.getWebSales(1),
                          );
                        }

                        // ── Empty state ──────────────────────────────────────
                        if (isEmpty || !hasData) {
                          return const EmptyListIndicator();
                        }

                        // ── Data state ───────────────────────────────────────
                        _dataSource.updateRows(ctrl.currentPageSales);

                        return Stack(
                          children: <Widget>[
                            SfDataGridTheme(
                              data: SfDataGridThemeData(
                                headerColor: colors.surfaceContainerHighest,
                                gridLineColor: colors.outlineVariant.withValues(
                                  alpha: 0.4,
                                ),
                                gridLineStrokeWidth: 0.5,
                                selectionColor: colors.primary.withValues(
                                  alpha: 0.08,
                                ),
                                // currentCellColor: Colors.transparent,
                                rowHoverColor: colors.onSurface.withValues(
                                  alpha: 0.04,
                                ),
                              ),
                              child: SfDataGrid(
                                source: _dataSource,
                                selectionMode: SelectionMode.single,
                                navigationMode: GridNavigationMode.row,
                                onSelectionChanged:
                                    (
                                      List<DataGridRow> added,
                                      List<DataGridRow> removed,
                                    ) {
                                      if (added.isNotEmpty) {
                                        final int idx = _dataSource.rows
                                            .indexOf(added.first);
                                        if (idx >= 0 &&
                                            idx !=
                                                ctrl.currentPageSales.length) {
                                          setState(() {
                                            _selectedSale =
                                                ctrl.currentPageSales[idx];
                                          });
                                        }
                                      }
                                    },
                                columnWidthMode: ColumnWidthMode.fill,
                                gridLinesVisibility:
                                    GridLinesVisibility.horizontal,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.horizontal,
                                rowHeight: 52,
                                headerRowHeight: 40,
                                columns: <GridColumn>[
                                  GridColumn(
                                    columnName: 'saleId',
                                    minimumWidth: 100,
                                    label: _headerCell('Sale ID'),
                                  ),
                                  GridColumn(
                                    columnName: 'date',
                                    minimumWidth: 110,
                                    label: _headerCell('Date'),
                                  ),
                                  GridColumn(
                                    columnName: 'driver',
                                    minimumWidth: 140,
                                    label: _headerCell('Driver'),
                                  ),
                                  GridColumn(
                                    columnName: 'vehicle',
                                    minimumWidth: 160,
                                    label: _headerCell('Vehicle'),
                                  ),
                                  GridColumn(
                                    columnName: 'amount',
                                    minimumWidth: 110,
                                    label: _headerCell(
                                      'Amount (GHS)',
                                      align: TextAlign.right,
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'status',
                                    minimumWidth: 90,
                                    label: _headerCell(
                                      'Status',
                                      align: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ── Next-page loading overlay ──────────────────
                            // Shown as a slim progress bar at the bottom while
                            // a subsequent page is being fetched, so the
                            // existing rows remain visible and interactive.
                           // if(ctrl.isWebLoading.value ==true) Positioned(
                           //    left: 0,
                           //    right: 0,
                           //    bottom: 0,
                           //    child: Obx(
                           //      () => ctrl.isWebLoading.value &&
                           //          ctrl.currentPageSales.isNotEmpty
                           //          ? LinearProgressIndicator(minHeight: 2)
                           //          : SizedBox.shrink(),
                           //    ),
                           //  ),
                          ],
                        );
                      }),
                    ),

                    // ── Pager footer (hidden during loading / error / empty) ──
                    Obx(() {
                      final bool showPager =
                          !ctrl.isWebLoading.value &&
                          ctrl.webError.value == null &&
                          ctrl.currentPageSales.isNotEmpty;

                      if (!showPager) return const SizedBox.shrink();

                      final int total = ctrl.totalCount.value;
                      final int pageCount = (total / _rowsPerPage).ceil().clamp(
                        1,
                        9999,
                      );

                      return Container(
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest,
                          border: Border(
                            top: BorderSide(
                              color: colors.outlineVariant.withValues(
                                alpha: 0.4,
                              ),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '$total records · ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Obx(
                              () => Text(
                                ctrl.dateText.value,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const Spacer(),
                            SfDataPager(
                              delegate: _dataSource,
                              controller: _dataPagerController,
                              pageCount: pageCount.toDouble(),
                              visibleItemsCount: 5,
                              itemWidth: 36,
                              itemHeight: 36,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // ── Detail drawer ──────────────────────────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                width: _selectedSale != null ? 260 : 0,
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border(
                    left: BorderSide(
                      color: colors.outlineVariant.withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                  ),
                ),
                child: _selectedSale != null
                    ? SaleDetailDrawer(
                        sale: _selectedSale!,
                        controller: ctrl,
                        onClose: () => setState(() => _selectedSale = null),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String text, {TextAlign align = TextAlign.left}) {
    return Container(
      alignment: align == TextAlign.right
          ? Alignment.centerRight
          : align == TextAlign.center
          ? Alignment.center
          : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: context.colorScheme.onSurfaceVariant,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void _showWebFilterSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: 480,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      builder: (_) => SalesFilter(controller: ctrl),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SfDataGrid data source  (unchanged except rowsPerPage getter fix)
// ─────────────────────────────────────────────────────────────────────────────

class _SalesDataGridSource extends DataGridSource {
  _SalesDataGridSource({
    required this.controller,
    required int rowsPerPage,
    required this.onPageLoad,
  }) : _rowsPerPage = rowsPerPage;

  final SalesController controller;
  final int _rowsPerPage;
  final Future<void> Function(int pageIndex) onPageLoad;

  List<DataGridRow> _rows = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _rows;

  void updateRows(List<Sale> sales) {
    _rows = sales.map((Sale sale) {
      return DataGridRow(
        cells: <DataGridCell<dynamic>>[
          DataGridCell<String>(
            columnName: 'saleId',
            value: sale.saleId ?? '--',
          ),
          DataGridCell<String>(
            columnName: 'date',
            value: DataFormatter.formatDate(sale.createdAt ?? ''),
          ),
          DataGridCell<String>(
            columnName: 'driver',
            value:
                '${sale.driver?.firstName ?? ''} ${sale.driver?.user?.lastName ?? ''}',
          ),
          DataGridCell<String>(
            columnName: 'vehicle',
            value:
                '${sale.vehicle?.model ?? ''} ${sale.vehicle?.make ?? ''} '
                '${sale.vehicle?.color ?? ''} ${sale.vehicle?.year ?? ''}',
          ),
          DataGridCell<double>(columnName: 'amount', value: sale.amount),
          DataGridCell<String>(
            columnName: 'status',
            value: sale.status ?? 'pending',
          ),
        ],
      );
    }).toList();
    notifyListeners();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final String status =
        row
                .getCells()
                .firstWhere(
                  (DataGridCell<dynamic> c) => c.columnName == 'status',
                )
                .value
            as String;
    final bool isPaid = status.toLowerCase() == 'paid';

    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell<dynamic> cell) {
        switch (cell.columnName) {
          case 'saleId':
            return _cellPadding(
              Text(
                cell.value as String,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            );

          case 'date':
            return _cellPadding(
              Text(
                cell.value as String,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            );

          case 'driver':
            final String name = cell.value as String;
            final List<String> parts = name.trim().split(' ');
            final String initials = parts.length >= 2
                ? '${parts.first[0]}${parts.last[0]}'.toUpperCase()
                : name.isNotEmpty
                ? name[0].toUpperCase()
                : '?';
            return _cellPadding(
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.blueAccent.withValues(alpha: 0.15),
                    child: Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );

          case 'vehicle':
            return _cellPadding(
              Text(
                cell.value as String,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            );

          case 'amount':
            return Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                (cell.value as double).toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );

          case 'status':
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: isPaid
                      ? Colors.green.withValues(alpha: 0.12)
                      : Colors.orange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status.toTitleCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isPaid ? Colors.green : Colors.orange,
                  ),
                ),
              ),
            );

          default:
            return _cellPadding(
              Text(cell.value.toString(), style: const TextStyle(fontSize: 12)),
            );
        }
      }).toList(),
    );
  }

  Widget _cellPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(alignment: Alignment.centerLeft, child: child),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    await onPageLoad(newPageIndex);
    return true;
  }

  @override
  int get rowsPerPage => _rowsPerPage;
}
