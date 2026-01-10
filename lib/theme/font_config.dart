/// Font family configuration for a theme.
class FontConfig {
  /// Sans-serif font stack for body text.
  final String sans;

  /// Font stack for headings. Falls back to [sans] if null.
  final String? heading;

  /// Monospace font stack for code.
  final String mono;

  const FontConfig({
    this.sans = "'Inter', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif",
    this.heading,
    this.mono = "ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace",
  });

  /// Returns [heading] if set, otherwise [sans].
  String get headingOrSans => heading ?? sans;

  /// System fonts only (no external fonts needed).
  const FontConfig.system()
      : sans = "ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
        heading = null,
        mono = "ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace";

  /// Inter font (requires Google Fonts CSS).
  const FontConfig.inter()
      : sans = "'Inter', ui-sans-serif, system-ui, sans-serif",
        heading = null,
        mono = "ui-monospace, SFMono-Regular, monospace";

  /// Create a copy with some fields replaced.
  FontConfig copyWith({
    String? sans,
    String? heading,
    String? mono,
  }) {
    return FontConfig(
      sans: sans ?? this.sans,
      heading: heading ?? this.heading,
      mono: mono ?? this.mono,
    );
  }
}
