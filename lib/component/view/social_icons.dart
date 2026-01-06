import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/social_icons_props.dart';

/// Social media icon link
class ArcaneSocialIcon extends StatelessComponent {
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

  const ArcaneSocialIcon({
    required this.platform,
    this.url,
    this.size = '24px',
    this.color,
    this.showBackground = true,
    super.key,
  });

  /// Named constructor for Twitter/X
  const ArcaneSocialIcon.twitter({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.twitter;

  /// Named constructor for GitHub
  const ArcaneSocialIcon.github({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.github;

  /// Named constructor for Discord
  const ArcaneSocialIcon.discord({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.discord;

  /// Named constructor for YouTube
  const ArcaneSocialIcon.youtube({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.youtube;

  /// Named constructor for LinkedIn
  const ArcaneSocialIcon.linkedin({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.linkedin;

  @override
  Component build(BuildContext context) {
    return context.renderers.socialIcon(SocialIconProps(
      platform: platform,
      url: url,
      size: size,
      color: color,
      showBackground: showBackground,
    ));
  }
}

/// Group of social icons
class ArcaneSocialIconGroup extends StatelessComponent {
  /// Icons to display (as props)
  final List<SocialIconProps> icons;

  /// Gap between icons
  final String gap;

  const ArcaneSocialIconGroup({
    required this.icons,
    this.gap = '12px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.socialIconGroup(SocialIconGroupProps(
      icons: icons,
      gap: gap,
    ));
  }
}

/// Social links component with labels
class ArcaneSocialLinks extends StatelessComponent {
  /// Social link items
  final List<SocialLinkItem> links;

  /// Orientation (horizontal or vertical)
  final bool vertical;

  /// Gap between items
  final String gap;

  const ArcaneSocialLinks({
    required this.links,
    this.vertical = false,
    this.gap = '16px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.socialLinks(SocialLinksProps(
      links: links,
      gap: gap,
      vertical: vertical,
    ));
  }
}

