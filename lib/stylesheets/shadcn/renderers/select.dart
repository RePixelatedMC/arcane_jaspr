import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/select_props.dart';

/// ShadCN-style select component
/// Reference: https://ui.shadcn.com/docs/components/select
class ShadcnSelect<T> extends StatelessComponent {
  final SelectProps<T> props;

  const ShadcnSelect(this.props, {super.key});

  Map<String, String> get _sizeConfig => switch (props.size) {
        ComponentSize.sm => {
            'height': '32px',
            'padding': '4px 8px',
            'fontSize': '13px',
            'iconSize': '12px',
          },
        ComponentSize.md => {
            'height': '40px',
            'padding': '8px 12px',
            'fontSize': '14px',
            'iconSize': '14px',
          },
        ComponentSize.lg => {
            'height': '48px',
            'padding': '12px 16px',
            'fontSize': '16px',
            'iconSize': '16px',
          },
      };

  bool get _hasSelection {
    if (props.multiSelect) {
      return (props.values ?? []).isNotEmpty;
    }
    return props.value != null;
  }

  String _getDisplayText() {
    if (props.multiSelect) {
      final values = props.values ?? [];
      if (values.isEmpty) return props.placeholder;

      if (props.showSelectedCount && values.length > 1) {
        return '${values.length} selected';
      }

      final selectedLabels = props.options
          .where((opt) => values.contains(opt.value))
          .map((opt) => opt.label)
          .toList();
      return selectedLabels.join(', ');
    } else {
      final selectedOption = props.value != null
          ? props.options.cast<SelectOptionProps<T>?>().firstWhere(
                (opt) => opt?.value == props.value,
                orElse: () => null,
              )
          : null;
      return selectedOption?.label ?? props.placeholder;
    }
  }

  @override
  Component build(BuildContext context) {
    final size = _sizeConfig;
    final hasError = props.error != null;
    final displayText = _getDisplayText();
    final dropdownMaxHeight = props.maxDropdownHeight ?? '300px';

    final dropdownPositionStyles =
        props.dropdownDirection == SelectDropdownDirection.up
            ? {'bottom': '100%', 'top': 'auto', 'margin-bottom': '4px'}
            : {'top': '100%', 'margin-top': '4px'};

    return dom.div(
      classes: 'arcane-select-wrapper',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-1)',
        'position': 'relative',
      }),
      [
        // Label
        if (props.label != null)
          dom.label(
            classes: 'arcane-select-label',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--space-1)',
            }),
            [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(raw: {'color': 'var(--destructive)'}),
                  [Component.text('*')],
                ),
            ],
          ),

        // Trigger button - ShadCN SelectTrigger
        dom.button(
          classes:
              'arcane-select ${hasError ? 'error' : ''} ${props.disabled ? 'disabled' : ''} ${props.isOpen ? 'open' : ''}',
          attributes: {
            'type': 'button',
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': 'var(--space-2)',
            'padding': size['padding']!,
            'min-height': size['height']!,
            'width': '100%',
            'background-color': 'var(--background)',
            'border': hasError
                ? '1px solid var(--destructive)'
                : '1px solid var(--input)',
            'border-radius': 'var(--arcane-radius-sm)',
            'color': 'var(--foreground)',
            'font-size': size['fontSize']!,
            'text-align': 'left',
            'cursor': props.disabled || props.loading ? 'not-allowed' : 'pointer',
            'opacity': props.disabled ? '0.5' : '1',
            'transition': 'border-color var(--arcane-transition)',
          }),
          events: props.onToggle != null ? {'click': (_) => props.onToggle!()} : null,
          [
            // Prefix
            if (props.prefix != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'color': 'var(--muted-foreground)',
                }),
                [props.prefix!],
              ),

            // Display text
            dom.span(
              styles: dom.Styles(raw: {
                'flex': '1',
                'color': _hasSelection
                    ? 'var(--foreground)'
                    : 'var(--muted-foreground)',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(displayText)],
            ),

            // Loading spinner
            if (props.loading)
              const dom.span(
                styles: dom.Styles(raw: {
                  'display': 'inline-block',
                  'width': '16px',
                  'height': '16px',
                  'border': '2px solid var(--border)',
                  'border-top-color': 'var(--primary)',
                  'border-radius': '50%',
                  'animation': 'spin 0.8s linear infinite',
                }),
                [],
              ),

            // Clear button
            if (!props.loading && props.clearable && _hasSelection)
              dom.span(
                classes: 'arcane-select-clear',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'padding': '2px',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'border-radius': 'var(--arcane-radius-xs)',
                }),
                events: props.onClear != null
                    ? {
                        'click': (event) {
                          event.stopPropagation();
                          props.onClear!();
                        },
                      }
                    : null,
                [const Component.text('\u{00D7}')], // Times symbol
              ),

            // Arrow - ShadCN SelectIcon
            if (!props.loading)
              dom.span(
                styles: dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'transition': 'transform var(--arcane-transition)',
                  'transform': props.isOpen ? 'rotate(180deg)' : 'rotate(0)',
                  'font-size': size['iconSize']!,
                }),
                [const Component.text('\u{25BC}')], // Down arrow
              ),
          ],
        ),

        // Dropdown - ShadCN SelectContent
        if (props.isOpen)
          dom.div(
            classes: 'arcane-select-dropdown',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'left': '0',
              'right': '0',
              'z-index': '50',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--arcane-radius-sm)',
              'box-shadow':
                  '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
              'max-height': dropdownMaxHeight,
              'overflow-y': 'auto',
              ...dropdownPositionStyles,
            }),
            [
              // Search input
              if (props.searchable)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'padding': '8px',
                    'border-bottom': '1px solid var(--border)',
                    'position': 'sticky',
                    'top': '0',
                    'background': 'var(--popover)',
                    'z-index': '1',
                  }),
                  [
                    dom.input(
                      type: dom.InputType.text,
                      attributes: {
                        'placeholder': props.searchPlaceholder,
                        'autofocus': 'true',
                      },
                      styles: const dom.Styles(raw: {
                        'width': '100%',
                        'padding': '4px 8px',
                        'border': '1px solid var(--border)',
                        'border-radius': 'var(--arcane-radius-xs)',
                        'background': 'transparent',
                        'color': 'var(--foreground)',
                        'font-size': 'var(--font-size-sm)',
                        'outline': 'none',
                      }),
                      events: props.onSearchChange != null
                          ? {
                              'input': (event) {
                                final target = event.target;
                                if (target != null) {
                                  props.onSearchChange!(
                                      (target as dynamic).value ?? '');
                                }
                              },
                              'click': (event) => event.stopPropagation(),
                            }
                          : null,
                    ),
                  ],
                ),

              // Loading state
              if (props.loading)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'padding': '24px 16px',
                    'color': 'var(--muted-foreground)',
                    'font-size': 'var(--font-size-sm)',
                    'text-align': 'center',
                  }),
                  [Component.text(props.loadingText)],
                )
              // Options - ShadCN SelectItem
              else
                dom.div(
                  classes: 'arcane-select-options',
                  styles: const dom.Styles(raw: {
                    'padding': '4px',
                  }),
                  [
                    if (props.filteredOptions.isEmpty)
                      dom.div(
                        styles: const dom.Styles(raw: {
                          'padding': '8px 16px',
                          'color': 'var(--muted-foreground)',
                          'font-size': 'var(--font-size-sm)',
                          'text-align': 'center',
                        }),
                        [Component.text(props.emptyMessage)],
                      )
                    else
                      for (final option in props.filteredOptions)
                        _buildOption(option),
                  ],
                ),
            ],
          ),

        // Helper text
        if (props.helperText != null && props.error == null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.helperText!)],
          ),

        // Error message
        if (props.error != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--destructive)',
            }),
            [Component.text(props.error!)],
          ),
      ],
    );
  }

  Component _buildOption(SelectOptionProps<T> option) {
    final isSelected = props.multiSelect
        ? (props.values?.contains(option.value) ?? false)
        : props.value == option.value;
    final isDisabled = option.disabled;

    final maxReached = props.multiSelect &&
        props.maxSelections != null &&
        !isSelected &&
        (props.values?.length ?? 0) >= props.maxSelections!;

    return dom.button(
      classes:
          'arcane-select-option ${isSelected ? 'selected' : ''} ${isDisabled || maxReached ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (isDisabled || maxReached) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        'width': '100%',
        'padding': '8px 12px',
        'background-color':
            isSelected ? 'var(--accent)' : 'transparent',
        'color': isSelected ? 'var(--accent-foreground)' : 'var(--foreground)',
        'border': 'none',
        'border-radius': 'var(--arcane-radius-xs)',
        'cursor': (isDisabled || maxReached) ? 'not-allowed' : 'pointer',
        'opacity': (isDisabled || maxReached) ? '0.5' : '1',
        'transition': 'background-color var(--arcane-transition), color var(--arcane-transition)',
        'text-align': 'left',
        'font-size': 'var(--font-size-sm)',
      }),
      events: props.onSelect != null && !isDisabled && !maxReached
          ? {'click': (_) => props.onSelect!(option.value)}
          : null,
      [
        // Checkbox for multi-select
        if (props.multiSelect && props.showCheckboxes)
          dom.div(
            styles: dom.Styles(raw: {
              'width': '16px',
              'height': '16px',
              'border': isSelected
                  ? '2px solid var(--primary)'
                  : '2px solid var(--border)',
              'border-radius': 'var(--arcane-radius-xs)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'background': isSelected ? 'var(--primary)' : 'transparent',
              'flex-shrink': '0',
            }),
            [
              if (isSelected)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--primary-foreground)',
                    'font-size': '10px',
                    'font-weight': 'var(--font-weight-bold)',
                  }),
                  [Component.text('\u{2713}')], // Checkmark
                ),
            ],
          ),

        // Icon
        if (option.icon != null) option.icon!,

        // Label and subtitle
        dom.div(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
            'overflow': 'hidden',
          }),
          [
            dom.span(
              styles: const dom.Styles(raw: {
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(option.label)],
            ),
            if (option.subtitle != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                }),
                [Component.text(option.subtitle!)],
              ),
          ],
        ),

        // Description
        if (option.description != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
              'flex-shrink': '0',
            }),
            [Component.text(option.description!)],
          ),

        // Checkmark for single select
        if (!props.multiSelect && isSelected)
          const dom.span(
            styles: dom.Styles(raw: {
              'color': 'var(--primary)',
              'flex-shrink': '0',
            }),
            [Component.text('\u{2713}')],
          ),
      ],
    );
  }
}