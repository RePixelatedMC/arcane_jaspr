import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/select_props.dart';

/// Codex Select renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon borders and focus states
/// - Holographic-style dropdown with glass morphism
/// - Cyberpunk-inspired selection animations
/// - Neon accent colors on selected items
class CodexSelect<T> extends StatelessComponent {
  final SelectProps<T> props;

  const CodexSelect(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex Neon sizes - larger with more presence
    final (String height, String fontSize, String padding) = switch (props.size) {
      ComponentSize.sm => ('40px', '0.8125rem', '0.625rem 1rem'),
      ComponentSize.md => ('48px', '0.875rem', '0.75rem 1.25rem'),
      ComponentSize.lg => ('56px', '1rem', '1rem 1.5rem'),
    };

    // Get display text
    final String displayText = _getDisplayText();

    // Determine border and glow based on state
    final bool hasError = props.error != null;
    final String borderColor = hasError
        ? 'var(--destructive)'
        : props.isOpen
            ? 'var(--primary)'
            : 'rgba(var(--primary-rgb), 0.3)';
    final String glowColor = hasError
        ? '0 0 20px rgba(var(--destructive-rgb), 0.3)'
        : props.isOpen
            ? '0 0 20px rgba(var(--primary-rgb), 0.3)'
            : '0 0 10px rgba(var(--primary-rgb), 0.1)';

    return dom.div(
      classes: 'codex-select codex-neon ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
      }),
      [
        // Label with neon accent
        if (props.label != null)
          dom.label(
            classes: 'codex-select-label codex-neon',
            styles: const dom.Styles(raw: {
              'display': 'block',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'color': 'var(--foreground)',
              'margin-bottom': '0.75rem',
            }),
            [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--primary)',
                    'margin-left': '0.375rem',
                    'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.5)',
                  }),
                  [Component.text('*')],
                ),
            ],
          ),

        // Select trigger with neon styling
        dom.button(
          classes: 'codex-select-trigger codex-neon ${props.isOpen ? 'open' : ''}',
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
            'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(var(--card-rgb), 0.6) 100%)',
            'border': '1px solid $borderColor',
            'border-radius': 'var(--radius)',
            'font-size': fontSize,
            'color': props.value != null || (props.values != null && props.values!.isNotEmpty)
                ? 'var(--foreground)'
                : 'var(--muted-foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'outline': 'none',
            'box-shadow': glowColor,
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
            if (props.disabled) 'opacity': '0.4',
          }),
          events: props.disabled || props.onToggle == null
              ? null
              : {'click': (_) => props.onToggle!()},
          [
            // Prefix with neon glow
            if (props.prefix != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'margin-right': '0.75rem',
                  'color': 'var(--primary)',
                  'filter': 'drop-shadow(0 0 4px currentColor)',
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

            // Clear button with neon style
            if (props.clearable &&
                (props.value != null || (props.values != null && props.values!.isNotEmpty)))
              dom.span(
                classes: 'codex-select-clear',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '20px',
                  'height': '20px',
                  'margin-right': '0.5rem',
                  'color': 'var(--destructive)',
                  'cursor': 'pointer',
                  'transition': 'all 0.2s ease',
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

            // Chevron with neon glow
            dom.span(
              styles: dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'color': 'var(--primary)',
                'font-size': 'var(--font-size-xs)',
                'filter': 'drop-shadow(0 0 4px currentColor)',
                'transition': 'transform 0.3s ease',
                'transform': props.isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
              }),
              [const Component.text('\u25BC')],
            ),
          ],
        ),

        // Neon glass dropdown
        if (props.isOpen)
          dom.div(
            classes: 'codex-select-dropdown codex-neon',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'z-index': '50',
              'width': '100%',
              'margin-top': '0.75rem',
              if (props.dropdownDirection == SelectDropdownDirection.up) ...{
                'bottom': '100%',
                'margin-bottom': '0.75rem',
                'margin-top': '0',
              },
              'max-height': props.maxDropdownHeight ?? '320px',
              'overflow-y': 'auto',
              // Neon glass effect
              'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.95) 0%, rgba(var(--card-rgb), 0.9) 100%)',
              'backdrop-filter': 'blur(16px)',
              '-webkit-backdrop-filter': 'blur(16px)',
              'border': '1px solid rgba(var(--primary-rgb), 0.3)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.15), 0 20px 60px rgba(0, 0, 0, 0.5)',
            }),
            [
              // Search input with neon styling
              if (props.searchable)
                dom.div(
                  classes: 'codex-select-search',
                  styles: const dom.Styles(raw: {
                    'padding': '0.75rem',
                    'border-bottom': '1px solid rgba(var(--border-rgb), 0.3)',
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
                        'padding': '0.75rem 1rem',
                        'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(var(--card-rgb), 0.4) 100%)',
                        'border': '1px solid rgba(var(--primary-rgb), 0.2)',
                        'border-radius': 'var(--radius)',
                        'font-size': 'var(--font-size-sm)',
                        'color': 'var(--foreground)',
                        'outline': 'none',
                        'transition': 'all 0.2s ease',
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
                    'padding': '1.5rem',
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
                    'padding': '1.5rem',
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
                    'padding': '0.5rem',
                  }),
                  [
                    for (final option in props.filteredOptions)
                      _buildOption(option),
                  ],
                ),
            ],
          ),

        // Error with neon glow or helper text
        if (hasError)
          dom.div(
            classes: 'codex-select-error',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--destructive)',
              'text-shadow': '0 0 8px rgba(var(--destructive-rgb), 0.4)',
              'margin-top': '0.75rem',
            }),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.div(
            classes: 'codex-select-helper',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.75rem',
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
      classes: 'codex-select-option codex-neon ${isSelected ? 'selected' : ''} ${option.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (option.disabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.875rem',
        'width': '100%',
        'padding': '0.875rem 1rem',
        'background': isSelected
            ? 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.2) 0%, rgba(var(--primary-rgb), 0.1) 100%)'
            : 'transparent',
        'border': 'none',
        'border-radius': 'var(--radius)',
        'font-size': 'var(--font-size-sm)',
        'color': isSelected ? 'var(--primary)' : 'var(--foreground)',
        'text-align': 'left',
        'cursor': option.disabled ? 'not-allowed' : 'pointer',
        'transition': 'all 0.2s ease',
        if (isSelected) 'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.15)',
        if (option.disabled) 'opacity': '0.4',
      }),
      events: option.disabled || props.onSelect == null
          ? null
          : {'click': (_) => props.onSelect!(option.value)},
      [
        // Checkbox for multi-select with neon style
        if (props.multiSelect && props.showCheckboxes)
          dom.div(
            styles: dom.Styles(raw: {
              'width': '20px',
              'height': '20px',
              'border-radius': 'var(--radius-sm)',
              'border': isSelected
                  ? '2px solid var(--primary)'
                  : '2px solid rgba(var(--border-rgb), 0.5)',
              'background': isSelected
                  ? 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)'
                  : 'transparent',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
              'box-shadow': isSelected ? '0 0 15px rgba(var(--primary-rgb), 0.3)' : 'none',
              'transition': 'all 0.2s ease',
            }),
            [
              if (isSelected)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': '#ffffff',
                    'font-size': '12px',
                    'font-weight': 'var(--font-weight-bold)',
                    'text-shadow': '0 0 6px currentColor',
                  }),
                  [Component.text('\u2713')],
                ),
            ],
          ),

        // Icon with neon glow
        if (option.icon != null)
          dom.div(
            styles: dom.Styles(raw: {
              'color': isSelected ? 'var(--primary)' : 'var(--muted-foreground)',
              'filter': isSelected ? 'drop-shadow(0 0 4px currentColor)' : 'none',
            }),
            [option.icon!],
          ),

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
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.25rem',
                }),
                [Component.text(option.subtitle!)],
              ),
          ],
        ),

        // Description (right side)
        if (option.description != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
              'flex-shrink': '0',
            }),
            [Component.text(option.description!)],
          ),
      ],
    );
  }
}
