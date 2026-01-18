import 'package:jaspr/jaspr.dart';

enum ProgressSize {
  small,
  medium,
  large,
}

enum ProgressVariant {
  primary,
  success,
  warning,
  error,
  info,
}

/// Progress bar component properties.
class ProgressProps {
  final double value;
  final ProgressSize size;
  final ProgressVariant variant;
  final bool indeterminate;
  final bool showValue;
  final String? trackColor;
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

/// Circular progress component properties.
class CircularProgressProps {
  final double value;
  final String? size;
  final String? strokeWidth;
  final String? fillColor;
  final String? trackColor;
  final String? label;
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

/// Loading spinner component properties.
class LoadingSpinnerProps {
  final String? size;
  final String? color;

  const LoadingSpinnerProps({
    this.size,
    this.color,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for progress components.
mixin ProgressRendererContract {
  /// Renders a linear progress bar component.
  Component progress(ProgressProps props);

  /// Renders a circular progress indicator component.
  Component circularProgress(CircularProgressProps props);

  /// Renders a loading spinner component.
  Component loadingSpinner(LoadingSpinnerProps props);
}
