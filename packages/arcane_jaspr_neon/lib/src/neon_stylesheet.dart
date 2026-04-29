import 'package:arcane_jaspr/theme/index.dart';
import 'package:arcane_jaspr/stylesheets/stylesheet.dart';

import 'neon_css.dart';
import 'neon_fonts.dart';
import 'neon_layout_renderers.dart';
import 'neon_theme.dart';
import 'renderers/neon_renderers.dart';

class NeonStylesheet extends ArcaneStylesheet {
  final NeonTheme theme;

  const NeonStylesheet({this.theme = NeonTheme.green});

  @override
  String get id => 'neon';

  @override
  String get name => 'Neon';

  @override
  ComponentRenderers get renderers => const NeonRenderers();

  @override
  LayoutRenderers get layouts => const NeonLayoutRenderers();

  @override
  ThemeSeed get lightSeed => ThemeSeed(
    primary: theme.color,
    background: theme.lightSurface,
    secondary: theme.lightSecondary,
    accent: theme.lightAccent,
    border: theme.lightBorder,
    destructive: 0xFFb4233c,
    success: 0xFF087f5b,
    warning: 0xFF9a5b00,
    info: 0xFF075985,
    accentGlow: false,
  );

  @override
  ThemeSeed get darkSeed => ThemeSeed(
    primary: theme.color,
    background: 0xFF12151C,
    secondary: 0xFF191D26,
    accent: 0xFF1B222C,
    border: 0xFF3E3E42,
    destructive: 0xFF661B1C,
    success: 0xFF1F8A65,
    warning: 0xFFB86B16,
    info: 0xFF007ACC,
    isDark: true,
    accentGlow: true,
    glowColor: theme.color,
  );

  @override
  FontConfig get fonts => const FontConfig(
    sans:
        "'Akzidenz-GroteskPro', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif",
    heading:
        "'ITCAvantGardeStd', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif",
    mono:
        "'Hack', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace",
  );

  @override
  RadiusConfig get radius => const RadiusConfig.compact();

  @override
  String get fontFaces => NeonFonts.fontFaces;

  @override
  String get bodyClass => 'neon-${theme.name}';

  @override
  String get componentCss => NeonCss.componentCss(theme);
}
