/// Progress bar size variants.
enum ProgressSize {
  /// Small (2px height)
  small,

  /// Medium (4px height) - default
  medium,

  /// Large (8px height)
  large,
}

/// Progress bar variant.
enum ProgressVariant {
  /// Default/primary color
  primary,

  /// Success color (green)
  success,

  /// Warning color (amber)
  warning,

  /// Error/destructive color (red)
  error,

  /// Info color (blue)
  info,
}

/// Properties for progress bar components.
class ProgressProps {
  /// Current progress value (0.0 to 1.0)
  final double value;

  /// Size variant
  final ProgressSize size;

  /// Color variant
  final ProgressVariant variant;

  /// Whether to show indeterminate animation
  final bool indeterminate;

  /// Whether to show the value as text
  final bool showValue;

  /// Custom track color
  final String? trackColor;

  /// Custom indicator color
  final String? indicatorColor;

  const ProgressProps({
    this.value = 0.0,
    this.size = ProgressSize.medium,
    this.variant = ProgressVariant.primary,
    this.indeterminate = false,
    this.showValue = false,
    this.trackColor,
    this.indicatorColor,
  });

  /// Create a copy with modified properties
  ProgressProps copyWith({
    double? value,
    ProgressSize? size,
    ProgressVariant? variant,
    bool? indeterminate,
    bool? showValue,
    String? trackColor,
    String? indicatorColor,
  }) {
    return ProgressProps(
      value: value ?? this.value,
      size: size ?? this.size,
      variant: variant ?? this.variant,
      indeterminate: indeterminate ?? this.indeterminate,
      showValue: showValue ?? this.showValue,
      trackColor: trackColor ?? this.trackColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
    );
  }
}

/// Properties for circular progress components.
class CircularProgressProps {
  /// Progress value (0.0 to 1.0)
  final double value;

  /// Size of the circle
  final String? size;

  /// Width of the stroke
  final String? strokeWidth;

  /// Fill color
  final String? fillColor;

  /// Track color
  final String? trackColor;

  /// Optional label
  final String? label;

  /// Whether to show percentage
  final bool showPercentage;

  const CircularProgressProps({
    required this.value,
    this.size,
    this.strokeWidth,
    this.fillColor,
    this.trackColor,
    this.label,
    this.showPercentage = true,
  });
}

/// Properties for loading spinner components.
class LoadingSpinnerProps {
  /// Size of the spinner
  final String? size;

  /// Color of the spinner
  final String? color;

  const LoadingSpinnerProps({
    this.size,
    this.color,
  });
}
