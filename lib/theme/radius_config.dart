/// Border radius configuration for a theme.
class RadiusConfig {
  final String xs;
  final String sm;
  final String md;
  final String lg;
  final String xl;
  final String xxl;
  final String full;

  const RadiusConfig({
    this.xs = '4px',
    this.sm = '6px',
    this.md = '8px',
    this.lg = '10px',
    this.xl = '14px',
    this.xxl = '18px',
    this.full = '9999px',
  });

  /// Smaller radii for compact/dense UIs.
  const RadiusConfig.compact()
      : xs = '2px',
        sm = '4px',
        md = '6px',
        lg = '8px',
        xl = '10px',
        xxl = '12px',
        full = '9999px';

  /// Larger radii for modern/gaming aesthetics.
  const RadiusConfig.large()
      : xs = '6px',
        sm = '8px',
        md = '10px',
        lg = '12px',
        xl = '16px',
        xxl = '24px',
        full = '9999px';

  /// Sharp corners (no rounding except full).
  const RadiusConfig.sharp()
      : xs = '0',
        sm = '0',
        md = '0',
        lg = '0',
        xl = '0',
        xxl = '0',
        full = '9999px';

  /// Create a copy with some fields replaced.
  RadiusConfig copyWith({
    String? xs,
    String? sm,
    String? md,
    String? lg,
    String? xl,
    String? xxl,
    String? full,
  }) {
    return RadiusConfig(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      full: full ?? this.full,
    );
  }
}
