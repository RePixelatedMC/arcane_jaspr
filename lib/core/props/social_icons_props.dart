import 'package:jaspr/jaspr.dart';

/// Social media platforms
enum SocialPlatform {
  twitter,
  github,
  discord,
  youtube,
  linkedin,
  instagram,
  facebook,
  twitch,
  reddit,
  tiktok,
}

/// Props for social icon component.
class SocialIconProps {
  /// Platform to display
  final SocialPlatform platform;

  /// Link URL (optional)
  final String? url;

  /// Icon size
  final String size;

  /// Custom color
  final String? color;

  /// Whether to show background
  final bool showBackground;

  const SocialIconProps({
    required this.platform,
    this.url,
    this.size = '24px',
    this.color,
    this.showBackground = true,
  });
}

/// Props for social icon group component.
class SocialIconGroupProps {
  /// Icons to display
  final List<SocialIconProps> icons;

  /// Gap between icons
  final String gap;

  const SocialIconGroupProps({
    required this.icons,
    this.gap = '12px',
  });
}

/// A social link item
class SocialLinkItem {
  /// Platform
  final SocialPlatform platform;

  /// URL
  final String url;

  /// Optional label
  final String? label;

  const SocialLinkItem({
    required this.platform,
    required this.url,
    this.label,
  });
}

/// Props for social links component.
class SocialLinksProps {
  /// Social link items
  final List<SocialLinkItem> links;

  /// Orientation (horizontal or vertical)
  final bool vertical;

  /// Gap between items
  final String gap;

  const SocialLinksProps({
    required this.links,
    this.vertical = false,
    this.gap = '16px',
  });
}
