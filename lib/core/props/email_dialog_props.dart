import 'package:jaspr/jaspr.dart';

/// Properties for email dialog components.
class EmailDialogProps {
  /// Dialog title
  final String title;

  /// Optional message/description
  final String? message;

  /// Input placeholder
  final String placeholder;

  /// Initial email value
  final String? initialValue;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Confirm callback with the entered email
  final void Function(String email)? onConfirm;

  /// Cancel callback
  final void Function()? onCancel;

  /// Custom email validation (in addition to format validation)
  final String? Function(String email)? validator;

  /// Whether to require work/business email domains
  final bool requireWorkEmail;

  /// Blocked domains (e.g., disposable email providers)
  final List<String>? blockedDomains;

  const EmailDialogProps({
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
  });
}
