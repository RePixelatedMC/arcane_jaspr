import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/select_props.dart';

/// Neon Select renderer.
class NeonSelect<T> extends StatelessComponent {
  final SelectProps<T> props;

  const NeonSelect(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (
      String height,
      String fontSize,
      String padding,
    ) = switch (props.size) {
      ComponentSize.sm => ('40px', '0.8125rem', '0.625rem 1rem'),
      ComponentSize.md => ('48px', '0.875rem', '0.75rem 1.25rem'),
      ComponentSize.lg => ('56px', '1rem', '1rem 1.5rem'),
    };

    // Get display text
    final String displayText = _getDisplayText();

    final bool hasError = props.error != null;
    final String borderColor = hasError
        ? 'var(--destructive)'
        : props.isOpen
        ? 'var(--primary)'
        : 'var(--neon-accent-border)';
    final String glowColor = hasError
        ? '0 0 0 2px color-mix(in srgb, var(--destructive) 24%, transparent)'
        : props.isOpen
        ? '0 0 0 2px color-mix(in srgb, var(--primary) 20%, transparent)'
        : 'none';

    return dom.div(
      classes:
          'neon-select ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      attributes: {
        'data-state': props.isOpen ? 'open' : 'closed',
        'data-disabled': '${props.disabled}',
        'data-size': props.size.name,
      },
      styles: const dom.Styles(raw: {'position': 'relative', 'width': '100%'}),
      [
        if (props.label != null)
          dom.label(
            classes: 'neon-select-label',
            styles: const dom.Styles(
              raw: {
                'display': 'block',
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'letter-spacing': '0',
                'text-transform': 'uppercase',
                'color': 'var(--foreground)',
                'margin-bottom': '0.75rem',
              },
            ),
            [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: const dom.Styles(
                    raw: {'color': 'var(--primary)', 'margin-left': '0.375rem'},
                  ),
                  [Component.text('*')],
                ),
            ],
          ),

        dom.button(
          classes: 'neon-select-trigger ${props.isOpen ? 'open' : ''}',
          attributes: {
            'type': 'button',
            'data-state': props.isOpen ? 'open' : 'closed',
            'data-disabled': '${props.disabled}',
            'data-variant': props.multiSelect ? 'multi' : 'single',
            'data-size': props.size.name,
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'width': '100%',
              'height': height,
              'padding': padding,
              'background':
                  'linear-gradient(180deg, color-mix(in srgb, var(--primary) 4%, var(--card)), var(--card))',
              'border': '1px solid $borderColor',
              'border-radius': 'var(--radius)',
              'font-size': fontSize,
              'color':
                  props.value != null ||
                      (props.values != null && props.values!.isNotEmpty)
                  ? 'var(--foreground)'
                  : 'var(--muted-foreground)',
              'cursor': props.disabled ? 'not-allowed' : 'pointer',
              'outline': 'none',
              'box-shadow': glowColor,
              'transition':
                  'border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease',
              if (props.disabled) 'opacity': '0.4',
            },
          ),
          events: props.disabled || props.onToggle == null
              ? null
              : {'click': (_) => props.onToggle!()},
          [
            if (props.prefix != null)
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'margin-right': '0.75rem',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [props.prefix!],
              ),

            // Display text
            dom.span(
              styles: const dom.Styles(
                raw: {
                  'flex': '1',
                  'text-align': 'left',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                },
              ),
              [Component.text(displayText)],
            ),

            if (props.clearable &&
                (props.value != null ||
                    (props.values != null && props.values!.isNotEmpty)))
              dom.span(
                classes: 'neon-select-clear',
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'width': '20px',
                    'height': '20px',
                    'margin-right': '0.5rem',
                    'color': 'var(--destructive)',
                    'cursor': 'pointer',
                    'transition': 'all 0.2s ease',
                  },
                ),
                events: props.onClear == null
                    ? null
                    : {
                        'click': (e) {
                          e.stopPropagation();
                          props.onClear!();
                        },
                      },
                [ArcaneIcon.x(size: IconSize.xs)],
              ),

            dom.span(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'color': 'var(--muted-foreground)',
                },
              ),
              [ArcaneIcon.chevronsUpDown(size: IconSize.sm)],
            ),
          ],
        ),

        if (props.isOpen)
          dom.div(
            classes: 'neon-select-dropdown',
            styles: dom.Styles(
              raw: {
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
                'background':
                    'linear-gradient(180deg, color-mix(in srgb, var(--primary) 5%, var(--card)), var(--card))',
                'backdrop-filter': 'blur(10px)',
                '-webkit-backdrop-filter': 'blur(10px)',
                'border': '1px solid var(--neon-accent-border)',
                'border-radius': 'var(--radius)',
                'box-shadow': '0 16px 36px rgba(0, 0, 0, 0.42)',
              },
            ),
            [
              if (props.searchable)
                dom.div(
                  classes: 'neon-select-search',
                  styles: const dom.Styles(
                    raw: {
                      'padding': '0.75rem',
                      'border-bottom': '1px solid rgba(var(--border-rgb), 0.3)',
                    },
                  ),
                  [
                    dom.input(
                      type: dom.InputType.text,
                      attributes: {
                        'placeholder': props.searchPlaceholder,
                        'value': props.searchQuery,
                      },
                      styles: const dom.Styles(
                        raw: {
                          'width': '100%',
                          'padding': '0.75rem 1rem',
                          'background':
                              'linear-gradient(180deg, color-mix(in srgb, var(--primary) 3%, var(--card)), var(--card))',
                          'border': '1px solid var(--neon-accent-border)',
                          'border-radius': 'var(--radius)',
                          'font-size': 'var(--font-size-sm)',
                          'color': 'var(--foreground)',
                          'outline': 'none',
                          'transition': 'all 0.2s ease',
                        },
                      ),
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

              if (props.loading)
                dom.div(
                  classes: 'neon-select-loading',
                  styles: const dom.Styles(
                    raw: {
                      'padding': '1.5rem',
                      'text-align': 'center',
                      'color': 'var(--muted-foreground)',
                    },
                  ),
                  [Component.text(props.loadingText)],
                )
              else if (props.filteredOptions.isEmpty)
                dom.div(
                  classes: 'neon-select-empty',
                  styles: const dom.Styles(
                    raw: {
                      'padding': '1.5rem',
                      'text-align': 'center',
                      'color': 'var(--muted-foreground)',
                    },
                  ),
                  [Component.text(props.emptyMessage)],
                )
              else
                dom.div(
                  classes: 'neon-select-options',
                  styles: const dom.Styles(raw: {'padding': '0.5rem'}),
                  [
                    for (final option in props.filteredOptions)
                      _buildOption(option),
                  ],
                ),
            ],
          ),

        if (hasError)
          dom.div(
            classes: 'neon-select-error',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
                'margin-top': '0.75rem',
              },
            ),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.div(
            classes: 'neon-select-helper',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
                'margin-top': '0.75rem',
              },
            ),
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
      classes:
          'neon-select-option ${isSelected ? 'selected' : ''} ${option.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'data-state': isSelected ? 'selected' : 'idle',
        'data-disabled': '${option.disabled}',
        if (option.disabled) 'disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': '0.875rem',
          'width': '100%',
          'padding': '0.875rem 1rem',
          'background': isSelected
              ? 'linear-gradient(180deg, color-mix(in srgb, var(--primary) 14%, transparent), color-mix(in srgb, var(--primary) 7%, transparent))'
              : 'transparent',
          'border': 'none',
          'border-radius': 'var(--radius)',
          'font-size': 'var(--font-size-sm)',
          'color': isSelected ? 'var(--primary)' : 'var(--foreground)',
          'text-align': 'left',
          'cursor': option.disabled ? 'not-allowed' : 'pointer',
          'transition': 'all 0.2s ease',
          if (isSelected)
            'box-shadow':
                'inset 0 0 0 1px color-mix(in srgb, var(--primary) 18%, transparent)',
          if (option.disabled) 'opacity': '0.4',
        },
      ),
      events: option.disabled || props.onSelect == null
          ? null
          : {'click': (_) => props.onSelect!(option.value)},
      [
        if (props.multiSelect && props.showCheckboxes)
          dom.div(
            styles: dom.Styles(
              raw: {
                'width': '20px',
                'height': '20px',
                'border-radius': 'var(--radius-sm)',
                'border': isSelected
                    ? '2px solid var(--primary)'
                    : '2px solid rgba(var(--border-rgb), 0.5)',
                'background': isSelected
                    ? 'linear-gradient(180deg, var(--primary), color-mix(in srgb, var(--primary) 70%, #065f46))'
                    : 'transparent',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'flex-shrink': '0',
                'box-shadow': isSelected
                    ? 'inset 0 0 0 1px color-mix(in srgb, #ffffff 15%, transparent)'
                    : 'none',
                'transition': 'all 0.2s ease',
              },
            ),
            [
              if (isSelected)
                dom.span(styles: const dom.Styles(raw: {'color': '#ffffff'}), [
                  ArcaneIcon.check(size: IconSize.xs),
                ]),
            ],
          ),

        if (option.icon != null)
          dom.div(
            styles: dom.Styles(
              raw: {
                'color': isSelected
                    ? 'var(--primary)'
                    : 'var(--muted-foreground)',
              },
            ),
            [option.icon!],
          ),

        // Label and subtitle
        dom.div(
          styles: const dom.Styles(raw: {'flex': '1', 'min-width': '0'}),
          [
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                },
              ),
              [Component.text(option.label)],
            ),
            if (option.subtitle != null)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                    'margin-top': '0.25rem',
                  },
                ),
                [Component.text(option.subtitle!)],
              ),
          ],
        ),

        // Description (right side)
        if (option.description != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-xs)',
                'color': 'var(--muted-foreground)',
                'flex-shrink': '0',
              },
            ),
            [Component.text(option.description!)],
          ),
      ],
    );
  }
}
