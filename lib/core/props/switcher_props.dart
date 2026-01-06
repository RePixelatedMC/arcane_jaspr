import 'package:jaspr/jaspr.dart';

/// Direction for switcher animation
enum SwitcherDirection {
  /// Slide up
  up,

  /// Slide down
  down,

  /// Slide left
  left,

  /// Slide right
  right,

  /// Fade in/out (no slide)
  fade,
}

/// Properties for switcher components.
class SwitcherProps {
  /// Currently visible child index
  final int index;

  /// Animation direction when transitioning
  final SwitcherDirection direction;

  /// Children to switch between
  final List<Component> children;

  /// Animation duration in milliseconds
  final int duration;

  const SwitcherProps({
    required this.index,
    required this.children,
    this.direction = SwitcherDirection.fade,
    this.duration = 300,
  });
}

/// Properties for indexed stack components.
class IndexedStackProps {
  /// Currently visible child index
  final int index;

  /// All children (all kept in DOM, only one visible)
  final List<Component> children;

  const IndexedStackProps({
    required this.index,
    required this.children,
  });
}
