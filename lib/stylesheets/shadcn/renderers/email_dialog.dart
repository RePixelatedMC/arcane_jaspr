import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';
import '../../../core/props/dialog_props.dart';
import '../../../core/props/email_dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// ShadCN Email Dialog renderer.
class ShadcnEmailDialog extends StatefulComponent {
  final EmailDialogProps props;

  const ShadcnEmailDialog(this.props, {super.key});

  @override
  State<ShadcnEmailDialog> createState() => _ShadcnEmailDialogState();
}

class _ShadcnEmailDialogState extends State<ShadcnEmailDialog> {
  late String _value;
  String? _error;

  static const _consumerDomains = [
    'gmail.com',
    'yahoo.com',
    'hotmail.com',
    'outlook.com',
    'aol.com',
    'icloud.com',
    'mail.com',
    'protonmail.com',
  ];

  @override
  void initState() {
    super.initState();
    _value = component.props.initialValue ?? '';
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    final domain = email.split('@').last.toLowerCase();

    if (component.props.blockedDomains != null &&
        component.props.blockedDomains!.contains(domain)) {
      return 'This email domain is not allowed';
    }

    if (component.props.requireWorkEmail && _consumerDomains.contains(domain)) {
      return 'Please use a work email address';
    }

    if (component.props.validator != null) {
      return component.props.validator!(email);
    }

    return null;
  }

  void _handleConfirm() {
    final error = _validateEmail(_value);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    component.props.onConfirm?.call(_value.trim());
  }

  @override
  Component build(BuildContext context) {
    return ShadcnDialog(
      DialogProps(
        title: component.props.title,
        onClose: component.props.onCancel,
        maxWidth: 450,
        content: [
          dom.div(
            classes: 'arcane-email-dialog-content',
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
                classes: 'arcane-email-dialog-input',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': '0.25rem',
                }),
                [
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'position': 'relative',
                      'display': 'flex',
                      'align-items': 'center',
                    }),
                    [
                      dom.span(
                        styles: const dom.Styles(raw: {
                          'position': 'absolute',
                          'left': '0.75rem',
                          'color': 'var(--muted-foreground)',
                          'pointer-events': 'none',
                        }),
                        [Component.text('@')],
                      ),
                      dom.input(
                        type: dom.InputType.email,
                        attributes: {
                          'value': _value,
                          'placeholder': component.props.placeholder,
                          'autofocus': 'true',
                          'autocomplete': 'email',
                        },
                        styles: dom.Styles(raw: {
                          'width': '100%',
                          'height': '2.5rem',
                          'padding': '0 0.75rem',
                          'padding-left': '2.25rem',
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
                            if ((event as dynamic).key == 'Enter') {
                              _handleConfirm();
                            }
                          },
                        },
                      ),
                    ],
                  ),
                  if (_error != null)
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'color': 'var(--destructive)',
                        'font-size': '0.75rem',
                        'display': 'flex',
                        'align-items': 'center',
                        'gap': '0.25rem',
                      }),
                      [Component.text(_error!)],
                    ),
                  if (component.props.requireWorkEmail)
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'color': 'var(--muted-foreground)',
                        'font-size': '0.75rem',
                      }),
                      [Component.text('Please use your work email address')],
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
