import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

/// A card component with consistent styling.
///
/// ```dart
/// ArcaneCard(
///   variant: CardVariant.elevated,
///   child: Text('Content'),
/// )
///
/// ArcaneCard(
///   children: [
///     ArcaneHeading.h3(text: 'Title'),
///     Text('Content'),
///   ],
///   onClick: () => print('clicked'),
/// )
/// ```
class ArcaneCard extends StatelessComponent {
  /// The child component (single)
  final Component? _child;

  /// The children components
  final List<Component>? _children;

  /// Visual style variant
  final CardVariant variant;

  /// Custom padding
  final String? padding;

  /// Border radius
  final String? borderRadius;

  /// Click handler
  final void Function()? _onTap;

  /// Custom background color
  final String? backgroundColor;

  /// Whether to fill width
  final bool fillWidth;

  const ArcaneCard({
    Component? child,
    List<Component>? children,
    this.variant = CardVariant.elevated,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    void Function()? onClick,
    this.backgroundColor,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Elevated card with shadow
  const ArcaneCard.elevated({
    Component? child,
    List<Component>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    void Function()? onClick,
    this.backgroundColor,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        variant = CardVariant.elevated,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Flat card without shadow
  const ArcaneCard.flat({
    Component? child,
    List<Component>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    void Function()? onClick,
    this.backgroundColor,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        variant = CardVariant.flat,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Outlined card (border only)
  const ArcaneCard.outlined({
    Component? child,
    List<Component>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    void Function()? onClick,
    this.backgroundColor,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        variant = CardVariant.outlined,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Ghost card (no border, no background)
  const ArcaneCard.ghost({
    Component? child,
    List<Component>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    void Function()? onClick,
    this.backgroundColor,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        variant = CardVariant.ghost,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Glass/frosted card
  const ArcaneCard.glass({
    Component? child,
    List<Component>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    void Function()? onClick,
    this.backgroundColor,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        variant = CardVariant.glass,
        assert(child != null || children != null,
            'Either child or children must be provided');

  /// Interactive card (shows hover effect)
  const ArcaneCard.interactive({
    Component? child,
    List<Component>? children,
    this.padding,
    this.borderRadius,
    void Function()? onTap,
    void Function()? onClick,
    this.backgroundColor,
    this.fillWidth = false,
    super.key,
  })  : _child = child,
        _children = children,
        _onTap = onTap ?? onClick,
        variant = CardVariant.interactive,
        assert(child != null || children != null,
            'Either child or children must be provided');

  @override
  Component build(BuildContext context) {
    return context.renderers.card(CardProps(
      child: _child,
      children: _children,
      variant: variant,
      padding: padding,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      fillWidth: fillWidth,
      onTap: _onTap,
    ));
  }
}

/// A card with header, body, and footer sections
class ArcaneStructuredCard extends StatelessComponent {
  final Component? header;
  final Component body;
  final Component? footer;
  final EdgeInsets? padding;
  final double? radius;
  final bool border;
  final int elevation;
  final void Function()? _onTap;

  /// Creates a structured card.
  ///
  /// Use [onTap] or [onClick] for click handling.
  const ArcaneStructuredCard({
    this.header,
    required this.body,
    this.footer,
    this.padding,
    this.radius,
    this.border = true,
    this.elevation = 0,
    void Function()? onTap,
    void Function()? onClick,
    super.key,
  }) : _onTap = onTap ?? onClick;

  @override
  Component build(BuildContext context) {
    // Generate shadow based on elevation
    final boxShadow = switch (elevation) {
      0 => 'none',
      1 => '0 1px 2px 0 rgb(0 0 0 / 0.05)',
      2 => '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
      3 => '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
      _ => '0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)',
    };

    return dom.div(
      classes: 'arcane-structured-card',
      styles: dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border-radius': radius != null ? '${radius}px' : '0.75rem',
        if (border) 'border': '1px solid var(--border)',
        'box-shadow': boxShadow,
        'overflow': 'hidden',
        if (_onTap != null) 'cursor': 'pointer',
        if (_onTap != null) 'transition': 'all 150ms ease',
      }),
      events: _onTap != null
          ? {
              'click': (event) => _onTap(),
            }
          : null,
      [
        if (header != null)
          dom.div(
            classes: 'arcane-structured-card-header',
            styles: const dom.Styles(raw: {
              'padding': '1rem',
              'border-bottom': '1px solid var(--border)',
            }),
            [header!],
          ),
        dom.div(
          classes: 'arcane-structured-card-body',
          styles: dom.Styles(raw: {
            'padding': (padding ?? const EdgeInsets.all(16)).padding,
          }),
          [body],
        ),
        if (footer != null)
          dom.div(
            classes: 'arcane-structured-card-footer',
            styles: const dom.Styles(raw: {
              'padding': '0.5rem 1rem',
              'border-top': '1px solid var(--border)',
              'background-color': 'var(--muted)',
            }),
            [footer!],
          ),
      ],
    );
  }
}

/// An image card with overlay text
class ArcaneImageCard extends StatelessComponent {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final Component? overlay;
  final double? height;
  final double? radius;
  final void Function()? _onTap;
  final BoxFit fit;

  /// Creates an image card.
  ///
  /// Use [onTap] or [onClick] for click handling.
  const ArcaneImageCard({
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.overlay,
    this.height,
    this.radius,
    void Function()? onTap,
    void Function()? onClick,
    this.fit = BoxFit.cover,
    super.key,
  }) : _onTap = onTap ?? onClick;

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-image-card ${_onTap != null ? 'clickable' : ''}',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'border-radius': radius != null ? '${radius}px' : '0.75rem',
        'overflow': 'hidden',
        if (height != null) 'height': '${height}px',
        if (_onTap != null) 'cursor': 'pointer',
      }),
      events: _onTap != null
          ? {
              'click': (event) => _onTap(),
            }
          : null,
      [
        // Image
        dom.img(
          src: imageUrl,
          alt: title ?? '',
          styles: dom.Styles(raw: {
            'width': '100%',
            'height': '100%',
            'object-fit': fit.css,
          }),
        ),

        // Overlay gradient
        if (title != null || subtitle != null || overlay != null)
          dom.div(
            classes: 'arcane-image-card-overlay',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'left': '0',
              'right': '0',
              'padding': '1rem',
              'background':
                  'linear-gradient(to top, hsl(var(--background) / 0.8), transparent)',
              'color': 'var(--foreground)',
            }),
            [
              if (title != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '1rem',
                    'font-weight': '600',
                  }),
                  [Component.text(title!)],
                ),
              if (subtitle != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem',
                    'opacity': '0.9',
                    'margin-top': '0.25rem',
                  }),
                  [Component.text(subtitle!)],
                ),
              if (overlay != null) overlay!,
            ],
          ),
      ],
    );
  }
}
