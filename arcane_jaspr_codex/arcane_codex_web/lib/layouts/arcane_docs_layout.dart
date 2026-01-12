import 'package:arcane_jaspr/arcane_jaspr.dart' hide TableOfContents;
import 'package:jaspr_content/jaspr_content.dart';

import '../components/docs_sidebar.dart';
import '../components/interactive_demo.dart';
import '../demos/demo_registry.dart';
import '../utils/constants.dart';
import '../utils/docs_scripts.dart';

const ArcaneStylesheet _stylesheet = ShadcnStylesheet(theme: ShadcnTheme.charcoal);
// const ArcaneStylesheet _stylesheet = CodexStylesheet(theme: CodexTheme.orange);

/// Custom documentation layout using Arcane UI components
class ArcaneDocsLayout extends PageLayoutBase {
  const ArcaneDocsLayout();

  @override
  Pattern get name => 'docs';

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);

    final assetPrefix = AppConstants.baseUrl.isNotEmpty ? AppConstants.baseUrl : '';
    // Favicons and app icons
    yield link(rel: 'icon', type: 'image/x-icon', href: '$assetPrefix/assets/favicon.ico');
    yield link(rel: 'icon', type: 'image/png', href: '$assetPrefix/assets/icon-32.png', attributes: const {'sizes': '32x32'});
    yield link(rel: 'icon', type: 'image/png', href: '$assetPrefix/assets/icon-16.png', attributes: const {'sizes': '16x16'});
    yield link(rel: 'apple-touch-icon', href: '$assetPrefix/assets/apple-touch-icon.png', attributes: const {'sizes': '180x180'});
    yield link(rel: 'manifest', href: '$assetPrefix/manifest.json');
    yield meta(name: 'theme-color', content: '#09090b');
    yield meta(name: 'viewport', content: 'width=device-width, initial-scale=1');

    // Inject stylesheet base CSS (contains all CSS variables and base styles)
    yield Component.element(
      tag: 'style',
      attributes: {'id': 'arcane-theme-vars'},
      children: [RawText(_stylesheet.baseCss)],
    );

    // Load external CSS (Google Fonts, etc.)
    if (_stylesheet.externalCssUrls.isNotEmpty) {
      yield link(rel: 'preconnect', href: 'https://fonts.googleapis.com');
      yield link(
        rel: 'preconnect',
        href: 'https://fonts.gstatic.com',
        attributes: const {'crossorigin': ''},
      );
      for (final url in _stylesheet.externalCssUrls) {
        yield link(rel: 'stylesheet', href: url);
      }
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

    // Theme initialization script
    yield script(content: '''
      (function() {
        window.arcaneThemeMode = localStorage.getItem('arcane-theme-mode') || 'dark';
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

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Component build(BuildContext context) {
    final demoRegistry = DemoRegistry(
      isDark: _isDark,
      onThemeToggle: _toggleTheme,
    );

    // Dark mode uses .dark class (defined in stylesheet baseCss)
    // Also include any stylesheet-specific body class (e.g., 'codex-orange')
    final themeClass = _isDark ? 'dark' : '';
    final stylesheetClass = _stylesheet.bodyClass ?? '';
    final rootClasses = [themeClass, stylesheetClass].where((c) => c.isNotEmpty).join(' ');

    // Wrap with ArcaneThemeProvider to enable context.renderers access
    return ArcaneThemeProvider(
      stylesheet: _stylesheet,
      brightness: _isDark ? Brightness.dark : Brightness.light,
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

  /// Main content area
  Component _buildMainArea(DemoRegistry demoRegistry) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        flexGrow: 1,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        minHeight: '100vh',
      ),
      children: [
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
        raw: {'padding-top': '2rem'},
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
    final segments = path.split('/').where((segment) => segment.isNotEmpty).toList();

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
      return 'Arcane${segment.substring(7).split('-').map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1)).join('')}';
    }
    // Capitalize first letter of each word
    return segment.split('-').map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1)).join(' ');
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
        position: Position.sticky,
        raw: {
          'width': '220px',
          'flex-shrink': '0',
          'top': '80px',
          'align-self': 'flex-start',
          'max-height': 'calc(100vh - 100px)',
          'overflow-y': 'auto',
        },
      ),
      children: [
        ArcaneToc.custom(
          content: component.toc!.build(),
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
