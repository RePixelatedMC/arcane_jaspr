import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/confirm_dialog_props.dart';

/// A confirmation dialog component.
class ArcaneConfirmDialog extends StatelessComponent {
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

  const ArcaneConfirmDialog({
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.destructive = false,
    this.icon,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.confirmDialog(ConfirmDialogProps(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      destructive: destructive,
      icon: icon,
    ));
  }
}

/// A simple alert dialog
class ArcaneAlertDialog extends StatelessComponent {
  final String title;
  final String message;
  final String buttonText;
  final void Function()? onDismiss;
  final Component? icon;

  const ArcaneAlertDialog({
    required this.title,
    required this.message,
    this.buttonText = 'OK',
    this.onDismiss,
    this.icon,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.alertDialog(AlertDialogProps(
      title: title,
      message: message,
      buttonText: buttonText,
      onDismiss: onDismiss,
      icon: icon,
    ));
  }
}
