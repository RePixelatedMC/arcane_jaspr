import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';
import '../../../core/props/dialog_props.dart';
import '../../../core/props/input_dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// ShadCN Input Dialog renderer.
class ShadcnInputDialog extends StatefulComponent {
  final InputDialogProps props;

  const ShadcnInputDialog(this.props, {super.key});

  @override
  State<ShadcnInputDialog> createState() => _ShadcnInputDialogState();
}

class _ShadcnInputDialogState extends State<ShadcnInputDialog> {
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

  String? _validateInput(String value) {
    final InputDialogType type = component.props.type;

    // Type-specific validation
    switch (type) {
      case InputDialogType.email:
        return _validateEmail(value);
      case InputDialogType.number:
        return _validateNumber(value);
      default:
        break;
    }

    // Custom validator
    if (component.props.validator != null) {
      return component.props.validator!(value);
    }

    return null;
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

    final String domain = email.split('@').last.toLowerCase();

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

  String? _validateNumber(String value) {
    if (value.isEmpty) {
      return null;
    }

    final num? numValue = num.tryParse(value);
    if (numValue == null) {
      return 'Please enter a valid number';
    }

    if (component.props.minValue != null && numValue < component.props.minValue!) {
      return 'Value must be at least ${component.props.minValue}';
    }

    if (component.props.maxValue != null && numValue > component.props.maxValue!) {
      return 'Value must be at most ${component.props.maxValue}';
    }

    if (component.props.validator != null) {
      return component.props.validator!(value);
    }

    return null;
  }

  void _handleConfirm() {
    final String? error = _validateInput(_value);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    component.props.onConfirm?.call(_value.trim());
  }

  dom.InputType _getInputType() {
    switch (component.props.type) {
      case InputDialogType.email:
        return dom.InputType.email;
      case InputDialogType.password:
        return dom.InputType.password;
      case InputDialogType.number:
        return dom.InputType.number;
      default:
        return dom.InputType.text;
    }
  }

  @override
  Component build(BuildContext context) {
    final InputDialogType type = component.props.type;
    final bool isMultiline = type == InputDialogType.multiline;
    final bool isEmail = type == InputDialogType.email;

    return ShadcnDialog(
      DialogProps(
        title: component.props.title,
        onClose: component.props.onCancel,
        maxWidth: 450,
        content: [
          dom.div(
            classes: 'arcane-input-dialog-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': 'var(--space-4)',
            }),
            [
              if (component.props.message != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'color': 'var(--muted-foreground)',
                    'font-size': 'var(--font-size-sm)',
                    'line-height': '1.625',
                  }),
                  [Component.text(component.props.message!)],
                ),
              dom.div(
                classes: 'arcane-input-dialog-input',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': 'var(--space-1)',
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
                        'font-size': 'var(--font-size-sm)',
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
                  else if (isEmail)
                    dom.div(
                      styles: const dom.Styles(raw: {
                        'position': 'relative',
                        'display': 'flex',
                        'align-items': 'center',
                      }),
                      [
                        const dom.span(
                          styles: dom.Styles(raw: {
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
                            'font-size': 'var(--font-size-sm)',
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
                    )
                  else
                    dom.input(
                      type: _getInputType(),
                      attributes: {
                        'value': _value,
                        'placeholder': component.props.placeholder,
                        'autofocus': 'true',
                        if (component.props.maxLength != null)
                          'maxlength': '${component.props.maxLength}',
                        if (type == InputDialogType.number) ...<String, String>{
                          if (component.props.minValue != null)
                            'min': '${component.props.minValue}',
                          if (component.props.maxValue != null)
                            'max': '${component.props.maxValue}',
                        },
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
                        'font-size': 'var(--font-size-sm)',
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
                  if (_error != null)
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'color': 'var(--destructive)',
                        'font-size': 'var(--font-size-xs)',
                        'display': 'flex',
                        'align-items': 'center',
                        'gap': 'var(--space-1)',
                      }),
                      [Component.text(_error!)],
                    ),
                  if (isEmail && component.props.requireWorkEmail)
                    const dom.span(
                      styles: dom.Styles(raw: {
                        'color': 'var(--muted-foreground)',
                        'font-size': 'var(--font-size-xs)',
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
