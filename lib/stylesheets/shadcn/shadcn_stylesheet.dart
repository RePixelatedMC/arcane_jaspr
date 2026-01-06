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
/// Reference: https://ui.shadcn.com
class ShadcnStylesheet extends ArcaneStylesheet {
  const ShadcnStylesheet();

  @override
  String get id => 'shadcn';

  @override
  String get name => 'ShadCN UI';

  @override
  ComponentRenderers get renderers => const ShadcnRenderers();

  @override
  List<String> get externalCssUrls => const [
    'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap',
  ];

  @override
  String get baseCss => '''
/* ShadCN Base CSS */

/* CSS Variables - Light Mode (default) */
:root {
  /* Core ShadCN Variables */
  --background: #ffffff;
  --foreground: #09090b;

  --card: #ffffff;
  --card-foreground: #09090b;

  --popover: #ffffff;
  --popover-foreground: #09090b;

  --primary: #09090b;
  --primary-foreground: #f9fafb;

  --secondary: #f4f4f5;
  --secondary-foreground: #09090b;

  --muted: #f4f4f5;
  --muted-foreground: #71717a;

  --accent: #f4f4f5;
  --accent-foreground: #09090b;

  --destructive: #ef4444;
  --destructive-foreground: #f9fafb;

  --success: #22c55e;
  --success-foreground: #ffffff;

  --warning: #f59e0b;
  --warning-foreground: #000000;

  --info: #3b82f6;
  --info-foreground: #ffffff;

  --border: #e4e4e7;
  --input: #e4e4e7;
  --ring: #09090b;

  --radius: 0.5rem;

  --font-sans: 'Inter', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;

  /* ==========================================================================
   * Arcane Token Aliases - Ensure ArcaneColors tokens work with this stylesheet
   * ========================================================================== */

  /* Core Colors */
  --arcane-background: var(--background);
  --arcane-foreground: var(--foreground);
  --arcane-on-background: var(--foreground);
  --arcane-card: var(--card);
  --arcane-card-foreground: var(--card-foreground);
  --arcane-card-hover: #f4f4f5;
  --arcane-card-alt: var(--secondary);
  --arcane-popover: var(--popover);
  --arcane-popover-foreground: var(--popover-foreground);

  /* Primary/Secondary/Accent */
  --arcane-primary: var(--primary);
  --arcane-primary-foreground: var(--primary-foreground);
  --arcane-on-primary: var(--primary-foreground);
  --arcane-secondary: var(--secondary);
  --arcane-secondary-foreground: var(--secondary-foreground);
  --arcane-on-secondary: var(--secondary-foreground);
  --arcane-accent: var(--accent);
  --arcane-accent-foreground: var(--accent-foreground);
  --arcane-accent-hover: #e4e4e7;
  --arcane-accent-container: rgba(244, 244, 245, 0.1);

  /* Surface (Material-style aliases) */
  --arcane-surface: var(--card);
  --arcane-on-surface: var(--card-foreground);
  --arcane-surface-variant: var(--secondary);
  --arcane-on-surface-variant: var(--secondary-foreground);

  /* Muted */
  --arcane-muted: var(--muted);
  --arcane-muted-foreground: var(--muted-foreground);

  /* Semantic Status */
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

  /* Borders */
  --arcane-border: var(--border);
  --arcane-border-subtle: var(--input);
  --arcane-input: var(--input);
  --arcane-input-foreground: var(--foreground);
  --arcane-ring: var(--ring);
  --arcane-outline: var(--border);
  --arcane-outline-variant: var(--input);

  /* Overlays */
  --arcane-overlay: rgba(0, 0, 0, 0.5);
  --arcane-overlay-strong: rgba(0, 0, 0, 0.7);
  --arcane-scrim: rgba(0, 0, 0, 0.5);
  --arcane-tooltip: var(--popover);
  --arcane-tooltip-foreground: var(--popover-foreground);
  --arcane-code-background: var(--secondary);
  --arcane-navbar: rgba(255, 255, 255, 0.8);

  /* RGB Channels for rgba() compositing */
  --arcane-background-rgb: 255, 255, 255;
  --arcane-foreground-rgb: 9, 9, 11;
  --arcane-on-background-rgb: 9, 9, 11;
  --arcane-primary-rgb: 9, 9, 11;
  --arcane-secondary-rgb: 244, 244, 245;
  --arcane-accent-rgb: 244, 244, 245;
  --arcane-muted-rgb: 113, 113, 122;
  --arcane-destructive-rgb: 239, 68, 68;
  --arcane-success-rgb: 34, 197, 94;
  --arcane-warning-rgb: 245, 158, 11;
  --arcane-info-rgb: 59, 130, 246;
  --arcane-surface-rgb: 255, 255, 255;
  --arcane-on-surface-rgb: 9, 9, 11;
  --arcane-surface-variant-rgb: 244, 244, 245;
  --arcane-on-surface-variant-rgb: 9, 9, 11;
  --arcane-card-rgb: 255, 255, 255;
  --arcane-border-rgb: 228, 228, 231;
  --arcane-input-rgb: 228, 228, 231;

  /* Typography */
  --arcane-font-sans: var(--font-sans);
  --arcane-font-heading: var(--font-sans);
  --arcane-font-mono: var(--font-mono);

  /* Radius */
  --arcane-radius: var(--radius);
  --arcane-radius-xs: 4px;
  --arcane-radius-sm: 6px;
  --arcane-radius-md: 8px;
  --arcane-radius-lg: 10px;
  --arcane-radius-xl: 14px;
  --arcane-radius-2xl: 18px;
  --arcane-radius-full: 9999px;

  /* Shadows */
  --arcane-shadow-xs: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
  --arcane-shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px -1px rgba(0, 0, 0, 0.1);
  --arcane-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.1);
  --arcane-shadow-md: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.1);
  --arcane-shadow-lg: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  --arcane-shadow-xl: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 8px 10px -1px rgba(0, 0, 0, 0.1);

  /* Transitions */
  --arcane-transition-fast: 100ms cubic-bezier(0.4, 0, 0.2, 1);
  --arcane-transition: 150ms cubic-bezier(0.4, 0, 0.2, 1);
  --arcane-transition-slow: 200ms cubic-bezier(0.4, 0, 0.2, 1);

  /* Component Structure */
  --arcane-interactive-radius: var(--arcane-radius-md);
  --arcane-container-radius: var(--arcane-radius-lg);
  --arcane-input-radius: var(--arcane-radius-md);
  --arcane-indicator-checkbox-radius: var(--arcane-radius-sm);
  --arcane-indicator-radio-radius: 50%;
  --arcane-indicator-toggle-track-radius: 9999px;
  --arcane-indicator-toggle-thumb-radius: 50%;

  /* Extended Colors */
  --arcane-tertiary: var(--accent);
  --arcane-on-tertiary: var(--accent-foreground);
  --arcane-tertiary-rgb: 244, 244, 245;
  --arcane-primary-container: rgba(9, 9, 11, 0.1);
  --arcane-on-primary-container: var(--primary);
  --arcane-secondary-container: rgba(244, 244, 245, 0.1);
  --arcane-on-secondary-container: var(--secondary-foreground);
  --arcane-tertiary-container: rgba(244, 244, 245, 0.1);
  --arcane-on-tertiary-container: var(--accent-foreground);
  --arcane-background-secondary: #fafafa;
  --arcane-background-tertiary: #f4f4f5;
  --arcane-text-subtle: rgba(113, 113, 122, 0.85);
  --arcane-text-faint: rgba(113, 113, 122, 0.65);
  --arcane-inverse-surface: #09090b;
  --arcane-on-inverse-surface: #f9fafb;
  --arcane-surface-tint: var(--accent);
  --arcane-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.1);
  --arcane-accent-glow: rgba(244, 244, 245, 0.1);
  --arcane-secondary-glow: rgba(244, 244, 245, 0.1);
  --arcane-grid-color: rgba(244, 244, 245, 0.03);

  /* Style Aliases (for ArcaneRadius/ArcaneEffects fallbacks) */
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
}

/* Dark Mode - OLED-optimized variant */
.dark {
  /* Core ShadCN Variables - Pure black for OLED */
  --background: #000000;
  --foreground: #fafafa;

  --card: #0a0a0a;
  --card-foreground: #fafafa;

  --popover: #0a0a0a;
  --popover-foreground: #fafafa;

  --primary: #fafafa;
  --primary-foreground: #0a0a0a;

  --secondary: #151515;
  --secondary-foreground: #fafafa;

  --muted: #151515;
  --muted-foreground: #a3a3a3;

  --accent: #151515;
  --accent-foreground: #fafafa;

  --destructive: #7f1d1d;
  --destructive-foreground: #fafafa;

  --success: #166534;
  --success-foreground: #ffffff;

  --warning: #92400e;
  --warning-foreground: #ffffff;

  --info: #1e40af;
  --info-foreground: #ffffff;

  --border: #252525;
  --input: #151515;
  --ring: #d4d4d4;

  /* ==========================================================================
   * Arcane Token Aliases - Dark Mode
   * ========================================================================== */

  /* Core Colors */
  --arcane-background: var(--background);
  --arcane-foreground: var(--foreground);
  --arcane-on-background: var(--foreground);
  --arcane-card: var(--card);
  --arcane-card-foreground: var(--card-foreground);
  --arcane-card-hover: #1a1a1a;
  --arcane-card-alt: var(--secondary);
  --arcane-popover: var(--popover);
  --arcane-popover-foreground: var(--popover-foreground);

  /* Primary/Secondary/Accent */
  --arcane-primary: var(--primary);
  --arcane-primary-foreground: var(--primary-foreground);
  --arcane-on-primary: var(--primary-foreground);
  --arcane-secondary: var(--secondary);
  --arcane-secondary-foreground: var(--secondary-foreground);
  --arcane-on-secondary: var(--secondary-foreground);
  --arcane-accent: var(--accent);
  --arcane-accent-foreground: var(--accent-foreground);
  --arcane-accent-hover: #1f1f1f;
  --arcane-accent-container: rgba(21, 21, 21, 0.1);

  /* Surface (Material-style aliases) */
  --arcane-surface: var(--card);
  --arcane-on-surface: var(--card-foreground);
  --arcane-surface-variant: var(--secondary);
  --arcane-on-surface-variant: var(--secondary-foreground);

  /* Muted */
  --arcane-muted: var(--muted);
  --arcane-muted-foreground: var(--muted-foreground);

  /* Semantic Status */
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

  /* Borders */
  --arcane-border: var(--border);
  --arcane-border-subtle: var(--input);
  --arcane-input: var(--input);
  --arcane-input-foreground: var(--foreground);
  --arcane-ring: var(--ring);
  --arcane-outline: var(--border);
  --arcane-outline-variant: var(--input);

  /* Overlays */
  --arcane-overlay: rgba(0, 0, 0, 0.5);
  --arcane-overlay-strong: rgba(0, 0, 0, 0.7);
  --arcane-scrim: rgba(0, 0, 0, 0.5);
  --arcane-tooltip: var(--popover);
  --arcane-tooltip-foreground: var(--popover-foreground);
  --arcane-code-background: var(--secondary);
  --arcane-navbar: rgba(0, 0, 0, 0.8);

  /* RGB Channels for rgba() compositing */
  --arcane-background-rgb: 0, 0, 0;
  --arcane-foreground-rgb: 250, 250, 250;
  --arcane-on-background-rgb: 250, 250, 250;
  --arcane-primary-rgb: 250, 250, 250;
  --arcane-secondary-rgb: 21, 21, 21;
  --arcane-accent-rgb: 21, 21, 21;
  --arcane-muted-rgb: 163, 163, 163;
  --arcane-destructive-rgb: 127, 29, 29;
  --arcane-success-rgb: 22, 101, 52;
  --arcane-warning-rgb: 146, 64, 14;
  --arcane-info-rgb: 30, 64, 175;
  --arcane-surface-rgb: 10, 10, 10;
  --arcane-on-surface-rgb: 250, 250, 250;
  --arcane-surface-variant-rgb: 21, 21, 21;
  --arcane-on-surface-variant-rgb: 250, 250, 250;
  --arcane-card-rgb: 10, 10, 10;
  --arcane-border-rgb: 37, 37, 37;
  --arcane-input-rgb: 21, 21, 21;

  /* Extended Colors */
  --arcane-tertiary: var(--accent);
  --arcane-on-tertiary: var(--accent-foreground);
  --arcane-tertiary-rgb: 21, 21, 21;
  --arcane-primary-container: rgba(250, 250, 250, 0.1);
  --arcane-on-primary-container: var(--primary);
  --arcane-secondary-container: rgba(21, 21, 21, 0.1);
  --arcane-on-secondary-container: var(--secondary-foreground);
  --arcane-tertiary-container: rgba(21, 21, 21, 0.1);
  --arcane-on-tertiary-container: var(--accent-foreground);
  --arcane-background-secondary: #0a0a0a;
  --arcane-background-tertiary: #151515;
  --arcane-text-subtle: rgba(163, 163, 163, 0.85);
  --arcane-text-faint: rgba(163, 163, 163, 0.65);
  --arcane-inverse-surface: #fafafa;
  --arcane-on-inverse-surface: #0a0a0a;
  --arcane-surface-tint: var(--accent);
  --arcane-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.3), 0 2px 4px -1px rgba(0, 0, 0, 0.2);
  --arcane-accent-glow: rgba(21, 21, 21, 0.1);
  --arcane-secondary-glow: rgba(21, 21, 21, 0.1);
  --arcane-grid-color: rgba(21, 21, 21, 0.03);
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

/* Button Hover States (applied via data attributes or JS) */
.arcane-button:hover:not([disabled]) {
  filter: brightness(0.95);
}

.arcane-button:active:not([disabled]) {
  filter: brightness(0.9);
}
''';
}