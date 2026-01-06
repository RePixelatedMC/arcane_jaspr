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

import '../input/button.dart';
import 'dialog.dart';

/// A general-purpose item picker dialog.
///
/// ```dart
/// ArcaneItemPicker<String>(
///   title: 'Select Country',
///   items: ['USA', 'Canada', 'Mexico', 'UK', 'Germany'],
///   onSelect: (country) => handleSelection(country),
///   itemBuilder: (item) => text(item),
/// )
/// ```
class ArcaneItemPicker<T> extends StatefulComponent {
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
  State<ArcaneItemPicker<T>> createState() => _ItemPickerState<T>();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-item-picker-item:hover').styles(raw: {
      'background': 'var(--muted)',
    }),
    css('.arcane-item-picker-item.selected').styles(raw: {
      'background': 'hsl(var(--accent) / 0.1)',
      'border-color': 'var(--accent)',
    }),
    css('.arcane-item-picker-search input:focus').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 0 0 2px hsl(var(--accent) / 0.1)',
    }),
  ];
}

class _ItemPickerState<T> extends State<ArcaneItemPicker<T>> {
  String _searchQuery = '';
  T? _pendingSelection;
  late Set<T> _multiSelection;

  @override
  void initState() {
    super.initState();
    _pendingSelection = component.selectedItem;
    _multiSelection = Set.from(component.selectedItems ?? []);
  }

  List<T> get _filteredItems {
    if (_searchQuery.isEmpty || component.searchFilter == null) {
      return component.items;
    }
    return component.items
        .where((item) => component.searchFilter!(item, _searchQuery))
        .toList();
  }

  void _selectItem(T item) {
    if (component.multiSelect) {
      setState(() {
        if (_multiSelection.contains(item)) {
          _multiSelection.remove(item);
        } else {
          _multiSelection.add(item);
        }
      });
    } else if (component.confirmText == null) {
      // Immediate selection
      component.onSelect?.call(item);
    } else {
      // Pending selection until confirm
      setState(() => _pendingSelection = item);
    }
  }

  void _handleConfirm() {
    if (component.multiSelect) {
      component.onMultiSelect?.call(_multiSelection.toList());
    } else if (_pendingSelection != null) {
      component.onSelect?.call(_pendingSelection as T);
    }
  }

  bool _isSelected(T item) {
    if (component.multiSelect) {
      return _multiSelection.contains(item);
    }
    return _pendingSelection == item;
  }

  @override
  Component build(BuildContext context) {
    final filteredItems = _filteredItems;

    return ArcaneDialog(
      title: component.title,
      onClose: component.onCancel,
      maxWidth: 480,
      child: div(
        classes: 'arcane-item-picker-content',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '1rem',
        }),
        [
          // Search box
          if (component.showSearch)
            div(
              classes: 'arcane-item-picker-search',
              [
                input(
                  type: InputType.text,
                  attributes: {
                    'value': _searchQuery,
                    'placeholder': component.searchPlaceholder,
                  },
                  styles: const Styles(raw: {
                    'width': '100%',
                    'padding': '10px 0.5rem',
                    'padding-left': '36px',
                    'border': '1px solid var(--border)',
                    'border-radius': '0.375rem',
                    'background': 'var(--card)',
                    'color': 'var(--foreground)',
                    'font-size': '0.875rem',
                    'outline': 'none',
                  }),
                  events: {
                    'input': (event) {
                      final dynamic target = event.target;
                      if (target != null) {
                        setState(() => _searchQuery = target.value ?? '');
                      }
                    },
                  },
                ),
              ],
            ),

          // Items list
          div(
            classes: 'arcane-item-picker-list',
            styles: Styles(raw: {
              'max-height': '${component.maxHeight}px',
              'overflow-y': 'auto',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.25rem',
            }),
            [
              if (filteredItems.isEmpty)
                div(
                  styles: const Styles(raw: {
                    'padding': '1.5rem',
                    'text-align': 'center',
                    'color': 'var(--muted-foreground)',
                    'font-size': '0.875rem',
                  }),
                  [text('No items found')],
                )
              else
                for (final item in filteredItems)
                  _buildItemRow(item),
            ],
          ),

          // Selection summary for multi-select
          if (component.multiSelect && _multiSelection.isNotEmpty)
            div(
              styles: const Styles(raw: {
                'padding': '0.5rem 1rem',
                'background': 'var(--muted)',
                'border-radius': '0.375rem',
                'font-size': '0.875rem',
                'color': 'var(--muted-foreground)',
              }),
              [text('${_multiSelection.length} item(s) selected')],
            ),
        ],
      ),
      actions: [
        ArcaneButton.outline(
          label: component.cancelText,
          onPressed: component.onCancel,
        ),
        if (component.confirmText != null || component.multiSelect)
          ArcaneButton.primary(
            label: component.confirmText ?? 'Confirm',
            onPressed: _handleConfirm,
            disabled: component.multiSelect
                ? _multiSelection.isEmpty
                : _pendingSelection == null,
          ),
      ],
    );
  }

  Component _buildItemRow(T item) {
    final selected = _isSelected(item);

    return button(
      type: ButtonType.button,
      classes: 'arcane-item-picker-item ${selected ? 'selected' : ''}',
      styles: Styles(raw: {
        'width': '100%',
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'padding': '0.5rem',
        'border': '1px solid ${selected ? 'var(--accent)' : 'var(--border)'}',
        'border-radius': '0.375rem',
        'background': selected ? 'hsl(var(--accent) / 0.1)' : 'transparent',
        'color': 'var(--foreground)',
        'cursor': 'pointer',
        'text-align': 'left',
        'transition': 'all 150ms ease',
      }),
      events: {
        'click': (_) => _selectItem(item),
      },
      [
        // Checkbox for multi-select
        if (component.multiSelect)
          div(
            styles: Styles(raw: {
              'width': '18px',
              'height': '18px',
              'border-radius': '0.25rem',
              'border': '2px solid ${selected ? 'var(--accent)' : 'var(--border)'}',
              'background': selected ? 'var(--accent)' : 'transparent',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
            }),
            [
              if (selected)
                span(
                  styles: const Styles(raw: {
                    'color': 'var(--accent-foreground)',
                    'font-size': '12px',
                  }),
                  [text('✓')],
                ),
            ],
          ),

        // Item content
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [component.itemBuilder(item)],
        ),

        // Selection indicator for single-select
        if (!component.multiSelect && selected)
          span(
            styles: const Styles(raw: {
              'color': 'var(--accent)',
              'font-size': '1.125rem',
            }),
            [text('✓')],
          ),
      ],
    );
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
                [text(subtitle!)],
              ),
          ],
        ),
      ],
    );
  }
}
