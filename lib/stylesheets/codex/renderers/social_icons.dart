import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/social_icons_props.dart';

/// Codex Social Icon renderer.
class CodexSocialIcon extends StatelessComponent {
  final SocialIconProps props;

  const CodexSocialIcon(this.props, {super.key});

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
    final String iconColor = props.color ?? 'var(--muted-foreground)';

    final Component content = dom.div(
      classes: 'codex-social-icon',
      styles: dom.Styles(raw: {
        'width': props.size,
        'height': props.size,
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'border-radius': 'var(--radius)',
        if (props.showBackground) 'background': 'var(--secondary)',
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

/// Codex Social Icon Group renderer.
class CodexSocialIconGroup extends StatelessComponent {
  final SocialIconGroupProps props;

  const CodexSocialIconGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-social-icon-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': props.gap,
      }),
      [
        for (final iconProps in props.icons)
          CodexSocialIcon(iconProps),
      ],
    );
  }
}

/// Codex Social Links renderer.
class CodexSocialLinks extends StatelessComponent {
  final SocialLinksProps props;

  const CodexSocialLinks(this.props, {super.key});

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
      classes: 'codex-social-links',
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
            classes: 'codex-social-link',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.75rem',
              'text-decoration': 'none',
              'color': 'var(--muted-foreground)',
              'font-size': 'var(--font-size-sm)',
              'transition': 'all var(--arcane-transition)',
            }),
            [
              dom.span(
                styles: const dom.Styles(raw: {
                  'width': '24px',
                  'height': '24px',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': '12px',
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
