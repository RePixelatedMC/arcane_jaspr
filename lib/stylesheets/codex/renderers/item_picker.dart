import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';
import '../../../core/props/dialog_props.dart';
import '../../../core/props/item_picker_props.dart';
import 'button.dart';
import 'dialog.dart';

/// Codex Item Picker Dialog renderer.
class CodexItemPicker<T> extends StatefulComponent {
  final ItemPickerProps<T> props;

  const CodexItemPicker(this.props, {super.key});

  @override
  State<CodexItemPicker<T>> createState() => _CodexItemPickerState<T>();
}

class _CodexItemPickerState<T> extends State<CodexItemPicker<T>> {
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

    return CodexDialog(
      DialogProps(
        title: component.props.title,
        onClose: component.props.onCancel,
        maxWidth: 520,
        content: [
          dom.div(
            classes: 'codex-item-picker-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '1.25rem',
            }),
            [
              if (component.props.showSearch)
                dom.div(
                  classes: 'codex-item-picker-search',
                  [
                    dom.input(
                      type: dom.InputType.text,
                      attributes: {
                        'value': _searchQuery,
                        'placeholder': component.props.searchPlaceholder,
                      },
                      styles: const dom.Styles(raw: {
                        'width': '100%',
                        'height': '2.75rem',
                        'padding': '0 1rem',
                        'border': '1px solid var(--border)',
                        'border-radius': 'var(--radius)',
                        'background': 'var(--input)',
                        'color': 'var(--foreground)',
                        'font-size': 'var(--arcane-font-size-sm)',
                        'outline': 'none',
                        'transition': 'border-color var(--arcane-transition)',
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
                classes: 'codex-item-picker-list',
                styles: dom.Styles(raw: {
                  'max-height': '${component.props.maxHeight}px',
                  'overflow-y': 'auto',
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': 'var(--arcane-space-2)',
                }),
                [
                  if (filteredItems.isEmpty)
                    const dom.div(
                      styles: dom.Styles(raw: {
                        'padding': '2rem',
                        'text-align': 'center',
                        'color': 'var(--muted-foreground)',
                        'font-size': 'var(--arcane-font-size-sm)',
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
                    'padding': '0.75rem 1rem',
                    'background': 'var(--secondary)',
                    'border-radius': 'var(--radius)',
                    'font-size': 'var(--arcane-font-size-sm)',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text('${_multiSelection.length} item(s) selected')],
                ),
            ],
          ),
        ],
        actions: [
          CodexButton(ButtonProps(
            label: component.props.cancelText,
            variant: ButtonVariant.outline,
            onPressed: component.props.onCancel,
          )),
          if (component.props.confirmText != null || component.props.multiSelect)
            CodexButton(ButtonProps(
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
      classes: 'codex-item-picker-item ${selected ? 'selected' : ''}',
      styles: dom.Styles(raw: {
        'width': '100%',
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.75rem',
        'padding': '0.75rem 1rem',
        'border': '1px solid ${selected ? 'rgba(var(--codex-accent-rgb), 0.5)' : 'var(--border)'}',
        'border-radius': 'var(--radius)',
        'background': selected ? 'rgba(var(--codex-accent-rgb), 0.1)' : 'transparent',
        'color': selected ? 'var(--codex-accent)' : 'var(--foreground)',
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
              'width': '1.25rem',
              'height': '1.25rem',
              'border-radius': 'var(--radius-sm)',
              'border': '2px solid ${selected ? 'var(--codex-accent)' : 'var(--border)'}',
              'background': selected ? 'var(--codex-accent)' : 'transparent',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
            }),
            [
              if (selected)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': '#ffffff',
                    'font-size': 'var(--arcane-font-size-xs)',
                    'font-weight': 'var(--arcane-font-weight-bold)',
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
              'color': 'var(--codex-accent)',
              'font-size': 'var(--arcane-font-size-base)',
            }),
            [Component.text('\u2713')],
          ),
      ],
    );
  }
}
