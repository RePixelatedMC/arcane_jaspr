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
