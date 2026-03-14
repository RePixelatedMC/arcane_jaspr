import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' as jaspr;
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';
import '../../stylesheets/shadcn/shadcn_stylesheet.dart';
import '../../util/interactivity/arcane_scripts.dart';

// Conditional import for Document handling - server vs client
import 'document_stub.dart'
    if (dart.library.io) 'document_server.dart'
    if (dart.library.js_interop) 'document_web.dart';

export '../../core/theme_provider.dart';
export '../../stylesheets/stylesheet.dart';
export '../../stylesheets/shadcn/shadcn_stylesheet.dart';
export '../../stylesheets/codex/codex_stylesheet.dart';

/// Root application component for Arcane Jaspr apps.
///
/// The [stylesheet] parameter is required - there is no default stylesheet.
/// You must explicitly choose a stylesheet for your app:
/// - [ShadcnStylesheet] - Clean, minimal ShadCN-inspired design
/// - [CodexStylesheet] - Premium dark-first system with restrained accent atmosphere (rainbow is opt-in)
class ArcaneApp extends StatefulWidget {
  final ArcaneStylesheet stylesheet;
  final Brightness brightness;
  final Widget child;
  final String? title;
  final String? description;
  final List<Widget>? head;
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
  Widget build(BuildContext context) {
    final bool isDark = component.brightness == Brightness.dark;
    final ArcaneStylesheet stylesheet = component.stylesheet;

    // Build head elements data for injection
    final List<HeadElementData> headElements = [];

    for (final String url in stylesheet.externalCssUrls) {
      if (url.contains('fonts.googleapis.com')) {
        headElements.addAll([
          HeadElementData.preconnect('https://fonts.googleapis.com'),
          HeadElementData.preconnect('https://fonts.gstatic.com', crossorigin: true),
        ]);
      }
      headElements.add(HeadElementData.link(url));
    }

    final String baseCss = stylesheet.baseCss;
    if (baseCss.isNotEmpty) {
      headElements.add(HeadElementData.style(baseCss));
    }

    // Build CSS classes: brightness + any stylesheet-specific classes
    final String brightnessClass = isDark ? 'dark' : 'light';
    final String? stylesheetClass = stylesheet.bodyClass;
    final String rootClasses = stylesheetClass != null && stylesheetClass.isNotEmpty
        ? '$brightnessClass $stylesheetClass'
        : brightnessClass;

    final Widget rootDiv = dom.div(
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
        component.child,
        if (component.includeFallbackScripts) const ArcaneScriptsComponent(),
      ],
    );

    return ArcaneThemeProvider(
      stylesheet: stylesheet,
      brightness: component.brightness,
      child: jaspr.Component.fragment([
        // Add brightness class to html element for CSS variable scoping
        DocumentHelper.html(attributes: {'class': brightnessClass}),
        // Inject styles into the actual document <head>
        DocumentHelper.head(elements: headElements),
        rootDiv,
      ]),
    );
  }
}

/// Web wrapper for ArcaneApp with optional background styling.
///
/// The [stylesheet] parameter is required - there is no default stylesheet.
class ArcaneWindow extends StatelessWidget {
  final ArcaneStylesheet stylesheet;
  final Brightness brightness;
  final Widget child;

  const ArcaneWindow({
    required this.stylesheet,
    this.brightness = Brightness.dark,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ArcaneApp(
      stylesheet: stylesheet,
      brightness: brightness,
      child: child,
    );
  }
}
