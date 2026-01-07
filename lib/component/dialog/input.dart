import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/input_dialog_props.dart';

/// A unified input dialog component supporting text, email, password, multiline, and number inputs.
///
/// ```dart
/// ArcaneInputDialog.text(
///   title: 'Enter Name',
///   message: 'Please enter your name.',
///   onConfirm: (value) => handleName(value),
///   onCancel: () => closeDialog(),
/// )
/// ```
///
/// ```dart
/// ArcaneInputDialog.email(
///   title: 'Enter Email',
///   message: 'Please enter your email address.',
///   requireWorkEmail: true,
///   onConfirm: (email) => handleEmail(email),
///   onCancel: () => closeDialog(),
/// )
/// ```
class ArcaneInputDialog extends StatelessComponent {
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

  const ArcaneInputDialog({
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
    super.key,
  });

  /// Creates a text input dialog
  const ArcaneInputDialog.text({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.maxLength,
    super.key,
  })  : type = InputDialogType.text,
        maxLines = 1,
        requireWorkEmail = false,
        blockedDomains = null,
        minValue = null,
        maxValue = null;

  /// Creates an email input dialog with validation
  const ArcaneInputDialog.email({
    required this.title,
    this.message,
    this.placeholder = 'Enter email address...',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.requireWorkEmail = false,
    this.blockedDomains,
    super.key,
  })  : type = InputDialogType.email,
        maxLength = null,
        maxLines = 1,
        minValue = null,
        maxValue = null;

  /// Creates a password input dialog
  const ArcaneInputDialog.password({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.maxLength,
    super.key,
  })  : type = InputDialogType.password,
        maxLines = 1,
        requireWorkEmail = false,
        blockedDomains = null,
        minValue = null,
        maxValue = null;

  /// Creates a multiline text input dialog
  const ArcaneInputDialog.multiline({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.maxLength,
    this.maxLines = 4,
    super.key,
  })  : type = InputDialogType.multiline,
        requireWorkEmail = false,
        blockedDomains = null,
        minValue = null,
        maxValue = null;

  /// Creates a number input dialog
  const ArcaneInputDialog.number({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.minValue,
    this.maxValue,
    super.key,
  })  : type = InputDialogType.number,
        maxLength = null,
        maxLines = 1,
        requireWorkEmail = false,
        blockedDomains = null;

  @override
  Component build(BuildContext context) {
    return context.renderers.inputDialog(InputDialogProps(
      title: title,
      message: message,
      placeholder: placeholder,
      initialValue: initialValue,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      validator: validator,
      type: type,
      maxLength: maxLength,
      maxLines: maxLines,
      requireWorkEmail: requireWorkEmail,
      blockedDomains: blockedDomains,
      minValue: minValue,
      maxValue: maxValue,
    ));
  }
}
