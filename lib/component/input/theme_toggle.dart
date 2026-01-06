import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/theme_toggle_props.dart' show ThemeToggleSize;

/// A toggle switch for dark/light theme selection.
///
/// Clean, accessible toggle with clear visual states.
///
/// ```dart
/// ArcaneThemeToggle(
///   isDark: true,
///   onChanged: (isDark) => print(isDark),
/// )
/// ```
class ArcaneThemeToggle extends StatelessComponent {
  /// Current theme state (true = dark)
  final bool isDark;

  /// Size variant
  final ThemeToggleSize size;

  /// Callback when theme changes
  final void Function(bool isDark)? onChanged;

  const ArcaneThemeToggle({
    this.isDark = true,
    this.size = ThemeToggleSize.md,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.themeToggle(ThemeToggleProps(
      isDark: isDark,
      size: size,
      onChanged: onChanged,
    ));
  }
}

/// Simple inline theme toggle with labels.
///
/// ```dart
/// ArcaneThemeToggleSimple(
///   isDark: true,
///   onChanged: (isDark) => print(isDark),
/// )
/// ```
class ArcaneThemeToggleSimple extends StatelessComponent {
  /// Current theme state (true = dark)
  final bool isDark;

  /// Callback when theme changes
  final void Function(bool isDark)? onChanged;

  const ArcaneThemeToggleSimple({
    this.isDark = true,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.themeToggleSimple(ThemeToggleSimpleProps(
      isDark: isDark,
      onChanged: onChanged,
    ));
  }
}
