import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';

/// A list tile component for displaying items in a list.
class ArcaneTile extends StatelessComponent {
  /// Title text
  final String? title;

  /// Title component (overrides title string)
  final Component? titleWidget;

  /// Subtitle text
  final String? subtitle;

  /// Subtitle component (overrides subtitle string)
  final Component? subtitleWidget;

  /// Leading component (usually an icon or avatar)
  final Component? leading;

  /// Trailing component (usually an action button or info)
  final Component? trailing;

  /// Click handler
  final void Function()? onTap;

  /// Whether the tile is selected
  final bool selected;

  /// Whether the tile is disabled
  final bool disabled;

  /// Custom padding
  final EdgeInsets? padding;

  /// Whether to use dense layout
  final bool dense;

  const ArcaneTile({
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    this.padding,
    this.dense = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: 16,
          vertical: dense ? 8 : 12,
        );

    return div(
      classes:
          'arcane-tile ${selected ? 'selected' : ''} ${disabled ? 'disabled' : ''} ${onTap != null ? 'clickable' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'padding': effectivePadding.padding,
        'background-color':
            selected ? 'hsl(var(--accent) / 0.1)' : 'transparent',
        'cursor': disabled
            ? 'not-allowed'
            : (onTap != null ? 'pointer' : 'default'),
        'opacity': disabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'border-radius': '0.375rem',
      }),
      events: onTap != null && !disabled
          ? {
              'click': (event) => onTap!(),
            }
          : null,
      [
        // Leading
        if (leading != null)
          div(
            classes: 'arcane-tile-leading',
            styles: Styles(raw: {
              'flex-shrink': '0',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': selected ? 'var(--accent)' : 'var(--muted-foreground)',
            }),
            [leading!],
          ),

        // Content
        div(
          classes: 'arcane-tile-content',
          styles: Styles(raw: {
            'flex': '1',
            'min-width': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': dense ? '2px' : '0.25rem',
          }),
          [
            // Title
            if (titleWidget != null)
              titleWidget!
            else if (title != null)
              span(
                classes: 'arcane-tile-title',
                styles: Styles(raw: {
                  'font-size': dense ? '0.875rem' : '1rem',
                  'font-weight': '500',
                  'color': selected ? 'var(--accent)' : 'var(--foreground)',
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [text(title!)],
              ),

            // Subtitle
            if (subtitleWidget != null)
              subtitleWidget!
            else if (subtitle != null)
              span(
                classes: 'arcane-tile-subtitle',
                styles: Styles(raw: {
                  'font-size': dense ? '0.75rem' : '0.875rem',
                  'color': selected ? 'var(--accent)' : 'var(--muted-foreground)',
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [text(subtitle!)],
              ),
          ],
        ),

        // Trailing
        if (trailing != null)
          div(
            classes: 'arcane-tile-trailing',
            styles: Styles(raw: {
              'flex-shrink': '0',
              'display': 'flex',
              'align-items': 'center',
              'color': selected ? 'var(--accent)' : 'var(--muted-foreground)',
            }),
            [trailing!],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-tile.clickable:hover:not(.disabled)').styles(raw: {
      'background-color': 'var(--muted)',
    }),
    css('.arcane-tile.clickable.selected:hover:not(.disabled)').styles(raw: {
      'background-color': 'hsl(var(--accent) / 0.1)',
    }),
  ];
}

/// A navigation tile for sidebar or list navigation
class ArcaneNavTile extends StatelessComponent {
  final String label;
  final Component? icon;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;
  final String? badge;

  const ArcaneNavTile({
    required this.label,
    this.icon,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    this.badge,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes:
          'arcane-nav-tile ${selected ? 'selected' : ''} ${disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (disabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'width': '100%',
        'padding': '0.5rem 1rem',
        'background-color':
            selected ? 'hsl(var(--accent) / 0.1)' : 'transparent',
        'color': selected ? 'var(--accent)' : 'var(--foreground)',
        'border-radius': '0.375rem',
        'border': 'none',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'text-align': 'left',
        'font-size': '1rem',
        'font-weight': selected ? '600' : '500',
      }),
      events: {
        'click': (event) {
          if (!disabled && onTap != null) {
            onTap!();
          }
        },
      },
      [
        if (icon != null)
          div(
            styles: const Styles(raw: {
              'flex-shrink': '0',
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            }),
            [icon!],
          ),
        span(
          styles: const Styles(raw: {
            'flex': '1',
            'overflow': 'hidden',
            'text-overflow': 'ellipsis',
            'white-space': 'nowrap',
          }),
          [text(label)],
        ),
        if (badge != null)
          span(
            classes: 'arcane-nav-tile-badge',
            styles: const Styles(raw: {
              'background-color': 'var(--accent)',
              'color': 'var(--accent-foreground)',
              'font-size': '0.75rem',
              'padding': '2px 6px',
              'border-radius': '9999px',
              'font-weight': '500',
            }),
            [text(badge!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-nav-tile:hover:not(:disabled):not(.selected)').styles(raw: {
      'background-color': 'var(--muted)',
    }),
  ];
}
