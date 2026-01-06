import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/arcane.dart';

/// A card with section-style content organization.
class ArcaneCardSection extends StatelessComponent {
  /// Section header
  final String? header;

  /// Header component (overrides header string)
  final Component? headerComponent;

  /// The child components
  final List<Component> children;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Gap between children
  final double gap;

  /// Trailing actions for the header
  final List<Component>? trailing;

  const ArcaneCardSection({
    this.header,
    this.headerComponent,
    required this.children,
    this.padding,
    this.radius,
    this.gap = 12,
    this.trailing,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String effectiveRadius = radius != null ? '${radius}px' : '0.5rem';
    final EdgeInsets effectivePadding = padding ?? const EdgeInsets.all(16);

    final Component? headerWidget = headerComponent ??
        (header != null
            ? div(
                classes: 'arcane-card-section-header',
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'gap': '1rem',
                  'margin-bottom': '${gap}px',
                }),
                [
                  span(
                    styles: const Styles(raw: {
                      'font-size': '0.875rem',
                      'font-weight': '600',
                      'color': 'var(--muted-foreground)',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.05em',
                    }),
                    [text(header!)],
                  ),
                  if (trailing != null && trailing!.isNotEmpty)
                    div(
                      styles: const Styles(raw: {
                        'display': 'flex',
                        'gap': '0.5rem',
                      }),
                      trailing!,
                    ),
                ],
              )
            : null);

    return div(
      classes: 'arcane-card-section',
      styles: Styles(raw: {
        'background-color': 'var(--card)',
        'border-radius': effectiveRadius,
        'border': '1px solid var(--border)',
        'padding': effectivePadding.padding,
      }),
      [
        if (headerWidget != null) headerWidget,
        div(
          classes: 'arcane-card-section-content',
          styles: Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '${gap}px',
          }),
          children,
        ),
      ],
    );
  }
}

/// A list card that contains list items
class ArcaneListCard extends StatelessComponent {
  final String? header;
  final List<Component> children;
  final double? radius;
  final bool divided;

  const ArcaneListCard({
    this.header,
    required this.children,
    this.radius,
    this.divided = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String effectiveRadius = radius != null ? '${radius}px' : '0.5rem';

    return div(
      classes: 'arcane-list-card',
      styles: Styles(raw: {
        'background-color': 'var(--card)',
        'border-radius': effectiveRadius,
        'border': '1px solid var(--border)',
        'overflow': 'hidden',
      }),
      [
        if (header != null)
          div(
            classes: 'arcane-list-card-header',
            styles: const Styles(raw: {
              'padding': '1rem 1.5rem',
              'font-size': '0.875rem',
              'font-weight': '600',
              'color': 'var(--muted-foreground)',
              'border-bottom': '1px solid var(--border)',
              'background-color': 'var(--muted)',
            }),
            [text(header!)],
          ),
        for (var i = 0; i < children.length; i++) ...[
          children[i],
          if (divided && i < children.length - 1)
            div(
              styles: const Styles(raw: {
                'height': '1px',
                'background-color': 'var(--border)',
                'margin': '0 1.5rem',
              }),
              [],
            ),
        ],
      ],
    );
  }
}
