import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/input/time_picker.dart';
import '../../../core/props/button_props.dart';
import '../../../core/props/dialog_props.dart';
import '../../../core/props/time_dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// ShadCN Time Dialog renderer.
class ShadcnTimeDialog extends StatefulComponent {
  final TimeDialogProps props;

  const ShadcnTimeDialog(this.props, {super.key});

  @override
  State<ShadcnTimeDialog> createState() => _ShadcnTimeDialogState();
}

class _ShadcnTimeDialogState extends State<ShadcnTimeDialog> {
  late int _hour;
  late int _minute;
  late int _second;
  late bool _isPM;

  @override
  void initState() {
    super.initState();
    final initial = component.props.initialTime ?? TimeOfDay.now();
    _hour = component.props.use24Hour ? initial.hour : initial.hourOfPeriod;
    _minute = initial.minute;
    _second = 0;
    _isPM = initial.isPM;
  }

  void _handleConfirm() {
    int hour24 = _hour;
    if (!component.props.use24Hour) {
      if (_isPM && _hour != 12) {
        hour24 = _hour + 12;
      } else if (!_isPM && _hour == 12) {
        hour24 = 0;
      }
    }
    component.props.onConfirm?.call(TimeOfDay(hour: hour24, minute: _minute));
  }

  @override
  Component build(BuildContext context) {
    return ShadcnDialog(
      DialogProps(
        title: component.props.title,
        onClose: component.props.onCancel,
        maxWidth: 400,
        content: [
          dom.div(
            classes: 'arcane-time-dialog-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '1.5rem',
            }),
            [
              if (component.props.message != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'color': 'var(--muted-foreground)',
                    'font-size': '0.875rem',
                    'line-height': '1.625',
                  }),
                  [Component.text(component.props.message!)],
                ),
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'align-items': 'center',
                  'gap': '0.5rem',
                  'font-size': '1.875rem',
                  'font-weight': '700',
                  'font-variant-numeric': 'tabular-nums',
                  'color': 'var(--foreground)',
                }),
                [
                  Component.text(_hour.toString().padLeft(2, '0')),
                  const Component.text(':'),
                  Component.text(_minute.toString().padLeft(2, '0')),
                  if (component.props.showSeconds) ...[
                    const Component.text(':'),
                    Component.text(_second.toString().padLeft(2, '0')),
                  ],
                  if (!component.props.use24Hour)
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'font-size': '1.125rem',
                        'margin-left': '0.5rem',
                        'color': 'var(--muted-foreground)',
                      }),
                      [Component.text(_isPM ? 'PM' : 'AM')],
                    ),
                ],
              ),
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'gap': '1rem',
                }),
                [
                  _buildTimeColumn(
                    label: 'Hour',
                    values: component.props.use24Hour
                        ? List.generate(24, (i) => i)
                        : List.generate(12, (i) => i == 0 ? 12 : i),
                    selectedValue: _hour,
                    onSelect: (h) => setState(() => _hour = h),
                  ),
                  _buildTimeColumn(
                    label: 'Minute',
                    values: List.generate(
                      60 ~/ component.props.minuteInterval,
                      (i) => i * component.props.minuteInterval,
                    ),
                    selectedValue: _minute,
                    onSelect: (m) => setState(() => _minute = m),
                    padZero: true,
                  ),
                  if (component.props.showSeconds)
                    _buildTimeColumn(
                      label: 'Second',
                      values: List.generate(60, (i) => i),
                      selectedValue: _second,
                      onSelect: (s) => setState(() => _second = s),
                      padZero: true,
                    ),
                  if (!component.props.use24Hour)
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
                            'text-align': 'center',
                            'margin-bottom': '0.25rem',
                          }),
                          [Component.text('Period')],
                        ),
                        dom.button(
                          classes: 'arcane-time-dialog-option ${!_isPM ? 'selected' : ''}',
                          styles: dom.Styles(raw: {
                            'padding': '0.5rem 1rem',
                            'border': 'none',
                            'border-radius': 'var(--radius)',
                            'background': !_isPM ? 'var(--primary)' : 'transparent',
                            'color': !_isPM ? 'var(--primary-foreground)' : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': '0.875rem',
                            'transition': 'all 150ms ease',
                          }),
                          events: {
                            'click': (_) {
                              if (_isPM) setState(() => _isPM = false);
                            },
                          },
                          [const Component.text('AM')],
                        ),
                        dom.button(
                          classes: 'arcane-time-dialog-option ${_isPM ? 'selected' : ''}',
                          styles: dom.Styles(raw: {
                            'padding': '0.5rem 1rem',
                            'border': 'none',
                            'border-radius': 'var(--radius)',
                            'background': _isPM ? 'var(--primary)' : 'transparent',
                            'color': _isPM ? 'var(--primary-foreground)' : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': '0.875rem',
                            'transition': 'all 150ms ease',
                          }),
                          events: {
                            'click': (_) {
                              if (!_isPM) setState(() => _isPM = true);
                            },
                          },
                          [const Component.text('PM')],
                        ),
                      ],
                    ),
                ],
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
          ShadcnButton(ButtonProps(
            label: component.props.confirmText,
            variant: ButtonVariant.primary,
            onPressed: _handleConfirm,
          )),
        ],
      ),
    );
  }

  Component _buildTimeColumn({
    required String label,
    required List<int> values,
    required int selectedValue,
    required void Function(int) onSelect,
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
            'text-align': 'center',
            'margin-bottom': '0.25rem',
          }),
          [Component.text(label)],
        ),
        dom.div(
          classes: 'arcane-time-dialog-column',
          styles: const dom.Styles(raw: {
            'max-height': '160px',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          }),
          [
            for (final value in values)
              dom.button(
                classes: 'arcane-time-dialog-option ${value == selectedValue ? 'selected' : ''}',
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
                  'click': (_) => onSelect(value),
                },
                [Component.text(padZero ? value.toString().padLeft(2, '0') : '$value')],
              ),
          ],
        ),
      ],
    );
  }
}