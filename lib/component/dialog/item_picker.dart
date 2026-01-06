import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../core/theme_provider.dart';

export '../../core/props/item_picker_props.dart';

/// A general-purpose item picker dialog.
///
/// ```dart
/// ArcaneItemPicker<String>(
///   title: 'Select Country',
///   items: ['USA', 'Canada', 'Mexico', 'UK', 'Germany'],
///   onSelect: (country) => handleSelection(country),
///   itemBuilder: (item) => Component.text(item),
/// )
/// ```
class ArcaneItemPicker<T> extends StatelessComponent {
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

  const ArcaneItemPicker({
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
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.itemPicker<T>(ItemPickerProps<T>(
      title: title,
      items: items,
      itemBuilder: itemBuilder,
      selectedItem: selectedItem,
      onSelect: onSelect,
      onCancel: onCancel,
      searchFilter: searchFilter,
      showSearch: showSearch,
      searchPlaceholder: searchPlaceholder,
      confirmText: confirmText,
      cancelText: cancelText,
      multiSelect: multiSelect,
      selectedItems: selectedItems,
      onMultiSelect: onMultiSelect,
      maxHeight: maxHeight,
    ));
  }
}

/// Item option for the picker
class ItemPickerOption<T> extends StatelessComponent {
  /// The item value
  final T value;

  /// Display content
  final Component child;

  /// Optional subtitle/description
  final String? subtitle;

  /// Optional leading widget
  final Component? leading;

  const ItemPickerOption({
    required this.value,
    required this.child,
    this.subtitle,
    this.leading,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.5rem',
      }),
      [
        if (leading != null) leading!,
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          }),
          [
            child,
            if (subtitle != null)
              span(
                styles: const Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(subtitle!)],
              ),
          ],
        ),
      ],
    );
  }
}
