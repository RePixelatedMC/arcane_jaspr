import 'package:jaspr/jaspr.dart';

import '../html/div.dart';
import '../../util/arcane.dart';
import '../../util/style_types/index.dart';

/// A documentation-style layout with fixed header, sidebar, main content, and optional TOC.
///
/// This layout is designed for documentation sites, knowledge bases, and similar
/// content-heavy applications. It provides:
/// - Fixed header at the top
/// - Fixed sidebar on the left
/// - Scrollable main content area
/// - Optional sticky table of contents on the right
/// - Responsive behavior for mobile devices
class ArcaneDocsLayout extends StatelessComponent {
  /// The header component (fixed at top).
  final Component header;

  /// The sidebar component (fixed on left).
  final Component sidebar;

  /// The main content area.
  final Component content;

  /// Optional table of contents (sticky on right).
  final Component? toc;

  /// Optional footer component.
  final Component? footer;

  /// Width of the sidebar in pixels.
  final int sidebarWidth;

  /// Width of the TOC in pixels.
  final int tocWidth;

  /// Height of the header in pixels.
  final int headerHeight;

  /// Maximum width of the content area in pixels.
  final int contentMaxWidth;

  /// CSS class prefix for customization.
  final String classPrefix;

  const ArcaneDocsLayout({
    required this.header,
    required this.sidebar,
    required this.content,
    this.toc,
    this.footer,
    this.sidebarWidth = 280,
    this.tocWidth = 240,
    this.headerHeight = 64,
    this.contentMaxWidth = 800,
    this.classPrefix = 'docs',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      id: '$classPrefix-root',
      styles: const ArcaneStyleData(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        minHeight: '100vh',
      ),
      children: [
        // Header
        ArcaneDiv(
          classes: '$classPrefix-header',
          styles: ArcaneStyleData(
            position: Position.fixed,
            top: '0',
            left: '0',
            right: '0',
            heightCustom: '${headerHeight}px',
            display: Display.flex,
            crossAxisAlignment: CrossAxisAlignment.center,
            padding: PaddingPreset.horizontalLg,
            zIndexCustom: '50',
            background: Background.background,
            borderBottom: BorderPreset.subtle,
          ),
          children: [header],
        ),

        // Main layout container
        ArcaneDiv(
          classes: '$classPrefix-layout',
          styles: const ArcaneStyleData(
            display: Display.flex,
            flexGrow: 1,
          ),
          children: [
            // Sidebar
            ArcaneDiv(
              classes: '$classPrefix-sidebar',
              styles: ArcaneStyleData(
                position: Position.fixed,
                top: '${headerHeight}px',
                left: '0',
                widthCustom: '${sidebarWidth}px',
                heightCustom: 'calc(100vh - ${headerHeight}px)',
                overflowY: OverflowAxis.auto,
                padding: PaddingPreset.verticalMd,
                zIndexCustom: '40',
                background: Background.background,
                borderRight: BorderPreset.subtle,
              ),
              children: [sidebar],
            ),

            // Main content area
            ArcaneDiv(
              classes: '$classPrefix-main',
              styles: ArcaneStyleData(
                flexGrow: 1,
                marginStringCustom: '${headerHeight}px 0 0 ${sidebarWidth}px',
                padding: PaddingPreset.xl,
                minHeight: 'calc(100vh - ${headerHeight}px)',
              ),
              children: [
                ArcaneDiv(
                  classes: '$classPrefix-content-wrapper',
                  styles: ArcaneStyleData(
                    display: Display.flex,
                    gap: Gap.xl,
                    maxWidthCustom: '${contentMaxWidth + tocWidth + 32}px',
                    margin: MarginPreset.autoX,
                  ),
                  children: [
                    // Content
                    ArcaneDiv(
                      classes: '$classPrefix-content',
                      styles: const ArcaneStyleData(
                        flex: FlexPreset.expand,
                        minWidth: '0',
                      ),
                      children: [content],
                    ),

                    // TOC
                    if (toc != null)
                      ArcaneDiv(
                        classes: '$classPrefix-toc',
                        styles: ArcaneStyleData(
                          position: Position.sticky,
                          top: '${headerHeight + 16}px',
                          widthCustom: '${tocWidth}px',
                          maxHeight: 'calc(100vh - ${headerHeight + 32}px)',
                          overflowY: OverflowAxis.auto,
                          flexShrink: 0,
                          alignSelf: CrossAxisAlignment.start,
                        ),
                        children: [toc!],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Footer
        if (footer != null)
          ArcaneDiv(
            classes: '$classPrefix-footer',
            styles: ArcaneStyleData(
              marginStringCustom: '0 0 0 ${sidebarWidth}px',
              padding: PaddingPreset.xl,
              textAlign: TextAlign.center,
              borderTop: BorderPreset.subtle,
            ),
            children: [footer!],
          ),
      ],
    );
  }
}

/// CSS styles for ArcaneDocsLayout responsive behavior.
///
/// Include this in your stylesheet's baseCss for mobile responsiveness.
const String arcaneDocsLayoutResponsiveCss = '''
/* Docs Layout Responsive Styles */
@media (max-width: 1024px) {
  .docs-toc { display: none; }
}

@media (max-width: 768px) {
  .docs-sidebar {
    transform: translateX(-100%);
    width: 280px !important;
    transition: transform 0.2s ease;
  }
  .docs-sidebar.open {
    transform: translateX(0);
  }
  .docs-main {
    margin-left: 0 !important;
  }
  .docs-footer {
    margin-left: 0 !important;
  }
}
''';
