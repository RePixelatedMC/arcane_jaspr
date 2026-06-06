import 'package:arcane_jaspr/component/navigation/toc.dart'
    show arcaneTocTreeLinesCss;
import 'package:arcane_jaspr/component/view/map/map_style.dart'
    show arcaneMapCss;
import 'package:arcane_jaspr/util/content/prose_styles.dart';

import 'shadcn_theme.dart';

class ShadcnCss {

  const ShadcnCss._();

  static String componentCss(ShadcnTheme theme) {
    String neutralOverrides = theme == ShadcnTheme.midnight
        ? '''
:root, html.light, .light {
  --card: #ffffff;
  --card-foreground: #09090b;
  --popover: #ffffff;
  --popover-foreground: #09090b;
  --muted: #f4f4f5;
  --muted-foreground: #71717a;
  --accent: #f4f4f5;
  --accent-foreground: #18181b;
  --border: #e4e4e7;
  --input: #e4e4e7;
}

html.dark, .dark {
  --background: #050505;
  --foreground: #F7F4EC;
  --card: #111111;
  --card-foreground: #F7F4EC;
  --card-hover: #1A1A1A;
  --popover: #1A1A1A;
  --popover-foreground: #F7F4EC;
  --muted: #111111;
  --muted-foreground: #A8A39A;
  --accent: #1A1A1A;
  --accent-foreground: #F7F4EC;
  --border: #2C2C2C;
  --input: #232323;
}
'''
        : '';

    return '''
$neutralOverrides

.arcane-button,
.arcane-text-input,
.arcane-select,
.arcane-select-option,
.arcane-dropdown-item,
.arcane-context-menu-item,
.arcane-tab,
.arcane-tab-bar-item,
.arcane-menubar-trigger,
.arcane-dialog-close,
.arcane-sheet-close,
.arcane-drawer-close,
.arcane-checkbox,
.arcane-radio-circle,
.arcane-toggle-switch,
.arcane-pagination-link,
.arcane-date-picker-trigger,
.arcane-otp-digit,
.arcane-calendar-day,
.arcane-calendar-nav-btn {
  transition:
    color var(--transition),
    background-color var(--transition),
    border-color var(--transition),
    box-shadow var(--transition),
    opacity var(--transition),
    transform var(--transition);
}

.arcane-button:hover:not(:disabled):not(.disabled),
.arcane-text-input:hover:not(:disabled),
.arcane-select:hover:not(:disabled):not(.disabled),
.arcane-select-option:hover:not(:disabled):not(.disabled),
.arcane-dropdown-item:hover:not(.disabled),
.arcane-context-menu-item:hover:not(.disabled),
.arcane-tab:hover:not(.disabled),
.arcane-tab-bar-item:hover:not(.disabled),
.arcane-menubar-trigger:hover,
.arcane-dialog-close:hover,
.arcane-sheet-close:hover,
.arcane-drawer-close:hover,
.arcane-pagination-link:hover:not(:disabled):not(.disabled),
.arcane-date-picker-trigger:hover:not(:disabled),
.arcane-calendar-day:hover:not(:disabled),
.arcane-calendar-nav-btn:hover:not(:disabled) {
  background-color: var(--accent);
  color: var(--accent-foreground);
}

.arcane-button:focus-visible,
.arcane-text-input:focus-visible,
.arcane-select:focus-visible,
.arcane-select-option:focus-visible,
.arcane-dropdown-item:focus-visible,
.arcane-context-menu-item:focus-visible,
.arcane-tab:focus-visible,
.arcane-tab-bar-item:focus-visible,
.arcane-menubar-trigger:focus-visible,
.arcane-dialog-close:focus-visible,
.arcane-sheet-close:focus-visible,
.arcane-drawer-close:focus-visible,
.arcane-checkbox:focus-visible,
.arcane-radio-input:focus-visible + .arcane-radio-circle,
.arcane-toggle-switch:focus-visible,
.arcane-pagination-link:focus-visible,
.arcane-date-picker-trigger:focus-visible,
.arcane-otp-digit:focus-visible,
.arcane-calendar-day:focus-visible,
.arcane-calendar-nav-btn:focus-visible {
  outline: none;
  box-shadow: 0 0 0 2px var(--background), 0 0 0 4px var(--ring);
}

.arcane-button:disabled,
.arcane-button[data-disabled='true'],
.arcane-button.disabled,
.arcane-text-input:disabled,
.arcane-text-input[data-disabled='true'],
.arcane-select:disabled,
.arcane-select[data-disabled='true'],
.arcane-select.disabled,
.arcane-select-option:disabled,
.arcane-select-option[data-disabled='true'],
.arcane-select-option.disabled,
.arcane-dropdown-item[data-disabled='true'],
.arcane-dropdown-item.disabled,
.arcane-context-menu-item[data-disabled='true'],
.arcane-context-menu-item.disabled,
.arcane-tab[data-disabled='true'],
.arcane-tab.disabled,
.arcane-tab-bar-item[data-disabled='true'],
.arcane-tab-bar-item.disabled,
.arcane-menubar-trigger[data-disabled='true'],
.arcane-checkbox[data-disabled='true'],
.arcane-radio-item[data-disabled='true'],
.arcane-toggle-switch[data-disabled='true'],
.arcane-pagination-link:disabled,
.arcane-pagination-link[data-disabled='true'],
.arcane-pagination-link.disabled,
.arcane-date-picker-trigger:disabled,
.arcane-date-picker-trigger[data-disabled='true'],
.arcane-otp-digit:disabled,
.arcane-otp-digit[data-disabled='true'],
.arcane-calendar-day:disabled,
.arcane-calendar-day[data-disabled='true'],
.arcane-calendar-nav-btn:disabled {
  pointer-events: none;
  opacity: 0.5;
}

.arcane-select[data-open='true'],
.arcane-dropdown-menu[data-state='open'],
.arcane-menubar-trigger[data-state='open'],
.arcane-date-picker-trigger[data-state='open'],
.arcane-tab[data-state='active'],
.arcane-tab-bar-item[data-state='active'],
.arcane-select-option[data-state='checked'],
.arcane-dropdown-item[data-state='checked'],
.arcane-context-menu-item[data-state='checked'],
.arcane-menubar-item[data-state='checked'],
.arcane-checkbox[data-state='checked'],
.arcane-toggle-switch[data-state='checked'] {
  background-color: var(--accent);
  color: var(--accent-foreground);
}

.arcane-select[data-open='true'],
.arcane-date-picker-trigger[data-state='open'],
.arcane-text-input[data-error='true'],
.arcane-select[data-error='true'],
.arcane-otp-digit.error,
.arcane-calendar-day[data-state='selected'] {
  border-color: var(--ring);
}

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
  color: var(--foreground);
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

$arcaneMapCss

$arcaneTocTreeLinesCss

''';
  }
}
