import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/author_card_props.dart';

/// Codex AuthorCard renderer.
class CodexAuthorCard extends StatelessComponent {
  final AuthorCardProps props;

  const CodexAuthorCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final int avatarSize = switch (props.size) {
      AuthorCardSize.sm => 32,
      AuthorCardSize.md => 40,
      AuthorCardSize.lg => 48,
    };

    final String nameFontSize = switch (props.size) {
      AuthorCardSize.sm => '0.8125rem',
      AuthorCardSize.md => '0.875rem',
      AuthorCardSize.lg => '1rem',
    };

    final String roleFontSize = switch (props.size) {
      AuthorCardSize.sm => '0.6875rem',
      AuthorCardSize.md => '0.75rem',
      AuthorCardSize.lg => '0.8125rem',
    };

    return dom.div(
      classes: 'codex-author-card codex-author-card-${props.size.name}',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.75rem',
      }),
      [
        // Avatar
        dom.div(
          classes: 'codex-author-avatar',
          styles: dom.Styles(raw: {
            'width': '${avatarSize}px',
            'height': '${avatarSize}px',
            'border-radius': '50%',
            'overflow': 'hidden',
            'flex-shrink': '0',
            'background-color':
                props.avatarBackground ?? 'var(--codex-accent)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
          }),
          [
            if (props.avatarUrl != null)
              dom.img(
                src: props.avatarUrl!,
                styles: const dom.Styles(raw: {
                  'width': '100%',
                  'height': '100%',
                  'object-fit': 'cover',
                }),
              )
            else
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': '${avatarSize * 0.4}px',
                  'font-weight': '600',
                  'color': '#ffffff',
                }),
                [
                  Component.text(
                    props.initials ?? props.name.substring(0, 1).toUpperCase(),
                  ),
                ],
              ),
          ],
        ),

        // Info
        dom.div(
          classes: 'codex-author-info',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '0.125rem',
          }),
          [
            dom.span(
              classes: 'codex-author-name',
              styles: dom.Styles(raw: {
                'font-size': nameFontSize,
                'font-weight': '500',
                'color': props.nameColor ?? 'var(--foreground)',
              }),
              [Component.text(props.name)],
            ),
            if (props.role != null)
              dom.span(
                classes: 'codex-author-role',
                styles: dom.Styles(raw: {
                  'font-size': roleFontSize,
                  'color': props.roleColor ?? 'var(--muted-foreground)',
                }),
                [Component.text(props.role!)],
              ),
          ],
        ),
      ],
    );
  }
}
