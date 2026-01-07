import 'package:jaspr/jaspr.dart';

/// Item picker dialog component properties.
class ItemPickerProps<T> {
  final String title;
  final List<T> items;
  final Component Function(T item) itemBuilder;
  final T? selectedItem;
  final void Function(T item)? onSelect;
  final void Function()? onCancel;
  final bool Function(T item, String query)? searchFilter;
  final bool showSearch;
  final String searchPlaceholder;
  final String? confirmText;
  final String cancelText;
  final bool multiSelect;
  final List<T>? selectedItems;
  final void Function(List<T> items)? onMultiSelect;
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
