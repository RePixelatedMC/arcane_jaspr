import 'package:jaspr/jaspr.dart';

import '../html/div.dart';
import '../html/arcane_link.dart';
import '../html/arcane_text.dart';
import '../layout/flow.dart';
import '../view/icon.dart';
import '../../util/arcane.dart';
import '../../util/style_types/index.dart';

/// Represents a page link for prev/next navigation.
class PageNavItem {
  /// The display title of the page.
  final String title;

  /// The URL path to the page.
  final String path;

  /// Optional description or subtitle.
  final String? description;

  const PageNavItem({
    required this.title,
    required this.path,
    this.description,
  });

  /// Create from JSON map.
  factory PageNavItem.fromJson(Map<String, dynamic> json) {
    return PageNavItem(
      title: json['title'] as String,
      path: json['path'] as String,
      description: json['description'] as String?,
    );
  }

  /// Convert to JSON map.
  Map<String, dynamic> toJson() => {
        'title': title,
        'path': path,
        if (description != null) 'description': description,
      };
}

/// Previous/Next page navigation component.
///
/// Displays navigation links to the previous and next pages in a sequence.
/// Commonly used at the bottom of documentation pages.
class ArcanePageNav extends StatelessComponent {
  /// The previous page (displayed on the left).
  final PageNavItem? previous;

  /// The next page (displayed on the right).
  final PageNavItem? next;

  /// Label for the previous link.
  final String previousLabel;

  /// Label for the next link.
  final String nextLabel;

  /// CSS class prefix for customization.
  final String classPrefix;

  const ArcanePageNav({
    this.previous,
    this.next,
    this.previousLabel = 'Previous',
    this.nextLabel = 'Next',
    this.classPrefix = 'page-nav',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (previous == null && next == null) {
      return const ArcaneDiv(children: []);
    }

    return ArcaneDiv(
      classes: classPrefix,
      styles: const ArcaneStyleData(
        display: Display.flex,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        gap: Gap.lg,
        margin: MarginPreset.topXl,
        padding: PaddingPreset.topLg,
        borderTop: BorderPreset.subtle,
      ),
      children: [
        // Previous link
        if (previous != null)
          _buildNavLink(
            item: previous!,
            label: previousLabel,
            isNext: false,
          )
        else
          const ArcaneDiv(
            styles: ArcaneStyleData(flex: FlexPreset.expand),
            children: [],
          ),

        // Next link
        if (next != null)
          _buildNavLink(
            item: next!,
            label: nextLabel,
            isNext: true,
          )
        else
          const ArcaneDiv(
            styles: ArcaneStyleData(flex: FlexPreset.expand),
            children: [],
          ),
      ],
    );
  }

  Component _buildNavLink({
    required PageNavItem item,
    required String label,
    required bool isNext,
  }) {
    return ArcaneLink(
      href: item.path,
      classes: '$classPrefix-link $classPrefix-${isNext ? 'next' : 'prev'}',
      styles: ArcaneStyleData(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        crossAxisAlignment:
            isNext ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        gap: Gap.xs,
        padding: PaddingPreset.md,
        border: BorderPreset.subtle,
        borderRadius: Radius.md,
        flex: FlexPreset.expand,
        textAlign: isNext ? TextAlign.right : TextAlign.left,
        textDecoration: TextDecoration.none,
        transition: Transition.allFast,
      ),
      child: ArcaneColumn(
        gapSize: Gap.xs,
        crossAxisAlignment:
            isNext ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Label with arrow
          ArcaneRow(
            gapSize: Gap.xs,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: isNext
                ? [
                    ArcaneDiv(
                      styles: const ArcaneStyleData(
                        fontSize: FontSize.sm,
                        textColor: TextColor.mutedForeground,
                      ),
                      children: [ArcaneText(label)],
                    ),
                    ArcaneIcon.arrowRight(size: IconSize.sm),
                  ]
                : [
                    ArcaneIcon.arrowLeft(size: IconSize.sm),
                    ArcaneDiv(
                      styles: const ArcaneStyleData(
                        fontSize: FontSize.sm,
                        textColor: TextColor.mutedForeground,
                      ),
                      children: [ArcaneText(label)],
                    ),
                  ],
          ),

          // Title
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontWeight: FontWeight.w500,
              textColor: TextColor.primary,
            ),
            children: [ArcaneText(item.title)],
          ),

          // Description (optional)
          if (item.description != null)
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.sm,
                textColor: TextColor.mutedForeground,
              ),
              children: [ArcaneText(item.description!)],
            ),
        ],
      ),
    );
  }
}

/// CSS styles for ArcanePageNav hover effects.
///
/// Include this in your stylesheet's baseCss for hover styling.
const String arcanePageNavCss = '''
/* Page Nav Hover Styles */
.page-nav-link:hover {
  background: var(--muted);
  border-color: var(--border);
}

.page-nav-link:hover .page-nav-title {
  color: var(--primary);
}
''';
