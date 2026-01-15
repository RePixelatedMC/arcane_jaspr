import '../../component/navigation/toc.dart' show arcaneTocTreeLinesCss;
import '../../theme/index.dart';
import '../../util/content/prose_styles.dart';
import '../../util/content/sidebar_styles.dart' show arcaneSidebarCodexStyles;
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
        // Clean white background - surfaces provide the color
        background: 0xFFffffff,
        // Bold, gaming-inspired surfaces - clearly tinted with theme color
        secondary: theme.lightSecondary,
        accent: theme.lightAccent,
        border: theme.lightBorder,
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
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_it.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_md.ttf') format('truetype');
  font-weight: 500;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_boldit.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_xbd.ttf') format('truetype');
  font-weight: 800;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_light.ttf') format('truetype');
  font-weight: 300;
  font-style: normal;
  font-display: block;
}

/* Hack - Monospace Font */
@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/HackFont/Hack-Regular.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/HackFont/Hack-Italic.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/HackFont/Hack-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/HackFont/Hack-BoldItalic.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: block;
}

/* ITCAvantGardeStd - Heading Font */
@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.ttf') format('truetype');
  font-weight: 200;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.ttf') format('truetype');
  font-weight: 200;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.ttf') format('truetype');
  font-weight: 500;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.ttf') format('truetype');
  font-weight: 500;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.ttf') format('truetype');
  font-weight: 600;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.ttf') format('truetype');
  font-weight: 600;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: block;
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
/* ============================================
   PROSE - Codex Gaming Typography
   ============================================ */
.prose {
  max-width: 65ch;
  color: var(--foreground);
  font-size: 0.9375rem;
  line-height: 1.65;
}

.prose h1, .prose h2, .prose h3,
.prose h4, .prose h5, .prose h6 {
  font-family: var(--font-heading);
  color: var(--foreground);
  font-weight: 600;
  line-height: 1.3;
  margin-top: 1.75rem;
  margin-bottom: 0.75rem;
}

.prose h1 {
  font-size: 1.75rem;
  margin-top: 0;
  letter-spacing: -0.01em;
}

.prose h2 {
  font-size: 1.375rem;
  padding-bottom: 0.5rem;
  border-bottom: 2px solid color-mix(in srgb, var(--primary) 30%, transparent);
}

.prose h3 { font-size: 1.125rem; }
.prose h4 { font-size: 1rem; }

.prose p {
  margin-bottom: 1rem;
}

.prose a {
  color: var(--primary);
  text-decoration: none;
  border-bottom: 1px solid color-mix(in srgb, var(--primary) 50%, transparent);
  transition: all 0.15s ease;
}

.prose a:hover {
  border-bottom-color: var(--primary);
  text-shadow: 0 0 8px color-mix(in srgb, var(--primary) 30%, transparent);
}

.prose strong, .prose b {
  font-weight: 600;
  color: var(--foreground);
}

.prose ul, .prose ol {
  margin-bottom: 1rem;
  padding-left: 1.5rem;
}

.prose li {
  margin-bottom: 0.375rem;
}

.prose li::marker {
  color: var(--primary);
}

.prose blockquote {
  border-left: 3px solid var(--primary);
  padding: 0.75rem 1rem;
  margin: 1rem 0;
  background: color-mix(in srgb, var(--primary) 5%, transparent);
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
}

.prose blockquote p:last-child {
  margin-bottom: 0;
}

.prose hr {
  border: none;
  height: 2px;
  background: linear-gradient(90deg, transparent, var(--primary), transparent);
  margin: 1.75rem 0;
  opacity: 0.5;
}

.prose table {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
}

.prose th, .prose td {
  border: 1px solid var(--border);
  padding: 0.625rem 0.75rem;
  text-align: left;
  font-size: 0.875rem;
}

.prose th {
  background: color-mix(in srgb, var(--primary) 10%, var(--muted));
  font-family: var(--font-heading);
  font-weight: 600;
  color: var(--primary);
}

.prose img {
  max-width: 100%;
  height: auto;
  border-radius: var(--radius-lg);
  margin: 1.5rem 0;
  border: 1px solid var(--border);
}

/* Code blocks - Codex terminal style */
.prose pre {
  background: #0a0a0a;
  border: 1px solid color-mix(in srgb, var(--primary) 30%, var(--border));
  border-radius: var(--radius-lg);
  padding: 1rem 1.25rem;
  overflow-x: auto;
  margin: 1rem 0;
  box-shadow: 0 0 20px color-mix(in srgb, var(--primary) 10%, transparent);
}

.prose code {
  font-family: var(--font-mono);
  font-size: 0.875em;
}

.prose :not(pre) > code {
  background: color-mix(in srgb, var(--primary) 15%, var(--muted));
  padding: 0.2rem 0.5rem;
  border-radius: var(--radius-sm);
  font-size: 0.875em;
  color: var(--primary);
}

/* Syntax highlighting - Codex neon */
.prose .hljs-keyword { color: #ff7b72; }
.prose .hljs-string { color: var(--primary); }
.prose .hljs-number { color: #79c0ff; }
.prose .hljs-function, .prose .hljs-title { color: #d2a8ff; }
.prose .hljs-comment { color: #6e7681; font-style: italic; }
.prose .hljs-variable { color: #ffa657; }
.prose .hljs-class, .prose .hljs-built_in { color: #7ee787; }

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

$arcaneSidebarTreeStyles

$arcaneSidebarCodexStyles

$arcaneTocTreeLinesCss
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
/// Each theme defines a primary accent color and bold light mode surfaces.
/// Light mode surfaces are intentionally more saturated for a gaming aesthetic.
enum CodexTheme {
  /// Emerald green - #10b981
  /// Light mode: Bold mint surfaces
  green(
    color: 0xFF10b981,
    lightSecondary: 0xFFd1fae5,
    lightAccent: 0xFFa7f3d0,
    lightBorder: 0xFF6ee7b7,
  ),

  /// Bright red - #ef4444
  /// Light mode: Bold coral/rose surfaces
  red(
    color: 0xFFef4444,
    lightSecondary: 0xFFfee2e2,
    lightAccent: 0xFFfecaca,
    lightBorder: 0xFFfca5a5,
  ),

  /// Electric blue - #3b82f6
  /// Light mode: Bold sky blue surfaces
  blue(
    color: 0xFF3b82f6,
    lightSecondary: 0xFFdbeafe,
    lightAccent: 0xFFbfdbfe,
    lightBorder: 0xFF93c5fd,
  ),

  /// Vibrant purple - #8b5cf6
  /// Light mode: Bold lavender surfaces
  purple(
    color: 0xFF8b5cf6,
    lightSecondary: 0xFFede9fe,
    lightAccent: 0xFFddd6fe,
    lightBorder: 0xFFc4b5fd,
  ),

  /// Neon cyan - #22d3ee
  /// Light mode: Bold aqua surfaces
  cyan(
    color: 0xFF22d3ee,
    lightSecondary: 0xFFcffafe,
    lightAccent: 0xFFa5f3fc,
    lightBorder: 0xFF67e8f9,
  ),

  /// Hot pink - #ec4899
  /// Light mode: Bold pink surfaces
  pink(
    color: 0xFFec4899,
    lightSecondary: 0xFFfce7f3,
    lightAccent: 0xFFfbcfe8,
    lightBorder: 0xFFf9a8d4,
  ),

  /// Bright orange - #f97316
  /// Light mode: Bold peach/amber surfaces
  orange(
    color: 0xFFf97316,
    lightSecondary: 0xFFffedd5,
    lightAccent: 0xFFfed7aa,
    lightBorder: 0xFFfdba74,
  ),

  /// Rainbow RGB spin - cycles through all colors.
  /// Uses cyan as the base color, with CSS animation override.
  rainbow(
    color: 0xFF22d3ee,
    lightSecondary: 0xFFcffafe,
    lightAccent: 0xFFa5f3fc,
    lightBorder: 0xFF67e8f9,
  );

  /// The primary accent color for this theme.
  final int color;

  /// Light mode secondary surface color (cards, elevated surfaces).
  final int lightSecondary;

  /// Light mode accent surface color (hover states, interactive).
  final int lightAccent;

  /// Light mode border color.
  final int lightBorder;

  const CodexTheme({
    required this.color,
    required this.lightSecondary,
    required this.lightAccent,
    required this.lightBorder,
  });
}
