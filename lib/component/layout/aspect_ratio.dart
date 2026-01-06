import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/aspect_ratio_props.dart';

/// A container that maintains a specific aspect ratio.
///
/// Uses the CSS `aspect-ratio` property for modern browsers.
///
/// Example:
/// ```dart
/// ArcaneAspectRatio(
///   ratio: 16 / 9,
///   child: ArcaneImage(src: 'video-thumbnail.jpg'),
/// )
/// ```
class ArcaneAspectRatio extends StatelessComponent {
  /// The aspect ratio as width / height (e.g., 16/9, 4/3, 1/1)
  final double ratio;

  /// The child component to display
  final Component child;

  /// Optional CSS class
  final String? classes;

  /// Optional inline styles
  final Map<String, String>? styles;

  const ArcaneAspectRatio({
    required this.ratio,
    required this.child,
    this.classes,
    this.styles,
    super.key,
  });

  /// Creates a square (1:1) aspect ratio container
  const ArcaneAspectRatio.square({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 1.0;

  /// Creates a video (16:9) aspect ratio container
  const ArcaneAspectRatio.video({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 16 / 9;

  /// Creates a widescreen (21:9) aspect ratio container
  const ArcaneAspectRatio.ultrawide({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 21 / 9;

  /// Creates a portrait (3:4) aspect ratio container
  const ArcaneAspectRatio.portrait({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 3 / 4;

  /// Creates a classic photo (4:3) aspect ratio container
  const ArcaneAspectRatio.photo({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 4 / 3;

  /// Creates a golden ratio (1.618:1) aspect ratio container
  const ArcaneAspectRatio.golden({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 1.618;

  @override
  Component build(BuildContext context) {
    return context.renderers.aspectRatio(AspectRatioProps(
      ratio: ratio,
      child: child,
      classes: classes,
      styles: styles,
    ));
  }
}
