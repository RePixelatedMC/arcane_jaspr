import 'package:arcane_jaspr/arcane_jaspr.dart' hide TableOfContents;
import 'package:jaspr_content/jaspr_content.dart';

import '../components/docs_sidebar.dart';
import '../components/docs_header.dart';
import '../components/interactive_demo.dart';
import '../demos/demo_registry.dart';
import '../utils/constants.dart';
import '../utils/docs_scripts.dart';

// =============================================================================
// STYLESHEET CONFIGURATION
// =============================================================================
// Change this ONE constant to swap the entire design system.
// All CSS generation, variant selection, and theming adapts automatically.
//
// Available options:
//   const ShadcnStyleSheet()  - ShadCN design (minimal, modern, with color presets)
//   const CodexStyleSheet()   - Codex design (gaming aesthetic, glass effects)
//
// Or create your own by extending ArcaneStyleSheet.
// =============================================================================
const ArcaneStyleSheet _docsStyleSheet = ShadcnStyleSheet();

/// Custom documentation layout using Arcane UI components
class ArcaneDocsLayout extends PageLayoutBase {
  const ArcaneDocsLayout();

  @override
  Pattern get name => 'docs';

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);

    final assetPrefix = AppConstants.baseUrl.isNotEmpty ? AppConstants.baseUrl : '';
    yield link(
        rel: 'icon', type: 'image/x-icon', href: '$assetPrefix/favicon.ico');
    yield meta(name: 'viewport', content: 'width=device-width, initial-scale=1');

    // Generate CSS for ALL variants of the configured stylesheet
    // This is stylesheet-agnostic - works with any ArcaneStyleSheet implementation
    yield Component.element(
      tag: 'style',
      attributes: {'id': 'arcane-theme-vars'},
      children: [RawText(_docsStyleSheet.generateCompleteCss())],
    );

    // Load custom fonts if the stylesheet provides them
    if (_docsStyleSheet.fontFaceCss != null) {
      yield Component.element(
        tag: 'style',
        attributes: {'id': 'arcane-font-face'},
        children: [RawText(_docsStyleSheet.fontFaceCss!)],
      );
    }

    // Load Google Fonts if the stylesheet uses them
    if (_docsStyleSheet.googleFontUrl != null) {
      yield link(
        rel: 'preconnect',
        href: 'https://fonts.googleapis.com',
      );
      yield link(
        rel: 'preconnect',
        href: 'https://fonts.gstatic.com',
        attributes: const {'crossorigin': ''},
      );
      yield link(
        rel: 'stylesheet',
        href: _docsStyleSheet.googleFontUrl!,
      );
    }

    // Load stylesheet AFTER theme variables so our overrides take precedence
    yield link(rel: 'stylesheet', href: '$assetPrefix/styles.css');

    // Highlight.js for syntax highlighting
    yield link(
      rel: 'stylesheet',
      href: 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css',
    );
    yield script(
      attributes: const {
        'src': 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js',
      },
    );
    yield script(
      attributes: const {
        'src': 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/dart.min.js',
      },
    );

    // Theme initialization script - stylesheet-agnostic
    // Stores the default variant ID for the configured stylesheet
    final defaultVariantId = _docsStyleSheet.currentVariantId;
    yield script(content: '''
      (function() {
        // Store values for later use by docs_scripts.dart
        window.arcaneThemeMode = localStorage.getItem('arcane-theme-mode') || 'dark';
        window.arcaneThemeVariant = localStorage.getItem('arcane-theme-variant') || '$defaultVariantId';
      })();
    ''');
  }

  @override
  Component buildBody(Page page, Component child) {
    final pageData = page.data.page;
    return ThemedDocsPage(
      title: pageData['title'] as String?,
      description: pageData['description'] as String?,
      toc: page.data['toc'] as TableOfContents?,
      currentPath: page.url,
      content: child,
      componentType: pageData['component'] as String?,
    );
  }
}

/// Documentation page wrapper with light/dark mode toggle and preset selector
class ThemedDocsPage extends StatefulComponent {
  final String? title;
  final String? description;
  final TableOfContents? toc;
  final String currentPath;
  final Component content;
  final String? componentType;

  const ThemedDocsPage({
    this.title,
    this.description,
    this.toc,
    required this.currentPath,
    required this.content,
    this.componentType,
  });

  @override
  State<ThemedDocsPage> createState() => _ThemedDocsPageState();
}

class _ThemedDocsPageState extends State<ThemedDocsPage> {
  bool _isDark = true;
  String _variantId = _docsStyleSheet.currentVariantId;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  void _setVariant(String variantId) {
    setState(() => _variantId = variantId);
  }

  @override
  Component build(BuildContext context) {
    final demoRegistry = DemoRegistry(
      isDark: _isDark,
      onThemeToggle: _toggleTheme,
    );

    // Get the stylesheet instance for the selected variant
    final ArcaneStyleSheet currentSheet = _docsStyleSheet.withVariant(_variantId);

    final theme = ArcaneTheme(
      styleSheet: currentSheet,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
    );

    // Build class string using stylesheet's variant system
    final rootClasses = '${currentSheet.cssClassForVariant(_variantId)} ${_isDark ? 'arcane-dark' : 'arcane-light'}';

    return ArcaneThemeProvider(
      theme: theme,
      child: ArcaneDiv(
        id: 'arcane-root',
        classes: rootClasses,
        styles: const ArcaneStyleData(
          minHeight: '100vh',
          background: Background.background,
          textColor: TextColor.primary,
          fontFamily: FontFamily.sans,
        ),
        children: [
          _buildPageLayout(demoRegistry),
          ..._buildScripts(),
        ],
      ),
    );
  }

  /// Main page layout structure
  Component _buildPageLayout(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        minHeight: '100vh',
      ),
      children: [
        DocsSidebar(currentPath: component.currentPath),
        _buildMainArea(demoRegistry),
      ],
    );
  }

  /// Main content area with header
  Component _buildMainArea(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        flexGrow: 1,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        minHeight: '100vh',
      ),
      children: [
        DocsHeader(
          isDark: _isDark,
          onThemeToggle: _toggleTheme,
          variants: _docsStyleSheet.variants,
          currentVariantId: _variantId,
          onVariantChanged: _setVariant,
        ),
        _buildContentArea(demoRegistry),
      ],
    );
  }

  /// Content area with main content and TOC
  Component _buildContentArea(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        gap: Gap.xl,
        padding: PaddingPreset.xl,
        maxWidth: MaxWidth.container,
        margin: MarginPreset.autoX,
        flexGrow: 1,
      ),
      children: [
        _buildMainContent(demoRegistry),
        if (component.toc != null) _buildTableOfContents(),
      ],
    );
  }

  /// Main content section
  Component _buildMainContent(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        flex: FlexPreset.expand,
        minWidth: '0',
      ),
      children: [
        _buildBreadcrumbs(),
        if (component.title != null) _buildTitle(),
        if (component.description != null) _buildDescription(),
        // Use @client InteractiveDemo for hydrated, interactive demos
        if (component.componentType != null)
          InteractiveDemo(componentType: component.componentType!),
        div(classes: 'prose', [component.content]),
      ],
    );
  }

  /// Build breadcrumbs from current path
  Component _buildBreadcrumbs() {
    final path = component.currentPath;
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();

    if (segments.isEmpty) {
      return const ArcaneDiv(children: []);
    }

    final items = <BreadcrumbItem>[];

    // Add "Docs" as first item if path starts with /docs
    if (segments.isNotEmpty && segments[0] == 'docs') {
      items.add(const BreadcrumbItem(
        label: 'Docs',
        href: '/docs',
      ));

      // Build remaining segments
      String currentHref = '/docs';
      for (int i = 1; i < segments.length; i++) {
        currentHref += '/${segments[i]}';
        final isLast = i == segments.length - 1;
        final label = _formatSegment(segments[i]);

        items.add(BreadcrumbItem(
          label: label,
          href: isLast ? null : currentHref,
        ));
      }
    }

    if (items.isEmpty) {
      return const ArcaneDiv(children: []);
    }

    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomMd,
      ),
      children: [
        ArcaneBreadcrumbs(
          items: items,
          separator: BreadcrumbSeparator.chevron,
          size: BreadcrumbSize.sm,
        ),
      ],
    );
  }

  /// Format path segment into readable label
  String _formatSegment(String segment) {
    // Handle arcane- prefix for component pages
    if (segment.startsWith('arcane-')) {
      return 'Arcane${segment.substring(7).split('-').map((s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1)).join('')}';
    }
    // Capitalize first letter of each word
    return segment.split('-').map((s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1)).join(' ');
  }

  Component _buildTitle() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomLg,
        fontSize: FontSize.xl3,
        fontWeight: FontWeight.bold,
        textColor: TextColor.primary,
      ),
      children: [ArcaneText(component.title!)],
    );
  }

  Component _buildDescription() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomXl,
        textColor: TextColor.mutedForeground,
        fontSize: FontSize.lg,
      ),
      children: [ArcaneText(component.description!)],
    );
  }


  /// Table of contents sidebar
  Component _buildTableOfContents() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '240px',
        flexShrink: 0,
        position: Position.sticky,
        overflow: Overflow.auto,
        top: '80px',
        alignSelf: CrossAxisAlignment.start,
        maxHeight: 'calc(100vh - 100px)',
      ),
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            borderRadius: Radius.lg,
            background: Background.surface,
            border: BorderPreset.subtle,
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                fontWeight: FontWeight.w700,
                margin: MarginPreset.bottomMd,
                textTransform: TextTransform.uppercase,
                letterSpacing: LetterSpacing.wide,
                textColor: TextColor.onSurfaceVariant,
                padding: PaddingPreset.bottomMd,
                borderBottom: BorderPreset.subtle,
              ),
              children: [ArcaneText('On this page')],
            ),
            div(classes: 'toc-content', [component.toc!.build()]),
          ],
        ),
      ],
    );
  }

  /// JavaScript for static site functionality
  Iterable<Component> _buildScripts() sync* {
    final basePath = AppConstants.baseUrl.isNotEmpty ? AppConstants.baseUrl : '/arcane_jaspr';
    yield script(content: DocsScripts.generate(basePath: basePath));
    // Component interactivity scripts from arcane_jaspr
    yield const ArcaneScriptsComponent();
  }
}
