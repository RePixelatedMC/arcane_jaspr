import 'package:jaspr/jaspr.dart';

/// Properties for text input dialog components.
class TextInputDialogProps {
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

  /// Number of lines for multiline input
  final int maxLines;

  const TextInputDialogProps({
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
  });
}
