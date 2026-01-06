import 'package:jaspr/jaspr.dart';

/// Text alignment for table columns.
enum DataTableTextAlign {
  left,
  center,
  right;

  String get css => switch (this) {
        DataTableTextAlign.left => 'left',
        DataTableTextAlign.center => 'center',
        DataTableTextAlign.right => 'right',
      };
}

/// A column definition for data tables.
class DataColumnProps<T> {
  final String header;
  final Component Function(T item) builder;
  final DataTableTextAlign align;
  final double? width;
  final bool sortable;

  const DataColumnProps({
    required this.header,
    required this.builder,
    this.align = DataTableTextAlign.left,
    this.width,
    this.sortable = false,
  });
}

/// Properties for data table components.
class DataTableProps<T> {
  /// The data items to display
  final List<T> items;

  /// Column definitions
  final List<DataColumnProps<T>> columns;

  /// Callback when a row is clicked
  final void Function(T item)? onRowTap;

  /// Whether rows are selectable
  final bool selectable;

  /// Currently selected items
  final Set<T> selectedItems;

  /// Whether to show row dividers
  final bool showDividers;

  /// Whether to show the header
  final bool showHeader;

  /// Fixed header
  final bool stickyHeader;

  /// Empty state message
  final String emptyMessage;

  /// Callback when selection changes
  final void Function(T item)? onToggleSelection;

  /// Callback when select all is toggled
  final void Function()? onToggleSelectAll;

  const DataTableProps({
    required this.items,
    required this.columns,
    this.onRowTap,
    this.selectable = false,
    this.selectedItems = const {},
    this.showDividers = true,
    this.showHeader = true,
    this.stickyHeader = false,
    this.emptyMessage = 'No data available',
    this.onToggleSelection,
    this.onToggleSelectAll,
  });
}
