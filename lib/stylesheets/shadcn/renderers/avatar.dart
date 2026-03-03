import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/avatar_props.dart';

/// ShadCN Avatar renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/avatar
class ShadcnAvatar extends StatelessComponent {
  final AvatarProps props;

  const ShadcnAvatar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // ShadCN Avatar sizes (default h-10 w-10 = 40px)
    final (dimension, fontSize, statusSize) = switch (props.size) {
      AvatarSize.xs => ('24px', '10px', '8px'),
      AvatarSize.sm => ('32px', '12px', '10px'),
      AvatarSize.md => ('40px', '14px', '12px'), // ShadCN default
      AvatarSize.lg => ('56px', '18px', '14px'),
      AvatarSize.xl => ('80px', '24px', '18px'),
    };

    // Shape-specific border radius
    final borderRadius = switch (props.shape) {
      AvatarShape.circle => '9999px', // rounded-full
      AvatarShape.rounded => '0.5rem', // rounded-md
      AvatarShape.square => '0', // rounded-none
    };

    // ShadCN: relative flex h-10 w-10 shrink-0 overflow-hidden rounded-full
    final Map<String, String> containerStyles = {
      'position': 'relative',
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'flex-shrink': '0',
      'overflow': 'hidden',
      'width': dimension,
      'height': dimension,
      'border-radius': borderRadius,
      if (props.borderColor != null) 'border': '2px solid ${props.borderColor}',
      if (props.onTap != null) 'cursor': 'pointer',
    };

    final List<Component> children = [];

    // Image or fallback
    if (props.imageUrl != null) {
      // ShadCN AvatarImage: aspect-square h-full w-full
      children.add(
        dom.img(
          classes: 'arcane-avatar-image',
          src: props.imageUrl!,
          alt: props.initials ?? 'Avatar',
          styles: const dom.Styles(raw: {
            'aspect-ratio': '1',
            'height': '100%',
            'width': '100%',
            'object-fit': 'cover',
          }),
        ),
      );
    } else {
      // ShadCN AvatarFallback: flex h-full w-full items-center justify-center rounded-full bg-muted
      children.add(
        dom.div(
          classes: 'arcane-avatar-fallback',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'height': '100%',
            'width': '100%',
            'align-items': 'center',
            'justify-content': 'center',
            'border-radius': borderRadius,
            'background-color': 'var(--muted)',
            'color': 'var(--muted-foreground)',
            'font-weight': 'var(--font-weight-medium)',
            'font-size': fontSize,
            'text-transform': 'uppercase',
          }),
          [if (props.initials != null) Component.text(props.initials!)],
        ),
      );
    }

    // Status indicator
    if (props.showStatus) {
      children.add(
        dom.div(
          classes: 'arcane-avatar-status',
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'bottom': '0',
            'right': '0',
            'width': statusSize,
            'height': statusSize,
            'border-radius': 'var(--radius-full)',
            'background-color': props.statusColor ?? 'var(--success, #22c55e)',
            'border': '2px solid var(--background)',
          }),
          [],
        ),
      );
    }

    return dom.div(
      classes: 'arcane-avatar',
      styles: dom.Styles(raw: containerStyles),
      events: props.onTap != null
          ? {'click': (event) => props.onTap!()}
          : null,
      children,
    );
  }
}
