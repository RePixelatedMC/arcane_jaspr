import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/email_dialog_props.dart';

/// An email input dialog with validation.
///
/// ```dart
/// ArcaneEmailDialog(
///   title: 'Enter Email',
///   message: 'Please enter your email address.',
///   onConfirm: (email) => handleEmail(email),
///   onCancel: () => closeDialog(),
/// )
/// ```
class ArcaneEmailDialog extends StatelessComponent {
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

  const ArcaneEmailDialog({
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
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.emailDialog(EmailDialogProps(
      title: title,
      message: message,
      placeholder: placeholder,
      initialValue: initialValue,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      validator: validator,
      requireWorkEmail: requireWorkEmail,
      blockedDomains: blockedDomains,
    ));
  }
}
