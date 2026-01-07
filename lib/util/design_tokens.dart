/// Design tokens for Arcane Jaspr.
///
/// Provides static string constants that reference CSS custom properties.
/// These can be used directly in inline styles or style classes.
library;

/// Color design tokens as CSS variable references.
///
/// All values reference CSS custom properties that are defined by the
/// active stylesheet (ShadCN, Codex, etc.).
abstract class ArcaneColors {
  ArcaneColors._();

  // Core backgrounds
  static const String background = 'var(--arcane-background, var(--background))';
  static const String backgroundSecondary = 'var(--arcane-background-secondary, var(--muted))';
  static const String backgroundTertiary = 'var(--arcane-background-tertiary, var(--secondary))';
  static const String backgroundOverlay = 'var(--arcane-overlay, rgba(0, 0, 0, 0.5))';

  // Surface colors
  static const String surface = 'var(--arcane-surface, var(--card))';
  static const String surfaceVariant = 'var(--arcane-surface-variant, var(--secondary))';
  static const String card = 'var(--arcane-card, var(--card))';
  static const String cardHover = 'var(--arcane-card-hover, var(--secondary))';
  static const String cardAlt = 'var(--arcane-card-alt, var(--secondary))';
  static const String input = 'var(--arcane-input, var(--input))';
  static const String navbar = 'var(--arcane-navbar, rgba(255, 255, 255, 0.8))';
  static const String popover = 'var(--arcane-popover, var(--popover))';

  // Primary, Secondary, Accent
  static const String primary = 'var(--arcane-primary, var(--primary))';
  static const String secondary = 'var(--arcane-secondary, var(--secondary))';
  static const String accent = 'var(--arcane-accent, var(--accent))';
  static const String muted = 'var(--arcane-muted, var(--muted))';

  // Text colors
  static const String foreground = 'var(--arcane-foreground, var(--foreground))';
  static const String onBackground = 'var(--arcane-on-background, var(--foreground))';
  static const String onSurface = 'var(--arcane-on-surface, var(--card-foreground))';
  static const String cardForeground = 'var(--arcane-card-foreground, var(--card-foreground))';
  static const String mutedForeground = 'var(--arcane-muted-foreground, var(--muted-foreground))';
  static const String textSubtle = 'var(--arcane-text-subtle, var(--muted-foreground))';
  static const String textFaint = 'var(--arcane-text-faint, rgba(113, 113, 122, 0.6))';
  static const String primaryForeground = 'var(--arcane-primary-foreground, var(--primary-foreground))';
  static const String secondaryForeground = 'var(--arcane-secondary-foreground, var(--secondary-foreground))';
  static const String accentForeground = 'var(--arcane-accent-foreground, var(--accent-foreground))';

  // Border colors
  static const String border = 'var(--arcane-border, var(--border))';
  static const String borderSubtle = 'var(--arcane-border-subtle, var(--input))';
  static const String borderMedium = 'var(--arcane-border-medium, var(--border))';
  static const String borderLight = 'var(--arcane-border-light, rgba(228, 228, 231, 0.5))';
  static const String ring = 'var(--arcane-ring, var(--ring))';

  // Status colors
  static const String success = 'var(--arcane-success, var(--success, #22c55e))';
  static const String successForeground = 'var(--arcane-success-foreground, var(--success-foreground, #ffffff))';
  static const String warning = 'var(--arcane-warning, var(--warning, #f59e0b))';
  static const String warningForeground = 'var(--arcane-warning-foreground, var(--warning-foreground, #000000))';
  static const String error = 'var(--arcane-error, var(--destructive, #ef4444))';
  static const String errorForeground = 'var(--arcane-error-foreground, var(--destructive-foreground, #ffffff))';
  static const String destructive = 'var(--arcane-destructive, var(--destructive, #ef4444))';
  static const String destructiveForeground = 'var(--arcane-destructive-foreground, var(--destructive-foreground, #ffffff))';
  static const String info = 'var(--arcane-info, var(--info, #3b82f6))';
  static const String infoForeground = 'var(--arcane-info-foreground, var(--info-foreground, #ffffff))';

  // Tooltip
  static const String tooltip = 'var(--arcane-tooltip, var(--popover))';
  static const String tooltipForeground = 'var(--arcane-tooltip-foreground, var(--popover-foreground))';

  // Code
  static const String codeBackground = 'var(--arcane-code-background, var(--secondary))';

  // Neon/Gaming colors (static values)
  static const String neonPink = '#EC4899';
  static const String neonCyan = '#06B6D4';
  static const String neonPurple = '#8B5CF6';
  static const String neonGreen = '#10B981';
  static const String neonOrange = '#F97316';

  // Window dots
  static const String windowDotRed = '#FF5F56';
  static const String windowDotYellow = '#FFBD2E';
  static const String windowDotGreen = '#27C93F';

  // Game-specific colors
  static const String minecraftGreen = '#62B247';
  static const String rustOrange = '#CE422B';
  static const String arkBlue = '#6EC8E4';
  static const String valheimGold = '#D4A843';
  static const String cs2Orange = '#DE9B35';
  static const String terrariaGreen = '#29A629';
}

/// Spacing design tokens as CSS value strings.
abstract class ArcaneSpacing {
  ArcaneSpacing._();

  static const String xs = '4px';
  static const String sm = '8px';
  static const String md = '16px';
  static const String lg = '24px';
  static const String xl = '32px';
  static const String xxl = '48px';
  static const String xxxl = '64px';
  static const String huge = '96px';
  static const String massive = '128px';

  // Section spacing
  static const String sectionY = '80px';
  static const String heroY = '120px';
}

/// Typography design tokens.
abstract class ArcaneTypography {
  ArcaneTypography._();

  // Font families
  static const String fontFamily = "var(--arcane-font-sans, 'Inter', ui-sans-serif, system-ui, sans-serif)";
  static const String fontFamilyMono = "var(--arcane-font-mono, ui-monospace, SFMono-Regular, Menlo, monospace)";
  static const String fontFamilyHeading = "var(--arcane-font-heading, var(--arcane-font-sans))";

  // Font sizes
  static const String fontSizeXs = '12px';
  static const String fontSizeSm = '14px';
  static const String fontSizeMd = '15px';
  static const String fontSizeBase = '16px';
  static const String fontSizeLg = '18px';
  static const String fontSizeXl = '20px';
  static const String fontSize2xl = '24px';
  static const String fontSize3xl = '32px';
  static const String fontSize4xl = '40px';
  static const String fontSize5xl = '48px';
  static const String fontSizeHero = '56px';
  static const String fontSizeMega = '72px';

  // Font weights
  static const String fontWeightNormal = '400';
  static const String fontWeightMedium = '500';
  static const String fontWeightSemibold = '600';
  static const String fontWeightBold = '700';
  static const String fontWeightExtrabold = '800';

  // Line heights
  static const String lineHeightTight = '1.1';
  static const String lineHeightSnug = '1.25';
  static const String lineHeightNormal = '1.5';
  static const String lineHeightRelaxed = '1.625';

  // Letter spacing
  static const String letterSpacingTight = '-0.025em';
  static const String letterSpacingNormal = '0';
  static const String letterSpacingWide = '0.025em';
  static const String letterSpacingWidest = '0.1em';
}

/// Border radius design tokens.
abstract class ArcaneRadius {
  ArcaneRadius._();

  static const String none = '0';
  static const String xs = '4px';
  static const String smStatic = '6px';
  static const String mdStatic = '8px';
  static const String lgStatic = '12px';
  static const String xlStatic = '16px';
  static const String xxlStatic = '24px';
  static const String fullStatic = '9999px';
  static const String circle = '50%';

  // Theme-reactive versions
  static const String sm = 'var(--arcane-radius-sm, 6px)';
  static const String md = 'var(--arcane-radius-md, 8px)';
  static const String lg = 'var(--arcane-radius-lg, 12px)';
  static const String xl = 'var(--arcane-radius-xl, 16px)';
  static const String xxl = 'var(--arcane-radius-2xl, 24px)';
  static const String full = 'var(--arcane-radius-full, 9999px)';
}

/// Layout design tokens.
abstract class ArcaneLayout {
  ArcaneLayout._();

  // Max widths
  static const String maxWidthCard = '400px';
  static const String maxWidthForm = '480px';
  static const String maxWidthNarrowText = '560px';
  static const String maxWidthText = '640px';
  static const String maxWidthNarrow = '768px';
  static const String maxWidthContent = '1024px';
  static const String maxWidthContainer = '1280px';
  static const String maxWidthFull = '1440px';

  // Component sizes
  static const String headerHeight = '64px';
  static const String sidebarWidth = '280px';
  static const String sidebarCollapsed = '72px';
}

/// Z-index design tokens.
abstract class ArcaneZIndex {
  ArcaneZIndex._();

  static const String below = '-1';
  static const String base = '0';
  static const String dropdown = '1000';
  static const String sticky = '1020';
  static const String fixed = '1030';
  static const String fab = '1035';
  static const String modalBackdrop = '1040';
  static const String modal = '1050';
  static const String popover = '1060';
  static const String tooltip = '1070';
  static const String toast = '1080';
}

/// Effects design tokens.
abstract class ArcaneEffects {
  ArcaneEffects._();

  // Backdrop blur
  static const String backdropBlur = 'blur(8px)';
  static const String backdropBlurStrong = 'blur(16px)';

  // Shadows
  static const String shadowXs = '0 1px 2px rgba(0, 0, 0, 0.05)';
  static const String shadowSm = '0 1px 3px rgba(0, 0, 0, 0.1)';
  static const String shadowMd = '0 4px 6px rgba(0, 0, 0, 0.1)';
  static const String shadowLgStatic = '0 10px 15px rgba(0, 0, 0, 0.1)';
  static const String shadowXlStatic = '0 20px 25px rgba(0, 0, 0, 0.15)';
  static const String shadowCard = '0 4px 6px -1px rgba(0, 0, 0, 0.1)';

  // Glow effects
  static const String glowPrimary = '0 0 20px var(--arcane-primary)';
  static const String glowGreen = '0 0 20px rgba(16, 185, 129, 0.5)';
  static const String glowCyan = '0 0 20px rgba(6, 182, 212, 0.5)';
  static const String glowPurple = '0 0 20px rgba(139, 92, 246, 0.5)';
  static const String glowOrange = '0 0 20px rgba(249, 115, 22, 0.5)';
  static const String glowPink = '0 0 20px rgba(236, 72, 153, 0.5)';

  // Transitions
  static const String transitionFast = '150ms ease';
  static const String transitionNormal = '200ms ease';
  static const String transitionSlow = '300ms ease';
  static const String transitionBounce = '300ms cubic-bezier(0.4, 0, 0.2, 1)';

  // Hover transforms
  static const String hoverLift = 'translateY(-2px)';
  static const String hoverScale = 'scale(1.02)';
}

/// Common style patterns.
abstract class ArcaneCommonStyles {
  ArcaneCommonStyles._();

  /// Standard card styles
  static Map<String, String> get card => {
    'background': ArcaneColors.card,
    'border-radius': ArcaneRadius.lg,
    'border': '1px solid ${ArcaneColors.border}',
  };

  /// Subtle card styles
  static Map<String, String> get cardSubtle => {
    'background': ArcaneColors.surface,
    'border-radius': ArcaneRadius.md,
    'border': '1px solid ${ArcaneColors.borderSubtle}',
  };

  /// Image container
  static Map<String, String> imageContainer(String size) => {
    'width': size,
    'height': size,
    'border-radius': ArcaneRadius.md,
    'overflow': 'hidden',
  };

  /// Image cover styles
  static Map<String, String> get imageCover => {
    'width': '100%',
    'height': '100%',
    'object-fit': 'cover',
  };

  /// Flex row
  static Map<String, String> get flexRow => {
    'display': 'flex',
    'flex-direction': 'row',
    'align-items': 'center',
  };

  /// Flex row with space-between
  static Map<String, String> get flexRowSpaced => {
    'display': 'flex',
    'flex-direction': 'row',
    'align-items': 'center',
    'justify-content': 'space-between',
  };

  /// Flex column
  static Map<String, String> get flexCol => {
    'display': 'flex',
    'flex-direction': 'column',
  };

  /// Flex center
  static Map<String, String> get flexCenter => {
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'center',
  };

  /// Heading text
  static Map<String, String> get heading => {
    'font-size': ArcaneTypography.fontSize3xl,
    'font-weight': ArcaneTypography.fontWeightBold,
    'line-height': ArcaneTypography.lineHeightTight,
    'color': ArcaneColors.foreground,
  };

  /// Subheading text
  static Map<String, String> get subheading => {
    'font-size': ArcaneTypography.fontSizeLg,
    'font-weight': ArcaneTypography.fontWeightMedium,
    'color': ArcaneColors.foreground,
  };

  /// Body text
  static Map<String, String> get bodyText => {
    'font-size': ArcaneTypography.fontSizeBase,
    'line-height': ArcaneTypography.lineHeightNormal,
    'color': ArcaneColors.foreground,
  };

  /// Label text
  static Map<String, String> get labelText => {
    'font-size': ArcaneTypography.fontSizeSm,
    'font-weight': ArcaneTypography.fontWeightMedium,
    'color': ArcaneColors.mutedForeground,
  };

  /// Tiny text
  static Map<String, String> get tinyText => {
    'font-size': ArcaneTypography.fontSizeXs,
    'color': ArcaneColors.textSubtle,
  };

  /// Section styles
  static Map<String, String> section({String? background}) => {
    'padding': '${ArcaneSpacing.sectionY} ${ArcaneSpacing.lg}',
    if (background != null) 'background': background,
  };

  /// Section header
  static Map<String, String> get sectionHeader => {
    'text-align': 'center',
    'margin-bottom': ArcaneSpacing.xxl,
  };

  /// Container
  static Map<String, String> container({String? maxWidth}) => {
    'max-width': maxWidth ?? ArcaneLayout.maxWidthContainer,
    'margin': '0 auto',
    'padding': '0 ${ArcaneSpacing.lg}',
  };

  /// Status badge
  static Map<String, String> statusBadge(String bgColor, String textColor) => {
    'display': 'inline-flex',
    'align-items': 'center',
    'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
    'border-radius': ArcaneRadius.full,
    'font-size': ArcaneTypography.fontSizeXs,
    'font-weight': ArcaneTypography.fontWeightMedium,
    'background': bgColor,
    'color': textColor,
  };

  /// Grid layout
  static Map<String, String> grid(int cols, {String gap = '24px'}) => {
    'display': 'grid',
    'grid-template-columns': 'repeat($cols, 1fr)',
    'gap': gap,
  };

  /// Auto grid layout
  static Map<String, String> gridAuto({String minWidth = '300px', String gap = '24px'}) => {
    'display': 'grid',
    'grid-template-columns': 'repeat(auto-fit, minmax($minWidth, 1fr))',
    'gap': gap,
  };
}
