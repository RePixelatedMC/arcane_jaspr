import 'package:jaspr/jaspr.dart';

/// Aspect ratio container component properties.
class AspectRatioProps {
  final double ratio;
  final Component child;
  final String? classes;
  final Map<String, String>? styles;

  const AspectRatioProps({
    required this.ratio,
    required this.child,
    this.classes,
    this.styles,
  });
}
