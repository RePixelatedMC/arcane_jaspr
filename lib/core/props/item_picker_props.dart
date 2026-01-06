import 'package:jaspr/jaspr.dart';

/// Properties for item picker dialog components.
class ItemPickerProps<T> {
  /// Dialog title
  final String title;

  /// Items to pick from
  final List<T> items;

  /// Builder for each item
  final Component Function(T item) itemBuilder;

  /// Currently selected item
  final T? selectedItem;

  /// Called when an item is selected
  final void Function(T item)? onSelect;

  /// Called when dialog is cancelled
  final void Function()? onCancel;

  /// Optional search/filter function
  final bool Function(T item, String query)? searchFilter;

  /// Whether to show search box
  final bool showSearch;

  /// Search placeholder
  final String searchPlaceholder;

  /// Confirm button text (null for immediate selection)
  final String? confirmText;

  /// Cancel button text
  final String cancelText;

  /// Whether multiple items can be selected
  final bool multiSelect;

  /// For multi-select: currently selected items
  final List<T>? selectedItems;

  /// For multi-select: callback with all selected items
  final void Function(List<T> items)? onMultiSelect;

  /// Maximum height for the list
  final int maxHeight;

  const ItemPickerProps({
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.selectedItem,
    this.onSelect,
    this.onCancel,
    this.searchFilter,
    this.showSearch = true,
    this.searchPlaceholder = 'Search...',
    this.confirmText,
    this.cancelText = 'Cancel',
    this.multiSelect = false,
    this.selectedItems,
    this.onMultiSelect,
    this.maxHeight = 400,
  });
}
