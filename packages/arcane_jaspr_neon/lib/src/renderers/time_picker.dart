import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/time_picker_props.dart';

/// Neon Time Picker renderer.
class NeonTimePicker extends StatelessComponent {
  final TimePickerProps props;

  const NeonTimePicker(this.props, {super.key});

  Map<String, String> get _sizeStyles => switch (props.size) {
    ComponentSize.sm => {'height': '36px', 'fontSize': '0.875rem'},
    ComponentSize.md => {'height': '44px', 'fontSize': '0.875rem'},
    ComponentSize.lg => {'height': '52px', 'fontSize': '1rem'},
  };

  @override
  Component build(BuildContext context) {
    final hasError = props.error != null;
    final hasValue = props.value != null;
    final sizeStyles = _sizeStyles;

    return dom.div(
      classes:
          'neon-time-picker ${props.isOpen ? 'open' : ''} ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      attributes: {
        'data-state': props.isOpen ? 'open' : 'closed',
        'data-disabled': '${props.disabled}',
        'data-size': props.size.name,
      },
      styles: const dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-2)',
        },
      ),
      [
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-family': 'var(--font-heading)',
                'font-size': '0.75rem',
                'font-weight': '600',
                'letter-spacing': '0.08em',
                'text-transform': 'uppercase',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(props.label!)],
          ),

        dom.button(
          classes:
              'neon-time-picker-trigger ${props.disabled ? 'disabled' : ''}',
          type: dom.ButtonType.button,
          attributes: {
            'aria-haspopup': 'dialog',
            'aria-expanded': '${props.isOpen}',
            'data-state': props.isOpen ? 'open' : 'closed',
            'data-disabled': '${props.disabled}',
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.75rem',
              'width': '100%',
              'height': sizeStyles['height']!,
              'padding': '0 1rem',
              'background':
                  'linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), color-mix(in srgb, var(--card) 86%, transparent))',
              'border':
                  '1px solid ${hasError ? 'var(--destructive)' : 'var(--neon-control-border)'}',
              'clip-path': 'var(--neon-control-clip)',
              'font-size': sizeStyles['fontSize']!,
              'color': hasValue
                  ? 'var(--foreground)'
                  : 'var(--muted-foreground)',
              'cursor': props.disabled ? 'not-allowed' : 'pointer',
              'transition':
                  'border-color 0.18s ease, box-shadow 0.18s ease',
              'box-shadow':
                  props.isOpen ? 'var(--neon-glow-md)' : 'var(--neon-inset)',
              'text-align': 'left',
              if (props.disabled) 'opacity': '0.5',
            },
          ),
          events: {'click': (_) => props.onToggle?.call()},
          [
            dom.span(
              styles: dom.Styles(
                raw: {
                  'color': props.isOpen
                      ? 'var(--neon-accent)'
                      : 'var(--muted-foreground)',
                  'display': 'flex',
                },
              ),
              [ArcaneIcon.clock(size: IconSize.sm)],
            ),
            dom.span(
              styles: const dom.Styles(
                raw: {
                  'flex': '1',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                },
              ),
              [Component.text(props.displayText)],
            ),
            if (hasValue && props.clearable)
              dom.span(
                classes: 'neon-time-picker-clear',
                attributes: {'role': 'button', 'aria-label': 'Clear time'},
                styles: const dom.Styles(
                  raw: {
                    'color': 'var(--muted-foreground)',
                    'cursor': 'pointer',
                    'transition': 'color var(--arcane-transition)',
                  },
                ),
                events: {
                  'click': (e) {
                    e.stopPropagation();
                    props.onClear?.call();
                  },
                },
                [ArcaneIcon.x(size: IconSize.xs)],
              ),
          ],
        ),

        if (props.isOpen)
          dom.div(
            classes: 'neon-time-picker-dropdown neon-time-picker',
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'top': '100%',
                'left': '0',
                'margin-top': '0.5rem',
                'z-index': '50',
                'padding': '1.25rem',
                'min-width': '300px',
              },
            ),
            [
              // Time selection columns
              dom.div(
                styles: const dom.Styles(
                  raw: {'display': 'flex', 'gap': '1.25rem'},
                ),
                [
                  // Hours column
                  _buildTimeColumn(
                    label: 'Hour',
                    values: props.use24Hour
                        ? List.generate(24, (i) => i)
                        : List.generate(12, (i) => i == 0 ? 12 : i),
                    selectedValue: props.selectedHour,
                    onSelect: props.onSelectHour,
                  ),

                  // Minutes column
                  _buildTimeColumn(
                    label: 'Minute',
                    values: List.generate(
                      60 ~/ props.minuteInterval,
                      (i) => i * props.minuteInterval,
                    ),
                    selectedValue: props.selectedMinute,
                    onSelect: props.onSelectMinute,
                    padZero: true,
                  ),

                  // AM/PM selector (12-hour mode only)
                  if (!props.use24Hour)
                    dom.div(
                      styles: const dom.Styles(
                        raw: {
                          'display': 'flex',
                          'flex-direction': 'column',
                          'gap': 'var(--space-2)',
                        },
                      ),
                      [
                        const dom.span(
                          styles: dom.Styles(
                            raw: {
                              'font-family': 'var(--font-heading)',
                              'font-size': '0.6875rem',
                              'font-weight': '600',
                              'letter-spacing': '0.12em',
                              'color': 'var(--muted-foreground)',
                              'text-transform': 'uppercase',
                              'margin-bottom': '0.5rem',
                            },
                          ),
                          [Component.text('Period')],
                        ),
                        dom.button(
                          classes:
                              'neon-time-picker-option ${!props.isPM ? 'selected' : ''}',
                          type: dom.ButtonType.button,
                          styles: dom.Styles(
                            raw: {
                              'padding': '0.5rem 1rem',
                              'border': !props.isPM
                                  ? '1px solid var(--neon-accent)'
                                  : '1px solid transparent',
                              'clip-path': 'var(--neon-clip-xs)',
                              'background': !props.isPM
                                  ? 'var(--neon-accent)'
                                  : 'transparent',
                              'color': !props.isPM
                                  ? 'var(--neon-on-accent)'
                                  : 'var(--foreground)',
                              'cursor': 'pointer',
                              'font-size': 'var(--font-size-sm)',
                              'font-weight': '600',
                              'letter-spacing': '0.04em',
                              'transition':
                                  'background 0.15s ease, color 0.15s ease',
                            },
                          ),
                          events: {
                            'click': (_) {
                              if (props.isPM) props.onTogglePeriod?.call();
                            },
                          },
                          [const Component.text('AM')],
                        ),
                        dom.button(
                          classes:
                              'neon-time-picker-option ${props.isPM ? 'selected' : ''}',
                          type: dom.ButtonType.button,
                          styles: dom.Styles(
                            raw: {
                              'padding': '0.5rem 1rem',
                              'border': props.isPM
                                  ? '1px solid var(--neon-accent)'
                                  : '1px solid transparent',
                              'clip-path': 'var(--neon-clip-xs)',
                              'background': props.isPM
                                  ? 'var(--neon-accent)'
                                  : 'transparent',
                              'color': props.isPM
                                  ? 'var(--neon-on-accent)'
                                  : 'var(--foreground)',
                              'cursor': 'pointer',
                              'font-size': 'var(--font-size-sm)',
                              'font-weight': '600',
                              'letter-spacing': '0.04em',
                              'transition':
                                  'background 0.15s ease, color 0.15s ease',
                            },
                          ),
                          events: {
                            'click': (_) {
                              if (!props.isPM) props.onTogglePeriod?.call();
                            },
                          },
                          [const Component.text('PM')],
                        ),
                      ],
                    ),
                ],
              ),

              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'justify-content': 'flex-end',
                    'gap': '0.75rem',
                    'margin-top': '1.25rem',
                    'padding-top': '1.25rem',
                    'border-top': '1px solid var(--neon-panel-border)',
                  },
                ),
                [
                  dom.button(
                    type: dom.ButtonType.button,
                    classes: 'neon-button',
                    attributes: {'data-variant': 'ghost'},
                    styles: const dom.Styles(
                      raw: {
                        'padding': '0.5rem 1rem',
                        'background': 'transparent',
                        'color': 'var(--foreground)',
                        'cursor': 'pointer',
                        'font-size': 'var(--font-size-sm)',
                      },
                    ),
                    events: {'click': (_) => props.onCancel?.call()},
                    [const Component.text('Cancel')],
                  ),
                  dom.button(
                    type: dom.ButtonType.button,
                    classes: 'neon-button',
                    attributes: {'data-variant': 'primary'},
                    styles: const dom.Styles(
                      raw: {
                        'padding': '0.5rem 1rem',
                        'cursor': 'pointer',
                        'font-size': 'var(--font-size-sm)',
                      },
                    ),
                    events: {'click': (_) => props.onConfirm?.call()},
                    [const Component.text('Confirm')],
                  ),
                ],
              ),
            ],
          ),

        // Error message
        if (props.error != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
              },
            ),
            [Component.text(props.error!)],
          ),
      ],
    );
  }

  Component _buildTimeColumn({
    required String label,
    required List<int> values,
    required int selectedValue,
    required void Function(int)? onSelect,
    bool padZero = false,
  }) {
    return dom.div(
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-2)',
        },
      ),
      [
        dom.span(
          styles: const dom.Styles(
            raw: {
              'font-family': 'var(--font-heading)',
              'font-size': '0.6875rem',
              'font-weight': '600',
              'letter-spacing': '0.12em',
              'color': 'var(--muted-foreground)',
              'text-transform': 'uppercase',
              'margin-bottom': '0.5rem',
            },
          ),
          [Component.text(label)],
        ),
        dom.div(
          styles: const dom.Styles(
            raw: {
              'max-height': '220px',
              'overflow-y': 'auto',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '4px',
            },
          ),
          [
            for (final value in values)
              dom.button(
                classes:
                    'neon-time-picker-option ${value == selectedValue ? 'selected' : ''}',
                type: dom.ButtonType.button,
                styles: dom.Styles(
                  raw: {
                    'padding': '0.375rem 0.875rem',
                    'border': value == selectedValue
                        ? '1px solid var(--neon-accent)'
                        : '1px solid transparent',
                    'clip-path': 'var(--neon-clip-xs)',
                    'background': value == selectedValue
                        ? 'var(--neon-accent)'
                        : 'transparent',
                    'color': value == selectedValue
                        ? 'var(--neon-on-accent)'
                        : 'var(--foreground)',
                    'cursor': 'pointer',
                    'font-size': 'var(--font-size-sm)',
                    'font-variant-numeric': 'tabular-nums',
                    'text-align': 'center',
                    'min-width': '52px',
                    'transition':
                        'background 0.15s ease, color 0.15s ease',
                  },
                ),
                events: {'click': (_) => onSelect?.call(value)},
                [
                  Component.text(
                    padZero ? value.toString().padLeft(2, '0') : '$value',
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
