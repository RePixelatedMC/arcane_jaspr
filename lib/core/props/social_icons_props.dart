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

/// Social icon component properties.
class SocialIconProps {
  final SocialPlatform platform;
  final String? url;
  final String size;
  final String? color;
  final bool showBackground;

  const SocialIconProps({
    required this.platform,
    this.url,
    this.size = '24px',
    this.color,
    this.showBackground = true,
  });
}

/// Social icon group component properties.
class SocialIconGroupProps {
  final List<SocialIconProps> icons;
  final String gap;

  const SocialIconGroupProps({
    required this.icons,
    this.gap = '12px',
  });
}

/// Social link item data.
class SocialLinkItem {
  final SocialPlatform platform;
  final String url;
  final String? label;

  const SocialLinkItem({
    required this.platform,
    required this.url,
    this.label,
  });
}

/// Social links component properties.
class SocialLinksProps {
  final List<SocialLinkItem> links;
  final bool vertical;
  final String gap;

  const SocialLinksProps({
    required this.links,
    this.vertical = false,
    this.gap = '16px',
  });
}
