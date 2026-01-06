import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/time_picker_props.dart';

/// ShadCN Time Picker renderer.
class ShadcnTimePicker extends StatelessComponent {
  final TimePickerProps props;

  const ShadcnTimePicker(this.props, {super.key});

  Map<String, String> get _sizeStyles => switch (props.size) {
        TimePickerSize.sm => {
            'height': '32px',
            'fontSize': '0.875rem',
          },
        TimePickerSize.md => {
            'height': '40px',
            'fontSize': '0.875rem',
          },
        TimePickerSize.lg => {
            'height': '48px',
            'fontSize': '1rem',
          },
      };

  @override
  Component build(BuildContext context) {
    final hasError = props.error != null;
    final hasValue = props.value != null;
    final sizeStyles = _sizeStyles;

    return dom.div(
      classes: 'arcane-time-picker ${props.isOpen ? 'open' : ''} ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
      }),
      [
        // Label
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),

        // Trigger button
        dom.button(
          classes: 'arcane-time-picker-trigger ${props.disabled ? 'disabled' : ''}',
          type: dom.ButtonType.button,
          attributes: {
            'aria-haspopup': 'dialog',
            'aria-expanded': '${props.isOpen}',
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.5rem',
            'width': '100%',
            'height': sizeStyles['height']!,
            'padding': '0 0.75rem',
            'background': 'var(--background)',
            'border': '1px solid ${hasError ? 'var(--destructive)' : 'var(--input)'}',
            'border-radius': 'var(--radius)',
            'font-size': sizeStyles['fontSize']!,
            'color': hasValue ? 'var(--foreground)' : 'var(--muted-foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'transition': 'all 150ms ease',
            'text-align': 'left',
            if (props.disabled) 'opacity': '0.5',
          }),
          events: {
            'click': (_) => props.onToggle?.call(),
          },
          [
            // Clock icon
            dom.span(
              styles: const dom.Styles(raw: {
                'color': 'var(--muted-foreground)',
              }),
              [ArcaneIcon.clock(size: IconSize.sm)],
            ),
            dom.span(
              styles: const dom.Styles(raw: {
                'flex': '1',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(props.displayText)],
            ),
            if (hasValue && props.clearable)
              dom.span(
                classes: 'arcane-time-picker-clear',
                attributes: {
                  'role': 'button',
                  'aria-label': 'Clear time',
                },
                styles: const dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'transition': 'color 150ms ease',
                }),
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

        // Time picker dropdown
        if (props.isOpen)
          dom.div(
            classes: 'arcane-time-picker-dropdown',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': '0.25rem',
              'z-index': '50',
              'background': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
              'padding': '1rem',
              'min-width': '280px',
            }),
            [
              // Time selection columns
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'gap': '1rem',
                }),
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
                      styles: const dom.Styles(raw: {
                        'display': 'flex',
                        'flex-direction': 'column',
                        'gap': '0.25rem',
                      }),
                      [
                        const dom.span(
                          styles: dom.Styles(raw: {
                            'font-size': '0.75rem',
                            'font-weight': '500',
                            'color': 'var(--muted-foreground)',
                            'text-transform': 'uppercase',
                            'margin-bottom': '0.25rem',
                          }),
                          [Component.text('Period')],
                        ),
                        dom.button(
                          classes: 'arcane-time-picker-option ${!props.isPM ? 'selected' : ''}',
                          type: dom.ButtonType.button,
                          styles: dom.Styles(raw: {
                            'padding': '0.5rem 1rem',
                            'border': 'none',
                            'border-radius': 'var(--radius)',
                            'background': !props.isPM ? 'var(--primary)' : 'transparent',
                            'color': !props.isPM ? 'var(--primary-foreground)' : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': '0.875rem',
                            'transition': 'all 150ms ease',
                          }),
                          events: {
                            'click': (_) {
                              if (props.isPM) props.onTogglePeriod?.call();
                            },
                          },
                          [const Component.text('AM')],
                        ),
                        dom.button(
                          classes: 'arcane-time-picker-option ${props.isPM ? 'selected' : ''}',
                          type: dom.ButtonType.button,
                          styles: dom.Styles(raw: {
                            'padding': '0.5rem 1rem',
                            'border': 'none',
                            'border-radius': 'var(--radius)',
                            'background': props.isPM ? 'var(--primary)' : 'transparent',
                            'color': props.isPM ? 'var(--primary-foreground)' : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': '0.875rem',
                            'transition': 'all 150ms ease',
                          }),
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

              // Action buttons
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'flex-end',
                  'gap': '0.5rem',
                  'margin-top': '1rem',
                  'padding-top': '1rem',
                  'border-top': '1px solid var(--border)',
                }),
                [
                  dom.button(
                    type: dom.ButtonType.button,
                    styles: const dom.Styles(raw: {
                      'padding': '0.5rem 1rem',
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius)',
                      'background': 'transparent',
                      'color': 'var(--foreground)',
                      'cursor': 'pointer',
                      'font-size': '0.875rem',
                    }),
                    events: {
                      'click': (_) => props.onCancel?.call(),
                    },
                    [const Component.text('Cancel')],
                  ),
                  dom.button(
                    type: dom.ButtonType.button,
                    styles: const dom.Styles(raw: {
                      'padding': '0.5rem 1rem',
                      'border': 'none',
                      'border-radius': 'var(--radius)',
                      'background': 'var(--primary)',
                      'color': 'var(--primary-foreground)',
                      'cursor': 'pointer',
                      'font-size': '0.875rem',
                    }),
                    events: {
                      'click': (_) => props.onConfirm?.call(),
                    },
                    [const Component.text('Confirm')],
                  ),
                ],
              ),
            ],
          ),

        // Error message
        if (props.error != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--destructive)',
            }),
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
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
      }),
      [
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': '0.75rem',
            'font-weight': '500',
            'color': 'var(--muted-foreground)',
            'text-transform': 'uppercase',
            'margin-bottom': '0.25rem',
          }),
          [Component.text(label)],
        ),
        dom.div(
          styles: const dom.Styles(raw: {
            'max-height': '200px',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          }),
          [
            for (final value in values)
              dom.button(
                classes: 'arcane-time-picker-option ${value == selectedValue ? 'selected' : ''}',
                type: dom.ButtonType.button,
                styles: dom.Styles(raw: {
                  'padding': '0.25rem 1rem',
                  'border': 'none',
                  'border-radius': 'var(--radius)',
                  'background': value == selectedValue ? 'var(--primary)' : 'transparent',
                  'color': value == selectedValue ? 'var(--primary-foreground)' : 'var(--foreground)',
                  'cursor': 'pointer',
                  'font-size': '0.875rem',
                  'text-align': 'center',
                  'min-width': '48px',
                  'transition': 'all 150ms ease',
                }),
                events: {
                  'click': (_) => onSelect?.call(value),
                },
                [Component.text(padZero ? value.toString().padLeft(2, '0') : '$value')],
              ),
          ],
        ),
      ],
    );
  }
}