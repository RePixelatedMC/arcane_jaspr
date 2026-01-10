import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/input/time_picker.dart';
import '../../../core/props/button_props.dart';
import '../../../core/props/dialog_props.dart';
import '../../../core/props/time_dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// Codex Time Dialog renderer.
class CodexTimeDialog extends StatefulComponent {
  final TimeDialogProps props;

  const CodexTimeDialog(this.props, {super.key});

  @override
  State<CodexTimeDialog> createState() => _CodexTimeDialogState();
}

class _CodexTimeDialogState extends State<CodexTimeDialog> {
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
    return CodexDialog(
      DialogProps(
        title: component.props.title,
        onClose: component.props.onCancel,
        maxWidth: 420,
        content: [
          dom.div(
            classes: 'codex-time-dialog-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '2rem',
            }),
            [
              if (component.props.message != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'color': 'var(--muted-foreground)',
                    'font-size': 'var(--arcane-font-size-sm)',
                    'line-height': '1.625',
                  }),
                  [Component.text(component.props.message!)],
                ),
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'align-items': 'center',
                  'gap': '0.75rem',
                  'font-size': '2.25rem',
                  'font-weight': 'var(--arcane-font-weight-bold)',
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
                        'font-size': 'var(--arcane-font-size-xl)',
                        'margin-left': '0.75rem',
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
                  'gap': '1.25rem',
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
                        'gap': 'var(--arcane-space-2)',
                      }),
                      [
                        const dom.span(
                          styles: dom.Styles(raw: {
                            'font-size': 'var(--arcane-font-size-xs)',
                            'font-weight': 'var(--arcane-font-weight-medium)',
                            'color': 'var(--muted-foreground)',
                            'text-transform': 'uppercase',
                            'text-align': 'center',
                            'margin-bottom': '0.5rem',
                          }),
                          [Component.text('Period')],
                        ),
                        dom.button(
                          classes: 'codex-time-dialog-option ${!_isPM ? 'selected' : ''}',
                          styles: dom.Styles(raw: {
                            'padding': '0.625rem 1.25rem',
                            'border': 'none',
                            'border-radius': 'var(--radius)',
                            'background': !_isPM ? 'var(--codex-accent)' : 'transparent',
                            'color': !_isPM ? '#ffffff' : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': 'var(--arcane-font-size-sm)',
                            'transition': 'all var(--arcane-transition)',
                          }),
                          events: {
                            'click': (_) {
                              if (_isPM) setState(() => _isPM = false);
                            },
                          },
                          [const Component.text('AM')],
                        ),
                        dom.button(
                          classes: 'codex-time-dialog-option ${_isPM ? 'selected' : ''}',
                          styles: dom.Styles(raw: {
                            'padding': '0.625rem 1.25rem',
                            'border': 'none',
                            'border-radius': 'var(--radius)',
                            'background': _isPM ? 'var(--codex-accent)' : 'transparent',
                            'color': _isPM ? '#ffffff' : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': 'var(--arcane-font-size-sm)',
                            'transition': 'all var(--arcane-transition)',
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
          CodexButton(ButtonProps(
            label: component.props.cancelText,
            variant: ButtonVariant.outline,
            onPressed: component.props.onCancel,
          )),
          CodexButton(ButtonProps(
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
        'gap': 'var(--arcane-space-2)',
      }),
      [
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-xs)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': 'var(--muted-foreground)',
            'text-transform': 'uppercase',
            'text-align': 'center',
            'margin-bottom': '0.5rem',
          }),
          [Component.text(label)],
        ),
        dom.div(
          classes: 'codex-time-dialog-column',
          styles: const dom.Styles(raw: {
            'max-height': '180px',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '4px',
          }),
          [
            for (final value in values)
              dom.button(
                classes: 'codex-time-dialog-option ${value == selectedValue ? 'selected' : ''}',
                styles: dom.Styles(raw: {
                  'padding': '0.375rem 1.25rem',
                  'border': 'none',
                  'border-radius': 'var(--radius)',
                  'background': value == selectedValue ? 'var(--codex-accent)' : 'transparent',
                  'color': value == selectedValue ? '#ffffff' : 'var(--foreground)',
                  'cursor': 'pointer',
                  'font-size': 'var(--arcane-font-size-sm)',
                  'text-align': 'center',
                  'min-width': '52px',
                  'transition': 'all var(--arcane-transition)',
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
