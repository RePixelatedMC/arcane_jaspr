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
   SIDEBAR SECTIONS - ShadCN Visual Styles
   ============================================ */
.sidebar-section-header {
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--muted-foreground);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* Folder summaries - ShadCN visual styling */
.sidebar-summary {
  font-size: 0.8125rem;
  font-weight: 600;
  color: var(--foreground);
  background: transparent;
  border: none;
  border-radius: var(--radius-md, 6px);
  transition: all 0.2s ease;
}

.sidebar-summary:hover {
  background: var(--muted);
  color: var(--foreground);
}

/* Expanded folder - ShadCN subtle highlight */
.sidebar-details[open] > .sidebar-summary {
  background: var(--muted);
  color: var(--foreground);
}

.sidebar-details[open] > .sidebar-summary:hover {
  background: color-mix(in srgb, var(--muted) 150%, transparent);
}

/* Chevron visual styling - ShadCN */
.sidebar-chevron {
  opacity: 0.6;
}

.sidebar-summary:hover .sidebar-chevron {
  opacity: 1;
}

.sidebar-details[open] > .sidebar-summary .sidebar-chevron {
  opacity: 1;
}

/* Nested folder styling - decreasing opacity */
.sidebar-tree .sidebar-summary {
  font-size: 0.8125rem;
  color: var(--muted-foreground);
  opacity: 0.9;
}

.sidebar-tree .sidebar-tree .sidebar-summary {
  opacity: 0.85;
}

.sidebar-tree .sidebar-tree .sidebar-tree .sidebar-summary {
  opacity: 0.8;
}

/* Tree connector colors - ShadCN (var(--border)) */
.sidebar-tree > .sidebar-section::before,
.sidebar-tree > .sidebar-section::after {
  background: var(--border);
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
  color: var(--accent-foreground);
  font-weight: 500;
  background: var(--accent);
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
''';

/// Codex gaming-style sidebar styles.
///
/// Cyberpunk aesthetic with glowing tree lines.
const String arcaneSidebarCodexStyles = '''
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
  background: transparent;
  border: none;
  border-bottom: 1px solid transparent;
}

[class*="codex-"] .sidebar-summary:hover,
.codex .sidebar-summary:hover {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 8%, transparent);
  border: none;
  border-bottom-color: color-mix(in srgb, var(--primary) 20%, transparent);
}

/* TOP-LEVEL expanded folder header - keep the nice folder look */
[class*="codex-"] .sidebar-details[open] > .sidebar-summary,
.codex .sidebar-details[open] > .sidebar-summary {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 12%, transparent);
  border-bottom-color: color-mix(in srgb, var(--primary) 20%, transparent);
  box-shadow:
    0 4px 12px -2px color-mix(in srgb, var(--primary) 25%, transparent),
    inset 0 1px 0 color-mix(in srgb, var(--primary) 15%, transparent);
}

[class*="codex-"] .sidebar-details[open] > .sidebar-summary:hover,
.codex .sidebar-details[open] > .sidebar-summary:hover {
  background: color-mix(in srgb, var(--primary) 18%, transparent);
  box-shadow:
    0 6px 16px -2px color-mix(in srgb, var(--primary) 35%, transparent),
    inset 0 1px 0 color-mix(in srgb, var(--primary) 20%, transparent);
}

/* Divider between folder header and children */
[class*="codex-"] .sidebar-details[open] > .sidebar-tree::before,
.codex .sidebar-details[open] > .sidebar-tree::before {
  content: '';
  display: block;
  height: 1px;
  background: color-mix(in srgb, var(--primary) 25%, transparent);
  margin: 0.375rem 0 0.5rem 0;
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

/* Codex overrides for .sidebar-section connectors (used by arcane_inkwell) */
[class*="codex-"] .sidebar-tree > .sidebar-section::before,
.codex .sidebar-tree > .sidebar-section::before {
  background: var(--primary);
  opacity: 0.6;
  height: 2px;
}

[class*="codex-"] .sidebar-tree > .sidebar-section::after,
.codex .sidebar-tree > .sidebar-section::after {
  background: var(--primary);
  width: 2px;
  box-shadow: 0 0 6px color-mix(in srgb, var(--primary) 30%, transparent);
}

/* Codex nested folders (subfolders) - distinct card-like appearance */
[class*="codex-"] .sidebar-tree .sidebar-section,
.codex .sidebar-tree .sidebar-section {
  margin: 0.25rem 0;
  padding: 0.125rem 0;
  border-radius: var(--radius-md);
  background: color-mix(in srgb, var(--primary) 3%, transparent);
  border: 1px solid color-mix(in srgb, var(--primary) 8%, transparent);
}

[class*="codex-"] .sidebar-tree .sidebar-tree .sidebar-section,
.codex .sidebar-tree .sidebar-tree .sidebar-section {
  background: color-mix(in srgb, var(--primary) 5%, transparent);
  border-color: color-mix(in srgb, var(--primary) 12%, transparent);
}

[class*="codex-"] .sidebar-tree .sidebar-tree .sidebar-tree .sidebar-section,
.codex .sidebar-tree .sidebar-tree .sidebar-tree .sidebar-section {
  background: color-mix(in srgb, var(--primary) 7%, transparent);
  border-color: color-mix(in srgb, var(--primary) 15%, transparent);
}

/* Codex nested summaries - subfolder headers - smaller, with proper spacing */
[class*="codex-"] .sidebar-tree .sidebar-details .sidebar-summary,
[class*="codex-"] .sidebar-tree-items .sidebar-details .sidebar-summary,
.codex .sidebar-tree .sidebar-details .sidebar-summary,
.codex .sidebar-tree-items .sidebar-details .sidebar-summary {
  font-family: var(--font-mono);
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--muted-foreground);
  border-bottom: none;
  border-left: 3px solid color-mix(in srgb, var(--primary) 30%, transparent);
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
  margin: 0.125rem 0;
  padding: 0.375rem 0.625rem;
  padding-left: 1rem;
  gap: 0.5rem;
}

[class*="codex-"] .sidebar-tree .sidebar-details .sidebar-summary:hover,
[class*="codex-"] .sidebar-tree-items .sidebar-details .sidebar-summary:hover,
.codex .sidebar-tree .sidebar-details .sidebar-summary:hover,
.codex .sidebar-tree-items .sidebar-details .sidebar-summary:hover {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 10%, transparent);
  border-left-color: color-mix(in srgb, var(--primary) 60%, transparent);
}

/* Subfolder expanded - NO glow/selected look, just subtle indicator */
[class*="codex-"] .sidebar-tree .sidebar-details[open] > .sidebar-summary,
[class*="codex-"] .sidebar-tree-items .sidebar-details[open] > .sidebar-summary,
.codex .sidebar-tree .sidebar-details[open] > .sidebar-summary,
.codex .sidebar-tree-items .sidebar-details[open] > .sidebar-summary {
  color: var(--foreground);
  border-left-color: var(--primary);
  background: transparent;
  box-shadow: none;
}

/* Codex nested tree content - more indentation and visual separation */
[class*="codex-"] .sidebar-tree .sidebar-tree,
.codex .sidebar-tree .sidebar-tree {
  padding-left: 1rem;
  margin-left: 0.375rem;
  border-left: 1px solid color-mix(in srgb, var(--primary) 20%, transparent);
}

[class*="codex-"] .sidebar-tree .sidebar-tree .sidebar-tree,
.codex .sidebar-tree .sidebar-tree .sidebar-tree {
  border-left-color: color-mix(in srgb, var(--primary) 15%, transparent);
}

/* Codex nested items - smaller, with proper left padding */
[class*="codex-"] .sidebar-tree .sidebar-link,
.codex .sidebar-tree .sidebar-link {
  font-size: 0.8125rem;
  padding: 0.375rem 0.625rem;
  padding-left: 1rem;
  margin: 0.125rem 0;
  border-left: 2px solid transparent;
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
''';

/// ArcaneSidebar component tree-line styles.
///
/// Tree-line styling for ArcaneSidebar components.
const String arcaneSidebarComponentStyles = '''
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

/// All sidebar styles combined.
const String arcaneAllSidebarStyles = '''
$arcaneSidebarTreeStyles

$arcaneSidebarCodexStyles

$arcaneSidebarComponentStyles
''';
