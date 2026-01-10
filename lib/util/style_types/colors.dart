const String _qnPrimary = 'var(--qn-primary, #059669)';
const String _qnSecondary = 'var(--qn-secondary, #047857)';

const String _neonPink = '#EC4899';
const String _neonCyan = '#06B6D4';
const String _neonPurple = '#8B5CF6';
const String _neonGreen = '#10B981';
const String _neonOrange = '#F97316';

const String _minecraftGreen = '#62B247';
const String _rustOrange = '#CE422B';
const String _arkBlue = '#6EC8E4';
const String _valheimGold = '#D4A843';
const String _cs2Orange = '#DE9B35';
const String _terrariaGreen = '#29A629';

/// Background color presets
enum Background {
  transparent,
  background,
  backgroundSecondary,
  backgroundTertiary,
  surface,
  surfaceVariant,
  card,
  cardHover,
  cardAlt,
  input,
  navbar,
  primary,
  secondary,
  tertiary,
  accent,
  accentContainer,
  success,
  successContainer,
  warning,
  error,
  info,
  overlay,
  tooltip,
  code,
  white,
  black,
  muted,
  brandPrimary,
  brandSecondary,
  glassTint,
  glassHeader,
  glassOverlay,
  destructive;

  String get css => switch (this) {
        Background.transparent => 'transparent',
        Background.background => 'var(--background)',
        Background.backgroundSecondary => 'var(--arcane-background-secondary, var(--muted))',
        Background.backgroundTertiary => 'var(--arcane-background-tertiary, var(--secondary))',
        Background.surface => 'var(--card)',
        Background.surfaceVariant => 'var(--secondary)',
        Background.card => 'var(--card)',
        Background.cardHover => 'var(--arcane-card-hover, var(--secondary))',
        Background.cardAlt => 'var(--arcane-card-alt, var(--secondary))',
        Background.input => 'var(--input)',
        Background.navbar => 'var(--arcane-navbar, color-mix(in srgb, var(--background) 80%, transparent))',
        Background.primary => 'var(--primary)',
        Background.secondary => 'var(--secondary)',
        Background.tertiary => 'var(--accent)',
        Background.accent => 'var(--primary)',
        Background.accentContainer => 'var(--arcane-accent-container, color-mix(in srgb, var(--primary) 10%, transparent))',
        Background.success => 'var(--success)',
        Background.successContainer => 'var(--arcane-success-container, color-mix(in srgb, var(--success) 10%, transparent))',
        Background.warning => 'var(--warning)',
        Background.error => 'var(--destructive)',
        Background.info => 'var(--info)',
        Background.overlay => 'var(--arcane-overlay, rgba(0, 0, 0, 0.5))',
        Background.tooltip => 'var(--popover)',
        Background.code => 'var(--arcane-code-background, var(--secondary))',
        Background.white => '#FFFFFF',
        Background.black => '#000000',
        Background.muted => 'var(--muted)',
        Background.brandPrimary => _qnPrimary,
        Background.brandSecondary => _qnSecondary,
        Background.glassTint => 'color-mix(in srgb, var(--foreground) 5%, transparent)',
        Background.glassHeader => 'color-mix(in srgb, var(--foreground) 3%, transparent)',
        Background.glassOverlay => 'color-mix(in srgb, var(--foreground) 8%, transparent)',
        Background.destructive => 'var(--destructive)',
      };
}

/// Text/foreground color presets
enum TextColor {
  primary,
  secondary,
  muted,
  mutedForeground,
  subtle,
  faint,
  accent,
  accentForeground,
  success,
  successForeground,
  warning,
  warningForeground,
  error,
  errorForeground,
  info,
  infoForeground,
  onPrimary,
  onSecondary,
  onBackground,
  onSurface,
  onSurfaceVariant,
  cardForeground,
  inputForeground,
  tooltipForeground,
  white,
  black,
  inherit,
  brandPrimary,
  brand,
  brandSecondary,
  neonPink,
  neonCyan,
  neonPurple,
  neonGreen,
  neonOrange,
  star;

  String get css => switch (this) {
        TextColor.primary => 'var(--foreground)',
        TextColor.secondary => 'var(--card-foreground)',
        TextColor.muted => 'var(--muted-foreground)',
        TextColor.mutedForeground => 'var(--muted-foreground)',
        TextColor.subtle => 'color-mix(in srgb, var(--muted-foreground) 85%, transparent)',
        TextColor.faint => 'color-mix(in srgb, var(--muted-foreground) 65%, transparent)',
        TextColor.accent => 'var(--primary)',
        TextColor.accentForeground => 'var(--accent-foreground)',
        TextColor.success => 'var(--success)',
        TextColor.successForeground => 'var(--success-foreground)',
        TextColor.warning => 'var(--warning)',
        TextColor.warningForeground => 'var(--warning-foreground)',
        TextColor.error => 'var(--destructive)',
        TextColor.errorForeground => 'var(--destructive-foreground)',
        TextColor.info => 'var(--info)',
        TextColor.infoForeground => 'var(--info-foreground)',
        TextColor.onPrimary => 'var(--primary-foreground)',
        TextColor.onSecondary => 'var(--secondary-foreground)',
        TextColor.onBackground => 'var(--foreground)',
        TextColor.onSurface => 'var(--card-foreground)',
        TextColor.onSurfaceVariant => 'var(--secondary-foreground)',
        TextColor.cardForeground => 'var(--card-foreground)',
        TextColor.inputForeground => 'var(--foreground)',
        TextColor.tooltipForeground => 'var(--popover-foreground)',
        TextColor.white => '#FFFFFF',
        TextColor.black => '#000000',
        TextColor.inherit => 'inherit',
        TextColor.brandPrimary => _qnPrimary,
        TextColor.brand => _qnPrimary,
        TextColor.brandSecondary => _qnSecondary,
        TextColor.neonPink => _neonPink,
        TextColor.neonCyan => _neonCyan,
        TextColor.neonPurple => _neonPurple,
        TextColor.neonGreen => _neonGreen,
        TextColor.neonOrange => _neonOrange,
        TextColor.star => 'var(--warning)',
      };
}

/// Border color presets
enum BorderColor {
  standard,
  subtle,
  medium,
  light,
  ring,
  accent,
  success,
  warning,
  error,
  info,
  transparent,
  outline,
  outlineVariant;

  String get css => switch (this) {
        BorderColor.standard => 'var(--border)',
        BorderColor.subtle => 'var(--input)',
        BorderColor.medium => 'color-mix(in srgb, var(--foreground) 10%, transparent)',
        BorderColor.light => 'color-mix(in srgb, var(--foreground) 15%, transparent)',
        BorderColor.ring => 'var(--ring)',
        BorderColor.accent => 'var(--primary)',
        BorderColor.success => 'var(--success)',
        BorderColor.warning => 'var(--warning)',
        BorderColor.error => 'var(--destructive)',
        BorderColor.info => 'var(--info)',
        BorderColor.transparent => 'transparent',
        BorderColor.outline => 'var(--border)',
        BorderColor.outlineVariant => 'var(--input)',
      };
}

/// Neon/gaming accent colors
enum NeonColor {
  pink,
  cyan,
  purple,
  green,
  orange;

  String get css => switch (this) {
        NeonColor.pink => _neonPink,
        NeonColor.cyan => _neonCyan,
        NeonColor.purple => _neonPurple,
        NeonColor.green => _neonGreen,
        NeonColor.orange => _neonOrange,
      };
}

/// Game-specific brand colors
enum GameColor {
  minecraft,
  rust,
  ark,
  valheim,
  cs2,
  terraria;

  String get css => switch (this) {
        GameColor.minecraft => _minecraftGreen,
        GameColor.rust => _rustOrange,
        GameColor.ark => _arkBlue,
        GameColor.valheim => _valheimGold,
        GameColor.cs2 => _cs2Orange,
        GameColor.terraria => _terrariaGreen,
      };
}
