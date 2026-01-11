import '../../theme/index.dart';
import '../stylesheet.dart';
import 'renderers/codex_renderers.dart';

/// Codex stylesheet - Gamer-inspired theme with neon glows.
///
/// Implements a neon, glowing gaming aesthetic:
/// - OLED-optimized dark mode with pure black backgrounds
/// - Vibrant neon accents (configurable: Green/Red/Blue/Purple/Rainbow)
/// - Subtle glow effects via colored shadows
/// - Larger radii and spacing for a modern feel
/// - Clean, accessible light mode with soft contrasts
/// - ITCAvantGardeStd font for headings and titles
/// - Akzidenz-GroteskPro font for body text
/// - Hack font for code
///
/// The light mode uses soft whites and grays with vibrant accents.
///
/// Supports multiple color themes via [CodexTheme].
class CodexStylesheet extends ArcaneStylesheet {
  /// The color theme to use. Defaults to green.
  final CodexTheme theme;

  const CodexStylesheet({this.theme = CodexTheme.green});

  @override
  String get id => 'codex';

  @override
  String get name => 'Codex';

  @override
  ComponentRenderers get renderers => const CodexRenderers();

  // ============================================
  // Theme Seeds
  // ============================================

  @override
  ThemeSeed get lightSeed => ThemeSeed(
        // Codex uses the theme color as primary
        primary: theme.color,
        background: 0xFFf9fafb,
        // Light gray secondary/accent
        secondary: 0xFFf3f4f6,
        accent: 0xFFf3f4f6,
        // Semantic colors
        destructive: 0xFFef4444,
        success: 0xFF22c55e,
        warning: 0xFFf59e0b,
        info: 0xFF3b82f6,
      );

  @override
  ThemeSeed get darkSeed => ThemeSeed(
        // Same theme color in dark mode
        primary: theme.color,
        background: 0xFF000000, // OLED black
        // Neutral dark gray secondary/accent (no blue tint)
        secondary: 0xFF1a1a1a,
        accent: 0xFF1a1a1a,
        // Darker semantic colors for dark mode
        destructive: 0xFF7f1d1d,
        success: 0xFF166534,
        warning: 0xFF92400e,
        info: 0xFF1e40af,
        isDark: true,
        // Enable neon glow on shadows
        accentGlow: true,
      );

  // ============================================
  // Fonts
  // ============================================

  @override
  FontConfig get fonts => const FontConfig(
        sans:
            "'Akzidenz-GroteskPro', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif",
        heading:
            "'ITCAvantGardeStd', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif",
        mono: "'Hack', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace",
      );

  // ============================================
  // Border Radius
  // ============================================

  @override
  RadiusConfig get radius => const RadiusConfig.large();

  // ============================================
  // Font Faces
  // ============================================

  @override
  String get fontFaces => '''
/* Akzidenz-GroteskPro - Body Font */
@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_regular.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_it.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_md.ttf') format('truetype');
  font-weight: 500;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_boldit.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_xbd.ttf') format('truetype');
  font-weight: 800;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_light.ttf') format('truetype');
  font-weight: 300;
  font-style: normal;
  font-display: swap;
}

/* Hack - Monospace Font */
@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/HackFont/Hack-Regular.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/HackFont/Hack-Italic.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: swap;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/HackFont/Hack-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/HackFont/Hack-BoldItalic.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: swap;
}

/* ITCAvantGardeStd - Heading Font */
@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.ttf') format('truetype');
  font-weight: 200;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.ttf') format('truetype');
  font-weight: 200;
  font-style: italic;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.ttf') format('truetype');
  font-weight: 500;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.ttf') format('truetype');
  font-weight: 500;
  font-style: italic;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.ttf') format('truetype');
  font-weight: 600;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.ttf') format('truetype');
  font-weight: 600;
  font-style: italic;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: swap;
}
''';

  // ============================================
  // Component-Specific CSS
  // ============================================

  /// Returns the CSS class to apply to the body element for this theme.
  /// Returns 'codex-{theme}' (e.g., 'codex-orange', 'codex-rainbow') to enable
  /// theme-specific styling in CSS.
  @override
  String get bodyClass => 'codex-${theme.name}';

  @override
  String get componentCss => '''
/* Heading Styles - Use heading font */
h1, h2, h3, h4, h5, h6,
.arcane-heading,
.arcane-headline,
.arcane-subheadline,
.arcane-title,
[class*="heading"],
[class*="headline"],
[class*="title"] {
  font-family: var(--font-heading);
}

/* Button and important UI elements use heading font */
button,
.arcane-button,
.arcane-btn,
[class*="button"],
[class*="btn"],
.arcane-badge,
.arcane-chip,
.arcane-tab,
.arcane-nav-item,
label {
  font-family: var(--font-heading);
}

/* Glow Utilities */
.codex-glow {
  box-shadow: var(--shadow-md);
}

.codex-glow-strong {
  box-shadow: var(--shadow-lg);
}

${theme == CodexTheme.rainbow ? _rainbowCss : ''}

/* Tree Lines for Disclosure/Navigation
   Each item draws its own connectors:
   - ::before = horizontal branch to content
   - ::after = vertical line down to next sibling (except last item = L-connector)
*/
.arcane-tree-lines {
  position: relative;
  --tree-indent: 1rem;
  --tree-line-color: var(--border);
}

/* Each direct child is a tree item */
.arcane-tree-lines > * {
  position: relative;
  padding-left: var(--tree-indent);
}

/* Horizontal branch from vertical line to content */
.arcane-tree-lines > *::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  width: calc(var(--tree-indent) - 4px);
  height: 1px;
  background: var(--tree-line-color);
}

/* Vertical line segment - connects this item to the next */
.arcane-tree-lines > *::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--tree-line-color);
}

/* Last item: L-connector - vertical line only goes to the horizontal branch */
.arcane-tree-lines > *:last-child::after {
  bottom: 50%;
}

/* First item: start vertical line from horizontal branch */
.arcane-tree-lines > *:first-child::after {
  top: 50%;
}

/* Only child: just horizontal branch, no vertical */
.arcane-tree-lines > *:only-child::after {
  display: none;
}

/* Nested tree lines - progressively lighter for visual hierarchy */
.arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 70%, transparent);
}

.arcane-tree-lines .arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 50%, transparent);
}

.arcane-tree-lines .arcane-tree-lines .arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 35%, transparent);
}
''';

  /// CSS for rainbow/RGB spin effect.
  /// Uses explicit color keyframes for maximum browser compatibility.
  /// Scoped to .codex-rainbow class.
  static const String _rainbowCss = '''
/* Rainbow RGB Spin Animation - Scoped to .codex-rainbow */
@keyframes codex-rainbow-colors {
  0%, 100% { --primary: #ff6b6b; --ring: #e55555; } /* Red */
  14% { --primary: #ffa94d; --ring: #e89035; } /* Orange */
  28% { --primary: #ffe066; --ring: #e6c94d; } /* Yellow */
  42% { --primary: #69db7c; --ring: #52c462; } /* Green */
  57% { --primary: #4dabf7; --ring: #3592dd; } /* Blue */
  71% { --primary: #9775fa; --ring: #7d5ce0; } /* Indigo */
  85% { --primary: #e599f7; --ring: #cc7fdd; } /* Violet */
}

@keyframes codex-rainbow-glow {
  0%, 100% { --glow-color: rgba(255, 107, 107, 0.3); }
  14% { --glow-color: rgba(255, 169, 77, 0.3); }
  28% { --glow-color: rgba(255, 224, 102, 0.3); }
  42% { --glow-color: rgba(105, 219, 124, 0.3); }
  57% { --glow-color: rgba(77, 171, 247, 0.3); }
  71% { --glow-color: rgba(151, 117, 250, 0.3); }
  85% { --glow-color: rgba(229, 153, 247, 0.3); }
}

.codex-rainbow {
  animation: codex-rainbow-colors 8s linear infinite;
}

.codex-rainbow.dark {
  --primary-foreground: #000000;
  animation: codex-rainbow-colors 8s linear infinite, codex-rainbow-glow 8s linear infinite;
}

/* Rainbow shadows with glow in dark mode */
.codex-rainbow.dark {
  --shadow-xs: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 0 8px var(--glow-color, rgba(77, 171, 247, 0.15));
  --shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 0 12px var(--glow-color, rgba(77, 171, 247, 0.2));
  --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 0 16px var(--glow-color, rgba(77, 171, 247, 0.25));
  --shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 0 20px var(--glow-color, rgba(77, 171, 247, 0.3));
  --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 0 30px var(--glow-color, rgba(77, 171, 247, 0.35));
  --shadow-xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25), 0 0 50px var(--glow-color, rgba(77, 171, 247, 0.4));
}

/* Rainbow text selection */
.codex-rainbow ::selection {
  background: var(--primary, #4dabf7);
  color: #000000;
}

.codex-rainbow ::-moz-selection {
  background: var(--primary, #4dabf7);
  color: #000000;
}
''';
}

/// Color themes for Codex stylesheet.
///
/// Each theme defines a primary accent color.
enum CodexTheme {
  /// Emerald green - #10b981
  green(0xFF10b981),

  /// Bright red - #ef4444
  red(0xFFef4444),

  /// Electric blue - #3b82f6
  blue(0xFF3b82f6),

  /// Vibrant purple - #8b5cf6
  purple(0xFF8b5cf6),

  /// Neon cyan - #22d3ee
  cyan(0xFF22d3ee),

  /// Hot pink - #ec4899
  pink(0xFFec4899),

  /// Bright orange - #f97316
  orange(0xFFf97316),

  /// Rainbow RGB spin - cycles through all colors.
  /// Uses cyan as the base color, with CSS animation override.
  rainbow(0xFF22d3ee);

  /// The color value for this theme.
  final int color;

  const CodexTheme(this.color);
}
