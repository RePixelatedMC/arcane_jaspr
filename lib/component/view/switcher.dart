import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../core/theme_provider.dart';

export '../../core/props/switcher_props.dart';

/// Animated content switcher that transitions between children.
class ArcaneSwitcher extends StatelessComponent {
  final int index;
  final SwitcherDirection direction;
  final List<Component> children;
  final int duration;
  final void Function(int)? onIndexChanged;

  const ArcaneSwitcher({
    required this.index,
    required this.children,
    this.direction = SwitcherDirection.fade,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  });

  const ArcaneSwitcher.horizontal({
    required this.index,
    required this.children,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  }) : direction = SwitcherDirection.left;

  const ArcaneSwitcher.vertical({
    required this.index,
    required this.children,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  }) : direction = SwitcherDirection.up;

  const ArcaneSwitcher.fade({
    required this.index,
    required this.children,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  }) : direction = SwitcherDirection.fade;

  @override
  Component build(BuildContext context) {
    return context.renderers.switcher(SwitcherProps(
      index: index,
      children: children,
      direction: direction,
      duration: duration,
    ));
  }
}

/// A keyed switcher that uses keys to determine which child to show.
class ArcaneKeyedSwitcher<T> extends StatelessComponent {
  final T currentKey;
  final Map<T, Component> children;
  final SwitcherDirection direction;
  final int duration;
  final Component? fallback;

  const ArcaneKeyedSwitcher({
    required this.currentKey,
    required this.children,
    this.direction = SwitcherDirection.fade,
    this.duration = 300,
    this.fallback,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final keys = children.keys.toList();
    final currentIndex = keys.indexOf(currentKey);

    if (currentIndex == -1) {
      return fallback ?? const div([]);
    }

    return context.renderers.switcher(SwitcherProps(
      index: currentIndex,
      direction: direction,
      duration: duration,
      children: children.values.toList(),
    ));
  }
}

/// An indexed stack that preserves state of all children.
class ArcaneIndexedStack extends StatelessComponent {
  final int index;
  final List<Component> children;
  final bool lazy;

  const ArcaneIndexedStack({
    required this.index,
    required this.children,
    this.lazy = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.indexedStack(IndexedStackProps(
      index: index,
      children: children,
    ));
  }
}
