import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/text_dialog_props.dart';

/// A text input dialog component.
class ArcaneTextInputDialog extends StatelessComponent {
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
  Component build(BuildContext context) {
    return context.renderers.textInputDialog(TextInputDialogProps(
      title: title,
      message: message,
      placeholder: placeholder,
      initialValue: initialValue,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      validator: validator,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: maxLines,
    ));
  }
}
