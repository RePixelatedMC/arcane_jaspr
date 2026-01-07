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

/// General-purpose item picker dialog with search and multi-select support.
class ArcaneItemPicker<T> extends StatelessComponent {
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

/// Item option with optional subtitle and leading widget for the picker.
class ItemPickerOption<T> extends StatelessComponent {
  final T value;
  final Component child;
  final String? subtitle;
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
