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
const String arcaneSidebarTreeStyles = '''
/* ============================================
   SIDEBAR NAVIGATION - Tree Lines
   Supports leaves (links) and folders (disclosures)
   ============================================ */
.sidebar-tree-nav {
  position: relative;
}

.sidebar-tree-items {
  position: relative;
  padding-left: 1.25rem;
  margin-left: 0.25rem;
}

.sidebar-tree-items::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--border);
}

.sidebar-tree-items > .sidebar-tree-item:first-child::after {
  content: '';
  position: absolute;
  left: -1.25rem;
  top: 0;
  height: 1rem;
  width: 1px;
  background: var(--background);
}

.sidebar-tree-items > .sidebar-tree-item:last-child::after {
  content: '';
  position: absolute;
  left: -1.25rem;
  bottom: 0;
  top: 1rem;
  width: 1px;
  background: var(--background);
}

.sidebar-tree-items:has(> .sidebar-tree-item:only-child)::before {
  display: none;
}

.sidebar-tree-items > .sidebar-tree-item:only-child::after {
  display: none;
}

.sidebar-tree-item {
  position: relative;
}

/* Leaf items (links) */
.sidebar-tree-leaf::before {
  content: '';
  position: absolute;
  left: -1.25rem;
  top: 1rem;
  width: 1rem;
  height: 1px;
  background: var(--border);
}

.sidebar-tree-leaf:only-child::before {
  width: 5px;
  height: 5px;
  border-radius: 50%;
  top: calc(1rem - 2.5px);
  left: calc(-0.75rem - 2.5px);
}

/* Folder items (disclosures) */
.sidebar-tree-folder {
  position: relative;
}

.sidebar-tree-folder::before {
  content: '';
  position: absolute;
  left: -1.25rem;
  top: 0.875rem;
  width: 0.75rem;
  height: 1px;
  background: var(--border);
}

.sidebar-tree-folder:only-child::before {
  width: 0.5rem;
  height: 1px;
  border-radius: 0;
  top: 0.875rem;
  left: -0.75rem;
}

.sidebar-tree-folder > details {
  position: relative;
}

.sidebar-tree-folder > details::before {
  content: '';
  position: absolute;
  left: -0.5rem;
  top: 1.25rem;
  bottom: 0.5rem;
  width: 1px;
  background: var(--border);
}

.sidebar-tree-folder > details:not([open])::before {
  display: none;
}

/* Nested depth styling */
.sidebar-tree-items .sidebar-tree-items::before {
  background: color-mix(in srgb, var(--border) 60%, transparent);
}

.sidebar-tree-items .sidebar-tree-items .sidebar-tree-item::before {
  background: color-mix(in srgb, var(--border) 60%, transparent);
}

.sidebar-tree-items .sidebar-tree-items .sidebar-tree-item::after {
  background: var(--background);
}

.sidebar-tree-items .sidebar-tree-items .sidebar-tree-items::before {
  background: color-mix(in srgb, var(--border) 40%, transparent);
}

.sidebar-tree-items .sidebar-tree-items .sidebar-tree-items .sidebar-tree-item::before {
  background: color-mix(in srgb, var(--border) 40%, transparent);
}

/* No tree lines variant */
.sidebar-tree-items.no-tree-lines::before,
.sidebar-tree-items.no-tree-lines .sidebar-tree-item::before,
.sidebar-tree-items.no-tree-lines .sidebar-tree-item::after,
.sidebar-tree-items.no-tree-lines .sidebar-tree-folder > details::before {
  display: none;
}

/* Sidebar hover */
aside a:hover {
  background: var(--muted) !important;
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
