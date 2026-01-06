import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/author_card_props.dart';

/// ShadCN Author Card renderer.
class ShadcnAuthorCard extends StatelessComponent {
  final AuthorCardProps props;

  const ShadcnAuthorCard(this.props, {super.key});

  (String avatarSize, String nameFontSize, String roleFontSize, String initialsFontSize) get _sizeStyles =>
      switch (props.size) {
        AuthorCardSize.sm => ('32px', '0.75rem', '0.75rem', '0.75rem'),
        AuthorCardSize.md => ('40px', '0.875rem', '0.75rem', '0.875rem'),
        AuthorCardSize.lg => ('48px', '1rem', '0.875rem', '1rem'),
      };

  @override
  Component build(BuildContext context) {
    final (avatarSize, nameFontSize, roleFontSize, initialsFontSize) = _sizeStyles;
    final effectiveNameColor = props.nameColor ?? 'var(--foreground)';
    final effectiveRoleColor = props.roleColor ?? 'var(--muted-foreground)';
    final effectiveInitials = props.initials ??
        (props.name.isNotEmpty ? props.name[0].toUpperCase() : '?');
    final effectiveAvatarBg = props.avatarBackground ?? 'var(--accent)';

    return dom.div(
      classes: 'arcane-author-card',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '1rem',
      }),
      [
        // Avatar
        dom.div(
          styles: dom.Styles(raw: {
            'width': avatarSize,
            'height': avatarSize,
            'border-radius': '50%',
            'overflow': 'hidden',
            'flex-shrink': '0',
            if (props.avatarUrl == null) 'background': effectiveAvatarBg,
            if (props.avatarUrl == null) 'display': 'flex',
            if (props.avatarUrl == null) 'align-items': 'center',
            if (props.avatarUrl == null) 'justify-content': 'center',
          }),
          [
            if (props.avatarUrl != null)
              dom.img(
                src: props.avatarUrl!,
                alt: props.name,
                styles: const dom.Styles(raw: {
                  'width': '100%',
                  'height': '100%',
                  'object-fit': 'cover',
                }),
              )
            else
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': initialsFontSize,
                  'font-weight': '600',
                  'color': 'var(--accent-foreground)',
                }),
                [Component.text(effectiveInitials)],
              ),
          ],
        ),
        // Name and role
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
          }),
          [
            dom.div(
              styles: dom.Styles(raw: {
                'font-size': nameFontSize,
                'font-weight': '600',
                'color': effectiveNameColor,
              }),
              [Component.text(props.name)],
            ),
            if (props.role != null)
              dom.div(
                styles: dom.Styles(raw: {
                  'font-size': roleFontSize,
                  'color': effectiveRoleColor,
                }),
                [Component.text(props.role!)],
              ),
          ],
        ),
      ],
    );
  }
}
