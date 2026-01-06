import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';
import '../../../core/props/dialog_props.dart';
import '../../../core/props/text_dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// ShadCN Text Input Dialog renderer.
class ShadcnTextInputDialog extends StatefulComponent {
  final TextInputDialogProps props;

  const ShadcnTextInputDialog(this.props, {super.key});

  @override
  State<ShadcnTextInputDialog> createState() => _ShadcnTextInputDialogState();
}

class _ShadcnTextInputDialogState extends State<ShadcnTextInputDialog> {
  late String _value;
  String? _error;

  @override
  void initState() {
    super.initState();
    _value = component.props.initialValue ?? '';
  }

  void _handleConfirm() {
    if (component.props.validator != null) {
      final String? error = component.props.validator!(_value);
      if (error != null) {
        setState(() => _error = error);
        return;
      }
    }
    component.props.onConfirm?.call(_value);
  }

  @override
  Component build(BuildContext context) {
    final bool isMultiline = component.props.maxLines > 1;

    return ShadcnDialog(
      DialogProps(
        title: component.props.title,
        onClose: component.props.onCancel,
        maxWidth: 450,
        content: [
          dom.div(
            classes: 'arcane-text-input-dialog-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '1rem',
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
                classes: 'arcane-text-input-dialog-input',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': '0.25rem',
                }),
                [
                  if (isMultiline)
                    dom.textarea(
                      attributes: {
                        'placeholder': component.props.placeholder,
                        'rows': '${component.props.maxLines}',
                        if (component.props.maxLength != null)
                          'maxlength': '${component.props.maxLength}',
                      },
                      styles: dom.Styles(raw: {
                        'width': '100%',
                        'min-height': '5rem',
                        'padding': '0.5rem 0.75rem',
                        'border': _error != null
                            ? '1px solid var(--destructive)'
                            : '1px solid var(--input)',
                        'border-radius': 'var(--radius)',
                        'background-color': 'transparent',
                        'color': 'var(--foreground)',
                        'font-size': '0.875rem',
                        'resize': 'vertical',
                        'font-family': 'inherit',
                        'outline': 'none',
                        'transition': 'border-color 150ms, box-shadow 150ms',
                      }),
                      events: {
                        'input': (event) {
                          final dynamic target = event.target;
                          if (target != null) {
                            setState(() {
                              _value = target.value ?? '';
                              _error = null;
                            });
                          }
                        },
                      },
                      [Component.text(_value)],
                    )
                  else
                    dom.input(
                      type: component.props.obscureText
                          ? dom.InputType.password
                          : dom.InputType.text,
                      attributes: {
                        'value': _value,
                        'placeholder': component.props.placeholder,
                        'autofocus': 'true',
                        if (component.props.maxLength != null)
                          'maxlength': '${component.props.maxLength}',
                      },
                      styles: dom.Styles(raw: {
                        'width': '100%',
                        'height': '2.5rem',
                        'padding': '0 0.75rem',
                        'border': _error != null
                            ? '1px solid var(--destructive)'
                            : '1px solid var(--input)',
                        'border-radius': 'var(--radius)',
                        'background-color': 'transparent',
                        'color': 'var(--foreground)',
                        'font-size': '0.875rem',
                        'outline': 'none',
                        'transition': 'border-color 150ms, box-shadow 150ms',
                      }),
                      events: {
                        'input': (event) {
                          final dynamic target = event.target;
                          if (target != null) {
                            setState(() {
                              _value = target.value ?? '';
                              _error = null;
                            });
                          }
                        },
                        'keydown': (event) {
                          if ((event as dynamic).key == 'Enter' && !isMultiline) {
                            _handleConfirm();
                          }
                        },
                      },
                    ),
                  if (_error != null)
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'color': 'var(--destructive)',
                        'font-size': '0.75rem',
                      }),
                      [Component.text(_error!)],
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
}
