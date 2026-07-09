

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../errors/failure.dart';
import '../theme/app_theme.dart';
import 'exception_indicators/empty_list_indicator.dart';
import 'exception_indicators/error_indicator.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Column definition
// ─────────────────────────────────────────────────────────────────────────────

class AppTableColumn {
  const AppTableColumn({
    required this.key,
    required this.label,
    this.minWidth = 100,
    this.alignment = Alignment.centerLeft,
    this.flex = 1,
  });

  final String key;
  final String label;
  final double minWidth;
  final Alignment alignment;
  final int flex;
}

// ─────────────────────────────────────────────────────────────────────────────
// Row definition
// ─────────────────────────────────────────────────────────────────────────────

class AppTableRow<T> {
  const AppTableRow({
    required this.cells,
    this.data,
  });

  /// key → widget to render in that cell
  final Map<String, Widget> cells;

  /// Original data object (used to pass back onRowTap)
  final T? data;
}

// ─────────────────────────────────────────────────────────────────────────────
// Main widget
// ─────────────────────────────────────────────────────────────────────────────

class AppDataTable<T> extends StatefulWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.totalCount,
    required this.rowsPerPage,
    required this.isLoading,
    required this.onPageChanged,
    this.error,
    this.onRetry,
    this.onRowTap,
    this.detailDrawerBuilder,
    this.drawerWidth = 280,
    this.rowHeight = 52,
    this.headerRowHeight = 40,
    this.isNextPageLoading = false,
  });

  /// Column definitions
  final List<AppTableColumn> columns;

  /// Rows to display on the current page
  final List<AppTableRow<T>> rows;

  /// Total record count across all pages (used for pager)
  final int totalCount;

  /// How many rows per page
  final int rowsPerPage;

  /// True while the first page is loading
  final bool isLoading;

  /// True while a subsequent page is loading (shows slim progress bar)
  final bool isNextPageLoading;

  /// Non-null when the first page load failed
  final Failure? error;

  /// Called when the retry button is tapped on the error state
  final VoidCallback? onRetry;

  /// Called when a row is tapped. Receives the row's [AppTableRow.data]
  final void Function(T data)? onRowTap;

  /// If provided, tapping a row opens a detail drawer on the right.
  /// The builder receives the tapped [AppTableRow.data].
  /// If null, no drawer is shown (onRowTap is used instead).
  final Widget Function(dynamic data, VoidCallback onClose)?
  detailDrawerBuilder;

  /// Width of the detail drawer when open
  final double drawerWidth;
  final Future<void> Function(int) onPageChanged;

  final double rowHeight;
  final double headerRowHeight;

  @override
  State<AppDataTable<T>> createState() => _AppDataTableState<T>();
}

class _AppDataTableState<T> extends State<AppDataTable<T>> {
  late _AppDataGridSource<T> _source;
  final DataPagerController _pagerController = DataPagerController();
  T? _selectedData;

  @override
  void initState() {
    super.initState();
    _source = _AppDataGridSource<T>(
      rows: widget.rows,
      onPageChange: widget.onPageChanged,
    );
  }

  @override
  void didUpdateWidget(covariant AppDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rows != widget.rows) {
      _source.updateRows(widget.rows);
    }
  }

  @override
  void dispose() {
    _pagerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // ── Master table + pager ───────────────────────────────────────────
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(child: _buildBody(context)),
              if (_shouldShowPager) _buildPager(context),
            ],
          ),
        ),

        // ── Detail drawer ──────────────────────────────────────────────────
        if (widget.detailDrawerBuilder != null)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: _selectedData != null ? widget.drawerWidth : 0,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              border: Border(
                left: BorderSide(
                  color: context.colorScheme.outlineVariant
                      .withValues(alpha: 0.5),
                  width: 0.5,
                ),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: _selectedData != null
                ? widget.detailDrawerBuilder!(
              _selectedData,
                  () => setState(() => _selectedData = null),
            )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }

  // ── Body: switches between loading / error / empty / data ─────────────────

  Widget _buildBody(BuildContext context) {
    // Loading
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    // Error
    if (widget.error != null) {
      return ErrorIndicator(
        error: widget.error!,
        onTryAgain: widget.onRetry,
      );
    }

    // Empty
    if (widget.rows.isEmpty) {
      return const EmptyListIndicator();
    }

    // Data
    return Stack(
      children: <Widget>[
        _buildGrid(context),
        if (widget.isNextPageLoading)
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LinearProgressIndicator(minHeight: 2),
          ),
      ],
    );
  }

  // ── SfDataGrid ─────────────────────────────────────────────────────────────

  Widget _buildGrid(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: colors.surfaceContainerHighest,
        gridLineColor: colors.outlineVariant.withValues(alpha: 0.4),
        gridLineStrokeWidth: 0.5,
        selectionColor: colors.primary.withValues(alpha: 0.08),
        //currentCellStyle: DataGridCurrentCellStyle(borderColor: Colors.transparent, borderWidth: 0.0),
        rowHoverColor: colors.onSurface.withValues(alpha: 0.04),
      ),
      child: SfDataGrid(
        source: _source,
        selectionMode: widget.detailDrawerBuilder != null ||
            widget.onRowTap != null
            ? SelectionMode.single
            : SelectionMode.none,
        navigationMode: GridNavigationMode.row,
        onSelectionChanged: (
            List<DataGridRow> added,
            List<DataGridRow> removed,
            ) {
          if (added.isEmpty) return;
          final int idx = _source.rows.indexOf(added.first);
          if (idx < 0 || idx >= widget.rows.length) return;
          final T? data = widget.rows[idx].data;

          if (widget.detailDrawerBuilder != null) {
            setState(() => _selectedData = data);
          } else if (data != null) {
            widget.onRowTap?.call(data);
          }
        },
        columnWidthMode: ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.horizontal,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        rowHeight: widget.rowHeight,
        headerRowHeight: widget.headerRowHeight,
        columns: widget.columns.map((AppTableColumn col) {
          return GridColumn(
            columnName: col.key,
            minimumWidth: col.minWidth,
            label: _buildHeaderCell(col, context),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHeaderCell(AppTableColumn col, BuildContext context) {
    return Container(
      alignment: col.alignment == Alignment.centerRight
          ? Alignment.centerRight
          : col.alignment == Alignment.center
          ? Alignment.center
          : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        col.label,
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

  // ── Pager footer ───────────────────────────────────────────────────────────

  bool get _shouldShowPager =>
      !widget.isLoading &&
          widget.error == null &&
          widget.rows.isNotEmpty;

  Widget _buildPager(BuildContext context) {
    final ColorScheme colors = context.colorScheme;
    final int pageCount =
    (widget.totalCount / widget.rowsPerPage).ceil().clamp(1, 9999);

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        border: Border(
          top: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.4),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              '${widget.totalCount} records',
              style: TextStyle(
                fontSize: 12,
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          const Spacer(),
          SfDataPager(
            delegate: _source,
            controller: _pagerController,
            pageCount: pageCount.toDouble(),
            visibleItemsCount: 5,
            itemWidth: 36,
            itemHeight: 36,
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DataGridSource
// ─────────────────────────────────────────────────────────────────────────────

class _AppDataGridSource<T> extends DataGridSource {
  _AppDataGridSource({
    required List<AppTableRow<T>> rows,
    required this.onPageChange,
  }) {
    _buildDataGridRows(rows);
  }

  final Future<void> Function(int pageIndex) onPageChange;
  List<DataGridRow> _rows = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _rows;

  void updateRows(List<AppTableRow<T>> appRows) {
    _buildDataGridRows(appRows);
    notifyListeners();
  }

  void _buildDataGridRows(List<AppTableRow<T>> appRows) {
    _rows = appRows.map((AppTableRow<T> row) {
      return DataGridRow(
        cells: row.cells.entries.map((MapEntry<String, Widget> entry) {
          return DataGridCell<Widget>(
            columnName: entry.key,
            value: entry.value,
          );
        }).toList(),
      );
    }).toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((DataGridCell<dynamic> cell) {
        final Widget cellWidget = cell.value as Widget;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: cellWidget,
          ),
        );
      }).toList(),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    await onPageChange(newPageIndex);
    return true;
  }
}