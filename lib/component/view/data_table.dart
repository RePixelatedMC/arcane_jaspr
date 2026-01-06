import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/data_table_props.dart'
    show DataTableTextAlign, DataColumnProps;

/// A data table component for displaying tabular data.
class ArcaneDataTable<T> extends StatefulComponent {
  /// The data items to display
  final List<T> items;

  /// Column definitions
  final List<ArcaneDataColumn<T>> columns;

  /// Callback when a row is clicked
  final void Function(T item)? onRowTap;

  /// Whether rows are selectable
  final bool selectable;

  /// Currently selected items
  final Set<T>? selectedItems;

  /// Callback when selection changes
  final void Function(Set<T> selected)? onSelectionChanged;

  /// Whether to show row dividers
  final bool showDividers;

  /// Whether to show the header
  final bool showHeader;

  /// Fixed header
  final bool stickyHeader;

  /// Empty state message
  final String emptyMessage;

  const ArcaneDataTable({
    required this.items,
    required this.columns,
    this.onRowTap,
    this.selectable = false,
    this.selectedItems,
    this.onSelectionChanged,
    this.showDividers = true,
    this.showHeader = true,
    this.stickyHeader = false,
    this.emptyMessage = 'No data available',
    super.key,
  });

  @override
  State<ArcaneDataTable<T>> createState() => _DataTableState<T>();
}

class _DataTableState<T> extends State<ArcaneDataTable<T>> {
  late Set<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = component.selectedItems ?? {};
  }

  @override
  void didUpdateComponent(ArcaneDataTable<T> oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.selectedItems != null) {
      _selectedItems = component.selectedItems!;
    }
  }

  void _toggleSelection(T item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
    component.onSelectionChanged?.call(Set.from(_selectedItems));
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectedItems.length == component.items.length) {
        _selectedItems.clear();
      } else {
        _selectedItems = Set.from(component.items);
      }
    });
    component.onSelectionChanged?.call(Set.from(_selectedItems));
  }

  @override
  Component build(BuildContext context) {
    // Convert ArcaneDataColumn to DataColumnProps
    final columnProps = component.columns
        .map((c) => DataColumnProps<T>(
              header: c.header,
              builder: c.builder,
              align: c.align,
              width: c.width,
              sortable: c.sortable,
            ))
        .toList();

    // Delegate rendering to the current stylesheet's data table renderer
    return context.renderers.dataTable<T>(DataTableProps<T>(
      items: component.items,
      columns: columnProps,
      onRowTap: component.onRowTap,
      selectable: component.selectable,
      selectedItems: _selectedItems,
      showDividers: component.showDividers,
      showHeader: component.showHeader,
      stickyHeader: component.stickyHeader,
      emptyMessage: component.emptyMessage,
      onToggleSelection: _toggleSelection,
      onToggleSelectAll: _toggleSelectAll,
    ));
  }
}

/// A column definition for ArcaneDataTable
class ArcaneDataColumn<T> {
  final String header;
  final Component Function(T item) builder;
  final DataTableTextAlign align;
  final double? width;
  final bool sortable;

  const ArcaneDataColumn({
    required this.header,
    required this.builder,
    this.align = DataTableTextAlign.left,
    this.width,
    this.sortable = false,
  });
}
