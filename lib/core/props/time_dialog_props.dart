
import '../../component/input/time_picker.dart';

/// Properties for time dialog components.
class TimeDialogProps {
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

  const TimeDialogProps({
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
  });
}
