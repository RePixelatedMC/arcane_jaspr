import 'package:jaspr/jaspr.dart';

import '../stylesheets/stylesheet.dart';

export '../stylesheets/stylesheet.dart';

/// Brightness mode for the application.
enum Brightness {
  light,
  dark,
}

/// Theme mode selection.
enum ThemeMode {
  system,
  light,
  dark,
}

/// Provides the current stylesheet and brightness to the component tree.
class ArcaneThemeProvider extends InheritedComponent {
  final ArcaneStylesheet stylesheet;
  final Brightness brightness;

  const ArcaneThemeProvider({
    required this.stylesheet,
    this.brightness = Brightness.dark,
    required super.child,
    super.key,
  });

  static ArcaneThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<ArcaneThemeProvider>();
  }

  ComponentRenderers get renderers => stylesheet.renderers;

  @override
  bool updateShouldNotify(ArcaneThemeProvider oldComponent) {
    return stylesheet != oldComponent.stylesheet ||
        brightness != oldComponent.brightness;
  }
}

/// Extension for easy access to theme properties from context.
extension ArcaneThemeContext on BuildContext {
  ArcaneStylesheet get stylesheet {
    final ArcaneThemeProvider? provider = ArcaneThemeProvider.of(this);
    if (provider == null) {
      throw StateError(
        'No ArcaneThemeProvider found in context. '
        'Wrap your app with ArcaneThemeProvider or ArcaneApp.',
      );
    }
    return provider.stylesheet;
  }

  ArcaneStylesheet? get stylesheetOrNull {
    return ArcaneThemeProvider.of(this)?.stylesheet;
  }

  ComponentRenderers get renderers => stylesheet.renderers;

  Brightness get brightness {
    return ArcaneThemeProvider.of(this)?.brightness ?? Brightness.dark;
  }

  bool get isDark => brightness == Brightness.dark;

  bool get isLight => brightness == Brightness.light;

  String get brightnessClass => isDark ? 'dark' : 'light';
}
