/// Complete prose CSS styles for markdown content.
///
/// Include this in your stylesheet's baseCss for prose styling:
/// ```dart
/// @override
/// String get baseCss => '''
/// ${super.baseCss}
/// $arcaneProseStyles
/// ''';
/// ```
const String arcaneProseStyles = '''
/* ============================================
   PROSE CONTENT STYLES
   Typography for markdown/documentation
   ============================================ */
.prose {
  max-width: 65ch;
  color: var(--foreground);
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
.prose h4 { font-size: 1rem; }

.prose p {
  color: var(--muted-foreground);
  margin-bottom: 1rem;
}

.prose li {
  color: var(--muted-foreground);
  margin-bottom: 0.25rem;
}

.prose a {
  color: var(--primary);
  text-decoration: none;
  transition: color var(--arcane-transition-fast);
}

.prose a:hover {
  color: var(--primary);
  text-decoration: underline;
  opacity: 0.8;
}

.prose strong, .prose b {
  color: var(--foreground);
  font-weight: 600;
}

.prose em {
  font-style: italic;
}

.prose ul, .prose ol {
  margin-bottom: 1rem;
  padding-left: 1.5rem;
}

.prose li::marker {
  color: var(--muted-foreground);
}

.prose blockquote {
  border-left: 4px solid var(--border);
  padding-left: 1rem;
  margin: 1rem 0;
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
  margin: 1rem 0;
}

.prose th, .prose td {
  border: 1px solid var(--border);
  padding: 0.75rem;
  text-align: left;
}

.prose th {
  background-color: var(--muted);
  color: var(--foreground);
  font-weight: 600;
}

.prose td {
  color: var(--muted-foreground);
}

.prose img {
  max-width: 100%;
  height: auto;
  border-radius: var(--arcane-radius-md);
}
''';

/// Prose code block styles with syntax highlighting.
///
/// Includes styles for both light and dark modes using
/// GitHub-inspired color schemes.
const String arcaneProseCodeStyles = '''
/* ============================================
   PROSE CODE BLOCK STYLES
   Syntax highlighting for code
   ============================================ */
.prose pre {
  background-color: oklch(0.97 0 0);
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 16px 20px;
  overflow-x: auto;
  margin: 1.5rem 0;
  position: relative;
}

/* Dark mode code blocks */
.dark .prose pre {
  background-color: oklch(0.145 0 0);
}

.prose code {
  font-family: var(--font-mono);
  font-size: 13px;
  line-height: 1.7;
  color: #c9d1d9;
}

/* Light mode code text */
:not(.dark) .prose code {
  color: #24292f;
}

/* Vibrant syntax highlighting - Dark mode (GitHub Dark inspired) */
.dark .prose pre code {
  color: #c9d1d9;
}

.dark .prose .hljs-keyword,
.dark .prose .hljs-selector-tag,
.dark .prose .hljs-literal,
.dark .prose .hljs-section,
.dark .prose .hljs-link {
  color: #ff7b72;
}

.dark .prose .hljs-string,
.dark .prose .hljs-attr {
  color: #a5d6ff;
}

.dark .prose .hljs-number,
.dark .prose .hljs-type {
  color: #79c0ff;
}

.dark .prose .hljs-function,
.dark .prose .hljs-title {
  color: #d2a8ff;
}

.dark .prose .hljs-comment {
  color: #8b949e;
  font-style: italic;
}

.dark .prose .hljs-variable,
.dark .prose .hljs-params {
  color: #ffa657;
}

.dark .prose .hljs-class,
.dark .prose .hljs-built_in {
  color: #7ee787;
}

/* Vibrant syntax highlighting - Light mode (GitHub Light inspired) */
.prose pre code {
  color: #24292f;
}

.prose .hljs-keyword,
.prose .hljs-selector-tag,
.prose .hljs-literal,
.prose .hljs-section,
.prose .hljs-link {
  color: #cf222e;
}

.prose .hljs-string,
.prose .hljs-attr {
  color: #0a3069;
}

.prose .hljs-number,
.prose .hljs-type {
  color: #0550ae;
}

.prose .hljs-function,
.prose .hljs-title {
  color: #8250df;
}

.prose .hljs-comment {
  color: #6e7781;
  font-style: italic;
}

.prose .hljs-variable,
.prose .hljs-params {
  color: #953800;
}

.prose .hljs-class,
.prose .hljs-built_in {
  color: #116329;
}

/* Inline code - Light mode (default) */
.prose :not(pre) > code {
  background-color: rgba(175, 184, 193, 0.3);
  color: #1f2328;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.875em;
  font-weight: 500;
}

/* Inline code - Dark mode */
.dark .prose :not(pre) > code {
  background-color: rgba(110, 118, 129, 0.4);
  color: #e6edf3;
}
''';

/// Code block copy button styles.
const String arcaneCodeCopyButtonStyles = '''
/* Code block copy button */
.code-wrapper {
  position: relative;
}

.code-copy-button {
  position: absolute;
  top: 12px;
  right: 12px;
  padding: 6px 10px;
  background: var(--muted);
  border: 1px solid var(--border);
  border-radius: var(--arcane-radius-sm);
  color: var(--muted-foreground);
  font-size: 12px;
  cursor: pointer;
  opacity: 0;
  transition: all 0.15s ease;
}

.code-wrapper:hover .code-copy-button {
  opacity: 0.8;
}

.code-copy-button:hover {
  opacity: 1 !important;
  background: var(--accent);
  color: var(--foreground);
}

.code-copy-button.copied {
  color: var(--success, #22c55e);
  opacity: 1 !important;
}
''';

/// Callout/admonition block styles.
///
/// Provides styles for note, tip, important, warning, and caution blocks.
const String arcaneCalloutStyles = '''
/* Callout/Admonition blocks */
.callout {
  margin: 1rem 0;
  padding: 1rem;
  border-radius: var(--arcane-radius-md);
  border-left: 4px solid;
}

.callout-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
}

.callout-icon {
  display: flex;
  align-items: center;
}

.callout-content {
  font-size: 0.875rem;
  line-height: 1.6;
}

/* Note - Blue */
.callout-note {
  background: rgba(59, 130, 246, 0.1);
  border-color: #3b82f6;
}
.callout-note .callout-title { color: #3b82f6; }

/* Tip - Green */
.callout-tip {
  background: rgba(34, 197, 94, 0.1);
  border-color: #22c55e;
}
.callout-tip .callout-title { color: #22c55e; }

/* Important - Purple */
.callout-important {
  background: rgba(168, 85, 247, 0.1);
  border-color: #a855f7;
}
.callout-important .callout-title { color: #a855f7; }

/* Warning - Yellow/Orange */
.callout-warning {
  background: rgba(234, 179, 8, 0.1);
  border-color: #eab308;
}
.callout-warning .callout-title { color: #eab308; }

/* Caution - Red */
.callout-caution {
  background: rgba(239, 68, 68, 0.1);
  border-color: #ef4444;
}
.callout-caution .callout-title { color: #ef4444; }
''';

/// Sidebar tree-line navigation styles.
///
/// Provides visual tree connectors for hierarchical navigation.
/// Uses proper ::before for horizontal branches and ::after for vertical lines
/// with correct last-child handling for the L-bend effect.
const String arcaneSidebarTreeStyles = '''
/* ============================================
   SIDEBAR HEADER & BRAND - ShadCN Style (Default)
   Clean, minimal design with clear hierarchy
   ============================================ */
.sidebar-header {
  padding: 1rem;
  border-bottom: 1px solid var(--border);
  display: flex;
  flex-direction: column;
  gap: 0.875rem;
}

.sidebar-brand {
  padding-bottom: 0;
}

.sidebar-brand-link {
  text-decoration: none;
}

.sidebar-brand-title {
  font-weight: 700;
  font-size: 1.0625rem;
  color: var(--foreground);
  letter-spacing: -0.01em;
  line-height: 1.2;
}

.sidebar-brand-subtitle {
  font-size: 0.6875rem;
  color: var(--muted-foreground);
  margin-top: 0.125rem;
  letter-spacing: 0.02em;
}

/* Navigation tabs */
.sidebar-tabs {
  display: flex;
  gap: 0.25rem;
  padding: 0.25rem;
  background: var(--muted);
  border-radius: var(--radius-md);
}

.sidebar-tab {
  flex: 1;
  padding: 0.375rem 0.5rem;
  font-size: 0.75rem;
  font-weight: 500;
  color: var(--muted-foreground);
  text-decoration: none;
  text-align: center;
  border-radius: calc(var(--radius-md) - 2px);
  transition: color 0.15s ease, background 0.15s ease;
}

.sidebar-tab:hover {
  color: var(--foreground);
}

.sidebar-tab.active {
  background: var(--background);
  color: var(--foreground);
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

/* Search and controls row */
.sidebar-controls {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.sidebar-search {
  flex: 1;
  position: relative;
}

.sidebar-search input {
  width: 100%;
  padding: 0.5rem 0.75rem 0.5rem 2rem;
  font-size: 0.8125rem;
  color: var(--foreground);
  background: var(--muted);
  border: 1px solid transparent;
  border-radius: var(--radius-md);
  outline: none;
  transition: border-color 0.15s ease, background 0.15s ease;
}

.sidebar-search input::placeholder {
  color: var(--muted-foreground);
}

.sidebar-search input:focus {
  border-color: var(--ring);
  background: var(--background);
}

.sidebar-search .search-icon {
  position: absolute;
  left: 0.625rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--muted-foreground);
  pointer-events: none;
}

/* Theme toggle button */
.sidebar-theme-toggle {
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--muted);
  border: none;
  border-radius: var(--radius-md);
  color: var(--muted-foreground);
  cursor: pointer;
  transition: color 0.15s ease, background 0.15s ease;
}

.sidebar-theme-toggle:hover {
  color: var(--foreground);
  background: color-mix(in srgb, var(--muted) 150%, transparent);
}

/* Show/hide icons based on theme */
.dark .theme-icon-dark { display: none; }
.dark .theme-icon-light { display: block; }
:not(.dark) .theme-icon-dark { display: block; }
:not(.dark) .theme-icon-light { display: none; }

/* ============================================
   SIDEBAR SECTIONS
   ============================================ */
.sidebar-section {
  margin-bottom: 0.75rem;
}

.sidebar-section-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.375rem 0.5rem;
  font-size: 0.6875rem;
  font-weight: 600;
  color: var(--foreground);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* ============================================
   SIDEBAR NAVIGATION - Tree Lines
   Supports leaves (links) and folders (disclosures)
   ============================================ */
.sidebar-tree-nav {
  position: relative;
}

.sidebar-tree {
  position: relative;
  display: flex;
  flex-direction: column;
  padding-left: 0.75rem;
  margin-left: 0.5rem;
  margin-top: 0.25rem;
}

.sidebar-tree-items {
  position: relative;
  display: flex;
  flex-direction: column;
  padding-left: 0.75rem;
  margin-left: 0.5rem;
  margin-top: 0.25rem;
}

/* Tree item with horizontal branch and vertical connector */
.sidebar-tree-item {
  position: relative;
}

/* Horizontal branch line */
.sidebar-tree-item::before {
  content: '';
  position: absolute;
  left: -0.75rem;
  top: 50%;
  width: 0.5rem;
  height: 1px;
  background: var(--border);
}

/* Vertical line segment - connects this item to the next (not on last item) */
.sidebar-tree-item:not(:last-child)::after {
  content: '';
  position: absolute;
  left: -0.75rem;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--border);
}

/* First item extends vertical line up to connect to parent */
.sidebar-tree-item:first-child::after {
  top: 0;
}

/* Last item only draws vertical line from top to center (L-bend) */
.sidebar-tree-item:last-child::after {
  content: '';
  position: absolute;
  left: -0.75rem;
  top: 0;
  height: 50%;
  width: 1px;
  background: var(--border);
}

/* Single child - hide tree lines, show dot */
.sidebar-tree-items:has(> .sidebar-tree-item:only-child) > .sidebar-tree-item::before,
.sidebar-tree-items:has(> .sidebar-tree-item:only-child) > .sidebar-tree-item::after {
  display: none;
}

/* Nested details within tree - inherits tree styling */
.sidebar-tree .sidebar-details,
.sidebar-tree-items .sidebar-details {
  margin-left: -0.75rem;
}

.sidebar-tree .sidebar-details .sidebar-summary,
.sidebar-tree-items .sidebar-details .sidebar-summary {
  padding: 0.25rem 0.5rem;
  font-size: 0.75rem;
  font-weight: 500;
  text-transform: none;
  letter-spacing: normal;
}

.sidebar-tree .sidebar-details .sidebar-tree,
.sidebar-tree-items .sidebar-details .sidebar-tree-items {
  margin-left: 0.5rem;
  padding-left: 0.75rem;
  margin-top: 0;
}

/* Navigation link styling */
.sidebar-link {
  display: block;
  padding: 0.375rem 0.625rem;
  font-size: 0.8125rem;
  color: var(--muted-foreground);
  text-decoration: none;
  border-radius: var(--radius-sm);
  transition: color 0.15s ease, background 0.15s ease;
}

.sidebar-link:hover {
  color: var(--foreground);
  background: var(--muted);
}

/* Active state */
.sidebar-link.active {
  color: var(--foreground);
  font-weight: 500;
  background: var(--muted);
}

/* Collapsible section styles */
.sidebar-details {
  border: none;
}

.sidebar-details > summary {
  list-style: none;
}

.sidebar-details > summary::-webkit-details-marker {
  display: none;
}

.sidebar-summary {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 0.75rem;
  font-size: 0.75rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.025em;
  color: var(--muted-foreground);
  cursor: pointer;
  border-radius: var(--radius-sm);
  transition: color 0.15s ease, background 0.15s ease;
  user-select: none;
}

.sidebar-summary:hover {
  color: var(--foreground);
  background: var(--muted);
}

/* Chevron icon for collapsible */
.sidebar-chevron {
  margin-left: auto;
  width: 14px;
  height: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.15s ease;
}

.sidebar-chevron::before {
  content: '';
  width: 5px;
  height: 5px;
  border-right: 1.5px solid var(--muted-foreground);
  border-bottom: 1.5px solid var(--muted-foreground);
  transform: rotate(-45deg);
  transition: transform 0.15s ease;
}

.sidebar-details[open] .sidebar-chevron::before {
  transform: rotate(45deg);
}

/* Nested depth styling - fading lines */
.sidebar-tree-items .sidebar-tree-items .sidebar-tree-item::before,
.sidebar-tree-items .sidebar-tree-items .sidebar-tree-item::after {
  background: color-mix(in srgb, var(--border) 70%, transparent);
}

.sidebar-tree-items .sidebar-tree-items .sidebar-tree-items .sidebar-tree-item::before,
.sidebar-tree-items .sidebar-tree-items .sidebar-tree-items .sidebar-tree-item::after {
  background: color-mix(in srgb, var(--border) 50%, transparent);
}

/* No tree lines variant */
.sidebar-tree-items.no-tree-lines .sidebar-tree-item::before,
.sidebar-tree-items.no-tree-lines .sidebar-tree-item::after,
.sidebar-tree-items.no-tree-lines .sidebar-details::before {
  display: none;
}

/* Sidebar hover enhancement */
aside a:hover {
  background: var(--muted) !important;
}

/* ============================================
   SIDEBAR NAVIGATION - Codex Gaming Style
   Cyberpunk with glowing tree lines
   ============================================ */

/* Codex sidebar header - gradient with glow */
[class*="codex-"] .sidebar-header,
.codex .sidebar-header {
  padding: 0;
  gap: 0;
  border-bottom: none;
  background: transparent;
}

[class*="codex-"] .sidebar-brand,
.codex .sidebar-brand {
  padding: 1rem 1rem 0.75rem;
  background: linear-gradient(180deg, color-mix(in srgb, var(--primary) 8%, transparent) 0%, transparent 100%);
  border-bottom: 2px solid var(--primary);
  box-shadow: 0 2px 12px color-mix(in srgb, var(--primary) 15%, transparent);
}

[class*="codex-"] .sidebar-brand-title,
.codex .sidebar-brand-title {
  font-size: 1.125rem;
  background: linear-gradient(135deg, var(--foreground) 0%, var(--primary) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

[class*="codex-"] .sidebar-brand-subtitle,
.codex .sidebar-brand-subtitle {
  font-family: var(--font-mono);
  letter-spacing: 0.15em;
  text-transform: uppercase;
  font-size: 0.5rem;
  color: var(--primary);
  opacity: 0.8;
  margin-top: 0.25rem;
}

[class*="codex-"] .sidebar-brand-subtitle::before,
.codex .sidebar-brand-subtitle::before {
  content: '// ';
  opacity: 0.5;
}

/* Codex tabs - vertical command list style */
[class*="codex-"] .sidebar-tabs,
.codex .sidebar-tabs {
  flex-direction: column;
  padding: 0.5rem 0;
  background: transparent;
  border-radius: 0;
  gap: 0;
  border-bottom: 1px solid color-mix(in srgb, var(--primary) 20%, transparent);
}

[class*="codex-"] .sidebar-tab,
.codex .sidebar-tab {
  font-family: var(--font-mono);
  letter-spacing: 0.08em;
  font-size: 0.625rem;
  text-transform: uppercase;
  padding: 0.5rem 1rem;
  border-radius: 0;
  text-align: left;
  border-left: 3px solid transparent;
  transition: all 0.15s ease;
}

[class*="codex-"] .sidebar-tab::before,
.codex .sidebar-tab::before {
  content: '> ';
  opacity: 0.4;
}

[class*="codex-"] .sidebar-tab:hover,
.codex .sidebar-tab:hover {
  background: color-mix(in srgb, var(--primary) 8%, transparent);
  border-left-color: color-mix(in srgb, var(--primary) 50%, transparent);
  color: var(--primary);
}

[class*="codex-"] .sidebar-tab.active,
.codex .sidebar-tab.active {
  background: color-mix(in srgb, var(--primary) 12%, transparent);
  color: var(--primary);
  border-left-color: var(--primary);
  box-shadow:
    inset 0 0 20px color-mix(in srgb, var(--primary) 10%, transparent),
    0 0 8px color-mix(in srgb, var(--primary) 8%, transparent);
}

[class*="codex-"] .sidebar-tab.active::before,
.codex .sidebar-tab.active::before {
  content: '>> ';
  opacity: 1;
}

/* Codex controls - compact row with terminal feel */
[class*="codex-"] .sidebar-controls,
.codex .sidebar-controls {
  padding: 0.625rem 0.75rem;
  background: color-mix(in srgb, var(--primary) 3%, transparent);
  border-bottom: 1px solid color-mix(in srgb, var(--primary) 15%, transparent);
}

[class*="codex-"] .sidebar-search input,
.codex .sidebar-search input {
  font-family: var(--font-mono);
  font-size: 0.75rem;
  border: 1px solid color-mix(in srgb, var(--primary) 20%, transparent);
  background: color-mix(in srgb, var(--primary) 5%, var(--muted));
}

[class*="codex-"] .sidebar-search input::placeholder,
.codex .sidebar-search input::placeholder {
  font-family: var(--font-mono);
  letter-spacing: 0.05em;
}

[class*="codex-"] .sidebar-search input:focus,
.codex .sidebar-search input:focus {
  border-color: var(--primary);
  box-shadow:
    0 0 8px color-mix(in srgb, var(--primary) 20%, transparent),
    inset 0 0 8px color-mix(in srgb, var(--primary) 5%, transparent);
}

[class*="codex-"] .sidebar-theme-toggle,
.codex .sidebar-theme-toggle {
  border: 1px solid color-mix(in srgb, var(--primary) 20%, transparent);
  background: color-mix(in srgb, var(--primary) 5%, var(--muted));
}

[class*="codex-"] .sidebar-theme-toggle:hover,
.codex .sidebar-theme-toggle:hover {
  color: var(--primary);
  border-color: var(--primary);
  box-shadow: 0 0 8px color-mix(in srgb, var(--primary) 25%, transparent);
}

[class*="codex-"] .sidebar-section-header,
.codex .sidebar-section-header {
  font-family: var(--font-mono);
  color: var(--primary);
  border-bottom: 1px solid color-mix(in srgb, var(--primary) 15%, transparent);
  padding-bottom: 0.5rem;
  margin-bottom: 0.25rem;
}

[class*="codex-"] .sidebar-summary,
.codex .sidebar-summary {
  font-family: var(--font-mono);
  color: var(--muted-foreground);
  border-bottom: 1px solid transparent;
}

[class*="codex-"] .sidebar-summary:hover,
.codex .sidebar-summary:hover {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 8%, transparent);
  border-bottom-color: color-mix(in srgb, var(--primary) 20%, transparent);
}

[class*="codex-"] .sidebar-details[open] > .sidebar-summary,
.codex .sidebar-details[open] > .sidebar-summary {
  color: var(--primary);
  border-bottom-color: color-mix(in srgb, var(--primary) 20%, transparent);
}

/* Codex chevron - glowing */
[class*="codex-"] .sidebar-chevron::before,
.codex .sidebar-chevron::before {
  border-color: var(--primary);
  opacity: 0.6;
}

[class*="codex-"] .sidebar-details[open] .sidebar-chevron::before,
.codex .sidebar-details[open] .sidebar-chevron::before {
  opacity: 1;
}

/* Codex tree lines - glowing primary color */
[class*="codex-"] .sidebar-tree-item::before,
.codex .sidebar-tree-item::before {
  background: var(--primary);
  opacity: 0.6;
  height: 2px;
}

[class*="codex-"] .sidebar-tree-item:not(:last-child)::after,
.codex .sidebar-tree-item:not(:last-child)::after {
  background: var(--primary);
  width: 2px;
  box-shadow: 0 0 6px color-mix(in srgb, var(--primary) 30%, transparent);
}

[class*="codex-"] .sidebar-tree-item:last-child::after,
.codex .sidebar-tree-item:last-child::after {
  background: var(--primary);
  width: 2px;
  box-shadow: 0 0 6px color-mix(in srgb, var(--primary) 30%, transparent);
}

/* Codex nested summaries */
[class*="codex-"] .sidebar-tree .sidebar-details .sidebar-summary,
[class*="codex-"] .sidebar-tree-items .sidebar-details .sidebar-summary,
.codex .sidebar-tree .sidebar-details .sidebar-summary,
.codex .sidebar-tree-items .sidebar-details .sidebar-summary {
  font-family: var(--font-mono);
  color: var(--muted-foreground);
  border-bottom: none;
  border-left: 2px solid transparent;
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
}

[class*="codex-"] .sidebar-tree .sidebar-details .sidebar-summary:hover,
[class*="codex-"] .sidebar-tree-items .sidebar-details .sidebar-summary:hover,
.codex .sidebar-tree .sidebar-details .sidebar-summary:hover,
.codex .sidebar-tree-items .sidebar-details .sidebar-summary:hover {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 8%, transparent);
  border-left-color: color-mix(in srgb, var(--primary) 50%, transparent);
}

[class*="codex-"] .sidebar-tree .sidebar-details[open] > .sidebar-summary,
[class*="codex-"] .sidebar-tree-items .sidebar-details[open] > .sidebar-summary,
.codex .sidebar-tree .sidebar-details[open] > .sidebar-summary,
.codex .sidebar-tree-items .sidebar-details[open] > .sidebar-summary {
  color: var(--primary);
  border-left-color: var(--primary);
}

/* Codex link styling - straight left edge */
[class*="codex-"] .sidebar-link,
.codex .sidebar-link {
  padding: 0.5rem 0.75rem;
  border-left: 3px solid transparent;
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease;
}

[class*="codex-"] .sidebar-link:hover,
.codex .sidebar-link:hover {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 10%, transparent);
  border-left-color: color-mix(in srgb, var(--primary) 50%, transparent);
}

/* Codex active state - prominent glow */
[class*="codex-"] .sidebar-link.active,
.codex .sidebar-link.active {
  color: var(--primary);
  font-weight: 600;
  background: color-mix(in srgb, var(--primary) 15%, transparent);
  border-left-color: var(--primary);
  box-shadow:
    inset 0 0 20px color-mix(in srgb, var(--primary) 12%, transparent),
    0 0 10px color-mix(in srgb, var(--primary) 8%, transparent);
}

/* ============================================
   ARCANE SIDEBAR COMPONENTS - Tree Lines
   Tree-line styling for ArcaneSidebar components
   ============================================ */

/* Submenu content and group items containers get tree-line treatment */
.arcane-sidebar-submenu-content,
.arcane-sidebar-group-items {
  position: relative;
  display: flex;
  flex-direction: column;
}

/* Each sidebar item in a submenu or group gets tree connectors */
.arcane-sidebar-submenu-content > .arcane-sidebar-item,
.arcane-sidebar-group-items > .arcane-sidebar-item {
  position: relative;
}

/* Horizontal branch line */
.arcane-sidebar-submenu-content > .arcane-sidebar-item::before,
.arcane-sidebar-group-items > .arcane-sidebar-item::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  width: 0.5rem;
  height: 1px;
  background: var(--border);
}

/* Vertical line segment - connects this item to the next */
.arcane-sidebar-submenu-content > .arcane-sidebar-item:not(:last-child)::after,
.arcane-sidebar-group-items > .arcane-sidebar-item:not(:last-child)::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--border);
}

/* Last item - L-bend connector */
.arcane-sidebar-submenu-content > .arcane-sidebar-item:last-child::after,
.arcane-sidebar-group-items > .arcane-sidebar-item:last-child::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  height: 50%;
  width: 1px;
  background: var(--border);
}

/* Single child - hide tree lines */
.arcane-sidebar-submenu-content:has(> .arcane-sidebar-item:only-child) > .arcane-sidebar-item::before,
.arcane-sidebar-submenu-content:has(> .arcane-sidebar-item:only-child) > .arcane-sidebar-item::after,
.arcane-sidebar-group-items:has(> .arcane-sidebar-item:only-child) > .arcane-sidebar-item::before,
.arcane-sidebar-group-items:has(> .arcane-sidebar-item:only-child) > .arcane-sidebar-item::after {
  display: none;
}

/* Adjust padding to accommodate tree lines */
.arcane-sidebar-submenu-content > .arcane-sidebar-item,
.arcane-sidebar-group-items > .arcane-sidebar-item {
  padding-left: 1rem !important;
}

/* Codex styling for ArcaneSidebar tree lines */
[class*="codex-"] .arcane-sidebar-submenu-content > .arcane-sidebar-item::before,
[class*="codex-"] .arcane-sidebar-group-items > .arcane-sidebar-item::before,
.codex .arcane-sidebar-submenu-content > .arcane-sidebar-item::before,
.codex .arcane-sidebar-group-items > .arcane-sidebar-item::before {
  background: var(--primary);
  opacity: 0.6;
  height: 2px;
}

[class*="codex-"] .arcane-sidebar-submenu-content > .arcane-sidebar-item:not(:last-child)::after,
[class*="codex-"] .arcane-sidebar-group-items > .arcane-sidebar-item:not(:last-child)::after,
.codex .arcane-sidebar-submenu-content > .arcane-sidebar-item:not(:last-child)::after,
.codex .arcane-sidebar-group-items > .arcane-sidebar-item:not(:last-child)::after {
  background: var(--primary);
  width: 2px;
  box-shadow: 0 0 6px color-mix(in srgb, var(--primary) 30%, transparent);
}

[class*="codex-"] .arcane-sidebar-submenu-content > .arcane-sidebar-item:last-child::after,
[class*="codex-"] .arcane-sidebar-group-items > .arcane-sidebar-item:last-child::after,
.codex .arcane-sidebar-submenu-content > .arcane-sidebar-item:last-child::after,
.codex .arcane-sidebar-group-items > .arcane-sidebar-item:last-child::after {
  background: var(--primary);
  width: 2px;
  box-shadow: 0 0 6px color-mix(in srgb, var(--primary) 30%, transparent);
}

/* Codex link styling for ArcaneSidebar items */
[class*="codex-"] .arcane-sidebar-item,
.codex .arcane-sidebar-item {
  border-left: 3px solid transparent;
  border-radius: 0 var(--radius-md) var(--radius-md) 0 !important;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease;
}

[class*="codex-"] .arcane-sidebar-item:hover,
.codex .arcane-sidebar-item:hover {
  color: var(--primary) !important;
  background: color-mix(in srgb, var(--primary) 10%, transparent) !important;
  border-left-color: color-mix(in srgb, var(--primary) 50%, transparent);
}

[class*="codex-"] .arcane-sidebar-item.selected,
.codex .arcane-sidebar-item.selected {
  color: var(--primary) !important;
  font-weight: 600;
  background: color-mix(in srgb, var(--primary) 15%, transparent) !important;
  border-left-color: var(--primary);
  box-shadow:
    inset 0 0 20px color-mix(in srgb, var(--primary) 12%, transparent),
    0 0 10px color-mix(in srgb, var(--primary) 8%, transparent);
}
''';

/// All documentation styles combined.
///
/// Use this to include all prose and documentation styles at once.
const String arcaneAllDocsStyles = '''
$arcaneProseStyles

$arcaneProseCodeStyles

$arcaneCodeCopyButtonStyles

$arcaneCalloutStyles

$arcaneSidebarTreeStyles
''';
