import '../../component/navigation/toc.dart' show arcaneTocTreeLinesCss;
import '../../theme/index.dart';
import '../../util/content/prose_styles.dart';
import '../stylesheet.dart';
import 'renderers/shadcn_renderers.dart';

/// ShadCN UI stylesheet.
///
/// Implements the ShadCN/ui design language:
/// - Rounded corners (0.5rem default radius)
/// - Minimal shadows
/// - Border-focused design
/// - Inter font (via Google Fonts)
/// - Accessible, clean aesthetic
///
/// Supports multiple color themes via [ShadcnTheme].
///
/// Reference: https://ui.shadcn.com
class ShadcnStylesheet extends ArcaneStylesheet {
  /// The color theme to use. Defaults to midnight (OLED black).
  final ShadcnTheme theme;

  const ShadcnStylesheet({this.theme = ShadcnTheme.midnight});

  @override
  String get id => 'shadcn';

  @override
  String get name => 'ShadCN UI';

  @override
  ComponentRenderers get renderers => const ShadcnRenderers();

  // ============================================
  // Theme Seeds
  // ============================================

  @override
  ThemeSeed get lightSeed => ThemeSeed(
        primary: theme.lightPrimary,
        background: theme.lightBackground,
        // Only pass secondary/accent if explicitly defined in theme
        // Otherwise let PaletteGenerator derive them with primary tinting
        secondary: theme.lightSecondary,
        accent: theme.lightAccent,
        destructive: 0xFFef4444,
        success: 0xFF22c55e,
        warning: 0xFFf59e0b,
        info: 0xFF3b82f6,
      );

  @override
  ThemeSeed get darkSeed => ThemeSeed(
        primary: theme.darkPrimary,
        background: theme.darkBackground,
        secondary: theme.darkSecondary,
        accent: theme.darkAccent,
        destructive: 0xFF7f1d1d,
        success: 0xFF166534,
        warning: 0xFF92400e,
        info: 0xFF1e40af,
        isDark: true,
      );

  // ============================================
  // Fonts
  // ============================================

  @override
  FontConfig get fonts => const FontConfig(
        sans:
            "'Inter', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
        mono:
            "ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace",
      );

  @override
  List<String> get externalCssUrls => const [
        'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap',
      ];

  // ============================================
  // Component-Specific CSS
  // ============================================

  @override
  String get componentCss => '''
/* ============================================
   PROSE - ShadCN Clean Typography
   ============================================ */
.prose {
  max-width: 65ch;
  color: var(--foreground);
  line-height: 1.75;
}

.prose h1, .prose h2, .prose h3,
.prose h4, .prose h5, .prose h6 {
  color: var(--foreground);
  font-weight: 600;
  line-height: 1.25;
  margin-top: 2rem;
  margin-bottom: 1rem;
}

.prose h1 { font-size: 2.25rem; margin-top: 0; }
.prose h2 {
  font-size: 1.5rem;
  border-bottom: 1px solid var(--border);
  padding-bottom: 0.5rem;
}
.prose h3 { font-size: 1.25rem; }
.prose h4 { font-size: 1.125rem; }

.prose p {
  margin-bottom: 1.25rem;
}

.prose a {
  color: var(--primary);
  text-decoration: underline;
  text-underline-offset: 2px;
  transition: color 0.15s ease;
}

.prose a:hover {
  opacity: 0.8;
}

.prose strong, .prose b {
  font-weight: 600;
}

.prose ul, .prose ol {
  margin-bottom: 1.25rem;
  padding-left: 1.5rem;
}

.prose li {
  margin-bottom: 0.5rem;
}

.prose li::marker {
  color: var(--muted-foreground);
}

.prose blockquote {
  border-left: 4px solid var(--border);
  padding-left: 1rem;
  margin: 1.5rem 0;
  font-style: italic;
  color: var(--muted-foreground);
}

.prose hr {
  border: none;
  border-top: 1px solid var(--border);
  margin: 2rem 0;
}

.prose table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.5rem 0;
}

.prose th, .prose td {
  border: 1px solid var(--border);
  padding: 0.75rem;
  text-align: left;
}

.prose th {
  background: var(--muted);
  font-weight: 600;
}

.prose img {
  max-width: 100%;
  height: auto;
  border-radius: var(--radius-md);
  margin: 1.5rem 0;
}

/* Code blocks */
.prose pre {
  background: var(--muted);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  padding: 1rem 1.25rem;
  overflow-x: auto;
  margin: 1.5rem 0;
}

.prose code {
  font-family: var(--font-mono);
  font-size: 0.875em;
}

.prose :not(pre) > code {
  background: var(--muted);
  padding: 0.125rem 0.375rem;
  border-radius: var(--radius-sm);
  font-size: 0.875em;
}

/* Syntax highlighting - Light */
.prose .hljs-keyword { color: #d73a49; }
.prose .hljs-string { color: #032f62; }
.prose .hljs-number { color: #005cc5; }
.prose .hljs-function, .prose .hljs-title { color: #6f42c1; }
.prose .hljs-comment { color: #6a737d; font-style: italic; }
.prose .hljs-variable { color: #e36209; }
.prose .hljs-class, .prose .hljs-built_in { color: #22863a; }

/* Syntax highlighting - Dark */
.dark .prose .hljs-keyword { color: #ff7b72; }
.dark .prose .hljs-string { color: #a5d6ff; }
.dark .prose .hljs-number { color: #79c0ff; }
.dark .prose .hljs-function, .dark .prose .hljs-title { color: #d2a8ff; }
.dark .prose .hljs-comment { color: #8b949e; font-style: italic; }
.dark .prose .hljs-variable { color: #ffa657; }
.dark .prose .hljs-class, .dark .prose .hljs-built_in { color: #7ee787; }

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

$arcaneTocTreeLinesCss
''';
}

/// Color themes for ShadCN stylesheet.
///
/// Each theme defines colors for both light and dark modes.
/// For neutral themes, light secondary/accent are null to allow
/// the palette generator to derive them with primary hue tinting.
enum ShadcnTheme {
  // ============================================
  // Neutral Themes (auto-tinted light surfaces)
  // ============================================

  /// OLED-optimized with pure black/white.
  /// Maximum contrast, perfect for AMOLED screens.
  /// Light mode surfaces are auto-tinted with the primary color.
  midnight(
    // Light: pure white background, near-black primary
    // Secondary/accent derived with subtle primary tinting
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF09090b,
    // Dark: pure black background, near-white primary
    darkBackground: 0xFF000000,
    darkPrimary: 0xFFfafafa,
    darkSecondary: 0xFF151515,
    darkAccent: 0xFF151515,
  ),

  /// Softer dark theme with off-black.
  /// Easier on the eyes in dark environments.
  charcoal(
    // Light: soft white background with auto-tinted surfaces
    lightBackground: 0xFFfafafa,
    lightPrimary: 0xFF18181b,
    // Dark: off-black background (easier on eyes)
    darkBackground: 0xFF0a0a0a,
    darkPrimary: 0xFFfafafa,
    darkSecondary: 0xFF1a1a1a,
    darkAccent: 0xFF262626,
  ),

  /// Warm cream/ivory tones.
  /// Reduces eye strain with warmer whites.
  cream(
    // Light: warm ivory background
    lightBackground: 0xFFfefdfb,
    lightPrimary: 0xFF78716c, // Warm stone primary for cohesive tinting
    // Dark: warm dark brown
    darkBackground: 0xFF0c0a09,
    darkPrimary: 0xFFfafaf9,
    darkSecondary: 0xFF1c1917,
    darkAccent: 0xFF292524,
  ),

  /// Cool slate/gray tones.
  /// Professional, neutral appearance.
  slate(
    // Light: cool gray-white with slate tinting
    lightBackground: 0xFFf8fafc,
    lightPrimary: 0xFF475569, // Slate primary for cool tinting
    // Dark: deep slate
    darkBackground: 0xFF020617,
    darkPrimary: 0xFFf8fafc,
    darkSecondary: 0xFF0f172a,
    darkAccent: 0xFF1e293b,
  ),

  // ============================================
  // Pastel Themes (richer colored surfaces)
  // ============================================

  /// Rose/pink theme.
  /// Warm, elegant, with visible rose surfaces.
  rose(
    // Light: clean white with rich rose-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFFe11d48, // Vibrant rose
    lightSecondary: 0xFFfce7f3, // Rich pink surface
    lightAccent: 0xFFfbcfe8, // Deeper pink for interaction
    // Dark: deep rose
    darkBackground: 0xFF0f0506,
    darkPrimary: 0xFFfda4af,
    darkSecondary: 0xFF1f0a0d,
    darkAccent: 0xFF4c0519,
  ),

  /// Lavender/purple theme.
  /// Calming and creative with visible purple surfaces.
  lavender(
    // Light: clean white with rich lavender-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF9333ea, // Vibrant purple
    lightSecondary: 0xFFede9fe, // Rich lavender surface
    lightAccent: 0xFFddd6fe, // Deeper lavender for interaction
    // Dark: deep purple
    darkBackground: 0xFF09050f,
    darkPrimary: 0xFFd8b4fe,
    darkSecondary: 0xFF1a0a2e,
    darkAccent: 0xFF3b0764,
  ),

  /// Mint/green theme.
  /// Fresh and natural with visible green surfaces.
  mint(
    // Light: clean white with rich mint-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF16a34a, // Vibrant green
    lightSecondary: 0xFFdcfce7, // Rich mint surface
    lightAccent: 0xFFbbf7d0, // Deeper mint for interaction
    // Dark: deep forest
    darkBackground: 0xFF030f07,
    darkPrimary: 0xFF86efac,
    darkSecondary: 0xFF052e16,
    darkAccent: 0xFF14532d,
  ),

  /// Sky/blue theme.
  /// Clean and professional with visible blue surfaces.
  sky(
    // Light: clean white with rich sky-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF0284c7, // Vibrant sky blue
    lightSecondary: 0xFFe0f2fe, // Rich sky surface
    lightAccent: 0xFFbae6fd, // Deeper blue for interaction
    // Dark: deep ocean
    darkBackground: 0xFF030a0f,
    darkPrimary: 0xFF7dd3fc,
    darkSecondary: 0xFF0c1929,
    darkAccent: 0xFF0c4a6e,
  ),

  /// Peach/orange theme.
  /// Warm and energetic with visible orange surfaces.
  peach(
    // Light: clean white with rich peach-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFFea580c, // Vibrant orange
    lightSecondary: 0xFFffedd5, // Rich peach surface
    lightAccent: 0xFFfed7aa, // Deeper orange for interaction
    // Dark: deep amber
    darkBackground: 0xFF0f0803,
    darkPrimary: 0xFFfdba74,
    darkSecondary: 0xFF1c0f05,
    darkAccent: 0xFF7c2d12,
  ),

  /// Teal/cyan theme.
  /// Modern and vibrant with visible teal surfaces.
  teal(
    // Light: clean white with rich teal-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF0d9488, // Vibrant teal
    lightSecondary: 0xFFccfbf1, // Rich teal surface
    lightAccent: 0xFF99f6e4, // Deeper teal for interaction
    // Dark: deep teal
    darkBackground: 0xFF030f0e,
    darkPrimary: 0xFF5eead4,
    darkSecondary: 0xFF042f2e,
    darkAccent: 0xFF134e4a,
  );

  /// Light mode background color.
  final int lightBackground;

  /// Light mode primary color (used for tinting and interactive elements).
  final int lightPrimary;

  /// Light mode secondary color. If null, derived with primary tinting.
  final int? lightSecondary;

  /// Light mode accent color. If null, derived with primary tinting.
  final int? lightAccent;

  /// Dark mode background color.
  final int darkBackground;

  /// Dark mode primary color.
  final int darkPrimary;

  /// Dark mode secondary color.
  final int darkSecondary;

  /// Dark mode accent color.
  final int darkAccent;

  const ShadcnTheme({
    required this.lightBackground,
    required this.lightPrimary,
    this.lightSecondary,
    this.lightAccent,
    required this.darkBackground,
    required this.darkPrimary,
    required this.darkSecondary,
    required this.darkAccent,
  });
}
