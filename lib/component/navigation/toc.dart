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
const String arcaneTocTreeLinesCss = '''
/* TOC Tree Line Styles */
.toc-content ul {
  list-style: none;
  padding-left: 1rem;
  margin: 0;
  position: relative;
}

.toc-content ul::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0.75rem;
  bottom: 0.75rem;
  width: 1px;
  background: var(--border);
}

.toc-content ul:has(> li:only-child)::before {
  display: none;
}

.toc-content li {
  position: relative;
}

.toc-content li::before {
  content: '';
  position: absolute;
  left: -1rem;
  top: 0.75rem;
  width: 0.75rem;
  height: 1px;
  background: var(--border);
}

.toc-content li:only-child::before {
  width: 4px;
  height: 4px;
  border-radius: 50%;
  top: calc(0.75rem - 2px);
  left: calc(-1rem - 2px);
}

.toc-content a {
  color: var(--muted-foreground);
  text-decoration: none;
  font-size: 13px;
  display: block;
  padding: 4px 8px;
  min-height: 1.5rem;
  line-height: 1.5rem;
  border-radius: var(--radius-sm);
  transition: all var(--arcane-transition-fast);
}

.toc-content a:hover {
  color: var(--foreground);
  background: var(--muted);
}

.toc-content a.toc-active {
  color: var(--primary);
  font-weight: 600;
  background: var(--accent);
  border-left: 2px solid var(--primary);
  padding-left: 6px;
}

.toc-content ul ul::before,
.toc-content ul ul li::before {
  background: color-mix(in srgb, var(--border) 60%, transparent);
}

.toc-content ul ul ul::before,
.toc-content ul ul ul li::before {
  background: color-mix(in srgb, var(--border) 40%, transparent);
}
''';
