import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/social_icons_props.dart';

/// ShadCN Social Icon renderer.
class ShadcnSocialIcon extends StatelessComponent {
  final SocialIconProps props;

  const ShadcnSocialIcon(this.props, {super.key});

  String get _icon {
    return switch (props.platform) {
      SocialPlatform.twitter => '\ud835\udd4f',
      SocialPlatform.github => '\u2318',
      SocialPlatform.discord => '\ud83d\udcac',
      SocialPlatform.youtube => '\u25b6',
      SocialPlatform.linkedin => 'in',
      SocialPlatform.instagram => '\ud83d\udcf7',
      SocialPlatform.facebook => 'f',
      SocialPlatform.twitch => '\ud83d\udcfa',
      SocialPlatform.reddit => 'r/',
      SocialPlatform.tiktok => '\u266a',
    };
  }

  @override
  Component build(BuildContext context) {
    final String iconColor = props.color ?? 'var(--muted)';

    final Component content = dom.div(
      classes: 'arcane-social-icon',
      styles: dom.Styles(raw: {
        'width': props.size,
        'height': props.size,
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'border-radius': 'var(--arcane-radius-sm)',
        if (props.showBackground) 'background': 'var(--muted)',
        'color': iconColor,
        'font-size': 'calc(${props.size} * 0.5)',
        'font-weight': 'var(--font-weight-semibold)',
        'transition': 'all var(--arcane-transition)',
        'cursor': 'pointer',
      }),
      [Component.text(_icon)],
    );

    if (props.url != null) {
      return dom.a(
        href: props.url!,
        attributes: {'target': '_blank', 'rel': 'noopener noreferrer'},
        styles: const dom.Styles(raw: {'text-decoration': 'none'}),
        [content],
      );
    } else {
      return content;
    }
  }
}

/// ShadCN Social Icon Group renderer.
class ShadcnSocialIconGroup extends StatelessComponent {
  final SocialIconGroupProps props;

  const ShadcnSocialIconGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-social-icon-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': props.gap,
      }),
      [
        for (final iconProps in props.icons)
          ShadcnSocialIcon(iconProps),
      ],
    );
  }
}

/// ShadCN Social Links renderer.
class ShadcnSocialLinks extends StatelessComponent {
  final SocialLinksProps props;

  const ShadcnSocialLinks(this.props, {super.key});

  String _getIcon(SocialPlatform platform) {
    return switch (platform) {
      SocialPlatform.twitter => '\ud835\udd4f',
      SocialPlatform.github => '\u2318',
      SocialPlatform.discord => '\ud83d\udcac',
      SocialPlatform.youtube => '\u25b6',
      SocialPlatform.linkedin => 'in',
      SocialPlatform.instagram => '\ud83d\udcf7',
      SocialPlatform.facebook => 'f',
      SocialPlatform.twitch => '\ud83d\udcfa',
      SocialPlatform.reddit => 'r/',
      SocialPlatform.tiktok => '\u266a',
    };
  }

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-social-links',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': props.vertical ? 'column' : 'row',
        'align-items': props.vertical ? 'flex-start' : 'center',
        'gap': props.gap,
        'flex-wrap': 'wrap',
      }),
      [
        for (final link in props.links)
          dom.a(
            href: link.url,
            attributes: {'target': '_blank', 'rel': 'noopener noreferrer'},
            classes: 'arcane-social-link',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--space-2)',
              'text-decoration': 'none',
              'color': 'var(--muted-foreground)',
              'font-size': 'var(--font-size-sm)',
              'transition': 'all var(--arcane-transition)',
            }),
            [
              dom.span(
                styles: const dom.Styles(raw: {
                  'width': '20px',
                  'height': '20px',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': '10px',
                }),
                [Component.text(_getIcon(link.platform))],
              ),
              if (link.label != null)
                dom.span([Component.text(link.label!)]),
            ],
          ),
      ],
    );
  }
}
