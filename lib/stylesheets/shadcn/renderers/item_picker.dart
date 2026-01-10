import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';
import '../../../core/props/dialog_props.dart';
import '../../../core/props/item_picker_props.dart';
import 'button.dart';
import 'dialog.dart';

/// ShadCN Item Picker Dialog renderer.
class ShadcnItemPicker<T> extends StatefulComponent {
  final ItemPickerProps<T> props;

  const ShadcnItemPicker(this.props, {super.key});

  @override
  State<ShadcnItemPicker<T>> createState() => _ShadcnItemPickerState<T>();
}

class _ShadcnItemPickerState<T> extends State<ShadcnItemPicker<T>> {
  String _searchQuery = '';
  T? _pendingSelection;
  late Set<T> _multiSelection;

  @override
  void initState() {
    super.initState();
    _pendingSelection = component.props.selectedItem;
    _multiSelection = Set.from(component.props.selectedItems ?? []);
  }

  List<T> get _filteredItems {
    if (_searchQuery.isEmpty || component.props.searchFilter == null) {
      return component.props.items;
    }
    return component.props.items
        .where((item) => component.props.searchFilter!(item, _searchQuery))
        .toList();
  }

  void _selectItem(T item) {
    if (component.props.multiSelect) {
      setState(() {
        if (_multiSelection.contains(item)) {
          _multiSelection.remove(item);
        } else {
          _multiSelection.add(item);
        }
      });
    } else if (component.props.confirmText == null) {
      component.props.onSelect?.call(item);
    } else {
      setState(() => _pendingSelection = item);
    }
  }

  void _handleConfirm() {
    if (component.props.multiSelect) {
      component.props.onMultiSelect?.call(_multiSelection.toList());
    } else if (_pendingSelection != null) {
      component.props.onSelect?.call(_pendingSelection as T);
    }
  }

  bool _isSelected(T item) {
    if (component.props.multiSelect) {
      return _multiSelection.contains(item);
    }
    return _pendingSelection == item;
  }

  @override
  Component build(BuildContext context) {
    final filteredItems = _filteredItems;

    return ShadcnDialog(
      DialogProps(
        title: component.props.title,
        onClose: component.props.onCancel,
        maxWidth: 480,
        content: [
          dom.div(
            classes: 'arcane-item-picker-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': 'var(--space-4)',
            }),
            [
              if (component.props.showSearch)
                dom.div(
                  classes: 'arcane-item-picker-search',
                  [
                    dom.input(
                      type: dom.InputType.text,
                      attributes: {
                        'value': _searchQuery,
                        'placeholder': component.props.searchPlaceholder,
                      },
                      styles: const dom.Styles(raw: {
                        'width': '100%',
                        'height': '2.5rem',
                        'padding': '0 0.75rem',
                        'border': '1px solid var(--input)',
                        'border-radius': 'var(--radius)',
                        'background': 'transparent',
                        'color': 'var(--foreground)',
                        'font-size': 'var(--font-size-sm)',
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
              dom.div(
                classes: 'arcane-item-picker-list',
                styles: dom.Styles(raw: {
                  'max-height': '${component.props.maxHeight}px',
                  'overflow-y': 'auto',
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': 'var(--space-1)',
                }),
                [
                  if (filteredItems.isEmpty)
                    const dom.div(
                      styles: dom.Styles(raw: {
                        'padding': '1.5rem',
                        'text-align': 'center',
                        'color': 'var(--muted-foreground)',
                        'font-size': 'var(--font-size-sm)',
                      }),
                      [Component.text('No items found')],
                    )
                  else
                    for (final item in filteredItems) _buildItemRow(item),
                ],
              ),
              if (component.props.multiSelect && _multiSelection.isNotEmpty)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'padding': '0.5rem 1rem',
                    'background': 'var(--muted)',
                    'border-radius': 'var(--radius)',
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text('${_multiSelection.length} item(s) selected')],
                ),
            ],
          ),
        ],
        actions: [
          ShadcnButton(ButtonProps(
            label: component.props.cancelText,
            variant: ButtonVariant.outline,
            onPressed: component.props.onCancel,
          )),
          if (component.props.confirmText != null || component.props.multiSelect)
            ShadcnButton(ButtonProps(
              label: component.props.confirmText ?? 'Confirm',
              variant: ButtonVariant.primary,
              onPressed: _handleConfirm,
              disabled: component.props.multiSelect
                  ? _multiSelection.isEmpty
                  : _pendingSelection == null,
            )),
        ],
      ),
    );
  }

  Component _buildItemRow(T item) {
    final selected = _isSelected(item);

    return dom.button(
      type: dom.ButtonType.button,
      classes: 'arcane-item-picker-item ${selected ? 'selected' : ''}',
      styles: dom.Styles(raw: {
        'width': '100%',
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        'padding': '0.5rem 0.75rem',
        'border': '1px solid ${selected ? 'var(--ring)' : 'var(--border)'}',
        'border-radius': 'var(--radius)',
        'background': selected ? 'var(--accent)' : 'transparent',
        'color': selected ? 'var(--accent-foreground)' : 'var(--foreground)',
        'cursor': 'pointer',
        'text-align': 'left',
        'transition': 'all var(--arcane-transition)',
      }),
      events: {
        'click': (_) => _selectItem(item),
      },
      [
        if (component.props.multiSelect)
          dom.div(
            styles: dom.Styles(raw: {
              'width': '1rem',
              'height': '1rem',
              'border-radius': 'var(--arcane-radius-xs)',
              'border': '2px solid ${selected ? 'var(--primary)' : 'var(--border)'}',
              'background': selected ? 'var(--primary)' : 'transparent',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
            }),
            [
              if (selected)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--primary-foreground)',
                    'font-size': '0.625rem',
                    'font-weight': 'var(--font-weight-bold)',
                  }),
                  [Component.text('\u2713')],
                ),
            ],
          ),
        dom.div(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [component.props.itemBuilder(item)],
        ),
        if (!component.props.multiSelect && selected)
          const dom.span(
            styles: dom.Styles(raw: {
              'color': 'var(--primary)',
              'font-size': 'var(--font-size-base)',
            }),
            [Component.text('\u2713')],
          ),
      ],
    );
  }
}