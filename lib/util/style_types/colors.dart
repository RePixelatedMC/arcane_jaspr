// CSS variable references for QualityNode brand colors
const String _qnPrimary = 'var(--qn-primary, #059669)';
const String _qnSecondary = 'var(--qn-secondary, #047857)';

// Neon gaming colors (static, not theme-reactive)
const String _neonPink = '#EC4899';
const String _neonCyan = '#06B6D4';
const String _neonPurple = '#8B5CF6';
const String _neonGreen = '#10B981';
const String _neonOrange = '#F97316';

// Game-specific colors
const String _minecraftGreen = '#62B247';
const String _rustOrange = '#CE422B';
const String _arkBlue = '#6EC8E4';
const String _valheimGold = '#D4A843';
const String _cs2Orange = '#DE9B35';
const String _terrariaGreen = '#29A629';

/// Background color presets for container backgrounds.
///
/// These presets map to CSS custom properties that automatically adapt
/// to the current theme (light/dark mode and color scheme).
///
/// ## Semantic Backgrounds
///
/// | Preset              | Use Case                               |
/// |---------------------|----------------------------------------|
/// | `background`        | Page/app background                    |
/// | `surface`           | Elevated surfaces (cards, panels)      |
/// | `surfaceVariant`    | Secondary surfaces                     |
/// | `card`              | Card backgrounds                       |
/// | `input`             | Form input backgrounds                 |
///
/// ## Status Backgrounds
///
/// | Preset              | Use Case                               |
/// |---------------------|----------------------------------------|
/// | `accent`            | Primary actions, highlights            |
/// | `success`           | Success states, confirmations          |
/// | `warning`           | Warning states, cautions               |
/// | `error`             | Error states, destructive actions      |
/// | `info`              | Informational states                   |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     background: Background.surface,      // Standard card
///     // background: Background.accent,    // Highlighted card
///     // background: Background.glassTint, // Glass morphism
///   ),
///   children: [...],
/// )
/// ```
enum Background {
  /// Fully transparent
  transparent,

  /// Main background
  background,

  /// Secondary background
  backgroundSecondary,

  /// Tertiary background
  backgroundTertiary,

  /// Primary surface
  surface,

  /// Surface variant
  surfaceVariant,

  /// Card background
  card,

  /// Card hover state
  cardHover,

  /// Alternate card
  cardAlt,

  /// Input field background
  input,

  /// Navbar background
  navbar,

  /// Primary color
  primary,

  /// Secondary color
  secondary,

  /// Tertiary color
  tertiary,

  /// Accent color
  accent,

  /// Accent container
  accentContainer,

  /// Success background
  success,

  /// Success container
  successContainer,

  /// Warning background
  warning,

  /// Error/destructive background
  error,

  /// Info background
  info,

  /// Overlay (for modals)
  overlay,

  /// Tooltip background
  tooltip,

  /// Code block background
  code,

  /// Pure white
  white,

  /// Pure black
  black,

  /// Muted background
  muted,

  /// Brand primary (theme-reactive)
  brandPrimary,

  /// Brand secondary (theme-reactive)
  brandSecondary,

  /// Glass tint (rgba white 5%)
  glassTint,

  /// Glass header (rgba white 3%)
  glassHeader,

  /// Glass overlay (rgba white 8%)
  glassOverlay,

  /// Destructive/error background
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
        Background.navbar => 'var(--arcane-navbar, hsl(var(--background) / 0.8))',
        Background.primary => 'var(--primary)',
        Background.secondary => 'var(--secondary)',
        Background.tertiary => 'var(--accent)',
        Background.accent => 'var(--primary)',
        Background.accentContainer => 'var(--arcane-accent-container, hsl(var(--primary) / 0.1))',
        Background.success => 'var(--success)',
        Background.successContainer => 'var(--arcane-success-container, hsl(var(--success) / 0.1))',
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
        Background.glassTint => 'hsl(var(--foreground) / 0.05)',
        Background.glassHeader => 'hsl(var(--foreground) / 0.03)',
        Background.glassOverlay => 'hsl(var(--foreground) / 0.08)',
        Background.destructive => 'var(--destructive)',
      };
}

/// Text/foreground color presets for typography.
///
/// These colors automatically adapt to theme changes and ensure proper
/// contrast ratios for accessibility.
///
/// ## Common Text Colors
///
/// | Preset           | Use Case                                |
/// |------------------|----------------------------------------|
/// | `primary`        | Main body text                          |
/// | `secondary`      | Secondary/supporting text               |
/// | `muted`          | De-emphasized text                      |
/// | `accent`         | Links, highlighted text                 |
/// | `onSurface`      | Text on surface backgrounds             |
///
/// ## Status Colors
///
/// | Preset              | Use Case                             |
/// |---------------------|--------------------------------------|
/// | `success`           | Success messages                     |
/// | `warning`           | Warning messages                     |
/// | `error`             | Error messages                       |
/// | `info`              | Info messages                        |
///
/// ## Example
///
/// ```dart
/// ArcaneText(
///   'Hello World',
///   color: TextColor.primary,   // Main text
///   // color: TextColor.muted,  // De-emphasized
///   // color: TextColor.accent, // Highlighted
/// )
/// ```
enum TextColor {
  /// Primary text (on background)
  primary,

  /// Secondary text (on surface)
  secondary,

  /// Muted text
  muted,

  /// Muted foreground
  mutedForeground,

  /// Subtle text (less visible than muted)
  subtle,

  /// Faint text (least visible)
  faint,

  /// Accent colored text
  accent,

  /// Accent foreground (text on accent backgrounds)
  accentForeground,

  /// Success colored text
  success,

  /// Success foreground
  successForeground,

  /// Warning colored text
  warning,

  /// Warning foreground
  warningForeground,

  /// Error colored text
  error,

  /// Error foreground
  errorForeground,

  /// Info colored text
  info,

  /// Info foreground
  infoForeground,

  /// Text on primary backgrounds
  onPrimary,

  /// Text on secondary backgrounds
  onSecondary,

  /// Text on background
  onBackground,

  /// Text on surface
  onSurface,

  /// Text on surface variant
  onSurfaceVariant,

  /// Card foreground
  cardForeground,

  /// Input foreground
  inputForeground,

  /// Tooltip foreground
  tooltipForeground,

  /// Pure white text
  white,

  /// Pure black text
  black,

  /// Inherit from parent
  inherit,

  /// Brand primary color (theme-reactive)
  brandPrimary,

  /// Brand color alias for brandPrimary
  brand,

  /// Brand secondary color (theme-reactive)
  brandSecondary,

  /// Neon pink
  neonPink,

  /// Neon cyan
  neonCyan,

  /// Neon purple
  neonPurple,

  /// Neon green
  neonGreen,

  /// Neon orange
  neonOrange,

  /// Star/rating color (gold/yellow)
  star;

  String get css => switch (this) {
        TextColor.primary => 'var(--foreground)',
        TextColor.secondary => 'var(--card-foreground)',
        TextColor.muted => 'var(--muted-foreground)',
        TextColor.mutedForeground => 'var(--muted-foreground)',
        TextColor.subtle => 'hsl(var(--muted-foreground) / 0.85)',
        TextColor.faint => 'hsl(var(--muted-foreground) / 0.65)',
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

/// Border color presets for element borders.
///
/// Use with [BorderPreset] for complete border styling, or use
/// these colors with custom border widths and styles.
///
/// ## Common Border Colors
///
/// | Preset       | Use Case                                  |
/// |--------------|-------------------------------------------|
/// | `standard`   | Default borders                           |
/// | `subtle`     | Barely visible dividers                   |
/// | `accent`     | Highlighted/focused elements              |
/// | `ring`       | Focus ring color                          |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     border: BorderPreset.accent, // Complete border
///     // Or use borderColor with custom styles
///   ),
/// )
/// ```
enum BorderColor {
  /// Primary border
  standard,

  /// Subtle border
  subtle,

  /// Medium border
  medium,

  /// Light border
  light,

  /// Focus ring color
  ring,

  /// Accent border
  accent,

  /// Success border
  success,

  /// Warning border
  warning,

  /// Error border
  error,

  /// Info border
  info,

  /// Transparent border
  transparent,

  /// Outline color
  outline,

  /// Outline variant
  outlineVariant;

  String get css => switch (this) {
        BorderColor.standard => 'var(--border)',
        BorderColor.subtle => 'var(--input)',
        BorderColor.medium => 'hsl(var(--foreground) / 0.10)',
        BorderColor.light => 'hsl(var(--foreground) / 0.15)',
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
