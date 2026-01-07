import 'package:jaspr/jaspr.dart';

/// Logo item data.
class LogoItem {
  final String name;
  final String? imageUrl;
  final Component? customLogo;
  final String? href;

  const LogoItem({
    required this.name,
    this.imageUrl,
    this.customLogo,
    this.href,
  });
}

/// Logo carousel component properties.
class LogoCarouselProps {
  final List<LogoItem> logos;
  final int duration;
  final double logoHeight;
  final double gap;
  final bool pauseOnHover;
  final bool reverse;
  final bool grayscale;
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

/// Logo grid component properties.
class LogoGridProps {
  final List<LogoItem> logos;
  final double logoHeight;
  final double gap;
  final bool grayscale;
  final String? title;
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
