import 'package:arcane_jaspr/theme/index.dart';
import 'package:arcane_jaspr/stylesheets/stylesheet.dart';

import 'neubrutalism_css.dart';
import 'neubrutalism_layout_renderers.dart';
import 'neubrutalism_theme.dart';
import 'renderers/neubrutalism_renderers.dart';

class NeubrutalismStylesheet extends ArcaneStylesheet {
  final NeubrutalismTheme theme;

  const NeubrutalismStylesheet({this.theme = NeubrutalismTheme.yellow});

  @override
  String get id => 'neubrutalism';

  @override
  String get name => 'Neubrutalism';

  @override
  ComponentRenderers get renderers => const NeubrutalismRenderers();

  @override
  LayoutRenderers get layouts => const NeubrutalismLayoutRenderers();

  @override
  ThemeSeed get lightSeed => ThemeSeed(
    primary: theme.color,
    background: theme.lightSurface,
    secondary: theme.lightSecondary,
    accent: theme.lightAccent,
    border: theme.lightBorder,
    destructive: 0xFFFF4747,
    success: 0xFF7BCB6A,
    warning: 0xFFFFD23F,
    info: 0xFF6FB3FF,
    accentGlow: false,
  );

  @override
  ThemeSeed get darkSeed => ThemeSeed(
    primary: theme.color,
    background: 0xFF202A4F,
    secondary: 0xFF1A1A1A,
    accent: theme.color,
    border: 0xFF000000,
    destructive: 0xFFFF4747,
    success: 0xFF7BCB6A,
    warning: 0xFFFFD23F,
    info: 0xFF6FB3FF,
    isDark: true,
    accentGlow: false,
  );

  @override
  FontConfig get fonts => const FontConfig(
    sans:
        "'Space Grotesk', 'Inter', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
    heading:
        "'Archivo Black', 'Space Grotesk', ui-sans-serif, system-ui, sans-serif",
    mono:
        "'JetBrains Mono', 'IBM Plex Mono', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace",
  );

  @override
  RadiusConfig get radius => const RadiusConfig(
    xs: '2px',
    sm: '4px',
    md: '6px',
    lg: '8px',
    xl: '10px',
    xxl: '12px',
    full: '9999px',
  );

  @override
  List<String> get externalCssUrls => const [
    'https://fonts.googleapis.com/css2?family=Archivo+Black&family=Space+Grotesk:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap',
  ];

  @override
  String get bodyClass => 'neubrutalism-${theme.name}';

  @override
  String get componentCss => NeubrutalismCss.componentCss(theme);
}
