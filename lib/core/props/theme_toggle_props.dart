/// Theme toggle size
enum ThemeToggleSize {
  sm,
  md,
  lg,
}

/// Props for theme toggle component
class ThemeToggleProps {
  /// Current theme state (true = dark)
  final bool isDark;

  /// Size variant
  final ThemeToggleSize size;

  /// Callback when theme changes
  final void Function(bool isDark)? onChanged;

  const ThemeToggleProps({
    this.isDark = true,
    this.size = ThemeToggleSize.md,
    this.onChanged,
  });
}

/// Props for simple theme toggle component
class ThemeToggleSimpleProps {
  /// Current theme state (true = dark)
  final bool isDark;

  /// Callback when theme changes
  final void Function(bool isDark)? onChanged;

  const ThemeToggleSimpleProps({
    this.isDark = true,
    this.onChanged,
  });
}
