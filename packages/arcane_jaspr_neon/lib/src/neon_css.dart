import 'package:arcane_jaspr/component/navigation/toc.dart'
    show arcaneTocTreeLinesCss;
import 'package:arcane_jaspr/util/content/prose_styles.dart';

import 'neon_theme.dart';

class NeonCss {
  const NeonCss._();

  static String componentCss(NeonTheme theme) =>
      '''
/* Neon Root Tokens */
#arcane-root[class*="neon-"] {
  --neon-accent: var(--primary);
  --neon-accent-rgb: var(--primary-rgb);
  --neon-cyan: #00e5ff;
  --neon-green: #00f5a0;
  --neon-magenta: #ff2bd6;
  --neon-purple: #a855f7;
  --neon-orange: #ffb020;
  --neon-red: #ff2d55;
  --neon-accent-secondary: color-mix(in srgb, var(--primary) 38%, var(--neon-cyan));
  --neon-accent-gradient: linear-gradient(135deg, var(--primary) 0%, var(--neon-cyan) 52%, var(--neon-magenta) 100%);
  --neon-accent-border: color-mix(in srgb, var(--primary) 38%, var(--border));
  --neon-surface-0: #020204;
  --neon-surface-1: rgba(5, 12, 16, 0.86);
  --neon-surface-2: rgba(8, 24, 26, 0.78);
  --neon-surface-3: rgba(13, 36, 39, 0.72);
  --neon-radius-panel: 0.625rem;
  --neon-radius-control: 0.375rem;
  --neon-cut-sm: 0.5rem;
  --neon-cut-md: 0.875rem;
  --neon-cut-lg: 1.25rem;
  --neon-panel-clip: polygon(0 var(--neon-cut-md), var(--neon-cut-md) 0, 100% 0, 100% calc(100% - var(--neon-cut-md)), calc(100% - var(--neon-cut-md)) 100%, 0 100%);
  --neon-control-clip: polygon(0 var(--neon-cut-sm), var(--neon-cut-sm) 0, 100% 0, 100% calc(100% - var(--neon-cut-sm)), calc(100% - var(--neon-cut-sm)) 100%, 0 100%);
  --neon-grid-line: color-mix(in srgb, var(--primary) 14%, transparent);
  --neon-grid-strong: color-mix(in srgb, var(--neon-cyan) 16%, transparent);
  --neon-glow-soft: color-mix(in srgb, var(--primary) 34%, transparent);
  --neon-glow-hard: color-mix(in srgb, var(--neon-cyan) 24%, transparent);
  --neon-panel-border: color-mix(in srgb, var(--foreground) 10%, var(--neon-accent-border));
  --neon-panel-shadow: 0 18px 52px rgba(0, 0, 0, 0.36), 0 0 34px color-mix(in srgb, var(--primary) 12%, transparent);
  --neon-inset-highlight: inset 0 1px 0 rgba(255,255,255,0.12), inset 0 -1px 0 rgba(0,0,0,0.42);
  background: transparent !important;
  isolation: isolate;
}

html.dark #arcane-root[class*="neon-"]::before {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -2;
  pointer-events: none;
  background-color: var(--neon-surface-0);
  background-image:
    radial-gradient(circle at 18% 8%, color-mix(in srgb, var(--primary) 18%, transparent), transparent 24rem),
    radial-gradient(circle at 82% 2%, color-mix(in srgb, var(--neon-cyan) 14%, transparent), transparent 28rem),
    radial-gradient(circle at 70% 78%, color-mix(in srgb, var(--neon-magenta) 10%, transparent), transparent 30rem),
    linear-gradient(var(--neon-grid-line) 1px, transparent 1px),
    linear-gradient(90deg, var(--neon-grid-line) 1px, transparent 1px);
  background-size: auto, auto, auto, 54px 54px, 54px 54px;
  background-attachment: fixed;
}

html.dark #arcane-root[class*="neon-"]::after {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -1;
  pointer-events: none;
  opacity: 0.22;
  background:
    linear-gradient(rgba(255,255,255,0.035) 1px, transparent 1px),
    url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.35'/%3E%3C/svg%3E");
  background-size: 100% 3px, 256px 256px;
}

#arcane-root[class*="neon-"]::before {
  transform: translateZ(0);
}

#arcane-root[class*="neon-"] ::selection {
  background: var(--neon-glow-soft);
  color: var(--foreground);
}

#arcane-root[class*="neon-"] :focus-visible {
  outline: 2px solid var(--neon-accent);
  outline-offset: 2px;
  box-shadow:
    0 0 0 3px color-mix(in srgb, var(--neon-accent) 22%, transparent),
    0 0 24px color-mix(in srgb, var(--neon-accent) 22%, transparent);
}

#arcane-root[class*="neon-"] a:hover {
  color: var(--neon-accent-secondary);
}

#arcane-root[class*="neon-"] .neon-card:hover,
#arcane-root[class*="neon-"] .arcane-card.clickable:hover {
  border-color: var(--neon-accent-border);
  transform: translateY(-2px);
  box-shadow:
    0 16px 40px rgba(0, 0, 0, 0.28),
    0 0 0 1px color-mix(in srgb, var(--neon-cyan) 16%, transparent),
    0 0 34px color-mix(in srgb, var(--neon-accent) 20%, transparent);
}

#arcane-root[class*="neon-"] .arcane-scaffold-sidebar,
#arcane-root[class*="neon-"] .arcane-scaffold-main,
#arcane-root[class*="neon-"] .arcane-scaffold-secondary,
#arcane-root[class*="neon-"] .neon-card,
#arcane-root[class*="neon-"] .arcane-card,
#arcane-root[class*="neon-"] .arcane-dialog,
#arcane-root[class*="neon-"] .arcane-sheet,
#arcane-root[class*="neon-"] .arcane-drawer,
#arcane-root[class*="neon-"] .neon-command-dialog {
  position: relative;
  overflow: hidden;
  border-radius: var(--neon-radius-panel) !important;
  clip-path: var(--neon-panel-clip);
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 9%, transparent), transparent 34%),
    linear-gradient(315deg, color-mix(in srgb, var(--neon-magenta) 8%, transparent), transparent 38%),
    linear-gradient(90deg, color-mix(in srgb, var(--primary) 4%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--neon-cyan) 3%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 80%, transparent) !important;
  background-size: auto, auto, 22px 22px, 22px 22px, auto;
  border-color: var(--neon-panel-border) !important;
  box-shadow: var(--neon-panel-shadow), var(--neon-inset-highlight);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
}

#arcane-root[class*="neon-"] .neon-card::before,
#arcane-root[class*="neon-"] .arcane-card::before,
#arcane-root[class*="neon-"] .arcane-scaffold-sidebar::before,
#arcane-root[class*="neon-"] .arcane-scaffold-main::before,
#arcane-root[class*="neon-"] .arcane-scaffold-secondary::before,
#arcane-root[class*="neon-"] .arcane-dialog::before,
#arcane-root[class*="neon-"] .arcane-sheet::before,
#arcane-root[class*="neon-"] .arcane-drawer::before,
#arcane-root[class*="neon-"] .neon-command-dialog::before {
  content: '';
  position: absolute;
  inset: 0;
  pointer-events: none;
  background:
    linear-gradient(90deg, var(--neon-accent), transparent 22%) top left / 42% 1px no-repeat,
    linear-gradient(180deg, var(--neon-accent), transparent 40%) top left / 1px 42% no-repeat,
    linear-gradient(270deg, var(--neon-cyan), transparent 22%) bottom right / 42% 1px no-repeat,
    linear-gradient(0deg, var(--neon-cyan), transparent 40%) bottom right / 1px 42% no-repeat;
  opacity: 0.62;
}

#arcane-root[class*="neon-"] .neon-card::after,
#arcane-root[class*="neon-"] .arcane-card::after {
  content: '';
  position: absolute;
  inset: -2px;
  pointer-events: none;
  opacity: 0;
  background:
    conic-gradient(from 180deg at 50% 50%, transparent 0deg, var(--neon-cyan) 24deg, transparent 55deg, transparent 170deg, var(--neon-magenta) 205deg, transparent 238deg, transparent 360deg);
  filter: blur(18px);
  transition: opacity 0.25s ease;
  z-index: -1;
}

#arcane-root[class*="neon-"] .neon-card:hover::after,
#arcane-root[class*="neon-"] .arcane-card.clickable:hover::after {
  opacity: 0.28;
}

#arcane-root[class*="neon-"] .neon-button,
#arcane-root[class*="neon-"] button[class*="neon-"],
#arcane-root[class*="neon-"] .neon-text-input,
#arcane-root[class*="neon-"] .neon-text-input-container,
#arcane-root[class*="neon-"] select,
#arcane-root[class*="neon-"] textarea {
  clip-path: var(--neon-control-clip);
  border-radius: var(--neon-radius-control) !important;
}

#arcane-root[class*="neon-"] .neon-button {
  isolation: isolate;
  overflow: hidden;
  text-transform: uppercase;
  letter-spacing: 0;
}

#arcane-root[class*="neon-"] .neon-button::before {
  content: '';
  position: absolute;
  inset: 0;
  pointer-events: none;
  opacity: 0;
  background:
    linear-gradient(90deg, transparent, rgba(255,255,255,0.42), transparent),
    repeating-linear-gradient(0deg, transparent 0 4px, color-mix(in srgb, var(--neon-cyan) 14%, transparent) 4px 5px);
  transform: translateX(-120%);
  transition: opacity 0.18s ease, transform 0.38s ease;
  z-index: -1;
}

#arcane-root[class*="neon-"] .neon-button::after {
  content: '';
  position: absolute;
  inset: 1px;
  pointer-events: none;
  border: 1px solid color-mix(in srgb, var(--foreground) 9%, transparent);
  clip-path: var(--neon-control-clip);
}

#arcane-root[class*="neon-"] .neon-button:hover::before {
  opacity: 0.75;
  transform: translateX(120%);
}

#arcane-root[class*="neon-"] .neon-button:hover {
  transform: translateY(-1px);
  text-shadow: 0 0 14px color-mix(in srgb, currentColor 34%, transparent);
}

#arcane-root[class*="neon-"] .neon-button:active {
  transform: translateY(1px);
  filter: saturate(1.25) contrast(1.08);
}

#arcane-root[class*="neon-"] .neon-alert {
  clip-path: polygon(0 var(--neon-cut-sm), var(--neon-cut-sm) 0, 100% 0, 100% 100%, 0 100%);
}

#arcane-root[class*="neon-"] .neon-alert-title,
#arcane-root[class*="neon-"] .neon-card h1,
#arcane-root[class*="neon-"] .neon-card h2,
#arcane-root[class*="neon-"] .neon-card h3 {
  text-transform: uppercase;
  letter-spacing: 0;
}

#arcane-root[class*="neon-"] .neon-dropdown-menu,
#arcane-root[class*="neon-"] .neon-dropdown-submenu,
#arcane-root[class*="neon-"] .neon-context-menu,
#arcane-root[class*="neon-"] .neon-menubar-content,
#arcane-root[class*="neon-"] .neon-select-content,
#arcane-root[class*="neon-"] .neon-calendar,
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
  clip-path: var(--neon-panel-clip);
  border-radius: var(--neon-radius-panel) !important;
  border-color: var(--neon-panel-border) !important;
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 8%, transparent), transparent 42%),
    linear-gradient(90deg, color-mix(in srgb, var(--primary) 4%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--popover, var(--card)) 82%, transparent) !important;
  background-size: auto, 18px 18px, auto;
  box-shadow: var(--neon-panel-shadow), var(--neon-inset-highlight);
  backdrop-filter: blur(18px) saturate(1.18);
  -webkit-backdrop-filter: blur(18px) saturate(1.18);
}

#arcane-root[class*="neon-"] .neon-dropdown-item,
#arcane-root[class*="neon-"] .neon-context-menu-item,
#arcane-root[class*="neon-"] .neon-select-item,
#arcane-root[class*="neon-"] .neon-command-item,
#arcane-root[class*="neon-"] .neon-tabs-trigger,
#arcane-root[class*="neon-"] .neon-radio-card,
#arcane-root[class*="neon-"] .neon-radio-button,
#arcane-root[class*="neon-"] .neon-toggle-group-item {
  clip-path: var(--neon-control-clip);
  border-radius: var(--neon-radius-control) !important;
}

#arcane-root[class*="neon-"] .neon-dropdown-item:hover,
#arcane-root[class*="neon-"] .neon-context-menu-item:hover,
#arcane-root[class*="neon-"] .neon-select-item:hover,
#arcane-root[class*="neon-"] .neon-command-item:hover,
#arcane-root[class*="neon-"] .neon-tabs-trigger:hover,
#arcane-root[class*="neon-"] .neon-toggle-group-item:hover {
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 16%, transparent), color-mix(in srgb, var(--primary) 8%, transparent)) !important;
  color: var(--foreground);
  box-shadow: inset 2px 0 0 var(--neon-cyan), 0 0 18px color-mix(in srgb, var(--neon-cyan) 10%, transparent);
}

#arcane-root[class*="neon-"] .neon-tabs-trigger[data-state="active"],
#arcane-root[class*="neon-"] .neon-toggle-group-item.selected,
#arcane-root[class*="neon-"] .neon-radio-card.selected,
#arcane-root[class*="neon-"] .neon-radio-button.selected {
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--primary) 22%, transparent), color-mix(in srgb, var(--neon-cyan) 10%, transparent)) !important;
  border-color: var(--neon-accent-border) !important;
  color: var(--neon-accent);
  box-shadow: 0 0 20px color-mix(in srgb, var(--primary) 15%, transparent), inset 0 0 14px color-mix(in srgb, var(--primary) 8%, transparent);
}

#arcane-root[class*="neon-"] .neon-badge,
#arcane-root[class*="neon-"] .neon-status-badge,
#arcane-root[class*="neon-"] .neon-kbd {
  clip-path: var(--neon-control-clip);
  border-radius: var(--neon-radius-control) !important;
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--primary) 12%, transparent), color-mix(in srgb, var(--card) 72%, transparent)) !important;
  border: 1px solid var(--neon-accent-border) !important;
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.1), 0 0 14px color-mix(in srgb, var(--primary) 8%, transparent);
}

#arcane-root[class*="neon-"] {
  --neon-widget-face: linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 7%, transparent), transparent 38%), linear-gradient(315deg, color-mix(in srgb, var(--neon-magenta) 6%, transparent), transparent 42%), linear-gradient(90deg, color-mix(in srgb, var(--primary) 4%, transparent) 1px, transparent 1px), color-mix(in srgb, var(--card) 82%, transparent);
  --neon-widget-face-strong: linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 13%, transparent), transparent 42%), linear-gradient(315deg, color-mix(in srgb, var(--neon-magenta) 10%, transparent), transparent 46%), linear-gradient(90deg, color-mix(in srgb, var(--primary) 5%, transparent) 1px, transparent 1px), color-mix(in srgb, var(--card) 76%, transparent);
  --neon-widget-line: color-mix(in srgb, var(--neon-cyan) 26%, var(--border));
  --neon-widget-line-hot: color-mix(in srgb, var(--neon-cyan) 58%, var(--primary));
  --neon-widget-shadow: inset 0 1px 0 rgba(255,255,255,0.11), 0 18px 40px rgba(0,0,0,0.24), 0 0 26px color-mix(in srgb, var(--primary) 10%, transparent);
  --neon-widget-clip-sm: polygon(0 0.55rem, 0.55rem 0, 100% 0, 100% calc(100% - 0.55rem), calc(100% - 0.55rem) 100%, 0 100%);
  --neon-widget-clip-md: polygon(0 0.9rem, 0.9rem 0, 100% 0, 100% calc(100% - 0.9rem), calc(100% - 0.9rem) 100%, 0 100%);
}

#arcane-root[class*="neon-"] .arcane-demo-panel > .arcane-box,
#arcane-root[class*="neon-"] .arcane-demo-preview-scope,
#arcane-root[class*="neon-"] .neon-accordion,
#arcane-root[class*="neon-"] .neon-alert,
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
#arcane-root[class*="neon-"] .neon-button-group {
  position: relative;
  isolation: isolate;
  overflow: hidden;
  clip-path: var(--neon-widget-clip-md);
  border-radius: var(--neon-radius-panel) !important;
  border: 1px solid var(--neon-panel-border) !important;
  background: var(--neon-widget-face) !important;
  background-size: auto, auto, 24px 24px, auto !important;
  box-shadow: var(--neon-widget-shadow) !important;
  backdrop-filter: blur(14px) saturate(1.12);
  -webkit-backdrop-filter: blur(14px) saturate(1.12);
}

#arcane-root[class*="neon-"] .arcane-demo-panel > .arcane-box::before,
#arcane-root[class*="neon-"] .arcane-demo-preview-scope::before,
#arcane-root[class*="neon-"] .neon-accordion::before,
#arcane-root[class*="neon-"] .neon-alert::before,
#arcane-root[class*="neon-"] .neon-calendar::before,
#arcane-root[class*="neon-"] .neon-chart::before,
#arcane-root[class*="neon-"] .neon-data-table-container::before,
#arcane-root[class*="neon-"] .neon-static-table-container::before,
#arcane-root[class*="neon-"] .neon-sidebar::before,
#arcane-root[class*="neon-"] .neon-empty-state-card::before,
#arcane-root[class*="neon-"] .neon-resizable::before,
#arcane-root[class*="neon-"] .neon-scroll-area::before,
#arcane-root[class*="neon-"] .neon-form-section::before,
#arcane-root[class*="neon-"] .neon-input-group::before,
#arcane-root[class*="neon-"] .neon-disclosure::before,
#arcane-root[class*="neon-"] .neon-field-wrapper::before,
#arcane-root[class*="neon-"] .neon-otp-input::before,
#arcane-root[class*="neon-"] .neon-radio-group::before,
#arcane-root[class*="neon-"] .neon-tabs::before,
#arcane-root[class*="neon-"] .neon-toggle-group::before,
#arcane-root[class*="neon-"] .neon-slot-counter::before,
#arcane-root[class*="neon-"] .neon-slot-counter-card::before,
#arcane-root[class*="neon-"] .neon-kv-table::before,
#arcane-root[class*="neon-"] .neon-button-panel::before,
#arcane-root[class*="neon-"] .neon-toolbar::before,
#arcane-root[class*="neon-"] .neon-button-group::before {
  content: '';
  position: absolute;
  inset: 0;
  pointer-events: none;
  background:
    linear-gradient(90deg, var(--neon-widget-line-hot), transparent 30%) top left / 46% 1px no-repeat,
    linear-gradient(180deg, var(--neon-widget-line-hot), transparent 44%) top left / 1px 48% no-repeat,
    linear-gradient(270deg, var(--neon-cyan), transparent 30%) bottom right / 46% 1px no-repeat,
    linear-gradient(0deg, var(--neon-cyan), transparent 44%) bottom right / 1px 48% no-repeat;
  opacity: 0.58;
  z-index: 1;
}

#arcane-root[class*="neon-"] .arcane-demo-panel > .arcane-box > *,
#arcane-root[class*="neon-"] .arcane-demo-preview-scope > *,
#arcane-root[class*="neon-"] .neon-accordion > *,
#arcane-root[class*="neon-"] .neon-alert > *,
#arcane-root[class*="neon-"] .neon-calendar > *,
#arcane-root[class*="neon-"] .neon-chart > *,
#arcane-root[class*="neon-"] .neon-data-table-container > *,
#arcane-root[class*="neon-"] .neon-static-table-container > *,
#arcane-root[class*="neon-"] .neon-sidebar > *,
#arcane-root[class*="neon-"] .neon-empty-state-card > *,
#arcane-root[class*="neon-"] .neon-resizable > *,
#arcane-root[class*="neon-"] .neon-scroll-area > *,
#arcane-root[class*="neon-"] .neon-form-section > *,
#arcane-root[class*="neon-"] .neon-input-group > *,
#arcane-root[class*="neon-"] .neon-disclosure > *,
#arcane-root[class*="neon-"] .neon-field-wrapper > *,
#arcane-root[class*="neon-"] .neon-otp-input > *,
#arcane-root[class*="neon-"] .neon-radio-group > *,
#arcane-root[class*="neon-"] .neon-tabs > *,
#arcane-root[class*="neon-"] .neon-toggle-group > *,
#arcane-root[class*="neon-"] .neon-slot-counter > *,
#arcane-root[class*="neon-"] .neon-slot-counter-card > *,
#arcane-root[class*="neon-"] .neon-kv-table > *,
#arcane-root[class*="neon-"] .neon-button-panel > *,
#arcane-root[class*="neon-"] .neon-toolbar > *,
#arcane-root[class*="neon-"] .neon-button-group > * {
  position: relative;
  z-index: 2;
}

#arcane-root[class*="neon-"] .neon-button,
#arcane-root[class*="neon-"] .neon-select-trigger,
#arcane-root[class*="neon-"] .neon-date-picker-trigger,
#arcane-root[class*="neon-"] .neon-text-input,
#arcane-root[class*="neon-"] .neon-text-input-container,
#arcane-root[class*="neon-"] .neon-otp-digit,
#arcane-root[class*="neon-"] .neon-calendar-nav-btn,
#arcane-root[class*="neon-"] .neon-calendar-today-btn,
#arcane-root[class*="neon-"] .neon-calendar-day,
#arcane-root[class*="neon-"] .neon-pagination-button,
#arcane-root[class*="neon-"] .neon-menubar-trigger,
#arcane-root[class*="neon-"] .neon-breadcrumb-link,
#arcane-root[class*="neon-"] .neon-breadcrumb-button,
#arcane-root[class*="neon-"] .neon-toggle-button,
#arcane-root[class*="neon-"] .neon-toggle-switch,
#arcane-root[class*="neon-"] .neon-radio-card,
#arcane-root[class*="neon-"] .neon-radio-button,
#arcane-root[class*="neon-"] .neon-radio-chip,
#arcane-root[class*="neon-"] .neon-toggle-group-item,
#arcane-root[class*="neon-"] .neon-tabs-trigger,
#arcane-root[class*="neon-"] .neon-tab-bar-item {
  clip-path: var(--neon-widget-clip-sm);
  border-radius: var(--neon-radius-control) !important;
  border-color: var(--neon-widget-line) !important;
  background-size: auto, 18px 18px, auto !important;
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
#arcane-root[class*="neon-"] .neon-breadcrumb-link,
#arcane-root[class*="neon-"] .neon-breadcrumb-button,
#arcane-root[class*="neon-"] .neon-toggle-button,
#arcane-root[class*="neon-"] .neon-radio-card,
#arcane-root[class*="neon-"] .neon-radio-button,
#arcane-root[class*="neon-"] .neon-radio-chip,
#arcane-root[class*="neon-"] .neon-toggle-group-item,
#arcane-root[class*="neon-"] .neon-tabs-trigger,
#arcane-root[class*="neon-"] .neon-tab-bar-item {
  background:
    linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 8%, transparent), transparent 58%),
    linear-gradient(90deg, color-mix(in srgb, var(--primary) 4%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 82%, transparent) !important;
  color: var(--foreground);
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.1), 0 0 14px color-mix(in srgb, var(--primary) 6%, transparent);
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
#arcane-root[class*="neon-"] .neon-breadcrumb-link:hover,
#arcane-root[class*="neon-"] .neon-breadcrumb-button:hover,
#arcane-root[class*="neon-"] .neon-toggle-button:hover,
#arcane-root[class*="neon-"] .neon-radio-card:hover,
#arcane-root[class*="neon-"] .neon-radio-button:hover,
#arcane-root[class*="neon-"] .neon-radio-chip:hover,
#arcane-root[class*="neon-"] .neon-toggle-group-item:hover,
#arcane-root[class*="neon-"] .neon-tabs-trigger:hover,
#arcane-root[class*="neon-"] .neon-tab-bar-item:hover {
  border-color: var(--neon-widget-line-hot) !important;
  color: var(--neon-cyan);
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.14),
    0 0 0 1px color-mix(in srgb, var(--neon-cyan) 20%, transparent),
    0 0 22px color-mix(in srgb, var(--neon-cyan) 12%, transparent);
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
    linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 18%, transparent), color-mix(in srgb, var(--primary) 14%, transparent)),
    color-mix(in srgb, var(--card) 74%, transparent) !important;
  border-color: var(--neon-widget-line-hot) !important;
  color: var(--neon-cyan) !important;
  box-shadow:
    inset 0 0 18px color-mix(in srgb, var(--neon-cyan) 9%, transparent),
    0 0 0 1px color-mix(in srgb, var(--neon-cyan) 25%, transparent),
    0 0 24px color-mix(in srgb, var(--neon-cyan) 16%, transparent) !important;
}

#arcane-root[class*="neon-"] .neon-data-table,
#arcane-root[class*="neon-"] .neon-static-table,
#arcane-root[class*="neon-"] .neon-kv-table {
  border-collapse: separate !important;
  border-spacing: 0;
  overflow: hidden;
}

#arcane-root[class*="neon-"] .neon-data-table th,
#arcane-root[class*="neon-"] .neon-static-table th,
#arcane-root[class*="neon-"] .neon-kv-table-key {
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 14%, transparent), transparent),
    color-mix(in srgb, var(--card) 78%, transparent) !important;
  color: var(--neon-cyan) !important;
  text-transform: uppercase;
  letter-spacing: 0;
  border-color: color-mix(in srgb, var(--neon-cyan) 22%, var(--border)) !important;
}

#arcane-root[class*="neon-"] .neon-data-table td,
#arcane-root[class*="neon-"] .neon-static-table td,
#arcane-root[class*="neon-"] .neon-kv-table-value {
  border-color: color-mix(in srgb, var(--neon-cyan) 14%, var(--border)) !important;
}

#arcane-root[class*="neon-"] .neon-data-table-row:hover,
#arcane-root[class*="neon-"] .neon-static-table tbody tr:hover,
#arcane-root[class*="neon-"] .neon-kv-table-row:hover {
  background: color-mix(in srgb, var(--neon-cyan) 8%, transparent) !important;
}

#arcane-root[class*="neon-"] .neon-progress-track,
#arcane-root[class*="neon-"] .neon-slider-track {
  clip-path: var(--neon-widget-clip-sm);
  border: 1px solid color-mix(in srgb, var(--neon-cyan) 18%, var(--border));
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 6%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--foreground) 10%, transparent) !important;
  background-size: 14px 14px, auto !important;
}

#arcane-root[class*="neon-"] .neon-progress-indicator,
#arcane-root[class*="neon-"] .neon-slider-range {
  background: linear-gradient(90deg, var(--primary), var(--neon-cyan)) !important;
  box-shadow: 0 0 18px color-mix(in srgb, var(--neon-cyan) 30%, transparent);
}

#arcane-root[class*="neon-"] .neon-slider-thumb,
#arcane-root[class*="neon-"] .neon-radio-circle,
#arcane-root[class*="neon-"] .neon-status-indicator,
#arcane-root[class*="neon-"] .neon-avatar-status {
  box-shadow:
    0 0 0 1px color-mix(in srgb, var(--neon-cyan) 35%, transparent),
    0 0 16px color-mix(in srgb, var(--neon-cyan) 22%, transparent) !important;
}

#arcane-root[class*="neon-"] .neon-avatar {
  clip-path: polygon(0 0.4rem, 0.4rem 0, 100% 0, 100% calc(100% - 0.4rem), calc(100% - 0.4rem) 100%, 0 100%);
  border: 1px solid var(--neon-widget-line-hot) !important;
  background: linear-gradient(135deg, var(--primary), var(--neon-cyan)) !important;
  box-shadow: 0 0 20px color-mix(in srgb, var(--neon-cyan) 18%, transparent);
}

#arcane-root[class*="neon-"] .neon-alert {
  align-items: flex-start;
  border-left: 0 !important;
}

#arcane-root[class*="neon-"] .neon-alert-icon,
#arcane-root[class*="neon-"] .neon-empty-state-icon,
#arcane-root[class*="neon-"] .neon-check-item-icon,
#arcane-root[class*="neon-"] .neon-feature-row-icon {
  clip-path: polygon(50% 0, 100% 50%, 50% 100%, 0 50%);
  border: 1px solid var(--neon-widget-line-hot);
  background:
    radial-gradient(circle, color-mix(in srgb, var(--neon-cyan) 26%, transparent), transparent 64%),
    color-mix(in srgb, var(--card) 76%, transparent) !important;
  box-shadow: 0 0 20px color-mix(in srgb, var(--neon-cyan) 18%, transparent);
}

#arcane-root[class*="neon-"] .neon-sidebar-item,
#arcane-root[class*="neon-"] .neon-dropdown-item,
#arcane-root[class*="neon-"] .neon-context-menu-item,
#arcane-root[class*="neon-"] .neon-menubar-item,
#arcane-root[class*="neon-"] .neon-select-option,
#arcane-root[class*="neon-"] .neon-select-item,
#arcane-root[class*="neon-"] .neon-command-item {
  clip-path: var(--neon-widget-clip-sm);
  border: 1px solid transparent;
}

#arcane-root[class*="neon-"] .neon-sidebar-item:hover,
#arcane-root[class*="neon-"] .neon-dropdown-item:hover,
#arcane-root[class*="neon-"] .neon-context-menu-item:hover,
#arcane-root[class*="neon-"] .neon-menubar-item:hover,
#arcane-root[class*="neon-"] .neon-select-option:hover,
#arcane-root[class*="neon-"] .neon-select-item:hover,
#arcane-root[class*="neon-"] .neon-command-item:hover {
  border-color: color-mix(in srgb, var(--neon-cyan) 35%, transparent);
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 15%, transparent), color-mix(in srgb, var(--primary) 8%, transparent)) !important;
}

#arcane-root[class*="neon-"] .neon-sidebar-item.selected,
#arcane-root[class*="neon-"] .neon-sidebar-item.active,
#arcane-root[class*="neon-"] .neon-command-item.selected,
#arcane-root[class*="neon-"] .neon-select-option.selected,
#arcane-root[class*="neon-"] .neon-select-item.selected {
  border-color: var(--neon-widget-line-hot);
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 20%, transparent), color-mix(in srgb, var(--primary) 12%, transparent)) !important;
  color: var(--neon-cyan);
  box-shadow: inset 2px 0 0 var(--neon-cyan), 0 0 20px color-mix(in srgb, var(--neon-cyan) 12%, transparent);
}

#arcane-root[class*="neon-"] .neon-separator,
#arcane-root[class*="neon-"] .neon-dropdown-divider,
#arcane-root[class*="neon-"] .neon-context-menu-separator,
#arcane-root[class*="neon-"] .neon-menubar-separator,
#arcane-root[class*="neon-"] .neon-sidebar-separator {
  background: linear-gradient(90deg, transparent, color-mix(in srgb, var(--neon-cyan) 52%, var(--border)), transparent) !important;
  box-shadow: 0 0 14px color-mix(in srgb, var(--neon-cyan) 12%, transparent);
}

#arcane-root[class*="neon-"] .neon-separator-with-label span {
  clip-path: var(--neon-widget-clip-sm);
  border: 1px solid var(--neon-widget-line);
  background: color-mix(in srgb, var(--card) 84%, transparent);
  color: var(--neon-cyan);
}

#arcane-root[class*="neon-"] .neon-skeleton,
#arcane-root[class*="neon-"] .neon-skeleton-card {
  clip-path: var(--neon-widget-clip-sm);
  background:
    linear-gradient(100deg, color-mix(in srgb, var(--foreground) 8%, transparent) 8%, color-mix(in srgb, var(--neon-cyan) 14%, transparent) 18%, color-mix(in srgb, var(--foreground) 8%, transparent) 33%),
    color-mix(in srgb, var(--card) 78%, transparent) !important;
  background-size: 240% 100%, auto !important;
}

html.light #arcane-root[class*="neon-"] {
  --neon-widget-face: linear-gradient(135deg, rgba(0, 149, 167, 0.07), transparent 42%), linear-gradient(315deg, rgba(157, 76, 189, 0.045), transparent 46%), linear-gradient(90deg, rgba(0, 128, 145, 0.055) 1px, transparent 1px), rgba(250, 254, 255, 0.82);
  --neon-widget-face-strong: linear-gradient(135deg, rgba(0, 149, 167, 0.1), transparent 42%), linear-gradient(315deg, rgba(157, 76, 189, 0.06), transparent 46%), linear-gradient(90deg, rgba(0, 128, 145, 0.065) 1px, transparent 1px), rgba(246, 253, 255, 0.9);
  --neon-widget-line: rgba(20, 108, 122, 0.26);
  --neon-widget-line-hot: rgba(0, 107, 125, 0.68);
  --neon-widget-shadow: inset 0 1px 0 rgba(255,255,255,0.95), 0 14px 32px rgba(18, 64, 77, 0.1), 0 0 18px rgba(0, 128, 145, 0.08);
}

/* ============================================
   PROSE - Neon Typography
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
  letter-spacing: 0;
}

.prose h2 {
  font-size: 1.375rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid color-mix(in srgb, var(--neon-accent) 34%, transparent);
}

.prose h3 { font-size: 1.125rem; }
.prose h4 { font-size: 1rem; }

.prose p {
  margin-bottom: 1rem;
}

.prose a {
  color: var(--neon-accent);
  text-decoration: none;
  border-bottom: 1px solid color-mix(in srgb, var(--neon-accent) 42%, transparent);
  transition: all 0.15s ease;
}

.prose a:hover {
  border-bottom-color: var(--neon-accent);
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
  height: 2px;
  background: linear-gradient(90deg, transparent, var(--neon-accent), transparent);
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
  background: color-mix(in srgb, var(--neon-accent) 10%, var(--muted));
  font-family: var(--font-heading);
  font-weight: 600;
  color: var(--neon-accent);
}

.prose img {
  max-width: 100%;
  height: auto;
  border-radius: var(--radius-lg);
  margin: 1.5rem 0;
  border: 1px solid var(--border);
}

.prose pre {
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-accent) 5%, transparent) 1px, transparent 1px),
    var(--neon-surface-1);
  background-size: 24px 24px, auto;
  border: 1px solid color-mix(in srgb, var(--neon-accent) 30%, var(--border));
  border-radius: var(--radius-md);
  padding: 1rem 1.25rem;
  overflow-x: auto;
  margin: 1rem 0;
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.04),
    0 14px 34px color-mix(in srgb, var(--neon-accent) 10%, transparent);
}

.prose code {
  font-family: var(--font-mono);
  font-size: 0.875em;
}

.prose :not(pre) > code {
  background: color-mix(in srgb, var(--neon-accent) 12%, var(--muted));
  padding: 0.2rem 0.5rem;
  border-radius: var(--radius-sm);
  font-size: 0.875em;
  color: var(--neon-accent);
  border: 1px solid color-mix(in srgb, var(--neon-accent) 18%, transparent);
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
.neon-glow {
  box-shadow: var(--shadow-md);
}

.neon-glow-strong {
  box-shadow: var(--shadow-lg);
}

${theme == NeonTheme.rainbow ? rainbowCss : ''}

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

$arcaneSidebarNeonStyles

$arcaneTocTreeLinesCss

/* ============================================
   GAME TILES - Card animations and hover effects
   ============================================ */

/* Appear animation for game cards/tiles */
@keyframes neon-card-appear {
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
.neon-game-tile--animated {
  animation: neon-card-appear 0.3s ease-out forwards;
  opacity: 0;
}

/* Hover effects for interactive game tiles */
.neon-game-tile--interactive {
  transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.neon-game-tile--interactive:hover {
  transform: translateY(-3px);
  border-color: color-mix(in srgb, var(--neon-accent) 52%, transparent);
  box-shadow:
    0 16px 34px rgba(0, 0, 0, 0.34),
    0 0 0 1px color-mix(in srgb, var(--neon-accent) 24%, transparent),
    0 0 24px color-mix(in srgb, var(--neon-accent) 16%, transparent);
}

/* Platform icon tooltips */
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
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.neon-platform-icon[data-tooltip]:hover::after {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(-8px);
}

/* CTA card variant (dashed border, request style) */
.neon-game-tile--cta {
  border: 2px dashed color-mix(in srgb, var(--foreground) 15%, transparent);
  transition: border-color 0.2s ease, background 0.2s ease;
}

.neon-game-tile--cta:hover {
  border-color: color-mix(in srgb, var(--neon-accent) 32%, transparent);
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
''';

  static const String rainbowCss = '''
/* Rainbow RGB Spin Animation - Scoped to .neon-rainbow */
@keyframes neon-rainbow-colors {
  0%, 100% { --primary: #ff6b6b; --ring: #e55555; } /* Red */
  14% { --primary: #ffa94d; --ring: #e89035; } /* Orange */
  28% { --primary: #ffe066; --ring: #e6c94d; } /* Yellow */
  42% { --primary: #69db7c; --ring: #52c462; } /* Green */
  57% { --primary: #4dabf7; --ring: #3592dd; } /* Blue */
  71% { --primary: #9775fa; --ring: #7d5ce0; } /* Indigo */
  85% { --primary: #e599f7; --ring: #cc7fdd; } /* Violet */
}

@keyframes neon-rainbow-glow {
  0%, 100% { --glow-color: rgba(255, 107, 107, 0.3); }
  14% { --glow-color: rgba(255, 169, 77, 0.3); }
  28% { --glow-color: rgba(255, 224, 102, 0.3); }
  42% { --glow-color: rgba(105, 219, 124, 0.3); }
  57% { --glow-color: rgba(77, 171, 247, 0.3); }
  71% { --glow-color: rgba(151, 117, 250, 0.3); }
  85% { --glow-color: rgba(229, 153, 247, 0.3); }
}

.neon-rainbow {
  animation: neon-rainbow-colors 8s linear infinite;
}

.neon-rainbow.dark {
  --primary-foreground: #000000;
  animation: neon-rainbow-colors 8s linear infinite, neon-rainbow-glow 8s linear infinite;
}

/* Rainbow shadows with glow in dark mode */
.neon-rainbow.dark {
  --shadow-xs: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 0 8px var(--glow-color, rgba(77, 171, 247, 0.15));
  --shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 0 12px var(--glow-color, rgba(77, 171, 247, 0.2));
  --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 0 16px var(--glow-color, rgba(77, 171, 247, 0.25));
  --shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 0 20px var(--glow-color, rgba(77, 171, 247, 0.3));
  --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 0 30px var(--glow-color, rgba(77, 171, 247, 0.35));
  --shadow-xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25), 0 0 50px var(--glow-color, rgba(77, 171, 247, 0.4));
}

/* Rainbow text selection */
.neon-rainbow ::selection {
  background: var(--primary, #4dabf7);
  color: #000000;
}

.neon-rainbow ::-moz-selection {
  background: var(--primary, #4dabf7);
  color: #000000;
}

@media (prefers-reduced-motion: reduce) {
  .neon-rainbow,
  .neon-rainbow.dark {
    animation: none;
  }
}
''';
}
