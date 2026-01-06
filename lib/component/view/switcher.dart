import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/switcher_props.dart';

/// Animated content switcher that transitions between children.
///
/// Use for wizards, step transitions, and content swaps.
///
/// ```dart
/// ArcaneSwitcher(
///   index: currentIndex,
///   direction: SwitcherDirection.left,
///   children: [
///     StepOne(),
///     StepTwo(),
///     StepThree(),
///   ],
/// )
/// ```
class ArcaneSwitcher extends StatelessComponent {
  /// Currently visible child index
  final int index;

  /// Animation direction when transitioning
  final SwitcherDirection direction;

  /// Children to switch between
  final List<Component> children;

  /// Animation duration in milliseconds
  final int duration;

  /// Callback when index changes (for controlled mode)
  final void Function(int)? onIndexChanged;

  const ArcaneSwitcher({
    required this.index,
    required this.children,
    this.direction = SwitcherDirection.fade,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  });

  /// Horizontal slide (left)
  const ArcaneSwitcher.horizontal({
    required this.index,
    required this.children,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  }) : direction = SwitcherDirection.left;

  /// Vertical slide (up)
  const ArcaneSwitcher.vertical({
    required this.index,
    required this.children,
    this.duration = 300,
    this.onIndexChanged,
    super.key,
  }) : direction = SwitcherDirection.up;

  /// Fade transition
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
///
/// Useful when children are dynamically generated and may change.
///
/// ```dart
/// ArcaneKeyedSwitcher<String>(
///   currentKey: selectedTab,
///   children: {
///     'home': HomeContent(),
///     'profile': ProfileContent(),
///     'settings': SettingsContent(),
///   },
/// )
/// ```
class ArcaneKeyedSwitcher<T> extends StatelessComponent {
  /// Currently active key
  final T currentKey;

  /// Map of keys to children
  final Map<T, Component> children;

  /// Animation direction
  final SwitcherDirection direction;

  /// Animation duration in milliseconds
  final int duration;

  /// Fallback component if key not found
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
///
/// Unlike Switcher which transitions, this simply hides/shows.
///
/// ```dart
/// ArcaneIndexedStack(
///   index: currentTab,
///   children: [
///     HeavyWidget1(),
///     HeavyWidget2(),
///     HeavyWidget3(),
///   ],
/// )
/// ```
class ArcaneIndexedStack extends StatelessComponent {
  /// Currently visible child index
  final int index;

  /// All children (all kept in DOM, only one visible)
  final List<Component> children;

  /// Whether to use lazy loading (only render visited children)
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
