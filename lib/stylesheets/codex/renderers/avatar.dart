import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/avatar_props.dart';

/// Codex Avatar renderer.
///
/// Implements the Codex design language:
/// - Larger sizes (1.25x)
/// - Accent-colored border option
/// - Subtle glow on status indicator
class CodexAvatar extends StatelessComponent {
  final AvatarProps props;

  const CodexAvatar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes - 1.25x larger than ShadCN
    final String sizeValue = switch (props.size) {
      AvatarSize.xs => '28px', // vs ShadCN 24px
      AvatarSize.sm => '40px', // vs ShadCN 32px
      AvatarSize.md => '48px', // vs ShadCN 40px
      AvatarSize.lg => '64px', // vs ShadCN 56px
      AvatarSize.xl => '96px', // vs ShadCN 80px
    };

    final String fontSize = switch (props.size) {
      AvatarSize.xs => '10px',
      AvatarSize.sm => '14px',
      AvatarSize.md => '16px',
      AvatarSize.lg => '22px',
      AvatarSize.xl => '32px',
    };

    // Codex shape border radius
    final String borderRadius = switch (props.shape) {
      AvatarShape.circle => '9999px',
      AvatarShape.rounded => 'var(--radius)', // Codex larger radius
      AvatarShape.square => 'var(--radius-sm)',
    };

    // Status indicator size
    final String statusSize = switch (props.size) {
      AvatarSize.xs => '8px',
      AvatarSize.sm => '10px',
      AvatarSize.md => '12px',
      AvatarSize.lg => '14px',
      AvatarSize.xl => '16px',
    };

    return dom.div(
      classes: 'codex-avatar',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
        'width': sizeValue,
        'height': sizeValue,
        'flex-shrink': '0',
        if (props.onTap != null) 'cursor': 'pointer',
      }),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      [
        // Avatar image or fallback
        dom.div(
          classes: 'codex-avatar-inner',
          styles: dom.Styles(raw: {
            'width': '100%',
            'height': '100%',
            'border-radius': borderRadius,
            'overflow': 'hidden',
            'background-color': 'var(--muted)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            // Codex: use accent border if specified
            'border': props.borderColor != null
                ? '2px solid ${props.borderColor}'
                : '2px solid var(--border)',
            'box-sizing': 'border-box',
            'transition': 'all var(--transition)',
          }),
          [
            if (props.imageUrl != null)
              dom.img(
                src: props.imageUrl!,
                attributes: {'alt': props.initials ?? 'Avatar'},
                styles: const dom.Styles(raw: {
                  'width': '100%',
                  'height': '100%',
                  'object-fit': 'cover',
                }),
              )
            else if (props.initials != null)
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': fontSize,
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--muted-foreground)',
                  'text-transform': 'uppercase',
                  'user-select': 'none',
                }),
                [Component.text(props.initials!)],
              )
            else
              // Default user icon placeholder
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': fontSize,
                  'color': 'var(--muted-foreground)',
                }),
                [const Component.text('?')],
              ),
          ],
        ),

        // Status indicator with Codex glow
        if (props.showStatus)
          dom.div(
            classes: 'codex-avatar-status',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'right': '0',
              'width': statusSize,
              'height': statusSize,
              'border-radius': 'var(--arcane-radius-full)',
              'background-color': props.statusColor ?? 'var(--success)',
              // Codex: ring with card background
              'border': '2px solid var(--card)',
              // Codex: subtle glow on status
              'box-shadow': '0 14px 8px ${props.statusColor ?? 'var(--success)'}',
            }),
            [],
          ),
      ],
    );
  }
}
