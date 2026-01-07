import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';
import '../../stylesheets/shadcn/shadcn_stylesheet.dart';
import '../../util/interactivity/arcane_scripts.dart';

export '../../core/theme_provider.dart';
export '../../stylesheets/stylesheet.dart';
export '../../stylesheets/shadcn/shadcn_stylesheet.dart';
export '../../stylesheets/codex/codex_stylesheet.dart';

/// Root application component for Arcane Jaspr apps.
///
/// Wraps the app with a theme provider and applies base CSS from the stylesheet.
/// Automatically injects fallback JavaScript for static sites.
///
/// ## Basic Usage
///
/// ```dart
/// ArcaneApp(
///   child: MyApp(),
/// )
/// ```
///
/// ## With Stylesheet
///
/// ```dart
/// ArcaneApp(
///   stylesheet: ShadcnStylesheet(),
///   brightness: Brightness.dark,
///   child: MyApp(),
/// )
/// ```
class ArcaneApp extends StatefulComponent {
  /// The stylesheet to use for rendering components.
  /// Defaults to ShadCN.
  final ArcaneStylesheet stylesheet;

  /// Current brightness mode.
  /// Defaults to dark.
  final Brightness brightness;

  /// The child component to render
  final Component child;

  /// Optional document title
  final String? title;

  /// Optional meta description
  final String? description;

  /// Optional additional head elements
  final List<Component>? head;

  /// Whether to include fallback scripts for static sites.
  ///
  /// When true (default), JavaScript is injected that provides interactivity
  /// for Arcane components when Jaspr client hydration is unavailable
  /// (e.g., on static sites built with `jaspr build`).
  final bool includeFallbackScripts;

  const ArcaneApp({
    this.stylesheet = const ShadcnStylesheet(),
    this.brightness = Brightness.dark,
    required this.child,
    this.title,
    this.description,
    this.head,
    this.includeFallbackScripts = true,
    super.key,
  });

  @override
  State<ArcaneApp> createState() => _ArcaneAppState();
}

class _ArcaneAppState extends State<ArcaneApp> {
  @override
  Component build(BuildContext context) {
    final bool isDark = component.brightness == Brightness.dark;
    final ArcaneStylesheet stylesheet = component.stylesheet;

    // Build font loading elements from stylesheet
    final List<Component> headElements = [];

    // External CSS URLs (Google Fonts, etc.)
    for (final String url in stylesheet.externalCssUrls) {
      if (url.contains('fonts.googleapis.com')) {
        headElements.addAll([
          const Component.element(
            tag: 'link',
            attributes: {
              'href': 'https://fonts.googleapis.com',
              'rel': 'preconnect',
            },
            children: [],
          ),
          const Component.element(
            tag: 'link',
            attributes: {
              'href': 'https://fonts.gstatic.com',
              'rel': 'preconnect',
              'crossorigin': '',
            },
            children: [],
          ),
        ]);
      }
      headElements.add(
        Component.element(
          tag: 'link',
          attributes: {
            'href': url,
            'rel': 'stylesheet',
          },
          children: const [],
        ),
      );
    }

    // Base CSS from stylesheet
    final String? baseCss = stylesheet.baseCss;
    if (baseCss != null && baseCss.isNotEmpty) {
      headElements.add(
        Component.element(
          tag: 'style',
          children: [dom.RawText(baseCss)],
        ),
      );
    }

    // Build the root div
    final Component rootDiv = dom.div(
      id: 'arcane-root',
      classes: isDark ? 'dark' : 'light',
      styles: const dom.Styles(raw: {
        'min-height': '100vh',
        'background-color': 'var(--background)',
        'color': 'var(--foreground)',
        'font-family': 'var(--font-sans)',
        '-webkit-font-smoothing': 'antialiased',
        '-moz-osx-font-smoothing': 'grayscale',
      }),
      [
        // Head elements (fonts, base CSS)
        ...headElements,
        // Main content
        component.child,
        // Fallback scripts for static sites
        if (component.includeFallbackScripts) const ArcaneScriptsComponent(),
      ],
    );

    // Wrap with theme provider
    return ArcaneThemeProvider(
      stylesheet: stylesheet,
      brightness: component.brightness,
      child: rootDiv,
    );
  }
}

/// ArcaneWindow for web - just wraps ArcaneApp with optional background styling
class ArcaneWindow extends StatelessComponent {
  final ArcaneStylesheet stylesheet;
  final Brightness brightness;
  final Component child;

  const ArcaneWindow({
    this.stylesheet = const ShadcnStylesheet(),
    this.brightness = Brightness.dark,
    required this.child,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneApp(
      stylesheet: stylesheet,
      brightness: brightness,
      child: child,
    );
  }
}
