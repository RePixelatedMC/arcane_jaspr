import 'package:jaspr/jaspr.dart';

/// Toast notification variant.
enum ToastVariant {
  /// Default informational toast
  info,

  /// Success toast with green accent
  success,

  /// Warning toast with yellow/orange accent
  warning,

  /// Error toast with red accent
  error,

  /// Loading toast with spinner
  loading,
}

/// Toast position on screen.
enum ToastPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// Toast action button configuration.
class ToastAction {
  final String label;
  final void Function() onPressed;
  final bool destructive;

  const ToastAction({
    required this.label,
    required this.onPressed,
    this.destructive = false,
  });
}

/// Properties for toast components.
class ToastProps {
  /// Toast message (required)
  final String message;

  /// Optional title displayed above message
  final String? title;

  /// Optional description displayed below message
  final String? description;

  /// Toast variant (info, success, warning, error, loading)
  final ToastVariant variant;

  /// Screen position
  final ToastPosition position;

  /// Auto-dismiss duration in milliseconds (0 = no auto-dismiss)
  final int duration;

  /// Whether the toast can be dismissed by clicking close
  final bool dismissible;

  /// Optional action button
  final ToastAction? action;

  /// Custom icon (overrides default variant icon)
  final Component? icon;

  /// Unique ID for this toast (used by toast manager)
  final String? id;

  /// Whether the toast is in exit animation state
  final bool isExiting;

  /// Whether the toast is currently hovered
  final bool isHovered;

  /// Callback when mouse enters toast
  final void Function()? onMouseEnter;

  /// Callback when mouse leaves toast
  final void Function()? onMouseLeave;

  /// Callback when dismiss button is clicked
  final void Function()? onDismiss;

  const ToastProps({
    required this.message,
    this.title,
    this.description,
    this.variant = ToastVariant.info,
    this.position = ToastPosition.bottomRight,
    this.duration = 4000,
    this.dismissible = true,
    this.action,
    this.icon,
    this.id,
    this.isExiting = false,
    this.isHovered = false,
    this.onMouseEnter,
    this.onMouseLeave,
    this.onDismiss,
  });

  /// Create a copy with modified properties
  ToastProps copyWith({
    String? message,
    String? title,
    String? description,
    ToastVariant? variant,
    ToastPosition? position,
    int? duration,
    bool? dismissible,
    ToastAction? action,
    Component? icon,
    String? id,
    bool? isExiting,
    bool? isHovered,
    void Function()? onMouseEnter,
    void Function()? onMouseLeave,
    void Function()? onDismiss,
  }) {
    return ToastProps(
      message: message ?? this.message,
      title: title ?? this.title,
      description: description ?? this.description,
      variant: variant ?? this.variant,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      dismissible: dismissible ?? this.dismissible,
      action: action ?? this.action,
      icon: icon ?? this.icon,
      id: id ?? this.id,
      isExiting: isExiting ?? this.isExiting,
      isHovered: isHovered ?? this.isHovered,
      onMouseEnter: onMouseEnter ?? this.onMouseEnter,
      onMouseLeave: onMouseLeave ?? this.onMouseLeave,
      onDismiss: onDismiss ?? this.onDismiss,
    );
  }
}

/// Properties for toast container components.
class ToastContainerProps {
  /// Position for toasts
  final ToastPosition position;

  /// Maximum number of visible toasts
  final int maxVisible;

  /// Gap between toasts in pixels
  final double gap;

  /// Offset from edge in pixels
  final double offset;

  /// Active toasts to render
  final List<ToastProps> toasts;

  const ToastContainerProps({
    this.position = ToastPosition.bottomRight,
    this.maxVisible = 3,
    this.gap = 12,
    this.offset = 20,
    this.toasts = const [],
  });
}
