import '../stylesheet.dart';
import 'renderers/codex_renderers.dart';

/// Codex stylesheet - Gamer-inspired theme with neon glows.
///
/// Implements a neon, glowing gaming aesthetic:
/// - OLED-optimized dark mode with pure black backgrounds
/// - Vibrant neon accents (configurable: Green/Red/Blue/Purple)
/// - Subtle glow effects via colored shadows
/// - Larger radii and spacing for a modern feel
/// - Clean, accessible light mode with soft contrasts
/// - ITCAvantGardeStd font for headings and titles
/// - Akzidenz-GroteskPro font for body text
/// - Hack font for code
///
/// The light mode uses soft whites and grays with vibrant accents for a fresh, energetic look.
class CodexStylesheet extends ArcaneStylesheet {
/// The accent theme to use. Defaults to green.
final CodexAccent accent;

const CodexStylesheet({this.accent = CodexAccent.green});

@override
String get id => 'codex';

@override
String get name => 'Codex';

@override
ComponentRenderers get renderers => const CodexRenderers();

@override
List<String> get externalCssUrls => const [];

@override
String get baseCss => '''
/* Codex Theme - Neon Gaming Aesthetic */

/* Font Face Declarations */
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

/* Accent Presets */
:root, .codex-green {
  --codex-accent: #10b981; /* Emerald green */
  --codex-accent-rgb: 16, 185, 129;
  --codex-accent-secondary: #059669; /* Darker green */
  --codex-accent-secondary-rgb: 5, 150, 105;
  --codex-accent-gradient: linear-gradient(135deg, #10b981 0%, #0891b2 100%);
  --codex-accent-glow-medium: 0 0 20px rgba(16, 185, 129, 0.3);
  --codex-accent-border: rgba(16, 185, 129, 0.25);
}

.codex-red {
  --codex-accent: #ef4444; /* Bright red */
  --codex-accent-rgb: 239, 68, 68;
  --codex-accent-secondary: #dc2626; /* Darker red */
  --codex-accent-secondary-rgb: 220, 38, 38;
  --codex-accent-gradient: linear-gradient(135deg, #ef4444 0%, #f97316 100%);
  --codex-accent-glow-medium: 0 0 20px rgba(239, 68, 68, 0.3);
  --codex-accent-border: rgba(239, 68, 68, 0.25);
}

.codex-blue {
  --codex-accent: #3b82f6; /* Electric blue */
  --codex-accent-rgb: 59, 130, 246;
  --codex-accent-secondary: #2563eb; /* Darker blue */
  --codex-accent-secondary-rgb: 37, 99, 235;
  --codex-accent-gradient: linear-gradient(135deg, #3b82f6 0%, #06b6d4 100%);
  --codex-accent-glow-medium: 0 0 20px rgba(59, 130, 246, 0.3);
  --codex-accent-border: rgba(59, 130, 246, 0.25);
}

.codex-purple {
  --codex-accent: #8b5cf6; /* Vibrant purple */
  --codex-accent-rgb: 139, 92, 246;
  --codex-accent-secondary: #7c3aed; /* Darker purple */
  --codex-accent-secondary-rgb: 124, 58, 237;
  --codex-accent-gradient: linear-gradient(135deg, #8b5cf6 0%, #ec4899 100%);
  --codex-accent-glow-medium: 0 0 20px rgba(139, 92, 246, 0.3);
  --codex-accent-border: rgba(139, 92, 246, 0.25);
}

/* CSS Variables - Light Mode (default) */
:root {
  /* Core ShadCN-like Variables */
  --background: #f9fafb;
  --foreground: #111827;

  --card: #ffffff;
  --card-foreground: #111827;

  --popover: #ffffff;
  --popover-foreground: #111827;

  --primary: var(--codex-accent);
  --primary-foreground: #ffffff;

  --secondary: #f3f4f6;
  --secondary-foreground: #111827;

  --muted: #f3f4f6;
  --muted-foreground: #6b7280;

  --accent: #f3f4f6;
  --accent-foreground: #111827;

  --destructive: #ef4444;
  --destructive-foreground: #ffffff;

  --success: #22c55e;
  --success-foreground: #ffffff;

  --warning: #f59e0b;
  --warning-foreground: #111827;

  --info: #3b82f6;
  --info-foreground: #ffffff;

  --border: #e5e7eb;
  --input: #e5e7eb;
  --ring: var(--codex-accent);

  --radius: 0.75rem;

  --font-sans: 'Akzidenz-GroteskPro', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
  --font-heading: 'ITCAvantGardeStd', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
  --font-mono: 'Hack', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;

  /* Arcane Token Aliases */
  --arcane-background: var(--background);
  --arcane-foreground: var(--foreground);
  --arcane-on-background: var(--foreground);
  --arcane-card: var(--card);
  --arcane-card-foreground: var(--card-foreground);
  --arcane-card-hover: #f3f4f6;
  --arcane-card-alt: var(--secondary);
  --arcane-popover: var(--popover);
  --arcane-popover-foreground: var(--popover-foreground);

  --arcane-primary: var(--primary);
  --arcane-primary-foreground: var(--primary-foreground);
  --arcane-on-primary: var(--primary-foreground);
  --arcane-secondary: var(--secondary);
  --arcane-secondary-foreground: var(--secondary-foreground);
  --arcane-on-secondary: var(--secondary-foreground);
  --arcane-accent: var(--accent);
  --arcane-accent-foreground: var(--accent-foreground);
  --arcane-accent-hover: #e5e7eb;
  --arcane-accent-container: rgba(243, 244, 246, 0.1);

  --arcane-surface: var(--card);
  --arcane-on-surface: var(--card-foreground);
  --arcane-surface-variant: var(--secondary);
  --arcane-on-surface-variant: var(--secondary-foreground);

  --arcane-muted: var(--muted);
  --arcane-muted-foreground: var(--muted-foreground);

  --arcane-destructive: var(--destructive);
  --arcane-destructive-foreground: var(--destructive-foreground);
  --arcane-destructive-hover: #dc2626;
  --arcane-destructive-container: rgba(239, 68, 68, 0.1);
  --arcane-success: var(--success);
  --arcane-success-foreground: var(--success-foreground);
  --arcane-success-hover: #16a34a;
  --arcane-success-container: rgba(34, 197, 94, 0.1);
  --arcane-warning: var(--warning);
  --arcane-warning-foreground: var(--warning-foreground);
  --arcane-warning-hover: #d97706;
  --arcane-warning-container: rgba(245, 158, 11, 0.1);
  --arcane-info: var(--info);
  --arcane-info-foreground: var(--info-foreground);
  --arcane-info-hover: #2563eb;
  --arcane-info-container: rgba(59, 130, 246, 0.1);

  --arcane-border: var(--border);
  --arcane-border-subtle: var(--input);
  --arcane-input: var(--input);
  --arcane-input-foreground: var(--foreground);
  --arcane-ring: var(--ring);
  --arcane-outline: var(--border);
  --arcane-outline-variant: var(--input);

  --arcane-overlay: rgba(17, 24, 39, 0.5);
  --arcane-overlay-strong: rgba(17, 24, 39, 0.7);
  --arcane-scrim: rgba(17, 24, 39, 0.5);
  --arcane-tooltip: var(--popover);
  --arcane-tooltip-foreground: var(--popover-foreground);
  --arcane-code-background: var(--secondary);
  --arcane-navbar: rgba(255, 255, 255, 0.8);

  --arcane-background-rgb: 249, 250, 251;
  --arcane-foreground-rgb: 17, 24, 39;
  --arcane-on-background-rgb: 17, 24, 39;
  --arcane-primary-rgb: var(--codex-accent-rgb);
  --arcane-secondary-rgb: 243, 244, 246;
  --arcane-accent-rgb: 243, 244, 246;
  --arcane-muted-rgb: 107, 114, 128;
  --arcane-destructive-rgb: 239, 68, 68;
  --arcane-success-rgb: 34, 197, 94;
  --arcane-warning-rgb: 245, 158, 11;
  --arcane-info-rgb: 59, 130, 246;
  --arcane-surface-rgb: 255, 255, 255;
  --arcane-on-surface-rgb: 17, 24, 39;
  --arcane-surface-variant-rgb: 243, 244, 246;
  --arcane-on-surface-variant-rgb: 17, 24, 39;
  --arcane-card-rgb: 255, 255, 255;
  --arcane-border-rgb: 229, 231, 235;
  --arcane-input-rgb: 229, 231, 235;

  --arcane-font-sans: var(--font-sans);
  --arcane-font-heading: var(--font-heading);
  --arcane-font-mono: var(--font-mono);

  --arcane-radius: var(--radius);
  --arcane-radius-xs: 0.25rem;
  --arcane-radius-sm: 0.375rem;
  --arcane-radius-md: 0.5rem;
  --arcane-radius-lg: 0.75rem;
  --arcane-radius-xl: 1rem;
  --arcane-radius-2xl: 1.25rem;
  --arcane-radius-full: 9999px;

  --arcane-shadow-xs: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --arcane-shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px -1px rgba(0, 0, 0, 0.1);
  --arcane-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
  --arcane-shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
  --arcane-shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
  --arcane-shadow-xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);

  --arcane-transition-fast: 100ms cubic-bezier(0.4, 0, 0.2, 1);
  --arcane-transition: 150ms cubic-bezier(0.4, 0, 0.2, 1);
  --arcane-transition-slow: 200ms cubic-bezier(0.4, 0, 0.2, 1);

  --arcane-interactive-radius: var(--arcane-radius-md);
  --arcane-container-radius: var(--arcane-radius-lg);
  --arcane-input-radius: var(--arcane-radius-md);
  --arcane-indicator-checkbox-radius: var(--arcane-radius-sm);
  --arcane-indicator-radio-radius: 50%;
  --arcane-indicator-toggle-track-radius: 9999px;
  --arcane-indicator-toggle-thumb-radius: 50%;

  --arcane-tertiary: var(--accent);
  --arcane-on-tertiary: var(--accent-foreground);
  --arcane-tertiary-rgb: 243, 244, 246;
  --arcane-primary-container: rgba(var(--codex-accent-rgb), 0.1);
  --arcane-on-primary-container: var(--primary);
  --arcane-secondary-container: rgba(243, 244, 246, 0.1);
  --arcane-on-secondary-container: var(--secondary-foreground);
  --arcane-tertiary-container: rgba(243, 244, 246, 0.1);
  --arcane-on-tertiary-container: var(--accent-foreground);
  --arcane-background-secondary: #f3f4f6;
  --arcane-background-tertiary: #e5e7eb;
  --arcane-text-subtle: rgba(107, 114, 128, 0.85);
  --arcane-text-faint: rgba(107, 114, 128, 0.65);
  --arcane-inverse-surface: #111827;
  --arcane-on-inverse-surface: #f9fafb;
  --arcane-surface-tint: var(--accent);
  --arcane-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
  --arcane-accent-glow: rgba(var(--codex-accent-rgb), 0.1);
  --arcane-secondary-glow: rgba(243, 244, 246, 0.1);
  --arcane-grid-color: rgba(243, 244, 246, 0.03);

  --arcane-style-radius-xs: var(--arcane-radius-xs);
  --arcane-style-radius-sm: var(--arcane-radius-sm);
  --arcane-style-radius-md: var(--arcane-radius-md);
  --arcane-style-radius-lg: var(--arcane-radius-lg);
  --arcane-style-radius-xl: var(--arcane-radius-xl);
  --arcane-style-radius-2xl: var(--arcane-radius-2xl);
  --arcane-style-shadow-xs: var(--arcane-shadow-xs);
  --arcane-style-shadow-sm: var(--arcane-shadow-sm);
  --arcane-style-shadow-md: var(--arcane-shadow-md);
  --arcane-style-shadow-lg: var(--arcane-shadow-lg);
  --arcane-style-shadow-xl: var(--arcane-shadow-xl);
  --arcane-style-transition-fast: var(--arcane-transition-fast);
  --arcane-style-transition: var(--arcane-transition);
  --arcane-style-transition-slow: var(--arcane-transition-slow);

  /* Neon Colors for Gaming Accents */
  --arcane-neon-pink: #ec4899;
  --arcane-neon-cyan: #22d3ee;
  --arcane-neon-purple: #a855f7;
  --arcane-neon-green: #22c55e;
  --arcane-neon-orange: #f97316;
}

/* Dark Mode - OLED-optimized with neon glows */
.dark {
  --background: #000000;
  --foreground: #f9fafb;

  --card: #0a0a0a;
  --card-foreground: #f9fafb;

  --popover: #0a0a0a;
  --popover-foreground: #f9fafb;

  --primary: var(--codex-accent);
  --primary-foreground: #000000;

  --secondary: #111827;
  --secondary-foreground: #f9fafb;

  --muted: #111827;
  --muted-foreground: #9ca3af;

  --accent: #111827;
  --accent-foreground: #f9fafb;

  --destructive: #7f1d1d;
  --destructive-foreground: #f9fafb;

  --success: #166534;
  --success-foreground: #ffffff;

  --warning: #92400e;
  --warning-foreground: #ffffff;

  --info: #1e40af;
  --info-foreground: #ffffff;

  --border: #1f2937;
  --input: #111827;
  --ring: var(--codex-accent-secondary);

  --arcane-background: var(--background);
  --arcane-foreground: var(--foreground);
  --arcane-on-background: var(--foreground);
  --arcane-card: var(--card);
  --arcane-card-foreground: var(--card-foreground);
  --arcane-card-hover: #111827;
  --arcane-card-alt: var(--secondary);
  --arcane-popover: var(--popover);
  --arcane-popover-foreground: var(--popover-foreground);

  --arcane-primary: var(--primary);
  --arcane-primary-foreground: var(--primary-foreground);
  --arcane-on-primary: var(--primary-foreground);
  --arcane-secondary: var(--secondary);
  --arcane-secondary-foreground: var(--secondary-foreground);
  --arcane-on-secondary: var(--secondary-foreground);
  --arcane-accent: var(--accent);
  --arcane-accent-foreground: var(--accent-foreground);
  --arcane-accent-hover: #1f2937;
  --arcane-accent-container: rgba(17, 24, 39, 0.1);

  --arcane-surface: var(--card);
  --arcane-on-surface: var(--card-foreground);
  --arcane-surface-variant: var(--secondary);
  --arcane-on-surface-variant: var(--secondary-foreground);

  --arcane-muted: var(--muted);
  --arcane-muted-foreground: var(--muted-foreground);

  --arcane-destructive: var(--destructive);
  --arcane-destructive-foreground: var(--destructive-foreground);
  --arcane-destructive-hover: #991b1b;
  --arcane-destructive-container: rgba(127, 29, 29, 0.1);
  --arcane-success: var(--success);
  --arcane-success-foreground: var(--success-foreground);
  --arcane-success-hover: #15803d;
  --arcane-success-container: rgba(22, 101, 52, 0.1);
  --arcane-warning: var(--warning);
  --arcane-warning-foreground: var(--warning-foreground);
  --arcane-warning-hover: #a16207;
  --arcane-warning-container: rgba(146, 64, 14, 0.1);
  --arcane-info: var(--info);
  --arcane-info-foreground: var(--info-foreground);
  --arcane-info-hover: #1d4ed8;
  --arcane-info-container: rgba(30, 64, 175, 0.1);

  --arcane-border: var(--border);
  --arcane-border-subtle: var(--input);
  --arcane-input: var(--input);
  --arcane-input-foreground: var(--foreground);
  --arcane-ring: var(--ring);
  --arcane-outline: var(--border);
  --arcane-outline-variant: var(--input);

  --arcane-overlay: rgba(0, 0, 0, 0.5);
  --arcane-overlay-strong: rgba(0, 0, 0, 0.7);
  --arcane-scrim: rgba(0, 0, 0, 0.5);
  --arcane-tooltip: var(--popover);
  --arcane-tooltip-foreground: var(--popover-foreground);
  --arcane-code-background: var(--secondary);
  --arcane-navbar: rgba(0, 0, 0, 0.8);

  --arcane-background-rgb: 0, 0, 0;
  --arcane-foreground-rgb: 249, 250, 251;
  --arcane-on-background-rgb: 249, 250, 251;
  --arcane-primary-rgb: var(--codex-accent-rgb);
  --arcane-secondary-rgb: 17, 24, 39;
  --arcane-accent-rgb: 17, 24, 39;
  --arcane-muted-rgb: 156, 163, 175;
  --arcane-destructive-rgb: 127, 29, 29;
  --arcane-success-rgb: 22, 101, 52;
  --arcane-warning-rgb: 146, 64, 14;
  --arcane-info-rgb: 30, 64, 175;
  --arcane-surface-rgb: 10, 10, 10;
  --arcane-on-surface-rgb: 249, 250, 251;
  --arcane-surface-variant-rgb: 17, 24, 39;
  --arcane-on-surface-variant-rgb: 249, 250, 251;
  --arcane-card-rgb: 10, 10, 10;
  --arcane-border-rgb: 31, 41, 55;
  --arcane-input-rgb: 17, 24, 39;

  --arcane-tertiary: var(--accent);
  --arcane-on-tertiary: var(--accent-foreground);
  --arcane-tertiary-rgb: 17, 24, 39;
  --arcane-primary-container: rgba(var(--codex-accent-rgb), 0.1);
  --arcane-on-primary-container: var(--primary);
  --arcane-secondary-container: rgba(17, 24, 39, 0.1);
  --arcane-on-secondary-container: var(--secondary-foreground);
  --arcane-tertiary-container: rgba(17, 24, 39, 0.1);
  --arcane-on-tertiary-container: var(--accent-foreground);
  --arcane-background-secondary: #0a0a0a;
  --arcane-background-tertiary: #111827;
  --arcane-text-subtle: rgba(156, 163, 175, 0.85);
  --arcane-text-faint: rgba(156, 163, 175, 0.65);
  --arcane-inverse-surface: #f9fafb;
  --arcane-on-inverse-surface: #111827;
  --arcane-surface-tint: var(--accent);
  --arcane-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3), 0 2px 4px -2px rgba(0, 0, 0, 0.2);
  --arcane-accent-glow: rgba(var(--codex-accent-rgb), 0.15);
  --arcane-secondary-glow: rgba(17, 24, 39, 0.1);
  --arcane-grid-color: rgba(17, 24, 39, 0.03);

  /* Shadows with Neon Glow in Dark Mode */
  --arcane-shadow-xs: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 0 8px rgba(var(--codex-accent-rgb), 0.08);
  --arcane-shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 0 12px rgba(var(--codex-accent-rgb), 0.1);
  --arcane-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 0 16px rgba(var(--codex-accent-rgb), 0.12);
  --arcane-shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 0 20px rgba(var(--codex-accent-rgb), 0.15);
  --arcane-shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 0 30px rgba(var(--codex-accent-rgb), 0.2);
  --arcane-shadow-xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25), 0 0 50px rgba(var(--codex-accent-rgb), 0.25);
}

/* Base Styles */
*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
  font-family: var(--font-sans);
  background-color: var(--background);
  color: var(--foreground);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Heading Styles - Akzidenz-GroteskPro */
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

/* Global Styled Scrollbars */
* {
  scrollbar-width: thin;
  scrollbar-color: var(--border) transparent;
}

*::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

*::-webkit-scrollbar-track {
  background: transparent;
}

*::-webkit-scrollbar-thumb {
  background: var(--border);
  border-radius: 9999px;
}

*::-webkit-scrollbar-thumb:hover {
  background: var(--muted-foreground);
}

*::-webkit-scrollbar-corner {
  background: transparent;
}

/* Spinner Animation */
@keyframes arcane-spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* Focus Ring Utility */
.focus-ring:focus-visible {
  outline: none;
  box-shadow: 0 0 0 2px var(--background), 0 0 0 4px var(--ring);
}

/* Button Hover States */
.arcane-button:hover:not([disabled]) {
  filter: brightness(0.95);
}

.arcane-button:active:not([disabled]) {
  filter: brightness(0.9);
}

/* Glow Utilities */
.codex-glow {
  box-shadow: var(--arcane-shadow-md);
}

.codex-glow-strong {
  box-shadow: var(--arcane-shadow-lg);
}
''';
}

/// Available accent themes for Codex.
enum CodexAccent {
green,
red,
blue,
purple,
}

/// Extension to get CSS class name for accent.
extension CodexAccentExtension on CodexAccent {
String get cssClass => 'codex-$name';
}
