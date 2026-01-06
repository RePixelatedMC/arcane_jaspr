import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../input/button.dart';
import 'dialog.dart';

/// A text input dialog component.
class ArcaneTextInputDialog extends StatefulComponent {
  /// Dialog title
  final String title;

  /// Optional message/description
  final String? message;

  /// Input placeholder
  final String placeholder;

  /// Initial value
  final String? initialValue;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Confirm callback with the entered value
  final void Function(String value)? onConfirm;

  /// Cancel callback
  final void Function()? onCancel;

  /// Input validation
  final String? Function(String value)? validator;

  /// Whether to obscure the text (password input)
  final bool obscureText;

  /// Maximum length
  final int? maxLength;

  /// Whether the input is multiline
  final int maxLines;

  const ArcaneTextInputDialog({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.obscureText = false,
    this.maxLength,
    this.maxLines = 1,
    super.key,
  });

  @override
  State<ArcaneTextInputDialog> createState() => _TextInputDialogState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-text-input-dialog-input input:focus').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 0 0 2px hsl(var(--accent) / 0.1)',
    }),
    css('.arcane-text-input-dialog-input textarea:focus').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 0 0 2px hsl(var(--accent) / 0.1)',
    }),
  ];
}

class _TextInputDialogState extends State<ArcaneTextInputDialog> {
  late String _value;
  String? _error;

  @override
  void initState() {
    super.initState();
    _value = component.initialValue ?? '';
  }

  void _handleConfirm() {
    if (component.validator != null) {
      final String? error = component.validator!(_value);
      if (error != null) {
        setState(() {
          _error = error;
        });
        return;
      }
    }
    component.onConfirm?.call(_value);
  }

  @override
  Component build(BuildContext context) {
    final bool isMultiline = component.maxLines > 1;

    return ArcaneDialog(
      title: component.title,
      onClose: component.onCancel,
      maxWidth: 450,
      child: div(
        classes: 'arcane-text-input-dialog-content',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '1rem',
        }),
        [
          if (component.message != null)
            div(
              styles: const Styles(raw: {
                'color': 'var(--muted-foreground)',
                'font-size': '0.875rem',
                'line-height': '1.625',
              }),
              [text(component.message!)],
            ),

          // Input field
          div(
            classes: 'arcane-text-input-dialog-input',
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.25rem',
            }),
            [
              if (isMultiline)
                textarea(
                  attributes: {
                    'placeholder': component.placeholder,
                    'rows': '${component.maxLines}',
                    if (component.maxLength != null)
                      'maxlength': '${component.maxLength}',
                  },
                  styles: Styles(raw: {
                    'width': '100%',
                    'padding': '10px 0.5rem',
                    'border': _error != null
                        ? '1px solid var(--destructive)'
                        : '1px solid var(--border)',
                    'border-radius': '0.375rem',
                    'background-color': 'var(--card)',
                    'color': 'var(--foreground)',
                    'font-size': '0.875rem',
                    'resize': 'vertical',
                    'font-family': 'inherit',
                    'outline': 'none',
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
                  [text(_value)],
                )
              else
                input(
                  type: component.obscureText
                      ? InputType.password
                      : InputType.text,
                  attributes: {
                    'value': _value,
                    'placeholder': component.placeholder,
                    'autofocus': 'true',
                    if (component.maxLength != null)
                      'maxlength': '${component.maxLength}',
                  },
                  styles: Styles(raw: {
                    'width': '100%',
                    'padding': '10px 0.5rem',
                    'border': _error != null
                        ? '1px solid var(--destructive)'
                        : '1px solid var(--border)',
                    'border-radius': '0.375rem',
                    'background-color': 'var(--card)',
                    'color': 'var(--foreground)',
                    'font-size': '0.875rem',
                    'outline': 'none',
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
                span(
                  styles: const Styles(raw: {
                    'color': 'var(--destructive)',
                    'font-size': '0.75rem',
                  }),
                  [text(_error!)],
                ),
            ],
          ),
        ],
      ),
      actions: [
        ArcaneButton.outline(
          label: component.cancelText,
          onPressed: component.onCancel,
        ),
        ArcaneButton.primary(
          label: component.confirmText,
          onPressed: _handleConfirm,
        ),
      ],
    );
  }
}
