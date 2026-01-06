import 'package:jaspr/jaspr.dart';

/// Props for confirm dialog renderer.
class ConfirmDialogProps {
  /// Dialog title
  final String title;

  /// Dialog message
  final String message;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Confirm callback
  final void Function()? onConfirm;

  /// Cancel callback
  final void Function()? onCancel;

  /// Whether this is a destructive action
  final bool destructive;

  /// Custom icon
  final Component? icon;

  const ConfirmDialogProps({
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.destructive = false,
    this.icon,
  });
}

/// Props for alert dialog renderer.
class AlertDialogProps {
  /// Dialog title
  final String title;

  /// Dialog message
  final String message;

  /// Button text
  final String buttonText;

  /// Dismiss callback
  final void Function()? onDismiss;

  /// Custom icon
  final Component? icon;

  const AlertDialogProps({
    required this.title,
    required this.message,
    this.buttonText = 'OK',
    this.onDismiss,
    this.icon,
  });
}
