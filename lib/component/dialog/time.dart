import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/time_dialog_props.dart';

/// A time picker dialog.
///
/// ```dart
/// ArcaneTimeDialog(
///   title: 'Select Time',
///   initialTime: TimeOfDay(hour: 14, minute: 30),
///   onConfirm: (time) => handleTime(time),
///   onCancel: () => closeDialog(),
/// )
/// ```
class ArcaneTimeDialog extends StatelessComponent {
  /// Dialog title
  final String title;

  /// Optional message/description
  final String? message;

  /// Initial time
  final TimeOfDay? initialTime;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Confirm callback with the selected time
  final void Function(TimeOfDay time)? onConfirm;

  /// Cancel callback
  final void Function()? onCancel;

  /// Whether to use 24-hour format
  final bool use24Hour;

  /// Minute interval
  final int minuteInterval;

  /// Whether to show seconds selector
  final bool showSeconds;

  const ArcaneTimeDialog({
    required this.title,
    this.message,
    this.initialTime,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.use24Hour = false,
    this.minuteInterval = 1,
    this.showSeconds = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.timeDialog(TimeDialogProps(
      title: title,
      message: message,
      initialTime: initialTime,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      use24Hour: use24Hour,
      minuteInterval: minuteInterval,
      showSeconds: showSeconds,
    ));
  }
}
