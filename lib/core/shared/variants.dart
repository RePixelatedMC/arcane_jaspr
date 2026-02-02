/// Color variants for semantic meaning.
enum ColorVariant {
  primary,
  secondary,
  destructive,
  success,
  warning,
  info;
}

/// Style variants for visual treatment.
enum StyleVariant {
  solid,
  outline,
  ghost,
  link,

  /// Soft/subtle variant with muted background and border.
  /// Ideal for display tags like "Pre-installed" chips.
  soft;
}
