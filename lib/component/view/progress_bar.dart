import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/props/progress_props.dart';
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
    final percent = (value.clamp(0.0, 1.0) * 100).round();
    final actualSize = size ?? '80px';
    final actualStroke = strokeWidth ?? '8px';
    final effectiveFillColor = fillColor ?? 'var(--primary)';
    final effectiveTrackColor = trackColor ?? 'var(--muted)';

    return dom.div(
      classes: 'arcane-circular-progress',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'width': actualSize,
        'height': actualSize,
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
      }),
      [
        // Background circle using conic gradient
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'width': '100%',
            'height': '100%',
            'border-radius': '9999px',
            'background':
                'conic-gradient($effectiveFillColor 0deg ${value * 360}deg, $effectiveTrackColor ${value * 360}deg 360deg)',
            'mask':
                'radial-gradient(farthest-side, transparent calc(100% - $actualStroke), #fff calc(100% - $actualStroke))',
            '-webkit-mask':
                'radial-gradient(farthest-side, transparent calc(100% - $actualStroke), #fff calc(100% - $actualStroke))',
          }),
          [],
        ),
        // Center content
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'justify-content': 'center',
          }),
          [
            if (showPercentage)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '1.25rem',
                  'font-weight': '700',
                  'color': 'var(--foreground)',
                }),
                [dom.text('$percent%')],
              ),
            if (label != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--muted-foreground)',
                }),
                [dom.text(label!)],
              ),
          ],
        ),
      ],
    );
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
    final actualSize = size ?? '24px';

    return dom.div(
      classes: 'arcane-loading-spinner',
      styles: dom.Styles(raw: {
        'width': actualSize,
        'height': actualSize,
        'border': '3px solid var(--border)',
        'border-top-color': color ?? 'var(--primary)',
        'border-radius': '9999px',
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}
