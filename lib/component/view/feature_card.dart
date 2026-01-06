import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// A feature card component (Supabase-style)
/// Used for showcasing product features with icon, title, and description
class ArcaneFeatureCard extends StatelessComponent {
  /// The feature title
  final String title;

  /// The feature description
  final String description;

  /// Optional icon component
  final Component? icon;

  /// Optional link URL
  final String? href;

  /// Click handler (alternative to href)
  final void Function()? onTap;

  /// Whether to show an arrow indicator
  final bool showArrow;

  /// Card orientation (vertical or horizontal)
  final bool horizontal;

  const ArcaneFeatureCard({
    required this.title,
    required this.description,
    this.icon,
    this.href,
    this.onTap,
    this.showArrow = false,
    this.horizontal = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final bool isClickable = href != null || onTap != null;

    final List<Component> content = [
      // Icon
      if (icon != null)
        div(
          classes: 'arcane-feature-card-icon',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '48px',
            'height': '48px',
            'border-radius': '0.375rem',
            'background-color': 'hsl(var(--accent) / 0.1)',
            'color': 'var(--accent)',
            'flex-shrink': '0',
            if (!horizontal) 'margin-bottom': '1.5rem',
          }),
          [icon!],
        ),

      // Content
      div(
        classes: 'arcane-feature-card-content',
        styles: const Styles(raw: {
          'flex': '1',
        }),
        [
          // Title with optional arrow
          div(
            classes: 'arcane-feature-card-title',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.5rem',
              'font-size': '1.125rem',
              'font-weight': '600',
              'color': 'var(--foreground)',
              'margin-bottom': '0.5rem',
            }),
            [
              text(title),
              if (showArrow && isClickable)
                span(
                  classes: 'arcane-feature-card-arrow',
                  styles: const Styles(raw: {
                    'transition': 'all 150ms ease',
                  }),
                  [text('→')],
                ),
            ],
          ),

          // Description
          p(
            classes: 'arcane-feature-card-description',
            styles: const Styles(raw: {
              'font-size': '1rem',
              'line-height': '1.7',
              'color': 'var(--muted-foreground)',
              'margin': '0',
            }),
            [text(description)],
          ),
        ],
      ),
    ];

    final Map<String, String> cardStyles = {
      'display': 'flex',
      'flex-direction': horizontal ? 'row' : 'column',
      'gap': horizontal ? '1.5rem' : '0',
      'padding': '2rem',
      'background-color': 'var(--card)',
      'border': '1px solid var(--border)',
      'border-radius': '0.75rem',
      'transition': 'all 200ms ease',
      if (isClickable) 'cursor': 'pointer',
    };

    if (href != null) {
      return a(
        classes: 'arcane-feature-card',
        href: href!,
        styles: Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        content,
      );
    }

    if (onTap != null) {
      return button(
        classes: 'arcane-feature-card',
        attributes: {'type': 'button'},
        styles: Styles(raw: {
          ...cardStyles,
          'text-align': 'left',
          'border': '1px solid var(--border)',
        }),
        events: {'click': (e) => onTap!()},
        content,
      );
    }

    return div(
      classes: 'arcane-feature-card',
      styles: Styles(raw: cardStyles),
      content,
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-feature-card:hover').styles(raw: {
      'border-color': 'var(--accent)',
    }),
    css('.arcane-feature-card:hover .arcane-feature-card-arrow').styles(raw: {
      'transform': 'translateX(4px)',
    }),
  ];
}

/// A simple icon card for feature grids
class ArcaneIconCard extends StatelessComponent {
  /// The card title
  final String title;

  /// Optional subtitle
  final String? subtitle;

  /// Icon component
  final Component icon;

  /// Click handler
  final void Function()? onTap;

  /// Optional link
  final String? href;

  const ArcaneIconCard({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final bool isClickable = href != null || onTap != null;

    final List<Component> content = [
      div(
        classes: 'arcane-icon-card-icon',
        styles: const Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '40px',
          'height': '40px',
          'border-radius': '0.375rem',
          'background-color': 'var(--muted)',
          'color': 'var(--accent)',
          'margin-bottom': '1rem',
        }),
        [icon],
      ),
      span(
        classes: 'arcane-icon-card-title',
        styles: const Styles(raw: {
          'font-size': '1rem',
          'font-weight': '500',
          'color': 'var(--foreground)',
        }),
        [text(title)],
      ),
      if (subtitle != null)
        span(
          classes: 'arcane-icon-card-subtitle',
          styles: const Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--muted-foreground)',
            'margin-top': '0.25rem',
          }),
          [text(subtitle!)],
        ),
    ];

    final Map<String, String> cardStyles = {
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'center',
      'text-align': 'center',
      'padding': '1.5rem',
      'background-color': 'var(--card)',
      'border': '1px solid var(--border)',
      'border-radius': '0.375rem',
      'transition': 'all 200ms ease',
      if (isClickable) 'cursor': 'pointer',
    };

    if (href != null) {
      return a(
        classes: 'arcane-icon-card',
        href: href!,
        styles: Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        content,
      );
    }

    if (onTap != null) {
      return button(
        classes: 'arcane-icon-card',
        attributes: {'type': 'button'},
        styles: Styles(raw: {
          ...cardStyles,
          'border': '1px solid var(--border)',
        }),
        events: {'click': (e) => onTap!()},
        content,
      );
    }

    return div(
      classes: 'arcane-icon-card',
      styles: Styles(raw: cardStyles),
      content,
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-icon-card:hover').styles(raw: {
      'border-color': 'var(--accent)',
      'background-color': 'var(--muted)',
    }),
  ];
}
