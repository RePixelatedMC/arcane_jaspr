import 'package:arcane_jaspr/theme/index.dart';
import 'package:arcane_jaspr/stylesheets/stylesheet.dart';

import 'neon_css.dart';
import 'neon_fonts.dart';
import 'neon_layout_renderers.dart';
import 'neon_theme.dart';
import 'renderers/neon_renderers.dart';

/// Neon stylesheet - premium dark design language.
///
/// Implements a dark-first visual system:
/// - High-contrast surfaces with restrained accent emphasis
/// - Configurable accent themes (Green/Red/Blue/Purple/Rainbow)
/// - Premium typography with clear hierarchy
/// - Focused interaction states and subtle atmosphere effects
/// - ITCAvantGardeStd font for headings and titles
/// - Akzidenz-GroteskPro font for body text
/// - Hack font for code
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

  // ============================================
  // Theme Seeds
  // ============================================

  @override
  ThemeSeed get lightSeed => ThemeSeed(
    primary: theme.color,
    background: 0xFFeef2f5,
    secondary: theme.lightSecondary,
    accent: theme.lightAccent,
    border: theme.lightBorder,
    destructive: 0xFFb4233c,
    success: 0xFF087f5b,
    warning: 0xFF9a5b00,
    info: 0xFF075985,
  );

  @override
  ThemeSeed get darkSeed => ThemeSeed(
    primary: theme.color,
    background: 0xFF020204,
    secondary: 0xFF07110f,
    accent: 0xFF0b1d1a,
    border: 0xFF17352f,
    destructive: 0xFF8f1238,
    success: 0xFF087a55,
    warning: 0xFF9b5a05,
    info: 0xFF075985,
    isDark: true,
    accentGlow: false,
  );

  // ============================================
  // Fonts
  // ============================================

  @override
  FontConfig get fonts => const FontConfig(
    sans:
        "'Akzidenz-GroteskPro', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif",
    heading:
        "'ITCAvantGardeStd', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, sans-serif",
    mono:
        "'Hack', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace",
  );

  // ============================================
  // Border Radius
  // ============================================

  @override
  RadiusConfig get radius => const RadiusConfig.compact();

  @override
  String get fontFaces => NeonFonts.fontFaces;

  @override
  String get bodyClass => 'neon-${theme.name}';

  @override
  String get componentCss => NeonCss.componentCss(theme);
}
