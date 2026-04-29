import 'package:arcane_jaspr/component/navigation/toc.dart'
    show arcaneTocTreeLinesCss;
import 'package:arcane_jaspr/component/view/map/map_style.dart'
    show arcaneMapCss;
import 'package:arcane_jaspr/util/content/prose_styles.dart';

import 'neon_theme.dart';

class NeonCss {
  const NeonCss._();

  static String _hex(int argb) {
    final int r = (argb >> 16) & 0xFF;
    final int g = (argb >> 8) & 0xFF;
    final int b = argb & 0xFF;
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }

  static String componentCss(NeonTheme theme) {
    final String accentHot = _hex(theme.accentHot);
    final String accentCool = _hex(theme.accentCool);

    return '''
#arcane-root[class*="neon-"] {
  --neon-accent: var(--primary);
  --neon-accent-rgb: var(--primary-rgb);
  --neon-accent-hot: $accentHot;
  --neon-accent-cool: $accentCool;

  --neon-accent-soft: color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --neon-accent-medium: color-mix(in srgb, var(--neon-accent) 32%, transparent);
  --neon-accent-strong: color-mix(in srgb, var(--neon-accent) 56%, transparent);
  --neon-on-accent: #03110f;

  --neon-cool-soft: color-mix(in srgb, var(--neon-accent-cool) 22%, transparent);
  --neon-cool-medium: color-mix(in srgb, var(--neon-accent-cool) 40%, transparent);

  --neon-hot-soft: color-mix(in srgb, var(--neon-accent-hot) 18%, transparent);

  --neon-surface-0: #12151C;
  --neon-surface-1: rgba(25, 29, 38, 0.94);
  --neon-surface-2: rgba(27, 34, 44, 0.9);
  --neon-surface-3: rgba(45, 45, 48, 0.82);

  --neon-cut-xs: 0.375rem;
  --neon-cut-sm: 0.625rem;
  --neon-cut-md: 1rem;

  --neon-radius-control: 0.375rem;
  --neon-radius-panel: 0.625rem;

  --neon-clip-xs: polygon(0 var(--neon-cut-xs), var(--neon-cut-xs) 0, 100% 0, 100% calc(100% - var(--neon-cut-xs)), calc(100% - var(--neon-cut-xs)) 100%, 0 100%);
  --neon-clip-sm: polygon(0 var(--neon-cut-sm), var(--neon-cut-sm) 0, 100% 0, 100% calc(100% - var(--neon-cut-sm)), calc(100% - var(--neon-cut-sm)) 100%, 0 100%);
  --neon-clip-md: polygon(0 var(--neon-cut-md), var(--neon-cut-md) 0, 100% 0, 100% calc(100% - var(--neon-cut-md)), calc(100% - var(--neon-cut-md)) 100%, 0 100%);

  --neon-control-clip: var(--neon-clip-sm);
  --neon-panel-clip: var(--neon-clip-md);

  --neon-panel-border: color-mix(in srgb, var(--neon-accent) 16%, #3E3E42);
  --neon-panel-border-hot: color-mix(in srgb, var(--neon-accent-cool) 38%, #3E3E42);
  --neon-control-border: color-mix(in srgb, var(--neon-accent) 10%, #3E3E42);
  --neon-control-border-strong: color-mix(in srgb, var(--neon-accent) 34%, #3E3E42);

  --neon-panel-surface: color-mix(in srgb, var(--card) 86%, transparent);
  --neon-panel-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 7%, transparent), transparent 58%);
  --neon-control-surface: color-mix(in srgb, var(--card) 88%, transparent);
  --neon-control-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), transparent 64%);

  --neon-shadow-sm: 0 6px 16px rgba(0, 0, 0, 0.3);
  --neon-shadow-md: 0 14px 32px rgba(0, 0, 0, 0.38);
  --neon-shadow-lg: 0 24px 48px rgba(0, 0, 0, 0.48);

  --neon-glow-sm: 0 0 16px color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --neon-glow-md: 0 0 24px color-mix(in srgb, var(--neon-accent) 22%, transparent);
  --neon-glow-lg: 0 0 36px color-mix(in srgb, var(--neon-accent) 28%, transparent);

  --neon-inset: inset 0 1px 0 rgba(255, 255, 255, 0.08);
  --neon-inset-strong: inset 0 1px 0 rgba(255, 255, 255, 0.14);

  --neon-grid-line: color-mix(in srgb, var(--neon-accent) 10%, transparent);

  background: transparent !important;
  isolation: isolate;
}

html.dark #arcane-root[class*="neon-"],
#arcane-root.dark[class*="neon-"] {
  --background: #12151C;
  --foreground: #F2F0EA;
  --card: #191D26;
  --card-foreground: #F2F0EA;
  --card-hover: #1B222C;
  --popover: #1B222C;
  --popover-foreground: #F2F0EA;
  --secondary: #191D26;
  --secondary-foreground: #F2F0EA;
  --accent: #1B222C;
  --accent-foreground: #F2F0EA;
  --muted: #191D26;
  --muted-foreground: #A8ADB6;
  --border: #3E3E42;
  --input: #2D2D30;
  --ring: #007ACC;
  --info: #007ACC;
  --destructive: #661B1C;
  --destructive-hover: #7A2022;
  --code-background: #1E1E1E;
  --neon-surface-0: #12151C;
  --neon-surface-1: rgba(25, 29, 38, 0.96);
  --neon-surface-2: rgba(27, 34, 44, 0.92);
  --neon-surface-3: rgba(45, 45, 48, 0.86);
  --neon-panel-surface: color-mix(in srgb, #191D26 92%, transparent);
  --neon-control-surface: color-mix(in srgb, #1B222C 90%, transparent);
  --neon-panel-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 6%, transparent), transparent 58%);
  --neon-control-tint: linear-gradient(135deg, color-mix(in srgb, #007ACC 4%, transparent), transparent 64%);
  --neon-grid-line: rgba(0, 122, 204, 0.075);
  --neon-on-accent: #101216;
}

html:has(#arcane-root[class*="neon-"]),
html:has(#arcane-root[class*="neon-"]) body,
#arcane-root[class*="neon-"],
#arcane-root[class*="neon-"] * {
  scrollbar-width: thin;
  scrollbar-color: color-mix(in srgb, var(--neon-accent-cool) 52%, transparent) transparent;
}

html:has(#arcane-root[class*="neon-"])::-webkit-scrollbar,
html:has(#arcane-root[class*="neon-"]) body::-webkit-scrollbar,
#arcane-root[class*="neon-"] *::-webkit-scrollbar {
  width: 0.5rem;
  height: 0.5rem;
}

html:has(#arcane-root[class*="neon-"])::-webkit-scrollbar-track,
html:has(#arcane-root[class*="neon-"]) body::-webkit-scrollbar-track,
#arcane-root[class*="neon-"] *::-webkit-scrollbar-track {
  background: transparent;
}

html:has(#arcane-root[class*="neon-"])::-webkit-scrollbar-thumb,
html:has(#arcane-root[class*="neon-"]) body::-webkit-scrollbar-thumb,
#arcane-root[class*="neon-"] *::-webkit-scrollbar-thumb {
  background: color-mix(in srgb, var(--neon-accent-cool) 44%, var(--border));
  border: 2px solid transparent;
  border-radius: 999px;
  background-clip: padding-box;
}

html:has(#arcane-root[class*="neon-"])::-webkit-scrollbar-thumb:hover,
html:has(#arcane-root[class*="neon-"]) body::-webkit-scrollbar-thumb:hover,
#arcane-root[class*="neon-"] *::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--neon-accent-cool) 68%, var(--foreground));
}

html.dark #arcane-root[class*="neon-"]::before {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -2;
  pointer-events: none;
  background-color: #12151C;
  background-image:
    radial-gradient(ellipse 60rem 40rem at 12% -8%, rgba(0, 122, 204, 0.1), transparent 70%),
    radial-gradient(ellipse 50rem 32rem at 92% 100%, rgba(102, 27, 28, 0.12), transparent 70%),
    linear-gradient(var(--neon-grid-line) 1px, transparent 1px),
    linear-gradient(90deg, var(--neon-grid-line) 1px, transparent 1px);
  background-size: auto, auto, 64px 64px, 64px 64px;
  background-attachment: fixed;
  transform: translateZ(0);
}

html.dark #arcane-root[class*="neon-"]::after {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -1;
  pointer-events: none;
  opacity: 0.06;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
  background-size: 200px 200px;
  mix-blend-mode: overlay;
}

#arcane-root[class*="neon-"] ::selection {
  background: color-mix(in srgb, var(--neon-accent) 38%, transparent);
  color: var(--foreground);
}

#arcane-root[class*="neon-"] :focus-visible {
  outline: 2px solid var(--neon-accent);
  outline-offset: 2px;
  box-shadow: 0 0 0 3px color-mix(in srgb, var(--neon-accent) 20%, transparent), var(--neon-glow-md);
}

#arcane-root[class*="neon-"] a {
  color: var(--neon-accent);
  text-underline-offset: 2px;
  transition: color 0.15s ease, text-shadow 0.15s ease;
}

#arcane-root[class*="neon-"] a:hover {
  color: var(--neon-accent-cool);
  text-shadow: 0 0 12px color-mix(in srgb, var(--neon-accent-cool) 32%, transparent);
}

#arcane-root[class*="neon-"] .arcane-scaffold-sidebar,
#arcane-root[class*="neon-"] .arcane-scaffold-main,
#arcane-root[class*="neon-"] .arcane-scaffold-secondary,
#arcane-root[class*="neon-"] .neon-card,
#arcane-root[class*="neon-"] .neon-command-dialog,
#arcane-root[class*="neon-"] .neon-accordion,
#arcane-root[class*="neon-"] .neon-calendar,
#arcane-root[class*="neon-"] .neon-chart,
#arcane-root[class*="neon-"] .neon-data-table-container,
#arcane-root[class*="neon-"] .neon-static-table-container,
#arcane-root[class*="neon-"] .neon-sidebar,
#arcane-root[class*="neon-"] .neon-empty-state-card,
#arcane-root[class*="neon-"] .neon-resizable,
#arcane-root[class*="neon-"] .neon-scroll-area,
#arcane-root[class*="neon-"] .neon-form-section,
#arcane-root[class*="neon-"] .neon-input-group,
#arcane-root[class*="neon-"] .neon-disclosure,
#arcane-root[class*="neon-"] .neon-field-wrapper,
#arcane-root[class*="neon-"] .neon-otp-input,
#arcane-root[class*="neon-"] .neon-radio-group,
#arcane-root[class*="neon-"] .neon-tabs,
#arcane-root[class*="neon-"] .neon-toggle-group,
#arcane-root[class*="neon-"] .neon-slot-counter,
#arcane-root[class*="neon-"] .neon-slot-counter-card,
#arcane-root[class*="neon-"] .neon-kv-table,
#arcane-root[class*="neon-"] .neon-button-panel,
#arcane-root[class*="neon-"] .neon-toolbar,
#arcane-root[class*="neon-"] .neon-button-group,
#arcane-root[class*="neon-"] .neon-panel {
  position: relative;
  isolation: isolate;
  overflow: hidden;
  border-radius: var(--neon-radius-panel) !important;
  clip-path: var(--neon-panel-clip);
  border: 1px solid var(--neon-panel-border) !important;
  background: var(--neon-panel-tint), var(--neon-panel-surface) !important;
  box-shadow: var(--neon-shadow-sm), var(--neon-inset);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
  transition: border-color 0.18s ease, box-shadow 0.18s ease, transform 0.18s ease;
}

#arcane-root[class*="neon-"] .neon-card.clickable {
  cursor: pointer;
}

#arcane-root[class*="neon-"] .neon-card.clickable:hover {
  border-color: var(--neon-panel-border-hot) !important;
  transform: translateY(-2px);
  box-shadow: var(--neon-shadow-md), var(--neon-glow-md), var(--neon-inset-strong);
}

#arcane-root[class*="neon-"] .neon-dropdown-menu,
#arcane-root[class*="neon-"] .neon-dropdown-submenu,
#arcane-root[class*="neon-"] .neon-context-menu,
#arcane-root[class*="neon-"] .neon-menubar-content,
#arcane-root[class*="neon-"] .neon-select-content,
#arcane-root[class*="neon-"] .neon-date-picker,
#arcane-root[class*="neon-"] .neon-time-picker,
#arcane-root[class*="neon-"] .neon-popover,
#arcane-root[class*="neon-"] .neon-tooltip,
#arcane-root[class*="neon-"] .neon-toast,
#arcane-root[class*="neon-"] .neon-tabs-list,
#arcane-root[class*="neon-"] .neon-command,
#arcane-root[class*="neon-"] .neon-data-table,
#arcane-root[class*="neon-"] .neon-static-table {
  position: relative;
  overflow: hidden;
  border-radius: var(--neon-radius-panel) !important;
  clip-path: var(--neon-panel-clip);
  border-color: var(--neon-panel-border) !important;
  background: var(--neon-panel-tint), color-mix(in srgb, var(--popover, var(--card)) 88%, transparent) !important;
  box-shadow: var(--neon-shadow-md), var(--neon-inset);
  backdrop-filter: blur(18px) saturate(1.18);
  -webkit-backdrop-filter: blur(18px) saturate(1.18);
}

#arcane-root[class*="neon-"] .neon-tooltip {
  background: color-mix(in srgb, var(--neon-surface-2) 92%, transparent) !important;
  border-color: color-mix(in srgb, var(--neon-accent) 18%, var(--border)) !important;
}

#arcane-root[class*="neon-"] .neon-button,
#arcane-root[class*="neon-"] .neon-text-input,
#arcane-root[class*="neon-"] .neon-text-input-container,
#arcane-root[class*="neon-"] .neon-select-trigger,
#arcane-root[class*="neon-"] .neon-date-picker-trigger,
#arcane-root[class*="neon-"] .neon-otp-digit,
#arcane-root[class*="neon-"] .neon-calendar-nav-btn,
#arcane-root[class*="neon-"] .neon-calendar-today-btn,
#arcane-root[class*="neon-"] .neon-calendar-day,
#arcane-root[class*="neon-"] .neon-pagination-button,
#arcane-root[class*="neon-"] .neon-menubar-trigger,
#arcane-root[class*="neon-"] .neon-toggle-button,
#arcane-root[class*="neon-"] .neon-radio-card,
#arcane-root[class*="neon-"] .neon-radio-button,
#arcane-root[class*="neon-"] .neon-radio-chip,
#arcane-root[class*="neon-"] .neon-toggle-group-item,
#arcane-root[class*="neon-"] .neon-tabs-trigger,
#arcane-root[class*="neon-"] .neon-tab-bar-item {
  border-radius: var(--neon-radius-control) !important;
  clip-path: var(--neon-control-clip);
  transition: color 0.16s ease, background 0.16s ease, border-color 0.16s ease, box-shadow 0.16s ease, transform 0.16s ease;
}

#arcane-root[class*="neon-"] .neon-select-trigger,
#arcane-root[class*="neon-"] .neon-date-picker-trigger,
#arcane-root[class*="neon-"] .neon-text-input,
#arcane-root[class*="neon-"] .neon-text-input-container,
#arcane-root[class*="neon-"] .neon-otp-digit,
#arcane-root[class*="neon-"] .neon-calendar-nav-btn,
#arcane-root[class*="neon-"] .neon-calendar-today-btn,
#arcane-root[class*="neon-"] .neon-pagination-button,
#arcane-root[class*="neon-"] .neon-menubar-trigger,
#arcane-root[class*="neon-"] .neon-toggle-button,
#arcane-root[class*="neon-"] .neon-radio-card,
#arcane-root[class*="neon-"] .neon-radio-button,
#arcane-root[class*="neon-"] .neon-radio-chip,
#arcane-root[class*="neon-"] .neon-toggle-group-item,
#arcane-root[class*="neon-"] .neon-tabs-trigger,
#arcane-root[class*="neon-"] .neon-tab-bar-item {
  background: var(--neon-control-tint), var(--neon-control-surface) !important;
  border: 1px solid var(--neon-control-border) !important;
  color: var(--foreground);
  box-shadow: var(--neon-inset);
}

#arcane-root[class*="neon-"] .neon-select-trigger:hover,
#arcane-root[class*="neon-"] .neon-date-picker-trigger:hover,
#arcane-root[class*="neon-"] .neon-text-input:hover,
#arcane-root[class*="neon-"] .neon-text-input-container:hover,
#arcane-root[class*="neon-"] .neon-otp-digit:hover,
#arcane-root[class*="neon-"] .neon-calendar-nav-btn:hover,
#arcane-root[class*="neon-"] .neon-calendar-today-btn:hover,
#arcane-root[class*="neon-"] .neon-calendar-day:hover,
#arcane-root[class*="neon-"] .neon-pagination-button:hover,
#arcane-root[class*="neon-"] .neon-menubar-trigger:hover,
#arcane-root[class*="neon-"] .neon-toggle-button:hover,
#arcane-root[class*="neon-"] .neon-radio-card:hover,
#arcane-root[class*="neon-"] .neon-radio-button:hover,
#arcane-root[class*="neon-"] .neon-radio-chip:hover,
#arcane-root[class*="neon-"] .neon-toggle-group-item:hover,
#arcane-root[class*="neon-"] .neon-tabs-trigger:hover,
#arcane-root[class*="neon-"] .neon-tab-bar-item:hover {
  border-color: var(--neon-panel-border-hot) !important;
  color: var(--neon-accent-cool);
  box-shadow: var(--neon-inset-strong), var(--neon-glow-sm);
}

#arcane-root[class*="neon-"] .neon-breadcrumbs {
  width: fit-content;
  max-width: 100%;
  gap: 0.28rem !important;
  padding: 0.24rem 0.38rem;
  border: 1px solid color-mix(in srgb, var(--neon-accent-cool) 16%, transparent);
  border-radius: 0.3rem;
  clip-path: polygon(0 0.38rem, 0.38rem 0, 100% 0, 100% calc(100% - 0.38rem), calc(100% - 0.38rem) 100%, 0 100%);
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--neon-surface-2) 70%, transparent), color-mix(in srgb, var(--neon-surface-1) 58%, transparent)),
    linear-gradient(90deg, color-mix(in srgb, var(--neon-accent-cool) 8%, transparent), transparent 48%, color-mix(in srgb, var(--neon-accent-hot) 5%, transparent));
  box-shadow:
    inset 0 1px 0 color-mix(in srgb, #ffffff 8%, transparent),
    0 0 18px color-mix(in srgb, var(--neon-accent-cool) 6%, transparent);
  backdrop-filter: blur(12px) saturate(1.08);
  -webkit-backdrop-filter: blur(12px) saturate(1.08);
}

#arcane-root[class*="neon-"] .neon-breadcrumb-link,
#arcane-root[class*="neon-"] .neon-breadcrumb-button,
#arcane-root[class*="neon-"] .neon-breadcrumb-current {
  position: relative;
  min-height: 1.35rem;
  padding: 0 0.34rem 0 0.78rem !important;
  border: 0 !important;
  border-radius: 0.18rem !important;
  clip-path: none !important;
  background: transparent !important;
  color: color-mix(in srgb, var(--muted-foreground) 82%, var(--foreground)) !important;
  box-shadow: none !important;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  line-height: 1;
}

#arcane-root[class*="neon-"] .neon-breadcrumb-link::before,
#arcane-root[class*="neon-"] .neon-breadcrumb-button::before,
#arcane-root[class*="neon-"] .neon-breadcrumb-current::before {
  content: '';
  position: absolute;
  left: 0.28rem;
  top: 50%;
  width: 0.34rem;
  height: 0.34rem;
  border: 1px solid color-mix(in srgb, var(--neon-accent-cool) 44%, transparent);
  background: color-mix(in srgb, var(--background) 74%, transparent);
  transform: translateY(-50%) rotate(45deg);
  box-shadow: 0 0 8px color-mix(in srgb, var(--neon-accent-cool) 10%, transparent);
}

#arcane-root[class*="neon-"] .neon-breadcrumb-link:hover,
#arcane-root[class*="neon-"] .neon-breadcrumb-button:hover {
  color: var(--neon-accent-cool) !important;
  background: color-mix(in srgb, var(--neon-accent-cool) 8%, transparent) !important;
}

#arcane-root[class*="neon-"] .neon-breadcrumb-link:hover::before,
#arcane-root[class*="neon-"] .neon-breadcrumb-button:hover::before,
#arcane-root[class*="neon-"] .neon-breadcrumb-current::before {
  border-color: var(--neon-accent-cool);
  background: color-mix(in srgb, var(--neon-accent-cool) 34%, var(--background));
  box-shadow: 0 0 10px color-mix(in srgb, var(--neon-accent-cool) 22%, transparent);
}

#arcane-root[class*="neon-"] .neon-breadcrumb-current {
  color: var(--foreground) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-accent-cool) 12%, transparent), color-mix(in srgb, var(--neon-accent-hot) 6%, transparent)) !important;
}

#arcane-root[class*="neon-"] .neon-breadcrumb-separator {
  position: relative;
  width: 1.25rem;
  min-width: 1.25rem;
  height: 1px;
  overflow: visible;
  color: transparent !important;
  opacity: 1 !important;
}

#arcane-root[class*="neon-"] .neon-breadcrumb-separator::before {
  content: '';
  position: absolute;
  left: 0.14rem;
  right: 0.14rem;
  top: 50%;
  height: 1px;
  background: linear-gradient(90deg, transparent, color-mix(in srgb, var(--neon-accent-cool) 44%, transparent), transparent);
  transform: translateY(-50%);
}

#arcane-root[class*="neon-"] .neon-breadcrumb-separator::after {
  content: '';
  position: absolute;
  right: 0.14rem;
  top: 50%;
  width: 0.28rem;
  height: 0.28rem;
  border-top: 1px solid color-mix(in srgb, var(--neon-accent-cool) 50%, transparent);
  border-right: 1px solid color-mix(in srgb, var(--neon-accent-cool) 50%, transparent);
  transform: translateY(-50%) rotate(45deg);
}

html.light #arcane-root[class*="neon-"] .neon-breadcrumbs,
#arcane-root.light[class*="neon-"] .neon-breadcrumbs {
  border-color: rgba(36, 78, 209, 0.14);
  background:
    linear-gradient(135deg, rgba(255, 255, 255, 0.76), rgba(243, 246, 251, 0.68)),
    linear-gradient(90deg, rgba(132, 165, 242, 0.12), transparent 52%, rgba(255, 102, 0, 0.05));
  box-shadow: 0 8px 20px rgba(36, 78, 209, 0.08), inset 0 1px 0 rgba(255, 255, 255, 0.9);
}

html.light #arcane-root[class*="neon-"] .neon-breadcrumb-link,
html.light #arcane-root[class*="neon-"] .neon-breadcrumb-button,
html.light #arcane-root[class*="neon-"] .neon-breadcrumb-current,
#arcane-root.light[class*="neon-"] .neon-breadcrumb-link,
#arcane-root.light[class*="neon-"] .neon-breadcrumb-button,
#arcane-root.light[class*="neon-"] .neon-breadcrumb-current {
  color: #52638d !important;
}

html.light #arcane-root[class*="neon-"] .neon-breadcrumb-current,
#arcane-root.light[class*="neon-"] .neon-breadcrumb-current {
  color: #101a3a !important;
  background: linear-gradient(90deg, rgba(132, 165, 242, 0.2), rgba(255, 102, 0, 0.06)) !important;
}

#arcane-root[class*="neon-"] .neon-text-input:focus,
#arcane-root[class*="neon-"] .neon-text-input-container:focus-within,
#arcane-root[class*="neon-"] .neon-otp-digit:focus {
  border-color: var(--neon-accent) !important;
  box-shadow: 0 0 0 1px color-mix(in srgb, var(--neon-accent) 32%, transparent), var(--neon-glow-md);
}

#arcane-root[class*="neon-"] .neon-tabs-trigger[data-state="active"],
#arcane-root[class*="neon-"] .neon-tab-bar-item.active,
#arcane-root[class*="neon-"] .neon-toggle-button.active,
#arcane-root[class*="neon-"] .neon-toggle-group-item.selected,
#arcane-root[class*="neon-"] .neon-radio-card.selected,
#arcane-root[class*="neon-"] .neon-radio-button.selected,
#arcane-root[class*="neon-"] .neon-radio-chip.selected,
#arcane-root[class*="neon-"] .neon-pagination-button.active,
#arcane-root[class*="neon-"] .neon-calendar-day.selected,
#arcane-root[class*="neon-"] .neon-calendar-day[aria-selected="true"],
#arcane-root[class*="neon-"] .neon-select-trigger.open,
#arcane-root[class*="neon-"] .neon-select-trigger[data-state="open"] {
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 22%, transparent), color-mix(in srgb, var(--neon-accent-cool) 12%, transparent)),
    color-mix(in srgb, var(--card) 80%, transparent) !important;
  border-color: var(--neon-accent) !important;
  color: var(--foreground) !important;
  box-shadow: var(--neon-inset-strong), var(--neon-glow-md);
}

#arcane-root[class*="neon-"] .neon-button {
  isolation: isolate;
  overflow: hidden;
  text-transform: uppercase;
  letter-spacing: 0.06em;
}

#arcane-root[class*="neon-"] .neon-button::before {
  content: '';
  position: absolute;
  inset: 0;
  pointer-events: none;
  opacity: 0;
  background: linear-gradient(120deg, transparent 38%, color-mix(in srgb, #ffffff 18%, transparent) 50%, transparent 62%);
  transform: translateX(-120%);
  transition: opacity 0.18s ease, transform 0.55s ease;
  z-index: 1;
}

#arcane-root[class*="neon-"] .neon-button:hover::before {
  opacity: 0.6;
  transform: translateX(120%);
}

#arcane-root[class*="neon-"] .neon-button:hover {
  transform: translateY(-1px);
  filter: brightness(1.06);
}

#arcane-root[class*="neon-"] .neon-button:active {
  transform: translateY(0);
  filter: brightness(0.96);
}

#arcane-root[class*="neon-"] .neon-alert {
  position: relative;
  isolation: isolate;
  overflow: hidden;
  border-radius: var(--neon-radius-panel) !important;
  clip-path: var(--neon-clip-sm);
  align-items: flex-start;
  border-left: 0 !important;
  box-shadow: var(--neon-shadow-sm), var(--neon-inset);
}

#arcane-root[class*="neon-"] .neon-alert-title,
#arcane-root[class*="neon-"] .neon-card h1,
#arcane-root[class*="neon-"] .neon-card h2,
#arcane-root[class*="neon-"] .neon-card h3 {
  letter-spacing: 0.06em;
}

#arcane-root[class*="neon-"] .neon-alert-icon,
#arcane-root[class*="neon-"] .neon-empty-state-icon,
#arcane-root[class*="neon-"] .neon-check-item-icon,
#arcane-root[class*="neon-"] .neon-feature-row-icon {
  border: 1px solid var(--neon-panel-border-hot);
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  background: var(--neon-panel-tint), color-mix(in srgb, var(--card) 80%, transparent) !important;
  box-shadow: var(--neon-glow-sm);
}

#arcane-root[class*="neon-"] .neon-badge,
#arcane-root[class*="neon-"] .neon-status-badge,
#arcane-root[class*="neon-"] .neon-kbd {
  border-radius: var(--neon-radius-control) !important;
  clip-path: var(--neon-clip-xs);
  background: var(--neon-panel-tint), color-mix(in srgb, var(--card) 84%, transparent) !important;
  border: 1px solid var(--neon-panel-border) !important;
  box-shadow: var(--neon-inset);
}

#arcane-root[class*="neon-"] .neon-status-label {
  letter-spacing: 0.08em;
}

#arcane-root[class*="neon-"] .neon-data-table,
#arcane-root[class*="neon-"] .neon-static-table,
#arcane-root[class*="neon-"] .neon-kv-table {
  border-collapse: separate !important;
  border-spacing: 0;
  overflow: hidden;
  font-variant-numeric: tabular-nums;
}

#arcane-root[class*="neon-"] .neon-data-table th,
#arcane-root[class*="neon-"] .neon-static-table th,
#arcane-root[class*="neon-"] .neon-kv-table-key {
  background: color-mix(in srgb, var(--neon-accent) 8%, var(--card)) !important;
  color: var(--neon-accent) !important;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  font-size: 0.75rem;
  font-weight: 600;
  border-color: color-mix(in srgb, var(--neon-accent) 18%, var(--border)) !important;
}

#arcane-root[class*="neon-"] .neon-data-table td,
#arcane-root[class*="neon-"] .neon-static-table td,
#arcane-root[class*="neon-"] .neon-kv-table-value {
  border-color: color-mix(in srgb, var(--neon-accent) 8%, var(--border)) !important;
}

#arcane-root[class*="neon-"] .neon-data-table-row:hover,
#arcane-root[class*="neon-"] .neon-static-table tbody tr:hover,
#arcane-root[class*="neon-"] .neon-kv-table-row:hover {
  background: color-mix(in srgb, var(--neon-accent) 6%, transparent) !important;
}

#arcane-root[class*="neon-"] .neon-progress-track,
#arcane-root[class*="neon-"] .neon-slider-track {
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  border: 1px solid color-mix(in srgb, var(--neon-accent) 14%, var(--border));
  background: color-mix(in srgb, var(--foreground) 8%, transparent) !important;
}

#arcane-root[class*="neon-"] .neon-progress-indicator,
#arcane-root[class*="neon-"] .neon-slider-range {
  background: linear-gradient(90deg, var(--neon-accent), var(--neon-accent-cool)) !important;
  box-shadow: 0 0 14px color-mix(in srgb, var(--neon-accent) 36%, transparent);
}

#arcane-root[class*="neon-"] .neon-slider-thumb,
#arcane-root[class*="neon-"] .neon-radio-circle,
#arcane-root[class*="neon-"] .neon-status-indicator {
  box-shadow:
    0 0 0 1px color-mix(in srgb, var(--neon-accent) 38%, transparent),
    0 0 12px color-mix(in srgb, var(--neon-accent) 24%, transparent) !important;
}

#arcane-root[class*="neon-"] .neon-sidebar-item,
#arcane-root[class*="neon-"] .neon-dropdown-item,
#arcane-root[class*="neon-"] .neon-context-menu-item,
#arcane-root[class*="neon-"] .neon-menubar-item,
#arcane-root[class*="neon-"] .neon-select-option,
#arcane-root[class*="neon-"] .neon-select-item,
#arcane-root[class*="neon-"] .neon-command-item {
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  border: 1px solid transparent;
  transition: background 0.14s ease, border-color 0.14s ease, color 0.14s ease, box-shadow 0.14s ease;
}

#arcane-root[class*="neon-"] .neon-sidebar-item:hover,
#arcane-root[class*="neon-"] .neon-dropdown-item:hover,
#arcane-root[class*="neon-"] .neon-context-menu-item:hover,
#arcane-root[class*="neon-"] .neon-menubar-item:hover,
#arcane-root[class*="neon-"] .neon-select-option:hover,
#arcane-root[class*="neon-"] .neon-select-item:hover,
#arcane-root[class*="neon-"] .neon-command-item:hover {
  border-color: color-mix(in srgb, var(--neon-accent) 32%, transparent);
  background: color-mix(in srgb, var(--neon-accent) 10%, transparent) !important;
  color: var(--foreground);
}

#arcane-root[class*="neon-"] .neon-sidebar-item.selected,
#arcane-root[class*="neon-"] .neon-sidebar-item.active,
#arcane-root[class*="neon-"] .neon-command-item.selected,
#arcane-root[class*="neon-"] .neon-select-option.selected,
#arcane-root[class*="neon-"] .neon-select-item.selected {
  border-color: var(--neon-panel-border-hot);
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-accent) 14%, transparent), color-mix(in srgb, var(--neon-accent-cool) 8%, transparent)) !important;
  color: var(--foreground);
  box-shadow: inset 2px 0 0 var(--neon-accent), var(--neon-glow-sm);
}

#arcane-root[class*="neon-"] .neon-separator,
#arcane-root[class*="neon-"] .neon-dropdown-divider,
#arcane-root[class*="neon-"] .neon-context-menu-separator,
#arcane-root[class*="neon-"] .neon-menubar-separator,
#arcane-root[class*="neon-"] .neon-sidebar-separator {
  background: linear-gradient(90deg, transparent, var(--neon-panel-border-hot), transparent) !important;
  height: 1px !important;
}

#arcane-root[class*="neon-"] .neon-separator-with-label span {
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  border: 1px solid var(--neon-control-border);
  background: color-mix(in srgb, var(--card) 86%, transparent);
  color: var(--neon-accent);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  font-size: 0.75rem;
}

#arcane-root[class*="neon-"] .neon-skeleton,
#arcane-root[class*="neon-"] .neon-skeleton-card {
  border-radius: var(--neon-radius-control);
  clip-path: var(--neon-clip-xs);
  background:
    linear-gradient(100deg, color-mix(in srgb, var(--foreground) 6%, transparent) 8%, color-mix(in srgb, var(--neon-accent) 12%, transparent) 22%, color-mix(in srgb, var(--foreground) 6%, transparent) 36%),
    color-mix(in srgb, var(--card) 80%, transparent) !important;
  background-size: 240% 100%, auto !important;
}

html.light #arcane-root[class*="neon-"] {
  --neon-surface-0: var(--background);
  --neon-grid-line: color-mix(in srgb, var(--neon-accent) 8%, transparent);
  --neon-panel-surface: color-mix(in srgb, #ffffff 92%, var(--neon-accent));
  --neon-panel-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), transparent 70%);
  --neon-control-surface: color-mix(in srgb, #ffffff 96%, var(--neon-accent));
  --neon-control-tint: linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 4%, transparent), transparent 75%);
  --neon-panel-border: color-mix(in srgb, var(--neon-accent) 30%, var(--border));
  --neon-panel-border-hot: color-mix(in srgb, var(--neon-accent) 60%, var(--border));
  --neon-control-border: color-mix(in srgb, var(--neon-accent) 22%, var(--border));
  --neon-shadow-sm: 0 4px 10px color-mix(in srgb, var(--neon-accent) 7%, transparent);
  --neon-shadow-md: 0 10px 24px color-mix(in srgb, var(--neon-accent) 10%, transparent);
  --neon-shadow-lg: 0 20px 36px color-mix(in srgb, var(--neon-accent) 12%, transparent);
  --neon-glow-sm: 0 0 12px color-mix(in srgb, var(--neon-accent) 14%, transparent);
  --neon-glow-md: 0 0 18px color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --neon-glow-lg: 0 0 26px color-mix(in srgb, var(--neon-accent) 22%, transparent);
  --neon-inset: inset 0 1px 0 rgba(255, 255, 255, 0.7);
  --neon-inset-strong: inset 0 1px 0 rgba(255, 255, 255, 0.85);
}

html.light #arcane-root[class*="neon-"]::before {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -2;
  pointer-events: none;
  background-image:
    radial-gradient(ellipse 60rem 40rem at 12% -8%, color-mix(in srgb, var(--neon-accent) 8%, transparent), transparent 70%),
    linear-gradient(var(--neon-grid-line) 1px, transparent 1px),
    linear-gradient(90deg, var(--neon-grid-line) 1px, transparent 1px);
  background-size: auto, 64px 64px, 64px 64px;
  background-attachment: fixed;
}

html.light #arcane-root[class*="neon-"]::after {
  display: none;
}

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
  letter-spacing: 0.02em;
}

.prose h1 {
  font-size: 1.75rem;
  margin-top: 0;
  letter-spacing: 0.04em;
}

.prose h2 {
  font-size: 1.375rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid color-mix(in srgb, var(--neon-accent) 30%, transparent);
}

.prose h3 { font-size: 1.125rem; }
.prose h4 { font-size: 1rem; }

.prose p {
  margin-bottom: 1rem;
}

.prose a {
  color: var(--neon-accent);
  text-decoration: none;
  border-bottom: 1px solid color-mix(in srgb, var(--neon-accent) 36%, transparent);
  transition: color 0.15s ease, border-color 0.15s ease;
}

.prose a:hover {
  color: var(--neon-accent-cool);
  border-bottom-color: var(--neon-accent-cool);
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
  color: var(--neon-accent);
}

.prose blockquote {
  border-left: 3px solid var(--neon-accent);
  padding: 0.75rem 1rem;
  margin: 1rem 0;
  background: color-mix(in srgb, var(--neon-accent) 6%, transparent);
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
}

.prose blockquote p:last-child {
  margin-bottom: 0;
}

.prose hr {
  border: none;
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--neon-accent), transparent);
  margin: 1.75rem 0;
  opacity: 0.6;
}

.prose table {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
  font-variant-numeric: tabular-nums;
}

.prose th, .prose td {
  border: 1px solid var(--border);
  padding: 0.625rem 0.75rem;
  text-align: left;
  font-size: 0.875rem;
}

.prose th {
  background: color-mix(in srgb, var(--neon-accent) 8%, var(--muted));
  font-family: var(--font-heading);
  font-weight: 600;
  color: var(--neon-accent);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  font-size: 0.75rem;
}

.prose img {
  max-width: 100%;
  height: auto;
  border-radius: var(--radius-lg);
  margin: 1.5rem 0;
  border: 1px solid var(--border);
}

.prose pre {
  background: var(--neon-surface-1);
  border: 1px solid color-mix(in srgb, var(--neon-accent) 22%, var(--border));
  border-radius: var(--radius-md);
  padding: 1rem 1.25rem;
  overflow-x: auto;
  margin: 1rem 0;
  box-shadow: var(--neon-inset), 0 8px 24px color-mix(in srgb, var(--neon-accent) 8%, transparent);
}

.prose code {
  font-family: var(--font-mono);
  font-size: 0.875em;
}

.prose :not(pre) > code {
  background: color-mix(in srgb, var(--neon-accent) 10%, var(--muted));
  padding: 0.2rem 0.5rem;
  border-radius: var(--radius-sm);
  font-size: 0.875em;
  color: var(--neon-accent);
  border: 1px solid color-mix(in srgb, var(--neon-accent) 16%, transparent);
}

.prose .hljs-keyword { color: var(--neon-accent-hot); }
.prose .hljs-string { color: var(--neon-accent); }
.prose .hljs-number { color: var(--neon-accent-cool); }
.prose .hljs-function, .prose .hljs-title { color: var(--neon-accent-cool); }
.prose .hljs-comment { color: var(--muted-foreground); font-style: italic; }
.prose .hljs-variable { color: var(--neon-accent-hot); }
.prose .hljs-class, .prose .hljs-built_in { color: var(--neon-accent); }

#arcane-root[class*="neon-"] h1,
#arcane-root[class*="neon-"] h2,
#arcane-root[class*="neon-"] h3,
#arcane-root[class*="neon-"] h4,
#arcane-root[class*="neon-"] h5,
#arcane-root[class*="neon-"] h6,
#arcane-root[class*="neon-"] .arcane-heading,
#arcane-root[class*="neon-"] .arcane-headline,
#arcane-root[class*="neon-"] .arcane-subheadline,
#arcane-root[class*="neon-"] .arcane-title {
  font-family: var(--font-heading);
  letter-spacing: 0.03em;
}

#arcane-root[class*="neon-"] .neon-button,
#arcane-root[class*="neon-"] .neon-tabs-trigger,
#arcane-root[class*="neon-"] .neon-tab-bar-item,
#arcane-root[class*="neon-"] .neon-toggle-group-item {
  font-family: var(--font-heading);
}

#arcane-root[class*="neon-"] .neon-glow {
  box-shadow: var(--neon-glow-sm);
}

#arcane-root[class*="neon-"] .neon-glow-strong {
  box-shadow: var(--neon-glow-lg);
}

${theme == NeonTheme.rainbow ? rainbowCss : ''}

#arcane-root[class*="neon-"] .arcane-tree-lines {
  position: relative;
  --tree-indent: 1rem;
  --tree-line-color: var(--border);
}

#arcane-root[class*="neon-"] .arcane-tree-lines > * {
  position: relative;
  padding-left: var(--tree-indent);
}

#arcane-root[class*="neon-"] .arcane-tree-lines > *::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  width: calc(var(--tree-indent) - 4px);
  height: 1px;
  background: var(--tree-line-color);
}

#arcane-root[class*="neon-"] .arcane-tree-lines > *::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--tree-line-color);
}

#arcane-root[class*="neon-"] .arcane-tree-lines > *:last-child::after {
  bottom: 50%;
}

#arcane-root[class*="neon-"] .arcane-tree-lines > *:first-child::after {
  top: 50%;
}

#arcane-root[class*="neon-"] .arcane-tree-lines > *:only-child::after {
  display: none;
}

#arcane-root[class*="neon-"] .arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 70%, transparent);
}

#arcane-root[class*="neon-"] .arcane-tree-lines .arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 50%, transparent);
}

#arcane-root[class*="neon-"] .arcane-tree-lines .arcane-tree-lines .arcane-tree-lines .arcane-tree-lines {
  --tree-line-color: color-mix(in srgb, var(--border) 35%, transparent);
}

$arcaneSidebarTreeStyles

$arcaneSidebarComponentStyles

$arcaneTocTreeLinesCss

$arcaneMapCss

@keyframes neon-card-appear {
  from {
    opacity: 0;
    transform: scale(0.96) translateY(8px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

.neon-game-tile--animated {
  animation: neon-card-appear 0.3s ease-out forwards;
  opacity: 0;
}

.neon-game-tile--interactive {
  transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.neon-game-tile--interactive:hover {
  transform: translateY(-3px);
  border-color: var(--neon-panel-border-hot);
  box-shadow: var(--neon-shadow-md), var(--neon-glow-md);
}

.neon-platform-icon {
  position: relative;
}

.neon-platform-icon[data-tooltip]::after {
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
  box-shadow: var(--neon-shadow-sm);
}

.neon-platform-icon[data-tooltip]:hover::after {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(-8px);
}

.neon-game-tile--cta {
  border: 2px dashed color-mix(in srgb, var(--foreground) 15%, transparent);
  transition: border-color 0.2s ease, background 0.2s ease;
}

.neon-game-tile--cta:hover {
  border-color: var(--neon-panel-border-hot);
  background: color-mix(in srgb, var(--neon-accent) 5%, var(--card));
}

@media (prefers-reduced-motion: reduce) {
  #arcane-root[class*="neon-"] *,
  #arcane-root[class*="neon-"] *::before,
  #arcane-root[class*="neon-"] *::after {
    animation-duration: 0.001ms !important;
    animation-iteration-count: 1 !important;
    scroll-behavior: auto !important;
    transition-duration: 0.001ms !important;
  }
}

#arcane-root[class*="neon-"] .arcane-demo-panel {
  padding: 1.25rem !important;
  clip-path: var(--neon-panel-clip);
  border: 1px solid var(--neon-panel-border) !important;
  border-radius: var(--neon-radius-panel) !important;
  background:
    radial-gradient(circle at top left, color-mix(in srgb, var(--neon-accent-cool) 9%, transparent), transparent 18rem),
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 4%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 72%, transparent) !important;
  background-size: auto, 24px 24px, auto !important;
  box-shadow: var(--neon-shadow-sm), var(--neon-inset) !important;
}

#arcane-root[class*="neon-"] .arcane-demo-kicker,
#arcane-root[class*="neon-"] .arcane-demo-code-label {
  color: var(--neon-accent-cool) !important;
  text-shadow: 0 0 14px color-mix(in srgb, var(--neon-accent-cool) 24%, transparent);
}

#arcane-root[class*="neon-"] .arcane-demo-component-chip {
  border: 1px solid color-mix(in srgb, var(--neon-accent) 32%, transparent) !important;
  border-radius: 0.375rem !important;
  background: color-mix(in srgb, var(--neon-accent) 9%, transparent) !important;
  color: var(--foreground) !important;
  box-shadow: var(--neon-inset) !important;
}

#arcane-root[class*="neon-"] .arcane-demo-section-title {
  color: var(--foreground) !important;
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope {
  border-radius: var(--neon-radius-panel);
  clip-path: var(--neon-panel-clip);
  border-color: var(--neon-panel-border);
  background:
    radial-gradient(circle at 12% 0%, color-mix(in srgb, var(--neon-cyan) 12%, transparent), transparent 16rem),
    radial-gradient(circle at 88% 100%, color-mix(in srgb, var(--neon-magenta) 9%, transparent), transparent 14rem),
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 6%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--neon-cyan) 5%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 70%, transparent);
  background-size: auto, auto, 28px 28px, 28px 28px, auto;
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.12),
    0 18px 42px rgba(0,0,0,0.28),
    0 0 30px color-mix(in srgb, var(--primary) 10%, transparent);
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope::before {
  content: '';
  display: block;
  position: absolute;
  inset: 0;
  pointer-events: none;
  background:
    linear-gradient(90deg, var(--neon-accent), transparent 26%) top left / 42% 1px no-repeat,
    linear-gradient(180deg, var(--neon-accent), transparent 42%) top left / 1px 46% no-repeat,
    linear-gradient(270deg, var(--neon-cyan), transparent 28%) bottom right / 46% 1px no-repeat,
    linear-gradient(0deg, var(--neon-cyan), transparent 42%) bottom right / 1px 46% no-repeat;
  opacity: 0.72;
  z-index: 1;
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope::after {
  content: '';
  display: block;
  position: absolute;
  inset: 0;
  pointer-events: none;
  background: repeating-linear-gradient(0deg, transparent 0 6px, color-mix(in srgb, var(--neon-cyan) 8%, transparent) 6px 7px);
  opacity: 0.2;
  z-index: 1;
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-dialog-overlay,
#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-command-overlay,
#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-sheet-overlay,
#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-drawer-overlay,
#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-dropdown-backdrop {
  position: absolute !important;
  inset: 0 !important;
  z-index: 25 !important;
  border-radius: inherit;
  overflow: hidden;
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-dialog-overlay {
  padding: 1rem !important;
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-command-overlay {
  padding: 1rem !important;
  padding-top: 1rem !important;
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-sheet,
#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-drawer {
  position: absolute !important;
  max-width: 100% !important;
  max-height: 100% !important;
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-command-dialog {
  max-width: min(640px, calc(100% - 2rem)) !important;
  max-height: calc(100% - 2rem) !important;
}

#arcane-root[class*="neon-"] .arcane-demo-preview-scope .neon-context-menu {
  position: absolute !important;
}

#arcane-root[class*="neon-"] .arcane-demo-code {
  clip-path: var(--neon-panel-clip);
  border-color: var(--neon-panel-border) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 7%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 78%, transparent) !important;
  background-size: 24px 24px, auto !important;
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.1),
    0 14px 34px color-mix(in srgb, var(--primary) 10%, transparent);
}

#arcane-root[class*="neon-"] .arcane-demo-missing {
  clip-path: var(--neon-panel-clip);
  border: 1px solid color-mix(in srgb, var(--neon-orange) 46%, var(--neon-panel-border)) !important;
  border-radius: var(--neon-radius-panel) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-orange) 12%, transparent), transparent 58%),
    color-mix(in srgb, var(--card) 84%, transparent) !important;
  color: var(--foreground) !important;
  box-shadow:
    var(--neon-inset),
    0 0 24px color-mix(in srgb, var(--neon-orange) 12%, transparent) !important;
}

#arcane-root[class*="neon-"] .arcane-demo-missing-icon {
  border: 1px solid color-mix(in srgb, var(--neon-orange) 72%, transparent) !important;
  border-radius: 0.25rem !important;
  background: color-mix(in srgb, var(--neon-orange) 18%, transparent) !important;
  color: var(--neon-orange) !important;
  box-shadow: 0 0 16px color-mix(in srgb, var(--neon-orange) 18%, transparent) !important;
}

#arcane-root[class*="neon-"] .arcane-demo-missing-body {
  color: var(--muted-foreground) !important;
}
#arcane-root[class*="neon-"] {
  --kb-neon-shell-gap: 0.85rem;
  --kb-neon-sidebar-width: 17.6rem;
  --kb-neon-dock-top: 0.7rem;
  --kb-neon-dock-height: 2.75rem;
  --kb-neon-dock-clearance: 4.85rem;
  --kb-neon-ink: var(--foreground);
  --kb-neon-muted: var(--muted-foreground);
  --kb-neon-panel: color-mix(in srgb, var(--background) 78%, transparent);
  --kb-neon-panel-strong: color-mix(in srgb, var(--card) 86%, transparent);
  --kb-neon-panel-faint: color-mix(in srgb, var(--card) 48%, transparent);
  --kb-neon-line: color-mix(in srgb, var(--neon-accent) 24%, var(--border));
  --kb-neon-line-soft: color-mix(in srgb, var(--neon-accent) 14%, var(--border));
  --kb-neon-node: var(--neon-accent);
  --kb-neon-node-soft: color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --kb-neon-node-alt: color-mix(in srgb, var(--primary) 72%, var(--foreground));
  --kb-neon-hazard: color-mix(in srgb, var(--neon-magenta) 70%, var(--primary));
  --kb-neon-clip-lg: polygon(0 1rem, 1rem 0, 100% 0, 100% calc(100% - 1rem), calc(100% - 1rem) 100%, 0 100%);
  --kb-neon-clip-md: polygon(0 0.7rem, 0.7rem 0, 100% 0, 100% calc(100% - 0.7rem), calc(100% - 0.7rem) 100%, 0 100%);
  --kb-neon-clip-sm: polygon(0 0.45rem, 0.45rem 0, 100% 0, 100% calc(100% - 0.45rem), calc(100% - 0.45rem) 100%, 0 100%);
  --kb-neon-shadow-panel: 0 22px 70px rgba(0, 0, 0, 0.34), 0 0 32px color-mix(in srgb, var(--primary) 10%, transparent);
  --kb-neon-shadow-soft: 0 0 22px color-mix(in srgb, var(--neon-accent) 10%, transparent);
}

html.dark #arcane-root[class*="neon-"],
#arcane-root.dark[class*="neon-"] {
  --background: #12151C;
  --foreground: #F2F0EA;
  --card: #191D26;
  --card-foreground: #F2F0EA;
  --card-hover: #1B222C;
  --popover: #1B222C;
  --popover-foreground: #F2F0EA;
  --muted: #191D26;
  --muted-foreground: #A8ADB6;
  --border: #3E3E42;
  --input: #2D2D30;
  --accent: #1B222C;
  --accent-foreground: #F2F0EA;
  --ring: #007ACC;
  --info: #007ACC;
  --destructive: #661B1C;
  --neon-cyan: #007ACC;
  --neon-green: #00B884;
  --neon-magenta: #661B1C;
  --neon-purple: #3E3E42;
  --neon-orange: #B86B16;
  --neon-red: #661B1C;
  --kb-neon-ink: #F2F0EA;
  --kb-neon-muted: #A8ADB6;
  --kb-neon-panel: rgba(25, 29, 38, 0.9);
  --kb-neon-panel-strong: rgba(27, 34, 44, 0.94);
  --kb-neon-panel-faint: rgba(45, 45, 48, 0.64);
  --kb-neon-line: color-mix(in srgb, var(--neon-accent) 28%, #3E3E42);
  --kb-neon-line-soft: color-mix(in srgb, var(--neon-accent) 16%, #3E3E42);
  --kb-neon-node: var(--neon-accent);
  --kb-neon-node-soft: color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --kb-neon-node-alt: color-mix(in srgb, var(--neon-accent) 74%, #F2F0EA);
  --kb-neon-hazard: #9E2B2D;
  --kb-neon-shadow-panel: 0 22px 70px rgba(0, 0, 0, 0.5), 0 0 24px color-mix(in srgb, var(--neon-accent) 8%, transparent);
  --kb-neon-shadow-soft: 0 0 18px color-mix(in srgb, var(--neon-accent) 10%, transparent);
}

html.light #arcane-root[class*="neon-"],
#arcane-root.light[class*="neon-"] {
  --background: #f3f6fb;
  --foreground: #101a3a;
  --card: #fbfdff;
  --card-foreground: #101a3a;
  --popover: #ffffff;
  --popover-foreground: #101a3a;
  --muted: #e8eefb;
  --muted-foreground: #52638d;
  --border: #c6d4f6;
  --input: #b7c8f2;
  --primary: #244ed1;
  --primary-rgb: 36, 78, 209;
  --primary-foreground: #ffffff;
  --accent: #e7eefc;
  --accent-foreground: #173a9f;
  --ring: #244ed1;
  --neon-cyan: #84a5f2;
  --neon-green: #1d8f73;
  --neon-magenta: #7a4ce0;
  --neon-purple: #4d42c9;
  --neon-orange: #ff6600;
  --neon-red: #c83136;
  --kb-neon-ink: #101a3a;
  --kb-neon-muted: #52638d;
  --kb-neon-panel: rgba(243, 246, 251, 0.82);
  --kb-neon-panel-strong: rgba(255, 255, 255, 0.94);
  --kb-neon-panel-faint: rgba(226, 235, 254, 0.74);
  --kb-neon-line: color-mix(in srgb, var(--neon-accent) 24%, var(--border));
  --kb-neon-line-soft: color-mix(in srgb, var(--neon-accent) 14%, var(--border));
  --kb-neon-node: var(--neon-accent);
  --kb-neon-node-soft: color-mix(in srgb, var(--neon-accent) 18%, transparent);
  --kb-neon-node-alt: color-mix(in srgb, var(--neon-accent) 74%, var(--foreground));
  --kb-neon-hazard: #ff6600;
  --kb-neon-shadow-panel: 0 18px 42px color-mix(in srgb, var(--neon-accent) 12%, transparent), 0 1px 0 rgba(255, 255, 255, 0.95);
  --kb-neon-shadow-soft: 0 10px 24px color-mix(in srgb, var(--neon-accent) 10%, transparent);
}

#arcane-root[class*="neon-"] .kb-page-shell {
  background:
    radial-gradient(circle at 8% 8%, color-mix(in srgb, var(--primary) 8%, transparent), transparent 30rem),
    radial-gradient(circle at 88% 12%, color-mix(in srgb, var(--neon-cyan) 7%, transparent), transparent 32rem),
    transparent;
}

html.dark #arcane-root[class*="neon-"]::before {
  background-image:
    radial-gradient(circle at 18% 8%, rgba(0, 122, 204, 0.08), transparent 30rem),
    radial-gradient(circle at 82% 2%, rgba(27, 34, 44, 0.72), transparent 32rem),
    radial-gradient(circle at 70% 78%, rgba(102, 27, 28, 0.08), transparent 36rem),
    linear-gradient(rgba(0, 122, 204, 0.035) 1px, transparent 1px),
    linear-gradient(90deg, rgba(0, 122, 204, 0.035) 1px, transparent 1px) !important;
  background-size: auto, auto, auto, 96px 96px, 96px 96px !important;
}

html.dark #arcane-root[class*="neon-"]::after {
  opacity: 0.045 !important;
  background:
    linear-gradient(rgba(255,255,255,0.018) 1px, transparent 1px) !important;
  background-size: 100% 6px !important;
}

html.light #arcane-root[class*="neon-"] .kb-page-shell,
#arcane-root.light[class*="neon-"] .kb-page-shell {
  background:
    radial-gradient(circle at 10% 8%, rgba(132, 165, 242, 0.2), transparent 25rem),
    radial-gradient(circle at 92% 12%, rgba(36, 78, 209, 0.12), transparent 26rem),
    radial-gradient(circle at 78% 86%, rgba(255, 102, 0, 0.07), transparent 25rem),
    linear-gradient(135deg, #f3f6fb 0%, #eef3fd 46%, #fbfdff 100%);
}

#arcane-root[class*="neon-"] .arcane-scaffold {
  display: grid !important;
  grid-template-rows: auto minmax(0, 1fr) auto !important;
  padding-top: 0 !important;
}

#arcane-root[class*="neon-"] .arcane-scaffold-header {
  position: sticky !important;
  top: 0 !important;
  left: auto !important;
  right: auto !important;
  z-index: 20 !important;
  height: auto !important;
  min-height: 0 !important;
  margin: 0 !important;
  padding: 0.75rem var(--kb-neon-shell-gap) 0 !important;
  border: 0 !important;
  background: transparent !important;
  box-shadow: none !important;
  backdrop-filter: none !important;
  -webkit-backdrop-filter: none !important;
  pointer-events: none;
}

#arcane-root[class*="neon-"] .arcane-scaffold-navigation {
  width: 100%;
  pointer-events: none;
}

#arcane-root[class*="neon-"] .arcane-scaffold-body {
  grid-template-columns: var(--kb-neon-sidebar-width) minmax(0, 1fr) !important;
  align-items: start !important;
  min-height: 0 !important;
  padding: var(--kb-neon-shell-gap) !important;
  gap: var(--kb-neon-shell-gap) !important;
}

#arcane-root[class*="neon-"] .arcane-scaffold-sidebar.arcane-scaffold-sidebar {
  position: sticky !important;
  left: auto !important;
  right: auto !important;
  bottom: auto !important;
  top: calc(var(--kb-neon-dock-height) + (var(--kb-neon-shell-gap) * 1.5)) !important;
  z-index: 6 !important;
  align-self: start !important;
  width: var(--kb-neon-sidebar-width) !important;
  height: max-content !important;
  max-height: none !important;
  min-height: 0 !important;
  padding: 0 !important;
  border: 1px solid var(--kb-neon-line-soft) !important;
  border-radius: 0.55rem !important;
  clip-path: var(--kb-neon-clip-lg) !important;
  background:
    linear-gradient(180deg, color-mix(in srgb, var(--kb-neon-panel-strong) 80%, transparent), var(--kb-neon-panel) 44%, color-mix(in srgb, var(--background) 70%, transparent)),
    radial-gradient(circle at 10% 0%, color-mix(in srgb, var(--primary) 8%, transparent), transparent 16rem) !important;
  box-shadow: var(--kb-neon-shadow-panel) !important;
  backdrop-filter: blur(12px) !important;
  -webkit-backdrop-filter: blur(12px) !important;
  overflow: visible !important;
}

#arcane-root[class*="neon-"] .arcane-scaffold-sidebar .kb-sidebar {
  position: relative !important;
  top: auto !important;
  width: 100% !important;
  height: max-content !important;
  min-height: 0;
  max-height: none !important;
  overflow: visible !important;
}

#arcane-root[class*="neon-"] .arcane-scaffold-sidebar .kb-sidebar-panel {
  min-height: 0 !important;
}

#arcane-root[class*="neon-"] .arcane-scaffold-main.arcane-scaffold-main {
  grid-column: 2 !important;
  display: block !important;
  padding: 0 !important;
  min-width: 0 !important;
  width: 100% !important;
  max-width: none !important;
  min-height: 0 !important;
  margin-left: 0 !important;
  border: 1px solid var(--kb-neon-line-soft) !important;
  border-left-color: transparent !important;
  border-radius: 0.55rem !important;
  clip-path: var(--kb-neon-clip-lg) !important;
  background:
    linear-gradient(180deg, color-mix(in srgb, var(--kb-neon-panel-strong) 80%, transparent), var(--kb-neon-panel) 54%, color-mix(in srgb, var(--background) 70%, transparent)),
    radial-gradient(circle at 96% 0%, color-mix(in srgb, var(--neon-magenta) 5%, transparent), transparent 18rem),
    radial-gradient(circle at 0% 0%, color-mix(in srgb, var(--primary) 5%, transparent), transparent 16rem) !important;
  box-shadow: var(--kb-neon-shadow-panel) !important;
  backdrop-filter: none !important;
  -webkit-backdrop-filter: none !important;
  overflow: visible !important;
}

#arcane-root[class*="neon-"] .arcane-scaffold-main.arcane-scaffold-main::before {
  content: none !important;
  display: none !important;
}

#arcane-root[class*="neon-"] .kb-topbar {
  position: static;
  width: 100%;
  max-width: none;
  margin-left: 0;
  border: 0;
  background: transparent;
  box-shadow: none;
  backdrop-filter: none;
  -webkit-backdrop-filter: none;
  pointer-events: auto;
}

#arcane-root[class*="neon-"] .kb-topbar-inner {
  height: var(--kb-neon-dock-height);
  min-height: var(--kb-neon-dock-height);
  padding: 0.4rem 0.55rem;
  gap: 0.55rem;
  justify-content: space-between;
  clip-path: var(--kb-neon-clip-md);
  border: 1px solid var(--kb-neon-line);
  border-radius: 0.42rem;
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 90%, transparent), color-mix(in srgb, var(--kb-neon-panel) 82%, transparent)),
    linear-gradient(90deg, color-mix(in srgb, var(--primary) 10%, transparent), transparent 38%, color-mix(in srgb, var(--neon-magenta) 5%, transparent));
  box-shadow: var(--kb-neon-shadow-panel);
  backdrop-filter: blur(16px) saturate(1.04);
  -webkit-backdrop-filter: blur(16px) saturate(1.04);
}

#arcane-root[class*="neon-"] .kb-topbar-left,
#arcane-root[class*="neon-"] .kb-topbar-right {
  flex: 0 1 auto;
  gap: 0.45rem;
  height: 100%;
  padding: 0.22rem;
  clip-path: var(--kb-neon-clip-sm);
  border: 1px solid var(--kb-neon-line-soft);
  border-radius: 0.32rem;
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 78%, transparent), color-mix(in srgb, var(--kb-neon-panel) 72%, transparent));
  box-shadow: inset 0 -1px 0 color-mix(in srgb, var(--kb-neon-node) 18%, transparent);
  backdrop-filter: none;
  -webkit-backdrop-filter: none;
}

#arcane-root[class*="neon-"] .kb-topbar-left {
  flex: 0 0 auto;
  min-width: 0;
  overflow: visible;
}

#arcane-root[class*="neon-"] .kb-topbar-right {
  flex: 0 1 auto;
  margin-left: auto;
  justify-content: flex-end;
}

#arcane-root[class*="neon-"] .kb-style-switcher {
  flex: 0 0 auto;
  flex-wrap: nowrap;
  padding-left: 0.45rem;
  border-left: 1px solid var(--kb-neon-line-soft);
}

#arcane-root[class*="neon-"] .kb-topbar-nav {
  margin-left: 0;
  gap: 0.75rem;
  padding-left: 0.5rem;
  border-left: 1px solid var(--kb-neon-line-soft);
}

#arcane-root[class*="neon-"] .kb-topbar-brand {
  flex: 0 0 auto;
  width: auto;
  min-width: 0;
  height: 2.05rem;
  padding: 0 0.7rem 0 0.42rem;
  justify-content: flex-start;
  gap: 0.52rem;
  clip-path: var(--kb-neon-clip-sm);
  border: 1px solid var(--kb-neon-line);
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--primary) 10%, transparent), var(--kb-neon-panel-strong) 68%, color-mix(in srgb, var(--neon-cyan) 5%, transparent));
  color: var(--kb-neon-node-alt);
  text-transform: uppercase;
  letter-spacing: 0;
  box-shadow: var(--kb-neon-shadow-soft);
}

#arcane-root[class*="neon-"] .kb-topbar-brand-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  flex: 0 0 auto;
  width: 1.35rem;
  height: 1.35rem;
  clip-path: var(--kb-neon-clip-sm);
  border: 1px solid var(--kb-neon-line);
  background:
    linear-gradient(135deg, var(--kb-neon-node-soft), color-mix(in srgb, var(--kb-neon-panel-strong) 80%, transparent));
  box-shadow:
    inset 0 -1px 0 var(--kb-neon-node),
    0 0 14px color-mix(in srgb, var(--kb-neon-node) 12%, transparent);
}

#arcane-root[class*="neon-"] .kb-topbar-brand-label {
  display: inline;
  min-width: 0;
  overflow: visible;
  color: var(--kb-neon-node-alt);
  font-size: 0.76rem;
  font-weight: 760;
  line-height: 1;
  text-overflow: clip;
  text-shadow: 0 0 14px color-mix(in srgb, var(--primary) 18%, transparent);
  white-space: nowrap;
}

#arcane-root[class*="neon-"] .kb-topbar-github,
#arcane-root[class*="neon-"] .kb-theme-toggle,
#arcane-root[class*="neon-"] .kb-stylesheet-select,
#arcane-root[class*="neon-"] .kb-palette-select,
#arcane-root[class*="neon-"] .kb-hamburger {
  clip-path: var(--kb-neon-clip-sm);
  border-radius: 0.25rem;
  border: 1px solid var(--kb-neon-line-soft);
  background:
    linear-gradient(135deg, var(--kb-neon-node-soft), var(--kb-neon-panel));
  color: var(--kb-neon-ink);
  letter-spacing: 0;
}

#arcane-root[class*="neon-"] .kb-topbar-link {
  position: relative;
  height: auto;
  padding: 0.2rem 0;
  clip-path: none;
  border: 0;
  border-radius: 0;
  background: transparent;
  color: color-mix(in srgb, var(--kb-neon-ink) 78%, var(--muted-foreground));
  box-shadow: none;
  font-size: 0.76rem;
  font-weight: 760;
  line-height: 1;
  letter-spacing: 0.02em;
  text-decoration: none;
  text-shadow: 0 0 12px color-mix(in srgb, var(--primary) 10%, transparent);
  text-transform: uppercase;
}

#arcane-root[class*="neon-"] .kb-topbar-link::after {
  content: '';
  position: absolute;
  left: 0;
  right: 0;
  bottom: -0.55rem;
  height: 1px;
  background: transparent;
  box-shadow: none;
}

#arcane-root[class*="neon-"] .kb-topbar-github,
#arcane-root[class*="neon-"] .kb-theme-toggle,
#arcane-root[class*="neon-"] .kb-hamburger {
  width: 2.05rem;
  height: 2.05rem;
}

#arcane-root[class*="neon-"] .kb-topbar .kb-hamburger {
  display: none !important;
}

@media (max-width: 900px) {
  #arcane-root[class*="neon-"] .kb-topbar .kb-hamburger {
    display: inline-flex !important;
  }
}

#arcane-root[class*="neon-"] .kb-stylesheet-select,
#arcane-root[class*="neon-"] .kb-palette-select {
  height: 2.05rem;
  min-width: 6.5rem;
}

#arcane-root[class*="neon-"] .kb-palette-select {
  min-width: 5.5rem;
}

#arcane-root[class*="neon-"] .kb-topbar-github:hover,
#arcane-root[class*="neon-"] .kb-theme-toggle:hover,
#arcane-root[class*="neon-"] .kb-stylesheet-select:hover,
#arcane-root[class*="neon-"] .kb-palette-select:hover,
#arcane-root[class*="neon-"] .kb-hamburger:hover {
  background:
    linear-gradient(90deg, var(--kb-neon-node-soft), color-mix(in srgb, var(--primary) 12%, transparent));
  border-color: var(--kb-neon-line);
  color: var(--kb-neon-node-alt);
  box-shadow:
    inset 0 -2px 0 var(--kb-neon-node),
    var(--kb-neon-shadow-soft);
}

#arcane-root[class*="neon-"] .kb-topbar-link:hover,
#arcane-root[class*="neon-"] .kb-topbar-link.active {
  background: transparent;
  border-color: transparent;
  color: var(--kb-neon-node-alt);
  box-shadow: none;
  text-shadow:
    0 0 12px color-mix(in srgb, var(--primary) 42%, transparent),
    0 0 26px color-mix(in srgb, var(--neon-accent-cool) 22%, transparent);
}

#arcane-root[class*="neon-"] .kb-topbar-link.active::after {
  background: linear-gradient(90deg, var(--primary), var(--neon-accent-cool));
  box-shadow: 0 0 12px color-mix(in srgb, var(--primary) 38%, transparent);
}

#arcane-root[class*="neon-"] .kb-search-input {
  width: 100%;
  height: 2.05rem;
  clip-path: var(--kb-neon-clip-sm);
  border-radius: 0.25rem;
  border: 1px solid var(--kb-neon-line);
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 88%, transparent), color-mix(in srgb, var(--kb-neon-panel) 86%, transparent));
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.08),
    0 0 0 1px color-mix(in srgb, var(--kb-neon-node) 4%, transparent);
}

#arcane-root[class*="neon-"] .kb-topbar-right .kb-search {
  flex: 0 0 auto;
  width: clamp(13rem, 22vw, 18rem);
}

#arcane-root[class*="neon-"] .search-results {
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
  border: 1px solid var(--kb-neon-line);
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 92%, transparent), color-mix(in srgb, var(--kb-neon-panel) 90%, transparent));
  box-shadow: var(--kb-neon-shadow-panel);
}

#arcane-root[class*="neon-"] .kb-content-area {
  display: grid !important;
  grid-template-columns: minmax(0, 1fr) minmax(12rem, 13.75rem) !important;
  align-items: flex-start !important;
  width: 100% !important;
  max-width: none !important;
  margin: 0 !important;
  gap: clamp(1rem, 1.8vw, 1.55rem) !important;
  padding: clamp(1rem, 1.8vw, 1.55rem) !important;
}

#arcane-root[class*="neon-"] .kb-article-panel {
  position: relative;
  min-width: 0 !important;
  width: 100% !important;
  max-width: min(100%, 64rem) !important;
  padding: clamp(0.25rem, 0.9vw, 0.75rem);
  clip-path: none;
  border-radius: 0;
  border: 0;
  background: transparent;
  box-shadow: none;
  backdrop-filter: none;
  -webkit-backdrop-filter: none;
}

#arcane-root[class*="neon-"] .kb-article-panel::before {
  content: none;
  display: none;
}

#arcane-root[class*="neon-"] .kb-page-metadata,
#arcane-root[class*="neon-"] .kb-tags-footer,
#arcane-root[class*="neon-"] .kb-page-nav {
  border-color: color-mix(in srgb, var(--neon-cyan) 18%, var(--border));
}

#arcane-root[class*="neon-"] .kb-page-nav-link {
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
  border-color: var(--kb-neon-line);
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--primary) 5%, transparent), var(--kb-neon-panel-strong)),
    linear-gradient(90deg, var(--kb-neon-line-soft) 1px, transparent 1px);
  background-size: auto, 18px 18px;
  box-shadow: var(--kb-neon-shadow-soft);
}

#arcane-root[class*="neon-"] .kb-page-nav-link:hover {
  border-color: var(--kb-neon-line);
  background:
    linear-gradient(135deg, var(--kb-neon-node-soft), color-mix(in srgb, var(--primary) 7%, transparent));
  box-shadow: var(--kb-neon-shadow-soft);
}

#arcane-root[class*="neon-"] .sidebar-header {
  position: sticky;
  top: 0;
  z-index: 4;
  border-bottom-color: var(--kb-neon-line);
  background:
    linear-gradient(135deg, var(--kb-neon-node-soft), transparent 64%),
    linear-gradient(180deg, color-mix(in srgb, var(--kb-neon-panel-strong) 76%, transparent), transparent);
  backdrop-filter: blur(12px) saturate(1.08);
  -webkit-backdrop-filter: blur(12px) saturate(1.08);
}

#arcane-root[class*="neon-"] .sidebar-brand-title {
  color: var(--kb-neon-node-alt);
  text-transform: uppercase;
  letter-spacing: 0;
  text-shadow: 0 0 18px color-mix(in srgb, var(--primary) 16%, transparent);
}

#arcane-root[class*="neon-"] .sidebar-section-header,
#arcane-root[class*="neon-"] .sidebar-summary {
  color: var(--kb-neon-ink);
  text-transform: uppercase;
  letter-spacing: 0;
}

#arcane-root[class*="neon-"] .sidebar-nav {
  padding: 0.7rem !important;
  gap: 0.35rem !important;
}

#arcane-root[class*="neon-"] .sidebar-tree {
  margin-left: 0;
  padding-left: 0.9rem;
  gap: 0.15rem;
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-tree {
  position: relative;
  padding-left: 1.12rem;
}

#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-tree-item,
#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-section {
  position: relative;
}

#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-tree-item::before,
#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-section::before {
  content: '';
  position: absolute;
  left: -0.72rem;
  top: 1.05rem;
  width: 0.42rem !important;
  height: 0.42rem !important;
  background: var(--kb-neon-panel-strong) !important;
  border: 1px solid var(--kb-neon-line) !important;
  transform: rotate(45deg);
  box-shadow: 0 0 0 3px var(--kb-neon-node-soft);
  z-index: 2;
}

#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-tree-item::after,
#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-section::after {
  content: '';
  position: absolute;
  left: -0.52rem !important;
  top: 1.55rem !important;
  bottom: -0.55rem !important;
  width: 1px !important;
  height: auto !important;
  background: linear-gradient(180deg, var(--kb-neon-line), transparent) !important;
  opacity: 0.76;
  z-index: 1;
}

#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-tree-item:last-child::after,
#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-section:last-child::after {
  display: none !important;
}

#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-section::before {
  border-color: color-mix(in srgb, var(--kb-neon-hazard) 42%, var(--kb-neon-line)) !important;
  box-shadow: 0 0 0 3px color-mix(in srgb, var(--kb-neon-hazard) 10%, transparent);
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-section {
  border: 0 !important;
  background: transparent !important;
  margin: 0.1rem 0 0.1rem 0;
  padding: 0;
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-details[open] > .sidebar-tree {
  margin-top: 0.16rem;
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-details[open] > .sidebar-tree::before {
  content: '' !important;
  display: block !important;
  position: absolute;
  left: 0.42rem;
  top: 0.1rem;
  bottom: 0.5rem;
  width: 1px;
  background:
    linear-gradient(180deg, transparent, var(--kb-neon-line) 18%, var(--kb-neon-line) 74%, transparent);
  opacity: 0.72;
}

#arcane-root[class*="neon-"] .sidebar-link,
#arcane-root[class*="neon-"] .sidebar-summary {
  position: relative;
  clip-path: var(--kb-neon-clip-sm);
  border-radius: 0.25rem;
  border: 1px solid transparent;
  transition: background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease, color 0.15s ease;
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-link,
#arcane-root[class*="neon-"] .sidebar-tree .sidebar-summary {
  min-height: 2rem;
  margin: 0;
  padding: 0.45rem 0.65rem 0.45rem 1.25rem !important;
  color: var(--kb-neon-muted);
  background:
    linear-gradient(90deg, transparent, color-mix(in srgb, var(--kb-neon-panel-faint) 76%, transparent));
  border-color: transparent;
  border-left: 0 !important;
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-summary {
  font-size: 0.72rem;
  font-weight: 650;
  color: color-mix(in srgb, var(--kb-neon-ink) 74%, var(--kb-neon-node-alt));
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-hazard) 8%, transparent), var(--kb-neon-panel-faint));
  border-color: color-mix(in srgb, var(--kb-neon-hazard) 18%, transparent);
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-link::before,
#arcane-root[class*="neon-"] .sidebar-tree .sidebar-summary::before {
  content: '';
  position: absolute;
  left: 0.42rem;
  top: 50%;
  width: 0.36rem;
  height: 0.36rem;
  border: 1px solid var(--kb-neon-line);
  background: color-mix(in srgb, var(--kb-neon-panel-strong) 82%, transparent);
  transform: translateY(-50%) rotate(45deg);
  box-shadow: 0 0 8px color-mix(in srgb, var(--kb-neon-node) 12%, transparent);
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-link::after,
#arcane-root[class*="neon-"] .sidebar-tree .sidebar-summary::after {
  content: '';
  position: absolute;
  left: 0.77rem;
  top: 50%;
  width: 0.26rem;
  height: 1px;
  background: var(--kb-neon-line);
  transform: translateY(-50%);
  opacity: 0.78;
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-tree .sidebar-link::before {
  width: 0.3rem;
  height: 0.3rem;
  border-radius: 999px;
  transform: translateY(-50%);
}

#arcane-root[class*="neon-"] .sidebar-tree .sidebar-tree .sidebar-summary::before {
  width: 0.34rem;
  height: 0.34rem;
  border-color: color-mix(in srgb, var(--kb-neon-hazard) 36%, var(--kb-neon-line));
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-hazard) 18%, transparent), color-mix(in srgb, var(--kb-neon-panel-strong) 78%, transparent));
}

#arcane-root[class*="neon-"] .sidebar-link:hover,
#arcane-root[class*="neon-"] .sidebar-summary:hover,
#arcane-root[class*="neon-"] .sidebar-link.active {
  background:
    linear-gradient(90deg, var(--kb-neon-node-soft), color-mix(in srgb, var(--primary) 7%, transparent));
  border-color: color-mix(in srgb, var(--kb-neon-node) 56%, var(--kb-neon-line));
  color: var(--kb-neon-node-alt);
  box-shadow:
    inset 0 -1px 0 var(--kb-neon-node),
    0 0 0 1px color-mix(in srgb, var(--kb-neon-node) 18%, transparent),
    0 0 18px color-mix(in srgb, var(--kb-neon-node) 14%, transparent),
    var(--kb-neon-shadow-soft);
}

#arcane-root[class*="neon-"] .sidebar-link:hover::before,
#arcane-root[class*="neon-"] .sidebar-summary:hover::before,
#arcane-root[class*="neon-"] .sidebar-link.active::before {
  border-color: var(--kb-neon-node);
  background: var(--kb-neon-node);
  box-shadow:
    0 0 0 3px var(--kb-neon-node-soft),
    0 0 14px color-mix(in srgb, var(--kb-neon-node) 34%, transparent);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-main.arcane-scaffold-main,
#arcane-root.light[class*="neon-"] .arcane-scaffold-main.arcane-scaffold-main {
  background:
    linear-gradient(180deg, rgba(255, 255, 255, 0.9), rgba(243, 246, 251, 0.78) 58%, rgba(255, 255, 255, 0.88)),
    radial-gradient(circle at 96% 0%, rgba(255, 102, 0, 0.055), transparent 17rem),
    radial-gradient(circle at 0% 0%, rgba(132, 165, 242, 0.16), transparent 18rem) !important;
  border-color: rgba(36, 78, 209, 0.13) !important;
  box-shadow:
    0 18px 42px rgba(36, 78, 209, 0.1),
    0 1px 0 rgba(255, 255, 255, 0.95) !important;
}

html.light #arcane-root[class*="neon-"] .kb-topbar-inner,
#arcane-root.light[class*="neon-"] .kb-topbar-inner {
  background:
    linear-gradient(135deg, rgba(255, 255, 255, 0.88), rgba(243, 246, 251, 0.78)),
    linear-gradient(90deg, rgba(132, 165, 242, 0.12), transparent 42%, rgba(255, 102, 0, 0.045));
  border-color: rgba(36, 78, 209, 0.18);
  box-shadow:
    0 14px 34px rgba(36, 78, 209, 0.11),
    0 1px 0 rgba(255, 255, 255, 0.95);
}

html.light #arcane-root[class*="neon-"] .kb-topbar-brand,
#arcane-root.light[class*="neon-"] .kb-topbar-brand {
  background:
    linear-gradient(90deg, rgba(132, 165, 242, 0.22), rgba(255, 255, 255, 0.88) 58%, rgba(255, 102, 0, 0.055));
  border-color: rgba(36, 78, 209, 0.24);
  color: #173a9f;
}

html.light #arcane-root[class*="neon-"] .kb-topbar-github,
html.light #arcane-root[class*="neon-"] .kb-theme-toggle,
html.light #arcane-root[class*="neon-"] .kb-stylesheet-select,
html.light #arcane-root[class*="neon-"] .kb-palette-select,
html.light #arcane-root[class*="neon-"] .kb-hamburger,
#arcane-root.light[class*="neon-"] .kb-topbar-github,
#arcane-root.light[class*="neon-"] .kb-theme-toggle,
#arcane-root.light[class*="neon-"] .kb-stylesheet-select,
#arcane-root.light[class*="neon-"] .kb-palette-select,
#arcane-root.light[class*="neon-"] .kb-hamburger {
  background:
    linear-gradient(135deg, rgba(132, 165, 242, 0.12), rgba(255, 255, 255, 0.82));
  border-color: rgba(36, 78, 209, 0.14);
  color: #101a3a;
}

html.light #arcane-root[class*="neon-"] .kb-topbar-link,
#arcane-root.light[class*="neon-"] .kb-topbar-link {
  background: transparent;
  color: #314069;
  text-shadow: none;
}

html.light #arcane-root[class*="neon-"] .kb-topbar-link:hover,
html.light #arcane-root[class*="neon-"] .kb-topbar-link.active,
#arcane-root.light[class*="neon-"] .kb-topbar-link:hover,
#arcane-root.light[class*="neon-"] .kb-topbar-link.active {
  color: #173a9f;
  text-shadow: 0 0 18px rgba(36, 78, 209, 0.16);
}

html.light #arcane-root[class*="neon-"] .kb-search-input,
#arcane-root.light[class*="neon-"] .kb-search-input {
  background:
    linear-gradient(135deg, rgba(255, 255, 255, 0.9), rgba(243, 246, 251, 0.86));
  border-color: rgba(36, 78, 209, 0.24);
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.88),
    0 0 0 1px rgba(132, 165, 242, 0.1);
}

html.light #arcane-root[class*="neon-"] .search-results,
#arcane-root.light[class*="neon-"] .search-results {
  background:
    linear-gradient(135deg, rgba(255, 255, 255, 0.96), rgba(243, 246, 251, 0.92));
  border-color: rgba(36, 78, 209, 0.2);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar.arcane-scaffold-sidebar,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar.arcane-scaffold-sidebar {
  background:
    radial-gradient(circle at 14% 0%, rgba(132, 165, 242, 0.22), transparent 15rem),
    radial-gradient(circle at 92% 100%, rgba(255, 102, 0, 0.055), transparent 16rem),
    linear-gradient(180deg, rgba(255, 255, 255, 0.94), rgba(243, 246, 251, 0.86) 54%, rgba(255, 255, 255, 0.9)) !important;
  border-color: rgba(36, 78, 209, 0.16) !important;
  box-shadow:
    0 18px 42px rgba(36, 78, 209, 0.11),
    0 0 18px rgba(132, 165, 242, 0.08) !important;
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-header,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-header {
  border-bottom-color: rgba(36, 78, 209, 0.15);
  background:
    linear-gradient(135deg, rgba(132, 165, 242, 0.18), transparent 62%),
    linear-gradient(180deg, rgba(255, 255, 255, 0.82), transparent);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-brand-title,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-brand-title {
  color: #173a9f;
  text-shadow: 0 0 12px rgba(36, 78, 209, 0.1);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-brand-subtitle,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-section-header,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-brand-subtitle,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-section-header {
  color: rgba(25, 42, 89, 0.7);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-summary,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-summary {
  color: rgba(16, 26, 58, 0.88);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-link,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-link {
  color: rgba(25, 42, 89, 0.72);
  background:
    linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.68));
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-summary,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-summary {
  color: rgba(23, 58, 159, 0.92);
  background:
    linear-gradient(90deg, rgba(255, 102, 0, 0.065), rgba(255, 255, 255, 0.72));
  border-color: rgba(255, 102, 0, 0.14);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-link:hover,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-summary:hover,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-link.active,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-link:hover,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-summary:hover,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-link.active {
  color: #173a9f;
  background:
    linear-gradient(90deg, rgba(132, 165, 242, 0.26), rgba(255, 255, 255, 0.8));
  border-color: rgba(36, 78, 209, 0.36);
  box-shadow:
    inset 0 -1px 0 rgba(36, 78, 209, 0.34),
    0 0 0 1px rgba(132, 165, 242, 0.14),
    0 0 14px rgba(36, 78, 209, 0.09);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree > .sidebar-tree-item::before,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree > .sidebar-section::before,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree > .sidebar-tree-item::before,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree > .sidebar-section::before {
  background: rgba(255, 255, 255, 0.9) !important;
  border-color: rgba(36, 78, 209, 0.34) !important;
  box-shadow: 0 0 0 3px rgba(132, 165, 242, 0.1);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree > .sidebar-tree-item::after,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree > .sidebar-section::after,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree > .sidebar-tree-item::after,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree > .sidebar-section::after {
  background: linear-gradient(180deg, rgba(36, 78, 209, 0.22), transparent) !important;
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-link::before,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-summary::before,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-link::before,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-summary::before {
  background: rgba(255, 255, 255, 0.92);
  border-color: rgba(36, 78, 209, 0.3);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-link::after,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-summary::after,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-link::after,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-tree .sidebar-summary::after {
  background: rgba(36, 78, 209, 0.24);
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-icon,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-chevron,
html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .sidebar-chevron-icon,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-icon,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-chevron,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .sidebar-chevron-icon {
  color: currentColor;
  opacity: 0.9;
}

html.light #arcane-root[class*="neon-"] .arcane-scaffold-sidebar .kb-stylesheet-select,
#arcane-root.light[class*="neon-"] .arcane-scaffold-sidebar .kb-stylesheet-select {
  color: #173a9f;
  background: rgba(255, 255, 255, 0.88);
  border-color: rgba(36, 78, 209, 0.2);
}

#arcane-root[class*="neon-"] .sidebar-tree > .sidebar-tree-item:has(.sidebar-link.active)::before {
  background: var(--kb-neon-node) !important;
  border-color: var(--kb-neon-node) !important;
  box-shadow:
    0 0 0 3px var(--kb-neon-node-soft),
    0 0 16px color-mix(in srgb, var(--kb-neon-node) 30%, transparent);
}

#arcane-root[class*="neon-"] .kb-toc-panel {
  width: 100% !important;
  top: calc(var(--kb-neon-dock-height) + 2rem) !important;
  max-height: none !important;
  overflow: visible !important;
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc {
  position: relative;
  padding: 0.7rem;
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
  border: 1px solid var(--kb-neon-line);
  background:
    linear-gradient(155deg, color-mix(in srgb, var(--neon-magenta) 3%, transparent), var(--kb-neon-panel-strong) 48%, var(--kb-neon-panel));
  box-shadow: var(--kb-neon-shadow-panel);
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc::before {
  content: '';
  position: absolute;
  top: 0.75rem;
  bottom: 0.75rem;
  left: 0.72rem;
  width: 1px;
  background: linear-gradient(180deg, transparent, var(--kb-neon-line), transparent);
  opacity: 0.9;
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc-title {
  position: relative;
  margin: 0 0 0.65rem 0.45rem;
  padding: 0 0 0.55rem 0.7rem;
  border-bottom: 1px solid var(--kb-neon-line-soft);
  color: var(--kb-neon-node-alt);
  font-family: var(--font-mono);
  font-size: 0.68rem;
  letter-spacing: 0;
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc-content > ul,
#arcane-root[class*="neon-"] .kb-toc-panel .toc-content ul ul {
  padding-left: 0;
  margin-left: 0;
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc-content li::before,
#arcane-root[class*="neon-"] .kb-toc-panel .toc-content li::after {
  display: none !important;
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc-content a {
  position: relative;
  margin: 0.12rem 0 0.12rem 0.5rem;
  padding: 0.42rem 0.55rem 0.42rem 1rem !important;
  clip-path: var(--kb-neon-clip-sm);
  border-radius: 0.25rem;
  border: 1px solid transparent;
  color: var(--kb-neon-muted);
  background: transparent;
  line-height: 1.25;
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc-content ul ul a {
  margin-left: 1rem;
  font-size: 0.75rem;
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc-content a::before {
  content: '';
  position: absolute;
  left: 0.34rem;
  top: 50%;
  width: 0.36rem;
  height: 0.36rem;
  background: var(--kb-neon-panel-strong);
  border: 1px solid var(--kb-neon-line);
  transform: translateY(-50%);
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc-content a:hover,
#arcane-root[class*="neon-"] .kb-toc-panel .toc-content a.toc-active {
  background:
    linear-gradient(90deg, var(--kb-neon-node-soft), color-mix(in srgb, var(--primary) 6%, transparent));
  border-color: var(--kb-neon-line-soft);
  color: var(--kb-neon-node-alt);
  box-shadow: inset 0 -1px 0 var(--kb-neon-node);
}

#arcane-root[class*="neon-"] .kb-toc-panel .toc-content a.toc-active::before {
  background: var(--kb-neon-node);
  border-color: var(--kb-neon-node);
  box-shadow: 0 0 12px color-mix(in srgb, var(--kb-neon-node) 30%, transparent);
}

html.light #arcane-root[class*="neon-"] .kb-toc-panel .toc,
#arcane-root.light[class*="neon-"] .kb-toc-panel .toc {
  background:
    linear-gradient(155deg, rgba(255, 102, 0, 0.035), rgba(255, 255, 255, 0.9) 45%, rgba(243, 246, 251, 0.84));
  border-color: rgba(36, 78, 209, 0.16);
  box-shadow:
    0 16px 34px rgba(36, 78, 209, 0.1),
    0 1px 0 rgba(255, 255, 255, 0.95);
}

html.light #arcane-root[class*="neon-"] .kb-toc-panel .toc::before,
#arcane-root.light[class*="neon-"] .kb-toc-panel .toc::before {
  background: linear-gradient(180deg, transparent, rgba(36, 78, 209, 0.22), transparent);
}

html.light #arcane-root[class*="neon-"] .kb-toc-panel .toc-content a:hover,
html.light #arcane-root[class*="neon-"] .kb-toc-panel .toc-content a.toc-active,
#arcane-root.light[class*="neon-"] .kb-toc-panel .toc-content a:hover,
#arcane-root.light[class*="neon-"] .kb-toc-panel .toc-content a.toc-active {
  background:
    linear-gradient(90deg, rgba(132, 165, 242, 0.24), rgba(255, 255, 255, 0.72));
  border-color: rgba(36, 78, 209, 0.18);
  color: #173a9f;
  box-shadow: inset 0 -1px 0 rgba(36, 78, 209, 0.28);
}

html.light #arcane-root[class*="neon-"] .prose a,
#arcane-root.light[class*="neon-"] .prose a {
  color: #244ed1;
}

html.light #arcane-root[class*="neon-"] .prose h1,
html.light #arcane-root[class*="neon-"] .prose h2,
html.light #arcane-root[class*="neon-"] .prose h3,
#arcane-root.light[class*="neon-"] .prose h1,
#arcane-root.light[class*="neon-"] .prose h2,
#arcane-root.light[class*="neon-"] .prose h3 {
  color: #101a3a;
  text-shadow: none;
}

html.light #arcane-root[class*="neon-"] .prose h2,
html.light #arcane-root[class*="neon-"] .prose h3,
#arcane-root.light[class*="neon-"] .prose h2,
#arcane-root.light[class*="neon-"] .prose h3 {
  border-bottom-color: rgba(36, 78, 209, 0.14);
}

html.light #arcane-root[class*="neon-"] .prose table,
#arcane-root.light[class*="neon-"] .prose table {
  border-color: rgba(36, 78, 209, 0.15);
  box-shadow: 0 8px 22px rgba(36, 78, 209, 0.055);
}

html.light #arcane-root[class*="neon-"] .prose th,
#arcane-root.light[class*="neon-"] .prose th {
  background: linear-gradient(180deg, rgba(231, 238, 252, 0.95), rgba(214, 225, 250, 0.88));
  border-color: rgba(36, 78, 209, 0.16);
  color: #173a9f;
}

html.light #arcane-root[class*="neon-"] .prose td,
#arcane-root.light[class*="neon-"] .prose td {
  background: rgba(255, 255, 255, 0.58);
  border-color: rgba(36, 78, 209, 0.11);
}

html.light #arcane-root[class*="neon-"] .prose code:not(pre code),
html.light #arcane-root[class*="neon-"] .kb-kbd,
html.light #arcane-root[class*="neon-"] .kb-tag,
#arcane-root.light[class*="neon-"] .prose code:not(pre code),
#arcane-root.light[class*="neon-"] .kb-kbd,
#arcane-root.light[class*="neon-"] .kb-tag {
  background: rgba(231, 238, 252, 0.86);
  border-color: rgba(36, 78, 209, 0.16);
  color: #173a9f;
}

html.light #arcane-root[class*="neon-"] .kb-page-metadata,
html.light #arcane-root[class*="neon-"] .kb-tags-footer,
html.light #arcane-root[class*="neon-"] .kb-page-nav,
#arcane-root.light[class*="neon-"] .kb-page-metadata,
#arcane-root.light[class*="neon-"] .kb-tags-footer,
#arcane-root.light[class*="neon-"] .kb-page-nav {
  border-color: rgba(36, 78, 209, 0.13);
}

#arcane-root[class*="neon-"] .prose {
  max-width: none;
}

#arcane-root[class*="neon-"] .prose h1,
#arcane-root[class*="neon-"] .prose h2,
#arcane-root[class*="neon-"] .prose h3 {
  text-transform: uppercase;
  letter-spacing: 0;
  scroll-margin-top: var(--kb-neon-dock-clearance);
}

#arcane-root[class*="neon-"] .prose pre,
#arcane-root[class*="neon-"] .kb-code-group,
#arcane-root[class*="neon-"] .kb-panel,
#arcane-root[class*="neon-"] .kb-frame,
#arcane-root[class*="neon-"] .kb-card,
#arcane-root[class*="neon-"] .kb-tile,
#arcane-root[class*="neon-"] .kb-step,
#arcane-root[class*="neon-"] .kb-banner {
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
  border-color: var(--kb-neon-line);
  box-shadow: var(--kb-neon-shadow-soft);
}

#arcane-root[class*="neon-"] .kb-callout {
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
}

#arcane-root[class*="neon-"] .markdown-alert {
  clip-path: polygon(0 0, 100% 0, 100% 100%, 0 100%);
  border-radius: 0.125rem;
}

@media (max-width: 1200px) {
  #arcane-root[class*="neon-"] .kb-content-area {
    grid-template-columns: minmax(0, 1fr) !important;
  }

  #arcane-root[class*="neon-"] .kb-toc-panel {
    display: none !important;
  }
}

@media (max-width: 1100px) {
  #arcane-root[class*="neon-"] .arcane-scaffold-header {
    margin: 0 !important;
    padding: 0.75rem !important;
    top: 0 !important;
  }

  #arcane-root[class*="neon-"] .kb-topbar {
    width: 100%;
    max-width: none;
  }

  #arcane-root[class*="neon-"] .kb-topbar-inner {
    justify-content: space-between;
  }

  #arcane-root[class*="neon-"] .kb-topbar-left {
    flex-basis: auto;
    min-width: 0;
  }

  #arcane-root[class*="neon-"] .arcane-scaffold-body {
    grid-template-columns: minmax(0, 1fr) !important;
  }

  #arcane-root[class*="neon-"] .arcane-scaffold-sidebar.arcane-scaffold-sidebar {
    position: relative !important;
    left: auto !important;
    top: auto !important;
    width: min(21rem, 92vw) !important;
    height: auto !important;
    max-height: none !important;
  }

  #arcane-root[class*="neon-"] .arcane-scaffold-main.arcane-scaffold-main {
    grid-column: 1 !important;
  }

  #arcane-root[class*="neon-"] .kb-content-area {
    padding-top: 0.55rem;
  }
}

@media (max-width: 900px) {
  #arcane-root[class*="neon-"] .arcane-scaffold-sidebar {
    width: min(21rem, 92vw) !important;
  }

  #arcane-root[class*="neon-"] .kb-topbar-brand {
    flex: 0 0 auto;
    width: 2.05rem;
    padding: 0;
    justify-content: center;
  }

  #arcane-root[class*="neon-"] .kb-topbar-brand-label {
    display: none;
  }

  #arcane-root[class*="neon-"] .kb-topbar-link {
    padding: 0.2rem 0;
  }
}

[class*="neon-"] .toc-content a,
.neon .toc-content a {
  margin: 0.125rem 0;
  padding: 0.5rem 0.75rem 0.5rem 0.625rem !important;
  font-size: 0.8125rem;
  line-height: 1.3;
}

#arcane-root[class*="neon-"] .kb-callout {
  border-color: color-mix(in srgb, var(--kb-callout-accent) 34%, var(--border));
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--kb-callout-accent) 6%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--kb-callout-accent) 5%, transparent) 1px, transparent 1px),
    radial-gradient(circle at 1.5rem 1.4rem, color-mix(in srgb, var(--kb-callout-accent) 26%, transparent), transparent 6rem),
    color-mix(in srgb, var(--card) 76%, transparent);
  background-size: 18px 18px, 18px 18px, auto, auto;
  border-radius: var(--arcane-radius-sm, var(--radius-md, 8px));
  box-shadow:
    0 18px 42px rgba(0, 0, 0, 0.24),
    0 0 28px color-mix(in srgb, var(--kb-callout-accent) 12%, transparent);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
}

#arcane-root[class*="neon-"] .kb-callout::before {
  box-shadow:
    0 0 16px color-mix(in srgb, var(--kb-callout-accent) 30%, transparent),
    inset 0 0 14px color-mix(in srgb, var(--kb-callout-accent) 14%, transparent);
}

#arcane-root[class*="neon-"] .markdown-alert {
  background: color-mix(in srgb, var(--kb-alert-accent) 6%, transparent);
  box-shadow: 0 0 18px color-mix(in srgb, var(--kb-alert-accent) 8%, transparent);
}

#arcane-root[class*="neon-"] .kb-landing-content-area {
  padding: clamp(1.5rem, 2.5vw, 2.75rem);
}

#arcane-root[class*="neon-"] .kb-landing-page {
  display: grid;
  gap: clamp(1.25rem, 2vw, 2rem);
  max-width: none !important;
}

#arcane-root[class*="neon-"] .kb-landing-prose {
  display: grid;
  gap: clamp(1.65rem, 2.8vw, 2.75rem);
}

#arcane-root[class*="neon-"] .kb-landing-prose > * + * {
  margin-top: 0;
}

#arcane-root[class*="neon-"] .kb-landing-grid {
  gap: clamp(1.45rem, 2.6vw, 2.2rem);
  margin-top: 1.35rem;
  margin-bottom: 1.65rem;
}

#arcane-root[class*="neon-"] .kb-landing-band {
  gap: clamp(1.6rem, 2.8vw, 2.35rem);
  margin-top: 1.35rem;
  padding: clamp(1.65rem, 2.4vw, 2.4rem);
}

#arcane-root[class*="neon-"] .kb-landing-hero,
#arcane-root[class*="neon-"] .kb-landing-card,
#arcane-root[class*="neon-"] .kb-landing-band,
#arcane-root[class*="neon-"] .kb-landing-terminal,
#arcane-root[class*="neon-"] .kb-landing-list-item {
  clip-path: var(--kb-neon-clip-md);
  border-radius: 0.375rem;
  border-color: var(--kb-neon-line);
  box-shadow: var(--kb-neon-shadow-panel);
}

#arcane-root[class*="neon-"] .kb-landing-hero {
  min-height: 30rem;
  padding: clamp(2.25rem, 4vw, 4rem);
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 88%, transparent), color-mix(in srgb, var(--background) 74%, transparent)),
    linear-gradient(90deg, color-mix(in srgb, var(--kb-neon-node) 16%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--kb-neon-hazard) 12%, transparent) 1px, transparent 1px);
  background-size: auto, 2.25rem 2.25rem, 2.25rem 2.25rem;
}

#arcane-root[class*="neon-"] .kb-landing-card {
  gap: 1rem;
  padding: clamp(1.35rem, 1.75vw, 1.85rem);
}

#arcane-root[class*="neon-"] .kb-landing-terminal-body {
  gap: 1rem;
}

#arcane-root[class*="neon-"] .kb-landing-list {
  gap: 1.1rem;
}

#arcane-root[class*="neon-"] .kb-landing-kicker,
#arcane-root[class*="neon-"] .kb-landing-actions a,
#arcane-root[class*="neon-"] .kb-landing-terminal-row,
#arcane-root[class*="neon-"] .kb-landing-list-index {
  clip-path: var(--kb-neon-clip-sm);
  border-radius: 0.25rem;
}

#arcane-root[class*="neon-"] .kb-landing-kicker {
  border-color: var(--kb-neon-line);
  background: var(--kb-neon-node-soft);
  color: var(--kb-neon-node-alt);
  font-family: var(--font-mono);
  text-shadow: 0 0 14px color-mix(in srgb, var(--kb-neon-node) 30%, transparent);
}

#arcane-root[class*="neon-"] .kb-landing-hero h1 {
  color: var(--kb-neon-ink);
  text-shadow: 0 0 22px color-mix(in srgb, var(--kb-neon-node) 18%, transparent);
}

#arcane-root[class*="neon-"] .kb-landing-primary {
  border-color: var(--kb-neon-line);
  background:
    linear-gradient(90deg, var(--kb-neon-node), color-mix(in srgb, var(--kb-neon-node-alt) 64%, var(--kb-neon-node)));
  color: #071015 !important;
  box-shadow: 0 0 24px color-mix(in srgb, var(--kb-neon-node) 24%, transparent);
}

#arcane-root[class*="neon-"] .kb-landing-secondary,
#arcane-root[class*="neon-"] .kb-landing-card,
#arcane-root[class*="neon-"] .kb-landing-band,
#arcane-root[class*="neon-"] .kb-landing-terminal {
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--kb-neon-panel-strong) 90%, transparent), color-mix(in srgb, var(--kb-neon-panel) 84%, transparent));
}

#arcane-root[class*="neon-"] .kb-landing-card h2,
#arcane-root[class*="neon-"] .kb-landing-band h2,
#arcane-root[class*="neon-"] .kb-landing-card a {
  color: var(--kb-neon-node-alt);
}

#arcane-root[class*="neon-"] .kb-landing-list-index {
  border: 1px solid color-mix(in srgb, var(--kb-neon-node) 72%, var(--kb-neon-line));
  background:
    linear-gradient(135deg, var(--kb-neon-node), color-mix(in srgb, var(--kb-neon-node) 58%, var(--kb-neon-panel-strong)));
  color: var(--primary-foreground);
  box-shadow: 0 0 18px color-mix(in srgb, var(--kb-neon-node) 28%, transparent);
}


/* ============================================
   SIDEBAR (Neon overrides) - moved from arcane_jaspr base
   ============================================ */
/* ============================================
   SIDEBAR NAVIGATION - Neon v2
   Disciplined gaming-console aesthetic
   ============================================ */

[class*="neon-"] .sidebar-header,
.neon .sidebar-header {
  padding: 0;
  gap: 0;
  border-bottom: none;
  background:
    linear-gradient(180deg, color-mix(in srgb, var(--card) 90%, transparent), color-mix(in srgb, var(--background) 72%, transparent));
  position: sticky;
  top: 0;
  z-index: 4;
  backdrop-filter: blur(12px) saturate(1.08);
  -webkit-backdrop-filter: blur(12px) saturate(1.08);
}

[class*="neon-"] .sidebar-brand,
.neon .sidebar-brand {
  padding: 1rem 1rem 0.875rem;
  background:
    linear-gradient(180deg, color-mix(in srgb, var(--neon-accent) 8%, transparent) 0%, transparent 100%);
  border-bottom: 1px solid var(--neon-panel-border);
}

[class*="neon-"] .sidebar-brand-title,
.neon .sidebar-brand-title {
  font-family: var(--font-heading);
  font-size: 1.0625rem;
  letter-spacing: 0.04em;
  background:
    linear-gradient(135deg, var(--foreground) 0%, color-mix(in srgb, var(--neon-accent) 70%, var(--foreground)) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

[class*="neon-"] .sidebar-brand-subtitle,
.neon .sidebar-brand-subtitle {
  font-family: var(--font-mono);
  letter-spacing: 0.16em;
  text-transform: uppercase;
  font-size: 0.5625rem;
  color: var(--neon-accent);
  opacity: 0.72;
  margin-top: 0.3125rem;
}

[class*="neon-"] .sidebar-tabs,
.neon .sidebar-tabs {
  flex-direction: column;
  padding: 0.375rem 0;
  background: transparent;
  border-radius: 0;
  gap: 0;
  border-bottom: 1px solid var(--neon-panel-border);
}

[class*="neon-"] .sidebar-tab,
.neon .sidebar-tab {
  font-family: var(--font-heading);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  font-size: 0.6875rem;
  padding: 0.5rem 1rem;
  border-radius: 0;
  text-align: left;
  border-left: 2px solid transparent;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease;
}

[class*="neon-"] .sidebar-tab:hover,
.neon .sidebar-tab:hover {
  background: color-mix(in srgb, var(--neon-accent) 8%, transparent);
  border-left-color: color-mix(in srgb, var(--neon-accent-cool) 50%, transparent);
  color: var(--neon-accent-cool);
}

[class*="neon-"] .sidebar-tab.active,
.neon .sidebar-tab.active {
  background: color-mix(in srgb, var(--neon-accent) 12%, transparent);
  color: var(--foreground);
  border-left-color: var(--neon-accent);
  box-shadow: inset 0 0 0 1px color-mix(in srgb, var(--neon-accent) 12%, transparent);
}

[class*="neon-"] .sidebar-controls,
.neon .sidebar-controls {
  padding: 0.625rem 0.75rem;
  background: color-mix(in srgb, var(--neon-accent) 3%, transparent);
  border-bottom: 1px solid var(--neon-panel-border);
}

[class*="neon-"] .sidebar-search input,
.neon .sidebar-search input {
  font-family: var(--font-sans);
  font-size: 0.75rem;
  border: 1px solid var(--neon-control-border);
  background: color-mix(in srgb, var(--neon-accent) 4%, var(--muted));
  border-radius: var(--neon-radius-control, 0.375rem);
}

[class*="neon-"] .sidebar-search input:focus,
.neon .sidebar-search input:focus {
  border-color: var(--neon-accent);
  box-shadow: 0 0 0 1px color-mix(in srgb, var(--neon-accent) 24%, transparent),
    0 0 12px color-mix(in srgb, var(--neon-accent) 18%, transparent);
}

[class*="neon-"] .sidebar-theme-toggle,
.neon .sidebar-theme-toggle {
  border: 1px solid var(--neon-control-border);
  background: color-mix(in srgb, var(--neon-accent) 4%, var(--muted));
  border-radius: var(--neon-radius-control, 0.375rem);
}

[class*="neon-"] .sidebar-theme-toggle:hover,
.neon .sidebar-theme-toggle:hover {
  color: var(--neon-accent-cool);
  border-color: var(--neon-panel-border-hot);
}

[class*="neon-"] .sidebar-section-header,
.neon .sidebar-section-header {
  font-family: var(--font-heading);
  text-transform: uppercase;
  letter-spacing: 0.12em;
  font-size: 0.6875rem;
  color: var(--neon-accent);
  border-bottom: 1px solid var(--neon-panel-border);
  padding-bottom: 0.5rem;
  margin-bottom: 0.25rem;
  opacity: 0.86;
}

[class*="neon-"] .sidebar-summary,
.neon .sidebar-summary {
  font-family: var(--font-heading);
  letter-spacing: 0.04em;
  color: var(--muted-foreground);
  background: color-mix(in srgb, var(--neon-accent) 5%, transparent);
  border: 1px solid var(--neon-control-border);
  border-radius: var(--neon-radius-control, 0.375rem);
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease;
}

[class*="neon-"] .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) > .sidebar-details > .sidebar-summary,
.neon .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) > .sidebar-details > .sidebar-summary {
  color: var(--neon-accent-cool);
  background: color-mix(in srgb, var(--neon-accent) 10%, transparent);
  border-color: var(--neon-panel-border-hot);
}

[class*="neon-"] .sidebar-details[open] > .sidebar-summary,
.neon .sidebar-details[open] > .sidebar-summary {
  color: var(--kb-neon-node-alt);
  background: color-mix(in srgb, var(--kb-neon-node) 16%, transparent);
  border-color: color-mix(in srgb, var(--kb-neon-node) 45%, transparent);
  box-shadow:
    inset 0 -1px 0 var(--kb-neon-node),
    0 0 18px color-mix(in srgb, var(--kb-neon-node) 14%, transparent);
}

[class*="neon-"] .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) > .sidebar-details[open] > .sidebar-summary,
.neon .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) > .sidebar-details[open] > .sidebar-summary {
  color: var(--kb-neon-node-alt);
  background: color-mix(in srgb, var(--kb-neon-node) 20%, transparent);
  border-color: color-mix(in srgb, var(--kb-neon-node) 58%, transparent);
}

[class*="neon-"] .sidebar-details[open] > .sidebar-tree::before,
.neon .sidebar-details[open] > .sidebar-tree::before {
  content: '';
  display: block;
  height: 1px;
  background:
    linear-gradient(90deg, transparent, var(--neon-panel-border), transparent);
  margin: 0.375rem 0 0.625rem 0;
}

[class*="neon-"] .sidebar-chevron::before,
.neon .sidebar-chevron::before {
  border-color: var(--neon-accent);
  opacity: 0.78;
}

[class*="neon-"] .sidebar-details[open] .sidebar-chevron::before,
.neon .sidebar-details[open] .sidebar-chevron::before {
  opacity: 1;
}

[class*="neon-"] .sidebar-tree .sidebar-tree-item::before,
.neon .sidebar-tree .sidebar-tree-item::before {
  background: color-mix(in srgb, var(--neon-accent) 50%, transparent);
  opacity: 1;
  height: 1px !important;
  width: 0.75rem !important;
  top: 50%;
  left: -1rem;
}

[class*="neon-"] .sidebar-tree .sidebar-tree-item:not(:last-child)::after,
.neon .sidebar-tree .sidebar-tree-item:not(:last-child)::after {
  background: color-mix(in srgb, var(--neon-accent) 40%, transparent);
  width: 1px !important;
  left: -1rem;
  top: calc(-0.25rem - 1px);
  bottom: calc(-0.25rem - 1px);
}

[class*="neon-"] .sidebar-tree .sidebar-tree-item:last-child::after,
.neon .sidebar-tree .sidebar-tree-item:last-child::after {
  background: color-mix(in srgb, var(--neon-accent) 40%, transparent);
  width: 1px !important;
  left: -1rem;
  top: calc(-0.25rem - 1px);
  height: calc(50% + 0.25rem + 1px);
}

[class*="neon-"] .sidebar-tree .sidebar-section::before,
.neon .sidebar-tree .sidebar-section::before {
  content: '';
  position: absolute;
  background: color-mix(in srgb, var(--neon-accent) 50%, transparent);
  opacity: 1;
  height: 1px !important;
  width: calc(0.75rem + 1px) !important;
  top: 50%;
  left: calc(-1rem - 1px);
}

[class*="neon-"] .sidebar-tree .sidebar-section:not(:last-child)::after,
.neon .sidebar-tree .sidebar-section:not(:last-child)::after {
  content: '';
  position: absolute;
  background: color-mix(in srgb, var(--neon-accent) 40%, transparent);
  width: 1px !important;
  left: calc(-1rem - 1px);
  top: calc(-0.25rem - 1px);
  bottom: calc(-0.25rem - 1px);
}

[class*="neon-"] .sidebar-tree .sidebar-section:last-child::after,
.neon .sidebar-tree .sidebar-section:last-child::after {
  content: '';
  position: absolute;
  background: color-mix(in srgb, var(--neon-accent) 40%, transparent);
  width: 1px !important;
  left: calc(-1rem - 1px);
  top: calc(-0.25rem - 1px);
  height: calc(50% + 0.25rem + 1px);
}

[class*="neon-"] .sidebar-tree .sidebar-section,
.neon .sidebar-tree .sidebar-section {
  position: relative;
  margin: 0.25rem 0;
  padding: 0;
  border-radius: var(--neon-radius-control, 0.375rem);
  background: transparent;
  border: 1px solid transparent;
  transition: background 0.15s ease, border-color 0.15s ease;
}

[class*="neon-"] .sidebar-tree .sidebar-section:has(.sidebar-details[open]),
.neon .sidebar-tree .sidebar-section:has(.sidebar-details[open]) {
  padding-bottom: 0.375rem;
}

[class*="neon-"] .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree,
.neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree {
  padding-left: 0.875rem;
}

[class*="neon-"] .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree > .sidebar-tree-item:not(:last-child)::before,
[class*="neon-"] .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree > .sidebar-section:not(:last-child)::before,
.neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree > .sidebar-tree-item:not(:last-child)::before,
.neon .sidebar-tree-nav > .sidebar-tree > .sidebar-section > .sidebar-details > .sidebar-tree > .sidebar-section:not(:last-child)::before {
  display: none;
}

[class*="neon-"] .sidebar-tree .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)),
.neon .sidebar-tree .sidebar-section:hover:not(:has(.sidebar-section:hover)):not(:has(.sidebar-link:hover)) {
  background: color-mix(in srgb, var(--neon-accent) 5%, transparent);
}

[class*="neon-"] .sidebar-tree .sidebar-tree .sidebar-section,
.neon .sidebar-tree .sidebar-tree .sidebar-section {
  background: transparent;
  border-color: transparent;
}

[class*="neon-"] .sidebar-tree .sidebar-tree .sidebar-tree .sidebar-section,
.neon .sidebar-tree .sidebar-tree .sidebar-tree .sidebar-section {
  background: transparent;
  border-color: transparent;
}

[class*="neon-"] .sidebar-tree .sidebar-details .sidebar-summary,
[class*="neon-"] .sidebar-tree-items .sidebar-details .sidebar-summary,
.neon .sidebar-tree .sidebar-details .sidebar-summary,
.neon .sidebar-tree-items .sidebar-details .sidebar-summary {
  font-family: var(--font-sans);
  font-size: 0.75rem;
  font-weight: 500;
  letter-spacing: 0;
  text-transform: none;
  color: var(--muted-foreground);
  background: transparent !important;
  border: none !important;
  border-radius: var(--radius-sm) !important;
  box-shadow: none !important;
  margin: 0;
  padding: 0.5rem 0.75rem 0.5rem 1.25rem !important;
  gap: 0.5rem;
}

[class*="neon-"] .sidebar-tree .sidebar-details .sidebar-summary:hover,
[class*="neon-"] .sidebar-tree-items .sidebar-details .sidebar-summary:hover,
.neon .sidebar-tree .sidebar-details .sidebar-summary:hover,
.neon .sidebar-tree-items .sidebar-details .sidebar-summary:hover {
  color: var(--neon-accent-cool);
}

[class*="neon-"] .sidebar-tree .sidebar-details[open] > .sidebar-summary,
[class*="neon-"] .sidebar-tree-items .sidebar-details[open] > .sidebar-summary,
.neon .sidebar-tree .sidebar-details[open] > .sidebar-summary,
.neon .sidebar-tree-items .sidebar-details[open] > .sidebar-summary {
  color: var(--kb-neon-node-alt);
  background: color-mix(in srgb, var(--kb-neon-node) 10%, transparent) !important;
  border-color: color-mix(in srgb, var(--kb-neon-node) 32%, transparent) !important;
  box-shadow: inset 0 -1px 0 color-mix(in srgb, var(--kb-neon-node) 54%, transparent) !important;
}

[class*="neon-"] .sidebar-tree .sidebar-tree,
.neon .sidebar-tree .sidebar-tree {
  padding-left: 1.5rem;
  margin-left: 0;
}

[class*="neon-"] .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-tree-item::before,
[class*="neon-"] .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-tree-item::after,
.neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-tree-item::before,
.neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-tree-item::after {
  display: none;
}

[class*="neon-"] .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-section::before,
[class*="neon-"] .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-section::after,
.neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-section::before,
.neon .sidebar-section .sidebar-tree .sidebar-section .sidebar-tree .sidebar-section::after {
  display: none;
}

[class*="neon-"] .sidebar-tree .sidebar-link,
.neon .sidebar-tree .sidebar-link {
  font-size: 0.8125rem;
  padding: 0.5rem 0.75rem 0.5rem 1.25rem !important;
  margin: 0.125rem 0;
  border-left: none !important;
}

[class*="neon-"] .sidebar-link,
.neon .sidebar-link {
  font-family: var(--font-sans);
  padding: 0.5rem 0.75rem;
  border-left: 2px solid transparent;
  border-radius: 0 var(--neon-radius-control, 0.375rem) var(--neon-radius-control, 0.375rem) 0;
  background: transparent;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease;
}

[class*="neon-"] .sidebar-link:hover,
.neon .sidebar-link:hover {
  color: var(--neon-accent-cool);
  background: color-mix(in srgb, var(--neon-accent) 7%, transparent);
  border-left-color: color-mix(in srgb, var(--neon-accent-cool) 45%, transparent);
}

[class*="neon-"] .sidebar-link.active,
.neon .sidebar-link.active {
  color: var(--kb-neon-node-alt);
  font-weight: 600;
  background: color-mix(in srgb, var(--kb-neon-node) 14%, transparent);
  border-left-color: var(--kb-neon-node);
  box-shadow: inset 2px 0 0 var(--kb-neon-node);
}
/* Neon styling for ArcaneSidebar tree lines */
[class*="neon-"] .arcane-sidebar-submenu-content > .arcane-sidebar-item::before,
[class*="neon-"] .arcane-sidebar-group-items > .arcane-sidebar-item::before,
.neon .arcane-sidebar-submenu-content > .arcane-sidebar-item::before,
.neon .arcane-sidebar-group-items > .arcane-sidebar-item::before {
  background: var(--primary);
  opacity: 0.6;
  height: 2px;
}

[class*="neon-"] .arcane-sidebar-submenu-content > .arcane-sidebar-item:not(:last-child)::after,
[class*="neon-"] .arcane-sidebar-group-items > .arcane-sidebar-item:not(:last-child)::after,
.neon .arcane-sidebar-submenu-content > .arcane-sidebar-item:not(:last-child)::after,
.neon .arcane-sidebar-group-items > .arcane-sidebar-item:not(:last-child)::after {
  background: var(--primary);
  width: 2px;
  box-shadow: none;
}

[class*="neon-"] .arcane-sidebar-submenu-content > .arcane-sidebar-item:last-child::after,
[class*="neon-"] .arcane-sidebar-group-items > .arcane-sidebar-item:last-child::after,
.neon .arcane-sidebar-submenu-content > .arcane-sidebar-item:last-child::after,
.neon .arcane-sidebar-group-items > .arcane-sidebar-item:last-child::after {
  background: var(--primary);
  width: 2px;
  box-shadow: none;
}

/* Neon link styling for ArcaneSidebar items */
[class*="neon-"] .arcane-sidebar-item,
.neon .arcane-sidebar-item {
  border-left: 3px solid transparent;
  border-radius: 0 var(--radius-md) var(--radius-md) 0 !important;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease;
}

[class*="neon-"] .arcane-sidebar-item:hover,
.neon .arcane-sidebar-item:hover {
  color: var(--primary) !important;
  background: color-mix(in srgb, var(--primary) 10%, transparent) !important;
  border-left-color: color-mix(in srgb, var(--primary) 50%, transparent);
}

[class*="neon-"] .arcane-sidebar-item.selected,
.neon .arcane-sidebar-item.selected {
  color: var(--primary) !important;
  font-weight: 600;
  background: color-mix(in srgb, var(--primary) 15%, transparent) !important;
  border-left-color: var(--primary);
  box-shadow: inset 0 0 0 1px color-mix(in srgb, var(--primary) 14%, transparent);
}
/* ============================================
   TABLE OF CONTENTS - Neon Gaming Style
   Cyberpunk with glowing tree lines
   ============================================ */
[class*="neon-"] .toc,
.neon .toc {
  background: color-mix(in srgb, var(--card) 82%, transparent);
  border-color: color-mix(in srgb, var(--primary) 20%, var(--border));
  box-shadow: 0 0 20px color-mix(in srgb, var(--primary) 5%, transparent);
}

[class*="neon-"] .toc-title,
.neon .toc-title {
  font-family: var(--font-mono);
  color: var(--primary);
  border-bottom-color: color-mix(in srgb, var(--primary) 22%, transparent);
  letter-spacing: 0;
}

[class*="neon-"] .toc-content > ul > li::before,
[class*="neon-"] .toc-content > ul > li::after,
[class*="neon-"] .toc-content ul ul li::before,
[class*="neon-"] .toc-content ul ul li::after,
.neon .toc-content > ul > li::before,
.neon .toc-content > ul > li::after,
.neon .toc-content ul ul li::before,
.neon .toc-content ul ul li::after {
  background: color-mix(in srgb, var(--primary) 36%, var(--border));
  box-shadow: none;
}

[class*="neon-"] .toc-content a,
.neon .toc-content a {
  font-size: 0.8125rem;
  line-height: 1.3;
  margin: 0.125rem 0;
  padding: 0.5rem 0.625rem !important;
  border: 1px solid transparent;
  border-radius: var(--radius-sm);
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease;
}

[class*="neon-"] .toc-content a:hover,
.neon .toc-content a:hover {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 8%, transparent);
  border-color: color-mix(in srgb, var(--primary) 18%, transparent);
}

[class*="neon-"] .toc-content a.toc-active,
.neon .toc-content a.toc-active {
  color: var(--primary);
  font-weight: 600;
  background: color-mix(in srgb, var(--primary) 12%, transparent);
  border-color: color-mix(in srgb, var(--primary) 24%, transparent);
  box-shadow: 0 0 8px color-mix(in srgb, var(--primary) 6%, transparent);
}
/* ============================================
   ARCANE MAP - Neon Style
   ============================================ */

[class*="neon-"] .arcane-world-map,
[class*="neon-"] .arcane-usa-map,
.neon .arcane-world-map,
.neon .arcane-usa-map {
  background: color-mix(in srgb, var(--card) 92%, transparent);
  border-color: var(--neon-panel-border, var(--border));
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.34);
}

[class*="neon-"] .arcane-world-map path[data-region]:hover,
[class*="neon-"] .arcane-usa-map path[data-region]:hover,
.neon .arcane-world-map path[data-region]:hover,
.neon .arcane-usa-map path[data-region]:hover {
  fill: var(--primary) !important;
  opacity: 0.72;
}

[class*="neon-"] .arcane-world-map path[data-region][data-active="true"],
[class*="neon-"] .arcane-usa-map path[data-region][data-active="true"],
.neon .arcane-world-map path[data-region][data-active="true"],
.neon .arcane-usa-map path[data-region][data-active="true"] {
  fill: var(--primary) !important;
  opacity: 0.9;
}

[class*="neon-"] .arcane-world-map circle[data-location],
[class*="neon-"] .arcane-usa-map circle[data-location],
.neon .arcane-world-map circle[data-location],
.neon .arcane-usa-map circle[data-location] {
  filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.35));
}

[class*="neon-"] .arcane-world-map circle[data-location]:hover,
[class*="neon-"] .arcane-usa-map circle[data-location]:hover,
.neon .arcane-world-map circle[data-location]:hover,
.neon .arcane-usa-map circle[data-location]:hover {
  filter: drop-shadow(0 2px 6px rgba(0, 0, 0, 0.45));
}

[class*="neon-"] .arcane-map-debug-tooltip > div,
.neon .arcane-map-debug-tooltip > div {
  background: color-mix(in srgb, var(--card) 96%, transparent);
  border-color: var(--neon-panel-border, var(--border));
  box-shadow: 0 10px 26px rgba(0, 0, 0, 0.42);
}

[class*="neon-"] .arcane-map-debug-tooltip .debug-lat,
[class*="neon-"] .arcane-map-debug-tooltip .debug-lng,
.neon .arcane-map-debug-tooltip .debug-lat,
.neon .arcane-map-debug-tooltip .debug-lng {
  color: var(--primary);
}

[class*="neon-"] .arcane-map-debug-tooltip .debug-hint,
.neon .arcane-map-debug-tooltip .debug-hint {
  color: var(--primary);
}

''';
  }

  static const String rainbowCss = '''
@keyframes neon-rainbow-primary {
  0%, 100% { --primary: #ff5169; --ring: #e54154; }
  14%      { --primary: #ffaa1f; --ring: #e0951a; }
  28%      { --primary: #f6c43c; --ring: #e0b035; }
  42%      { --primary: #00f5a0; --ring: #00d68b; }
  57%      { --primary: #00d9ff; --ring: #00b8d9; }
  71%      { --primary: #6366f1; --ring: #4f52d4; }
  85%      { --primary: #a855f7; --ring: #9242d4; }
}

@keyframes neon-rainbow-hot {
  0%, 100% { --neon-accent-hot: #ffaa1f; }
  14%      { --neon-accent-hot: #f6c43c; }
  28%      { --neon-accent-hot: #00f5a0; }
  42%      { --neon-accent-hot: #00d9ff; }
  57%      { --neon-accent-hot: #6366f1; }
  71%      { --neon-accent-hot: #a855f7; }
  85%      { --neon-accent-hot: #ff5169; }
}

@keyframes neon-rainbow-cool {
  0%, 100% { --neon-accent-cool: #6366f1; }
  14%      { --neon-accent-cool: #a855f7; }
  28%      { --neon-accent-cool: #ff5169; }
  42%      { --neon-accent-cool: #ffaa1f; }
  57%      { --neon-accent-cool: #f6c43c; }
  71%      { --neon-accent-cool: #00f5a0; }
  85%      { --neon-accent-cool: #00d9ff; }
}

#arcane-root.neon-rainbow,
.neon-rainbow {
  animation:
    neon-rainbow-primary 16s linear infinite,
    neon-rainbow-hot 16s linear infinite,
    neon-rainbow-cool 16s linear infinite;
}

@media (prefers-reduced-motion: reduce) {
  #arcane-root.neon-rainbow,
  .neon-rainbow {
    animation: none;
  }
}
''';
}
