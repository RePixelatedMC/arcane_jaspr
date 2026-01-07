import 'package:jaspr/jaspr.dart';

enum SwitcherDirection {
  up,
  down,
  left,
  right,
  fade,
}

/// Switcher component properties.
class SwitcherProps {
  final int index;
  final SwitcherDirection direction;
  final List<Component> children;
  final int duration;

  const SwitcherProps({
    required this.index,
    required this.children,
    this.direction = SwitcherDirection.fade,
    this.duration = 300,
  });
}

/// Indexed stack component properties.
class IndexedStackProps {
  final int index;
  final List<Component> children;

  const IndexedStackProps({
    required this.index,
    required this.children,
  });
}
