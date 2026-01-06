import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../core/theme_provider.dart';

export '../../core/props/logo_carousel_props.dart';

/// Re-export for backwards compatibility
typedef ArcaneLogoItem = LogoItem;

/// An infinite scrolling logo carousel (Supabase-style)
class ArcaneLogoCarousel extends StatelessComponent {
  /// Logo items
  final List<LogoItem> logos;

  /// Animation duration in seconds
  final int duration;

  /// Logo height
  final double logoHeight;

  /// Gap between logos
  final double gap;

  /// Whether to pause on hover
  final bool pauseOnHover;

  /// Whether to reverse direction
  final bool reverse;

  /// Grayscale logos
  final bool grayscale;

  /// Optional title above the carousel
  final String? title;

  const ArcaneLogoCarousel({
    required this.logos,
    this.duration = 30,
    this.logoHeight = 40,
    this.gap = 48,
    this.pauseOnHover = true,
    this.reverse = false,
    this.grayscale = true,
    this.title,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.logoCarousel(LogoCarouselProps(
      logos: logos,
      duration: duration,
      logoHeight: logoHeight,
      gap: gap,
      pauseOnHover: pauseOnHover,
      reverse: reverse,
      grayscale: grayscale,
      title: title,
    ));
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-scroll').styles(raw: {
      '0%': 'transform: translateX(0)',
      '100%': 'transform: translateX(-50%)',
    }),
    css('@keyframes arcane-scroll-reverse').styles(raw: {
      '0%': 'transform: translateX(-50%)',
      '100%': 'transform: translateX(0)',
    }),
    css('.arcane-logo-carousel-track.pause-on-hover:hover').styles(raw: {
      'animation-play-state': 'paused',
    }),
    css('.arcane-logo-carousel-item:hover img').styles(raw: {
      'filter': 'grayscale(0%)',
      'opacity': '1',
    }),
    css('.arcane-logo-carousel-item:hover span').styles(raw: {
      'filter': 'grayscale(0%)',
      'opacity': '1',
      'color': 'var(--foreground)',
    }),
  ];
}

/// A static logo grid
class ArcaneLogoGrid extends StatelessComponent {
  /// Logo items
  final List<LogoItem> logos;

  /// Logo height
  final double logoHeight;

  /// Gap between logos
  final double gap;

  /// Grayscale logos
  final bool grayscale;

  /// Optional title
  final String? title;

  /// Number of columns
  final int columns;

  const ArcaneLogoGrid({
    required this.logos,
    this.logoHeight = 40,
    this.gap = 32,
    this.grayscale = true,
    this.title,
    this.columns = 6,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.logoGrid(LogoGridProps(
      logos: logos,
      logoHeight: logoHeight,
      gap: gap,
      grayscale: grayscale,
      title: title,
      columns: columns,
    ));
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-logo-grid-item:hover img').styles(raw: {
      'filter': 'grayscale(0%)',
      'opacity': '1',
    }),
  ];
}
