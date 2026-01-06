import 'package:jaspr/jaspr.dart';

/// A logo item for carousels and grids.
class LogoItem {
  /// Logo name/alt text
  final String name;

  /// Image URL
  final String? imageUrl;

  /// Custom logo component
  final Component? customLogo;

  /// Optional link URL
  final String? href;

  const LogoItem({
    required this.name,
    this.imageUrl,
    this.customLogo,
    this.href,
  });
}

/// Properties for infinite scrolling logo carousel.
class LogoCarouselProps {
  /// Logo items
  final List<LogoItem> logos;

  /// Animation duration in seconds
  final int duration;

  /// Logo height in pixels
  final double logoHeight;

  /// Gap between logos in pixels
  final double gap;

  /// Whether to pause on hover
  final bool pauseOnHover;

  /// Whether to reverse direction
  final bool reverse;

  /// Whether to grayscale logos
  final bool grayscale;

  /// Optional title above carousel
  final String? title;

  const LogoCarouselProps({
    required this.logos,
    this.duration = 30,
    this.logoHeight = 40,
    this.gap = 48,
    this.pauseOnHover = true,
    this.reverse = false,
    this.grayscale = true,
    this.title,
  });
}

/// Properties for static logo grid.
class LogoGridProps {
  /// Logo items
  final List<LogoItem> logos;

  /// Logo height in pixels
  final double logoHeight;

  /// Gap between logos in pixels
  final double gap;

  /// Whether to grayscale logos
  final bool grayscale;

  /// Optional title
  final String? title;

  /// Number of columns
  final int columns;

  const LogoGridProps({
    required this.logos,
    this.logoHeight = 40,
    this.gap = 32,
    this.grayscale = true,
    this.title,
    this.columns = 6,
  });
}
