import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/social_icons_props.dart';

/// Social media icon link.
class ArcaneSocialIcon extends StatelessComponent {
  final SocialPlatform platform;
  final String? url;
  final String size;
  final String? color;
  final bool showBackground;

  const ArcaneSocialIcon({
    required this.platform,
    this.url,
    this.size = '24px',
    this.color,
    this.showBackground = true,
    super.key,
  });

  const ArcaneSocialIcon.twitter({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.twitter;

  const ArcaneSocialIcon.github({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.github;

  const ArcaneSocialIcon.discord({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.discord;

  const ArcaneSocialIcon.youtube({this.url, this.size = '24px', this.color, this.showBackground = true, super.key})
      : platform = SocialPlatform.youtube;

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

/// Group of social icons.
class ArcaneSocialIconGroup extends StatelessComponent {
  final List<SocialIconProps> icons;
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

/// Social links component with labels.
class ArcaneSocialLinks extends StatelessComponent {
  final List<SocialLinkItem> links;
  final bool vertical;
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
