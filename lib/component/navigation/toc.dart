import 'package:jaspr/jaspr.dart';

import '../html/div.dart';
import '../html/arcane_link.dart';
import '../html/arcane_text.dart';
import '../../util/arcane.dart';
import '../../util/style_types/index.dart';

/// Represents a heading entry for the table of contents.
class TocEntry {
  /// The unique ID for the heading (used for anchor links).
  final String id;

  /// The display text of the heading.
  final String text;

  /// The depth level (1-6 corresponding to h1-h6).
  final int depth;

  /// Child entries for nested headings.
  final List<TocEntry> children;

  const TocEntry({
    required this.id,
    required this.text,
    required this.depth,
    this.children = const [],
  });

  /// Create a TocEntry from a map (for JSON deserialization).
  factory TocEntry.fromJson(Map<String, dynamic> json) {
    return TocEntry(
      id: json['id'] as String,
      text: json['text'] as String,
      depth: json['depth'] as int? ?? 2,
      children: (json['children'] as List<dynamic>?)
              ?.map((dynamic e) => TocEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  /// Convert to JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'depth': depth,
        'children': children.map((TocEntry e) => e.toJson()).toList(),
      };
}

/// A table of contents component for documentation pages.
///
/// Displays a hierarchical list of headings with anchor links.
/// Supports tree-line visual connectors and active state highlighting.
class ArcaneToc extends StatelessComponent {
  /// The list of TOC entries to display.
  final List<TocEntry> entries;

  /// Title displayed above the TOC.
  final String title;

  /// Whether to show tree-line connectors.
  final bool showTreeLines;

  /// CSS class prefix for customization.
  final String classPrefix;

  /// Optional component to wrap around the TOC content.
  /// Useful for integrating with jaspr_content's TableOfContents.
  final Component? customContent;

  const ArcaneToc({
    this.entries = const [],
    this.title = 'On this page',
    this.showTreeLines = true,
    this.classPrefix = 'toc',
    this.customContent,
    super.key,
  });

  /// Create a TOC that wraps custom content (e.g., from jaspr_content).
  const ArcaneToc.custom({
    required Component content,
    this.title = 'On this page',
    this.showTreeLines = true,
    this.classPrefix = 'toc',
    super.key,
  })  : entries = const [],
        customContent = content;

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      classes: classPrefix,
      styles: const ArcaneStyleData(
        padding: PaddingPreset.md,
        borderRadius: Radius.lg,
        background: Background.surface,
        border: BorderPreset.subtle,
      ),
      children: [
        // Title
        ArcaneDiv(
          classes: '$classPrefix-title',
          styles: const ArcaneStyleData(
            fontSize: FontSize.xs,
            fontWeight: FontWeight.bold,
            margin: MarginPreset.bottomMd,
            textTransform: TextTransform.uppercase,
            letterSpacing: LetterSpacing.wide,
            textColor: TextColor.onSurfaceVariant,
            padding: PaddingPreset.bottomMd,
            borderBottom: BorderPreset.subtle,
          ),
          children: [ArcaneText(title)],
        ),

        // Content
        ArcaneDiv(
          classes: '$classPrefix-content${showTreeLines ? ' sidebar-tree-nav' : ''}',
          children: [
            if (customContent != null)
              customContent!
            else
              _buildEntries(entries, 0),
          ],
        ),
      ],
    );
  }

  Component _buildEntries(List<TocEntry> items, int depth) {
    if (items.isEmpty) return const ArcaneDiv(children: []);

    return ArcaneDiv(
      classes: showTreeLines ? 'sidebar-tree-items' : '$classPrefix-list',
      styles: ArcaneStyleData(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        gap: Gap.xs,
        paddingStringCustom: depth > 0 ? '0 0 0 16px' : null,
      ),
      children: items.map((TocEntry entry) => _buildEntry(entry, depth)).toList(),
    );
  }

  Component _buildEntry(TocEntry entry, int depth) {
    final bool hasChildren = entry.children.isNotEmpty;

    return ArcaneDiv(
      classes: showTreeLines
          ? 'sidebar-tree-item sidebar-tree-leaf'
          : '$classPrefix-item',
      children: [
        ArcaneLink(
          href: '#${entry.id}',
          classes: '$classPrefix-link',
          styles: const ArcaneStyleData(
            display: Display.block,
            padding: PaddingPreset.sm,
            textColor: TextColor.mutedForeground,
            fontSize: FontSize.sm,
            textDecoration: TextDecoration.none,
            borderRadius: Radius.sm,
            transition: Transition.allFast,
          ),
          child: ArcaneText(entry.text),
        ),
        if (hasChildren) _buildEntries(entry.children, depth + 1),
      ],
    );
  }
}

/// CSS styles for ArcaneToc tree-line visual connectors.
///
/// Include this in your stylesheet's baseCss for tree-line styling.
/// Provides comprehensive tree visualization with proper vertical/horizontal
/// line connectors, scrollbar styling, and active state highlighting.
const String arcaneTocTreeLinesCss = '''
/* ============================================
   TABLE OF CONTENTS - Tree Line Styles
   Clean tree view with subtle connecting lines
   ============================================ */

/* Scrollbar styling for TOC container */
.kb-toc,
.toc-container {
  scrollbar-width: thin;
  scrollbar-color: var(--border) transparent;
}

.kb-toc::-webkit-scrollbar,
.toc-container::-webkit-scrollbar {
  width: 4px;
}

.kb-toc::-webkit-scrollbar-track,
.toc-container::-webkit-scrollbar-track {
  background: transparent;
}

.kb-toc::-webkit-scrollbar-thumb,
.toc-container::-webkit-scrollbar-thumb {
  background: var(--border);
  border-radius: 2px;
}

/* TOC content with tree lines */
.toc-content ul {
  list-style: none;
  padding-left: 0;
  margin: 0;
  position: relative;
}

/* Top-level list gets tree line padding */
.toc-content > ul {
  padding-left: 0.75rem;
  margin-left: 0.25rem;
}

/* Nested lists */
.toc-content ul ul {
  padding-left: 0.875rem;
  margin-left: 0.375rem;
  margin-top: 0.25rem;
  position: relative;
}

/* All list items */
.toc-content li {
  position: relative;
}

/* Horizontal branch for top-level items */
.toc-content > ul > li::before {
  content: '';
  position: absolute;
  left: -0.5rem;
  top: 50%;
  width: 0.375rem;
  height: 1px;
  background: var(--border);
}

/* Vertical line segment for top-level items (not last) */
.toc-content > ul > li:not(:last-child)::after {
  content: '';
  position: absolute;
  left: -0.5rem;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--border);
}

/* Last top-level item - vertical line only to center (L-bend) */
.toc-content > ul > li:last-child::after {
  content: '';
  position: absolute;
  left: -0.5rem;
  top: 0;
  height: 50%;
  width: 1px;
  background: var(--border);
}

/* Horizontal branch for nested items */
.toc-content ul ul li::before {
  content: '';
  position: absolute;
  left: -0.875rem;
  top: 50%;
  width: 0.5rem;
  height: 1px;
  background: var(--border);
}

/* Vertical line segment for nested items (not last) */
.toc-content ul ul li:not(:last-child)::after {
  content: '';
  position: absolute;
  left: -0.875rem;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--border);
}

/* Last nested item - vertical line only to center (L-bend) */
.toc-content ul ul li:last-child::after {
  content: '';
  position: absolute;
  left: -0.875rem;
  top: 0;
  height: 50%;
  width: 1px;
  background: var(--border);
}

/* Single child - show dot instead of tree lines */
.toc-content > ul:has(> li:only-child) > li::before,
.toc-content > ul:has(> li:only-child) > li::after {
  display: none;
}

.toc-content ul ul:has(> li:only-child) > li::before,
.toc-content ul ul:has(> li:only-child) > li::after {
  display: none;
}

/* Link styling */
.toc-content a {
  color: var(--muted-foreground);
  text-decoration: none;
  font-size: 12px;
  display: block;
  padding: 0.375rem 0.625rem;
  border-radius: var(--radius-sm);
  transition: color 0.15s ease, background 0.15s ease;
}

.toc-content a:hover {
  color: var(--foreground);
  background: var(--muted);
}

/* Active TOC link */
.toc-content a.toc-active {
  color: var(--foreground);
  font-weight: 500;
  background: var(--muted);
}

/* Nested link sizing */
.toc-content ul ul a {
  font-size: 11px;
  padding: 0.25rem 0.5rem;
}

/* Fading tree lines at deeper nesting levels */
.toc-content ul ul li::before,
.toc-content ul ul li::after {
  background: color-mix(in srgb, var(--border) 70%, transparent);
}

.toc-content ul ul ul li::before,
.toc-content ul ul ul li::after {
  background: color-mix(in srgb, var(--border) 50%, transparent);
}

/* ============================================
   TABLE OF CONTENTS - Codex Gaming Style
   Cyberpunk with glowing tree lines
   ============================================ */
[class*="codex-"] .toc-wrapper,
.codex .toc-wrapper {
  background: color-mix(in srgb, var(--card) 80%, transparent);
  border-color: color-mix(in srgb, var(--primary) 20%, var(--border));
  box-shadow: 0 0 20px color-mix(in srgb, var(--primary) 5%, transparent);
}

[class*="codex-"] .toc-header,
.codex .toc-header {
  font-family: var(--font-mono);
  color: var(--primary);
  border-bottom-color: color-mix(in srgb, var(--primary) 25%, transparent);
}

/* Codex horizontal branches - glowing */
[class*="codex-"] .toc-content > ul > li::before,
[class*="codex-"] .toc-content ul ul li::before,
.codex .toc-content > ul > li::before,
.codex .toc-content ul ul li::before {
  background: var(--primary);
  opacity: 0.5;
  height: 2px;
}

/* Codex vertical lines - glowing */
[class*="codex-"] .toc-content > ul > li:not(:last-child)::after,
[class*="codex-"] .toc-content > ul > li:last-child::after,
[class*="codex-"] .toc-content ul ul li:not(:last-child)::after,
[class*="codex-"] .toc-content ul ul li:last-child::after,
.codex .toc-content > ul > li:not(:last-child)::after,
.codex .toc-content > ul > li:last-child::after,
.codex .toc-content ul ul li:not(:last-child)::after,
.codex .toc-content ul ul li:last-child::after {
  background: var(--primary);
  width: 2px;
  box-shadow: 0 0 4px color-mix(in srgb, var(--primary) 20%, transparent);
}

/* Codex link styling */
[class*="codex-"] .toc-content a,
.codex .toc-content a {
  padding: 0.5rem 0.75rem;
  border-left: 3px solid transparent;
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  transition: color 0.15s ease, background 0.15s ease, border-color 0.15s ease, box-shadow 0.15s ease;
}

[class*="codex-"] .toc-content a:hover,
.codex .toc-content a:hover {
  color: var(--primary);
  background: color-mix(in srgb, var(--primary) 10%, transparent);
  border-left-color: color-mix(in srgb, var(--primary) 50%, transparent);
}

[class*="codex-"] .toc-content a.toc-active,
.codex .toc-content a.toc-active {
  color: var(--primary);
  font-weight: 600;
  background: color-mix(in srgb, var(--primary) 15%, transparent);
  border-left-color: var(--primary);
  box-shadow:
    inset 0 0 16px color-mix(in srgb, var(--primary) 12%, transparent),
    0 0 8px color-mix(in srgb, var(--primary) 6%, transparent);
}
''';
