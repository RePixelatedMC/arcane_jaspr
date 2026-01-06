import 'package:jaspr/jaspr.dart';

/// Properties for aspect ratio container components.
class AspectRatioProps {
  /// The aspect ratio as width / height (e.g., 16/9, 4/3, 1/1)
  final double ratio;

  /// The child component to display
  final Component child;

  /// Optional CSS class
  final String? classes;

  /// Optional inline styles
  final Map<String, String>? styles;

  const AspectRatioProps({
    required this.ratio,
    required this.child,
    this.classes,
    this.styles,
  });
}
