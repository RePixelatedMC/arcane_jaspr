import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/select_props.dart';

/// Codex Select renderer.
///
/// Implements the Codex design language:
/// - Larger sizes (1.25x)
/// - Accent focus ring with subtle glow
/// - Glass effect on dropdown
class CodexSelect<T> extends StatelessComponent {
  final SelectProps<T> props;

  const CodexSelect(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes - 1.25x larger
    final (String height, String fontSize, String padding) = switch (props.size) {
      SelectSize.sm => ('36px', '0.8125rem', '0.5rem 0.875rem'),
      SelectSize.md => ('44px', '0.875rem', '0.625rem 1rem'), // vs 40px
      SelectSize.lg => ('52px', '1rem', '0.75rem 1.25rem'), // vs 48px
    };

    // Get display text
    final String displayText = _getDisplayText();

    return dom.div(
      classes: 'codex-select ${props.disabled ? 'disabled' : ''} ${props.error != null ? 'error' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
      }),
      [
        // Label
        if (props.label != null)
          dom.label(
            classes: 'codex-select-label',
            styles: const dom.Styles(raw: {
              'display': 'block',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
              'margin-bottom': '0.5rem',
            }),
            [
              Component.text(props.label!),
              if (props.required)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'color': 'var(--destructive)',
                    'margin-left': '0.25rem',
                  }),
                  [const Component.text('*')],
                ),
            ],
          ),

        // Select trigger
        dom.button(
          classes: 'codex-select-trigger ${props.isOpen ? 'open' : ''}',
          attributes: {
            'type': 'button',
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'width': '100%',
            'height': height,
            'padding': padding,
            'background-color': 'var(--input)',
            'border': props.error != null
                ? '1px solid var(--destructive)'
                : props.isOpen
                    ? '1px solid var(--codex-accent)'
                    : '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'font-size': fontSize,
            'color': props.value != null || (props.values != null && props.values!.isNotEmpty)
                ? 'var(--foreground)'
                : 'var(--muted-foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'outline': 'none',
            'transition': 'all var(--transition)',
            // Codex: glow when open
            if (props.isOpen) 'box-shadow': '0 0 0 2px rgba(var(--codex-accent-rgb), 0.2)',
            if (props.disabled) 'opacity': '0.5',
          }),
          events: props.disabled || props.onToggle == null
              ? null
              : {'click': (_) => props.onToggle!()},
          [
            // Prefix
            if (props.prefix != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'margin-right': '0.5rem',
                  'color': 'var(--muted-foreground)',
                }),
                [props.prefix!],
              ),

            // Display text
            dom.span(
              styles: const dom.Styles(raw: {
                'flex': '1',
                'text-align': 'left',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(displayText)],
            ),

            // Clear button (if clearable and has value)
            if (props.clearable &&
                (props.value != null || (props.values != null && props.values!.isNotEmpty)))
              dom.span(
                classes: 'codex-select-clear',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '18px',
                  'height': '18px',
                  'margin-right': '0.25rem',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                }),
                events: props.onClear == null
                    ? null
                    : {
                        'click': (e) {
                          e.stopPropagation();
                          props.onClear!();
                        },
                      },
                [const Component.text('\u2715')],
              ),

            // Chevron
            dom.span(
              styles: dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'color': 'var(--muted-foreground)',
                'font-size': '0.75rem',
                'transition': 'transform var(--transition)',
                'transform': props.isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
              }),
              [const Component.text('\u25BC')],
            ),
          ],
        ),

        // Dropdown
        if (props.isOpen)
          dom.div(
            classes: 'codex-select-dropdown',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'z-index': '50',
              'width': '100%',
              'margin-top': '0.5rem',
              if (props.dropdownDirection == SelectDropdownDirection.up) ...{
                'bottom': '100%',
                'margin-bottom': '0.5rem',
                'margin-top': '0',
              },
              'max-height': props.maxDropdownHeight ?? '300px',
              'overflow-y': 'auto',
              // Codex: glass effect
              'background-color': 'rgba(10, 10, 10, 0.95)',
              'backdrop-filter': 'blur(12px)',
              '-webkit-backdrop-filter': 'blur(12px)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 10px 40px rgba(0, 0, 0, 0.3)',
            }),
            [
              // Search input
              if (props.searchable)
                dom.div(
                  classes: 'codex-select-search',
                  styles: const dom.Styles(raw: {
                    'padding': '0.5rem',
                    'border-bottom': '1px solid var(--border)',
                  }),
                  [
                    dom.input(
                      type: dom.InputType.text,
                      attributes: {
                        'placeholder': props.searchPlaceholder,
                        'value': props.searchQuery,
                      },
                      styles: const dom.Styles(raw: {
                        'width': '100%',
                        'padding': '0.5rem 0.75rem',
                        'background-color': 'var(--secondary)',
                        'border': '1px solid var(--border)',
                        'border-radius': 'var(--radius-md)',
                        'font-size': '0.875rem',
                        'color': 'var(--foreground)',
                        'outline': 'none',
                      }),
                      events: props.onSearchChange == null
                          ? null
                          : {
                              'input': (e) {
                                final dynamic target = e.target;
                                final String? value = target?.value;
                                if (value != null) props.onSearchChange!(value);
                              },
                            },
                    ),
                  ],
                ),

              // Loading state
              if (props.loading)
                dom.div(
                  classes: 'codex-select-loading',
                  styles: const dom.Styles(raw: {
                    'padding': '1rem',
                    'text-align': 'center',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text(props.loadingText)],
                )
              // Empty state
              else if (props.filteredOptions.isEmpty)
                dom.div(
                  classes: 'codex-select-empty',
                  styles: const dom.Styles(raw: {
                    'padding': '1rem',
                    'text-align': 'center',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text(props.emptyMessage)],
                )
              // Options
              else
                dom.div(
                  classes: 'codex-select-options',
                  styles: const dom.Styles(raw: {
                    'padding': '0.375rem',
                  }),
                  [
                    for (final option in props.filteredOptions)
                      _buildOption(option),
                  ],
                ),
            ],
          ),

        // Helper text or error
        if (props.error != null)
          dom.div(
            classes: 'codex-select-error',
            styles: const dom.Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--destructive)',
              'margin-top': '0.5rem',
            }),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.div(
            classes: 'codex-select-helper',
            styles: const dom.Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.5rem',
            }),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }

  String _getDisplayText() {
    if (props.multiSelect) {
      if (props.values == null || props.values!.isEmpty) {
        return props.placeholder;
      }
      if (props.showSelectedCount) {
        return '${props.values!.length} selected';
      }
      final List<String> labels = props.values!
          .map((v) => props.options.firstWhere((o) => o.value == v).label)
          .toList();
      return labels.join(', ');
    }

    if (props.value == null) {
      return props.placeholder;
    }

    final SelectOptionProps<T>? selectedOption = props.options
        .where((o) => o.value == props.value)
        .firstOrNull;

    return selectedOption?.label ?? props.placeholder;
  }

  Component _buildOption(SelectOptionProps<T> option) {
    final bool isSelected = props.multiSelect
        ? props.values?.contains(option.value) ?? false
        : props.value == option.value;

    return dom.button(
      classes: 'codex-select-option ${isSelected ? 'selected' : ''} ${option.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (option.disabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.75rem',
        'width': '100%',
        'padding': '0.625rem 0.75rem', // Codex: more padding
        'background-color': isSelected
            ? 'rgba(var(--codex-accent-rgb), 0.15)'
            : 'transparent',
        'border': 'none',
        'border-radius': 'var(--radius-md)',
        'font-size': '0.875rem',
        'color': isSelected ? 'var(--codex-accent)' : 'var(--foreground)',
        'text-align': 'left',
        'cursor': option.disabled ? 'not-allowed' : 'pointer',
        'transition': 'all var(--transition)',
        if (option.disabled) 'opacity': '0.5',
      }),
      events: option.disabled || props.onSelect == null
          ? null
          : {'click': (_) => props.onSelect!(option.value)},
      [
        // Checkbox for multi-select
        if (props.multiSelect && props.showCheckboxes)
          dom.div(
            styles: dom.Styles(raw: {
              'width': '18px',
              'height': '18px',
              'border-radius': 'var(--radius-sm)',
              'border': isSelected
                  ? '2px solid var(--codex-accent)'
                  : '2px solid var(--border)',
              'background-color': isSelected ? 'var(--codex-accent)' : 'transparent',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
            }),
            [
              if (isSelected)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'color': '#ffffff',
                    'font-size': '12px',
                    'font-weight': '700',
                  }),
                  [const Component.text('\u2713')],
                ),
            ],
          ),

        // Icon
        if (option.icon != null) option.icon!,

        // Label and subtitle
        dom.div(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(option.label)],
            ),
            if (option.subtitle != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.125rem',
                }),
                [Component.text(option.subtitle!)],
              ),
          ],
        ),

        // Description (right side)
        if (option.description != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
              'flex-shrink': '0',
            }),
            [Component.text(option.description!)],
          ),
      ],
    );
  }
}
