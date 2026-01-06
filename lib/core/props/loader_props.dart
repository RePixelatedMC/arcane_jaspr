import 'package:jaspr/jaspr.dart';

/// Loader variant types
enum LoaderVariant {
  /// Spinning circle
  spinner,

  /// Bouncing dots
  dots,

  /// Pulsing circle
  pulse,
}

/// Props for the loader component
class LoaderProps {
  /// Loader variant
  final LoaderVariant variant;

  /// Size (CSS value)
  final String size;

  /// Color (CSS value)
  final String? color;

  /// Stroke width for spinner
  final String strokeWidth;

  /// Dot size for dots loader
  final String dotSize;

  const LoaderProps({
    this.variant = LoaderVariant.spinner,
    this.size = '32px',
    this.color,
    this.strokeWidth = '3px',
    this.dotSize = '8px',
  });

  /// Create spinner props
  const LoaderProps.spinner({
    this.size = '32px',
    this.color,
    this.strokeWidth = '3px',
  })  : variant = LoaderVariant.spinner,
        dotSize = '8px';

  /// Create dots props
  const LoaderProps.dots({
    this.color,
    this.dotSize = '8px',
  })  : variant = LoaderVariant.dots,
        size = '32px',
        strokeWidth = '3px';

  /// Create pulse props
  const LoaderProps.pulse({
    this.size = '40px',
    this.color,
  })  : variant = LoaderVariant.pulse,
        strokeWidth = '3px',
        dotSize = '8px';
}

/// Props for loading overlay
class LoadingOverlayProps {
  /// Custom loader component
  final Component? loader;

  /// Message to display
  final String? message;

  const LoadingOverlayProps({
    this.loader,
    this.message,
  });
}
