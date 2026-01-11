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
/// The [stylesheet] parameter is required - there is no default stylesheet.
/// You must explicitly choose a stylesheet for your app:
/// - [ShadcnStylesheet] - Clean, minimal ShadCN-inspired design
/// - [CodexStylesheet] - Gaming/cyberpunk aesthetic with neon glows
class ArcaneApp extends StatefulComponent {
  final ArcaneStylesheet stylesheet;
  final Brightness brightness;
  final Component child;
  final String? title;
  final String? description;
  final List<Component>? head;
  final bool includeFallbackScripts;

  const ArcaneApp({
    required this.stylesheet,
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

    final List<Component> headElements = [];

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

    final String baseCss = stylesheet.baseCss;
    if (baseCss.isNotEmpty) {
      headElements.add(
        Component.element(
          tag: 'style',
          children: [dom.RawText(baseCss)],
        ),
      );
    }

    // Build CSS classes: brightness + any stylesheet-specific classes
    final String brightnessClass = isDark ? 'dark' : 'light';
    final String? stylesheetClass = stylesheet.bodyClass;
    final String rootClasses = stylesheetClass != null && stylesheetClass.isNotEmpty
        ? '$brightnessClass $stylesheetClass'
        : brightnessClass;

    final Component rootDiv = dom.div(
      id: 'arcane-root',
      classes: rootClasses,
      styles: const dom.Styles(raw: {
        'min-height': '100vh',
        'background-color': 'var(--background)',
        'color': 'var(--foreground)',
        'font-family': 'var(--font-sans)',
        '-webkit-font-smoothing': 'antialiased',
        '-moz-osx-font-smoothing': 'grayscale',
      }),
      [
        ...headElements,
        component.child,
        if (component.includeFallbackScripts) const ArcaneScriptsComponent(),
      ],
    );

    return ArcaneThemeProvider(
      stylesheet: stylesheet,
      brightness: component.brightness,
      child: rootDiv,
    );
  }
}

/// Web wrapper for ArcaneApp with optional background styling.
///
/// The [stylesheet] parameter is required - there is no default stylesheet.
class ArcaneWindow extends StatelessComponent {
  final ArcaneStylesheet stylesheet;
  final Brightness brightness;
  final Component child;

  const ArcaneWindow({
    required this.stylesheet,
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
