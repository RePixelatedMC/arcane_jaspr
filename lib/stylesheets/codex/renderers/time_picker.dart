import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/time_picker_props.dart';

/// Codex Time Picker renderer.
class CodexTimePicker extends StatelessComponent {
  final TimePickerProps props;

  const CodexTimePicker(this.props, {super.key});

  Map<String, String> get _sizeStyles => switch (props.size) {
        TimePickerSize.sm => {
            'height': '36px',
            'fontSize': '0.875rem',
          },
        TimePickerSize.md => {
            'height': '44px',
            'fontSize': '0.875rem',
          },
        TimePickerSize.lg => {
            'height': '52px',
            'fontSize': '1rem',
          },
      };

  @override
  Component build(BuildContext context) {
    final hasError = props.error != null;
    final hasValue = props.value != null;
    final sizeStyles = _sizeStyles;

    return dom.div(
      classes: 'codex-time-picker ${props.isOpen ? 'open' : ''} ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-2)',
      }),
      [
        // Label
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),

        // Trigger button
        dom.button(
          classes: 'codex-time-picker-trigger ${props.disabled ? 'disabled' : ''}',
          type: dom.ButtonType.button,
          attributes: {
            'aria-haspopup': 'dialog',
            'aria-expanded': '${props.isOpen}',
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.75rem',
            'width': '100%',
            'height': sizeStyles['height']!,
            'padding': '0 1rem',
            'background': 'var(--input)',
            'border': '1px solid ${hasError ? 'var(--destructive)' : 'var(--border)'}',
            'border-radius': 'var(--radius)',
            'font-size': sizeStyles['fontSize']!,
            'color': hasValue ? 'var(--foreground)' : 'var(--muted-foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'transition': 'all var(--arcane-transition)',
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
                classes: 'codex-time-picker-clear',
                attributes: {
                  'role': 'button',
                  'aria-label': 'Clear time',
                },
                styles: const dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'transition': 'color var(--arcane-transition)',
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
            classes: 'codex-time-picker-dropdown',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': '0.5rem',
              'z-index': '50',
              'background': 'var(--card)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.1)',
              'padding': '1.25rem',
              'min-width': '300px',
            }),
            [
              // Time selection columns
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'gap': '1.25rem',
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
                        'gap': 'var(--space-2)',
                      }),
                      [
                        const dom.span(
                          styles: dom.Styles(raw: {
                            'font-size': 'var(--font-size-xs)',
                            'font-weight': 'var(--font-weight-medium)',
                            'color': 'var(--muted-foreground)',
                            'text-transform': 'uppercase',
                            'margin-bottom': '0.5rem',
                          }),
                          [Component.text('Period')],
                        ),
                        dom.button(
                          classes: 'codex-time-picker-option ${!props.isPM ? 'selected' : ''}',
                          type: dom.ButtonType.button,
                          styles: dom.Styles(raw: {
                            'padding': '0.625rem 1.25rem',
                            'border': 'none',
                            'border-radius': 'var(--radius)',
                            'background': !props.isPM ? 'var(--primary)' : 'transparent',
                            'color': !props.isPM ? '#ffffff' : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': 'var(--font-size-sm)',
                            'transition': 'all var(--arcane-transition)',
                          }),
                          events: {
                            'click': (_) {
                              if (props.isPM) props.onTogglePeriod?.call();
                            },
                          },
                          [const Component.text('AM')],
                        ),
                        dom.button(
                          classes: 'codex-time-picker-option ${props.isPM ? 'selected' : ''}',
                          type: dom.ButtonType.button,
                          styles: dom.Styles(raw: {
                            'padding': '0.625rem 1.25rem',
                            'border': 'none',
                            'border-radius': 'var(--radius)',
                            'background': props.isPM ? 'var(--primary)' : 'transparent',
                            'color': props.isPM ? '#ffffff' : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': 'var(--font-size-sm)',
                            'transition': 'all var(--arcane-transition)',
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
                  'gap': '0.75rem',
                  'margin-top': '1.25rem',
                  'padding-top': '1.25rem',
                  'border-top': '1px solid var(--border)',
                }),
                [
                  dom.button(
                    type: dom.ButtonType.button,
                    styles: const dom.Styles(raw: {
                      'padding': '0.625rem 1.25rem',
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius)',
                      'background': 'transparent',
                      'color': 'var(--foreground)',
                      'cursor': 'pointer',
                      'font-size': 'var(--font-size-sm)',
                    }),
                    events: {
                      'click': (_) => props.onCancel?.call(),
                    },
                    [const Component.text('Cancel')],
                  ),
                  dom.button(
                    type: dom.ButtonType.button,
                    styles: const dom.Styles(raw: {
                      'padding': '0.625rem 1.25rem',
                      'border': 'none',
                      'border-radius': 'var(--radius)',
                      'background': 'var(--primary)',
                      'color': '#ffffff',
                      'cursor': 'pointer',
                      'font-size': 'var(--font-size-sm)',
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
              'font-size': 'var(--font-size-sm)',
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
        'gap': 'var(--space-2)',
      }),
      [
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-xs)',
            'font-weight': 'var(--font-weight-medium)',
            'color': 'var(--muted-foreground)',
            'text-transform': 'uppercase',
            'margin-bottom': '0.5rem',
          }),
          [Component.text(label)],
        ),
        dom.div(
          styles: const dom.Styles(raw: {
            'max-height': '220px',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '4px',
          }),
          [
            for (final value in values)
              dom.button(
                classes: 'codex-time-picker-option ${value == selectedValue ? 'selected' : ''}',
                type: dom.ButtonType.button,
                styles: dom.Styles(raw: {
                  'padding': '0.375rem 1.25rem',
                  'border': 'none',
                  'border-radius': 'var(--radius)',
                  'background': value == selectedValue ? 'var(--primary)' : 'transparent',
                  'color': value == selectedValue ? '#ffffff' : 'var(--foreground)',
                  'cursor': 'pointer',
                  'font-size': 'var(--font-size-sm)',
                  'text-align': 'center',
                  'min-width': '52px',
                  'transition': 'all var(--arcane-transition)',
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
