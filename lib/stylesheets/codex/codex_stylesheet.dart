import '../../component/navigation/toc.dart' show arcaneTocTreeLinesCss;
import '../../theme/index.dart';
import '../../util/content/prose_styles.dart';
import '../stylesheet.dart';
import 'renderers/codex_renderers.dart';

/// Codex stylesheet - premium dark design language.
///
/// Implements a dark-first visual system:
/// - High-contrast surfaces with restrained accent emphasis
/// - Configurable accent themes (Green/Red/Blue/Purple/Rainbow)
/// - Premium typography with clear hierarchy
/// - Focused interaction states and subtle atmosphere effects
/// - ITCAvantGardeStd font for headings and titles
/// - Akzidenz-GroteskPro font for body text
/// - Hack font for code
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
        primary: theme.color,
        background: 0xFFffffff,
        secondary: theme.lightSecondary,
        accent: theme.lightAccent,
        border: theme.lightBorder,
        destructive: 0xFFef4444,
        success: 0xFF22c55e,
        warning: 0xFFf59e0b,
        info: 0xFF3b82f6,
      );

  @override
  ThemeSeed get darkSeed => ThemeSeed(
        primary: theme.color,
        background: 0xFF000000,
        secondary: 0xFF0A0D0B,
        accent: 0xFF101614,
        border: 0xFF1F2824,
        destructive: 0xFF7f1d1d,
        success: 0xFF166534,
        warning: 0xFF92400e,
        info: 0xFF1e40af,
        isDark: true,
        accentGlow: false,
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
  src: url('/assets/fonts/hack/Hack-Regular.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/hack/Hack-Italic.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/hack/Hack-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/hack/Hack-BoldItalic.ttf') format('truetype');
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
/* Codex Root Tokens */
#arcane-root[class*="codex-"] {
  --codex-accent: var(--primary);
  --codex-accent-rgb: var(--primary-rgb);
  --codex-accent-secondary: color-mix(in srgb, var(--primary) 72%, #065f46);
  --codex-accent-gradient: linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 55%, #0891b2) 100%);
  --codex-accent-border: color-mix(in srgb, var(--primary) 25%, var(--border));
  --codex-surface-0: #000000;
  --codex-surface-1: #050705;
  --codex-surface-2: #0A0F0C;
  --codex-grid-line: color-mix(in srgb, var(--primary) 13%, transparent);
  --codex-glow-soft: color-mix(in srgb, var(--primary) 32%, transparent);
  background: transparent !important;
  isolation: isolate;
}

html.dark #arcane-root[class*="codex-"]::before {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -2;
  pointer-events: none;
  background-color: var(--codex-surface-0);
  background-image:
    linear-gradient(var(--codex-grid-line) 1px, transparent 1px),
    linear-gradient(90deg, var(--codex-grid-line) 1px, transparent 1px);
  background-size: 60px 60px;
  background-attachment: fixed;
}

html.dark #arcane-root[class*="codex-"]::after {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -1;
  pointer-events: none;
  opacity: 0.03;
  mix-blend-mode: overlay;
  background: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");
  background-repeat: repeat;
}

#arcane-root[class*="codex-"] ::selection {
  background: var(--codex-glow-soft);
  color: var(--foreground);
}

#arcane-root[class*="codex-"] :focus-visible {
  outline: 2px solid var(--codex-accent);
  outline-offset: 2px;
  box-shadow: 0 0 0 3px color-mix(in srgb, var(--codex-accent) 24%, transparent);
}

#arcane-root[class*="codex-"] a:hover {
  color: var(--codex-accent-secondary);
}

#arcane-root[class*="codex-"] .codex-card:hover,
#arcane-root[class*="codex-"] .arcane-card.clickable:hover {
  border-color: var(--codex-accent-border);
}

/* ============================================
   PROSE - Codex Typography
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
  color: var(--codex-accent);
  text-decoration: none;
  border-bottom: 1px solid color-mix(in srgb, var(--codex-accent) 42%, transparent);
  transition: all 0.15s ease;
}

.prose a:hover {
  border-bottom-color: var(--codex-accent);
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
  color: var(--codex-accent);
}

.prose blockquote {
  border-left: 3px solid var(--codex-accent);
  padding: 0.75rem 1rem;
  margin: 1rem 0;
  background: color-mix(in srgb, var(--codex-accent) 5%, transparent);
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
}

.prose blockquote p:last-child {
  margin-bottom: 0;
}

.prose hr {
  border: none;
  height: 2px;
  background: linear-gradient(90deg, transparent, var(--codex-accent), transparent);
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
  background: color-mix(in srgb, var(--codex-accent) 10%, var(--muted));
  font-family: var(--font-heading);
  font-weight: 600;
  color: var(--codex-accent);
}

.prose img {
  max-width: 100%;
  height: auto;
  border-radius: var(--radius-lg);
  margin: 1.5rem 0;
  border: 1px solid var(--border);
}

.prose pre {
  background: var(--codex-surface-1);
  border: 1px solid color-mix(in srgb, var(--codex-accent) 24%, var(--border));
  border-radius: var(--radius-lg);
  padding: 1rem 1.25rem;
  overflow-x: auto;
  margin: 1rem 0;
  box-shadow: 0 8px 24px color-mix(in srgb, var(--codex-accent) 8%, transparent);
}

.prose code {
  font-family: var(--font-mono);
  font-size: 0.875em;
}

.prose :not(pre) > code {
  background: color-mix(in srgb, var(--codex-accent) 12%, var(--muted));
  padding: 0.2rem 0.5rem;
  border-radius: var(--radius-sm);
  font-size: 0.875em;
  color: var(--codex-accent);
}

/* Syntax highlighting */
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

/* ============================================
   GAME TILES - Card animations and hover effects
   ============================================ */

/* Appear animation for game cards/tiles */
@keyframes codex-card-appear {
  from {
    opacity: 0;
    transform: scale(0.95) translateY(10px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

/* Base styles for animated game tiles */
.codex-game-tile--animated {
  animation: codex-card-appear 0.3s ease-out forwards;
  opacity: 0;
}

/* Hover effects for interactive game tiles */
.codex-game-tile--interactive {
  transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.codex-game-tile--interactive:hover {
  transform: translateY(-2px);
  border-color: color-mix(in srgb, var(--codex-accent) 45%, transparent);
  box-shadow:
    0 10px 28px color-mix(in srgb, var(--codex-accent) 16%, transparent),
    0 0 0 1px color-mix(in srgb, var(--codex-accent) 18%, transparent);
}

/* Platform icon tooltips */
.codex-platform-icon {
  position: relative;
}

.codex-platform-icon[data-tooltip]::after {
  content: attr(data-tooltip);
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%) translateY(-4px);
  padding: 6px 10px;
  background: var(--card);
  border: 1px solid color-mix(in srgb, var(--foreground) 15%, transparent);
  border-radius: 6px;
  font-size: 12px;
  font-weight: 500;
  color: var(--foreground);
  white-space: nowrap;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.15s ease, visibility 0.15s ease, transform 0.15s ease;
  pointer-events: none;
  z-index: 100;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.codex-platform-icon[data-tooltip]:hover::after {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(-8px);
}

/* CTA card variant (dashed border, request style) */
.codex-game-tile--cta {
  border: 2px dashed color-mix(in srgb, var(--foreground) 15%, transparent);
  transition: border-color 0.2s ease, background 0.2s ease;
}

.codex-game-tile--cta:hover {
  border-color: color-mix(in srgb, var(--codex-accent) 32%, transparent);
  background: color-mix(in srgb, var(--codex-accent) 5%, var(--card));
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
/// Each theme defines a primary accent color and supporting light-mode surfaces.
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
