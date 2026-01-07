/// Input dialog types
enum InputDialogType {
  /// Standard text input
  text,

  /// Email input with validation
  email,

  /// Password input (obscured)
  password,

  /// Multiline text input
  multiline,

  /// Number input
  number,
}

/// Properties for input dialog components.
class InputDialogProps {
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

  /// Input type
  final InputDialogType type;

  /// Maximum length
  final int? maxLength;

  /// Number of lines for multiline input
  final int maxLines;

  /// Whether to require work/business email domains (email type only)
  final bool requireWorkEmail;

  /// Blocked domains for email (email type only)
  final List<String>? blockedDomains;

  /// Minimum value (number type only)
  final num? minValue;

  /// Maximum value (number type only)
  final num? maxValue;

  const InputDialogProps({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.type = InputDialogType.text,
    this.maxLength,
    this.maxLines = 1,
    this.requireWorkEmail = false,
    this.blockedDomains,
    this.minValue,
    this.maxValue,
  });
}
