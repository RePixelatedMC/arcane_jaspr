import 'package:jaspr/jaspr.dart';

import '../stylesheets/stylesheet.dart';

export '../stylesheets/stylesheet.dart';

/// Brightness mode for the application.
enum Brightness {
  /// Light mode
  light,

  /// Dark mode
  dark,
}

/// Theme mode selection.
enum ThemeMode {
  /// Follow system preference
  system,

  /// Always light mode
  light,

  /// Always dark mode
  dark,
}

/// Provides the current stylesheet and brightness to the component tree.
///
/// Wrap your app with [ArcaneThemeProvider] to enable stylesheet-based rendering:
///
/// ```dart
/// ArcaneThemeProvider(
///   stylesheet: ArcaneStylesheet.shadcn,
///   brightness: Brightness.dark,
///   child: MyApp(),
/// )
/// ```
class ArcaneThemeProvider extends InheritedComponent {
  /// The active stylesheet
  final ArcaneStylesheet stylesheet;

  /// Current brightness mode
  final Brightness brightness;

  const ArcaneThemeProvider({
    required this.stylesheet,
    this.brightness = Brightness.dark,
    required super.child,
    super.key,
  });

  /// Get the theme provider from context
  static ArcaneThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<ArcaneThemeProvider>();
  }

  /// Get component renderers from the current stylesheet
  ComponentRenderers get renderers => stylesheet.renderers;

  @override
  bool updateShouldNotify(ArcaneThemeProvider oldComponent) {
    return stylesheet != oldComponent.stylesheet ||
        brightness != oldComponent.brightness;
  }
}

/// Extension for easy access to theme properties from context.
extension ArcaneThemeContext on BuildContext {
  /// Get the current stylesheet
  ArcaneStylesheet get stylesheet {
    final provider = ArcaneThemeProvider.of(this);
    if (provider == null) {
      throw StateError(
        'No ArcaneThemeProvider found in context. '
        'Wrap your app with ArcaneThemeProvider or ArcaneApp.',
      );
    }
    return provider.stylesheet;
  }

  /// Get the current stylesheet, or null if not in a themed context
  ArcaneStylesheet? get stylesheetOrNull {
    return ArcaneThemeProvider.of(this)?.stylesheet;
  }

  /// Get component renderers from the current stylesheet
  ComponentRenderers get renderers => stylesheet.renderers;

  /// Get the current brightness
  Brightness get brightness {
    return ArcaneThemeProvider.of(this)?.brightness ?? Brightness.dark;
  }

  /// Whether currently in dark mode
  bool get isDark => brightness == Brightness.dark;

  /// Whether currently in light mode
  bool get isLight => brightness == Brightness.light;

  /// CSS class for current brightness mode
  String get brightnessClass => isDark ? 'dark' : 'light';
}
