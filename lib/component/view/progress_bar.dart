import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// Progress bar component with various styles
///
/// ```dart
/// ArcaneProgressBar(
///   value: 0.75,
///   variant: ProgressVariant.success,
/// )
/// ```
class ArcaneProgressBar extends StatelessComponent {
  final double value;
  final ProgressSize size;
  final ProgressVariant variant;
  final bool indeterminate;
  final bool showValue;
  final String? trackColor;
  final String? indicatorColor;

  const ArcaneProgressBar({
    required this.value,
    this.size = ProgressSize.medium,
    this.variant = ProgressVariant.primary,
    this.indeterminate = false,
    this.showValue = false,
    this.trackColor,
    this.indicatorColor,
    super.key,
  });

  /// Standard progress bar
  const ArcaneProgressBar.standard({
    required this.value,
    this.size = ProgressSize.medium,
    this.showValue = false,
    super.key,
  })  : variant = ProgressVariant.primary,
        indeterminate = false,
        trackColor = null,
        indicatorColor = null;

  /// Success progress bar
  const ArcaneProgressBar.success({
    required this.value,
    this.size = ProgressSize.medium,
    this.showValue = false,
    super.key,
  })  : variant = ProgressVariant.success,
        indeterminate = false,
        trackColor = null,
        indicatorColor = null;

  /// Warning progress bar
  const ArcaneProgressBar.warning({
    required this.value,
    this.size = ProgressSize.medium,
    this.showValue = false,
    super.key,
  })  : variant = ProgressVariant.warning,
        indeterminate = false,
        trackColor = null,
        indicatorColor = null;

  /// Error progress bar
  const ArcaneProgressBar.error({
    required this.value,
    this.size = ProgressSize.medium,
    this.showValue = false,
    super.key,
  })  : variant = ProgressVariant.error,
        indeterminate = false,
        trackColor = null,
        indicatorColor = null;

  @override
  Component build(BuildContext context) {
    return context.renderers.progress(ProgressProps(
      value: value,
      size: size,
      variant: variant,
      indeterminate: indeterminate,
      showValue: showValue,
      trackColor: trackColor,
      indicatorColor: indicatorColor,
    ));
  }
}

/// Circular progress indicator
class ArcaneCircularProgress extends StatelessComponent {
  final double value;
  final String? size;
  final String? strokeWidth;
  final String? fillColor;
  final String? trackColor;
  final String? label;
  final bool showPercentage;

  const ArcaneCircularProgress({
    required this.value,
    this.size,
    this.strokeWidth,
    this.fillColor,
    this.trackColor,
    this.label,
    this.showPercentage = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.circularProgress(CircularProgressProps(
      value: value,
      size: size,
      strokeWidth: strokeWidth,
      fillColor: fillColor,
      trackColor: trackColor,
      label: label,
      showPercentage: showPercentage,
    ));
  }
}

/// Indeterminate loading spinner
class ArcaneLoadingSpinner extends StatelessComponent {
  final String? size;
  final String? color;

  const ArcaneLoadingSpinner({
    this.size,
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.loadingSpinner(LoadingSpinnerProps(
      size: size,
      color: color,
    ));
  }
}
