import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

/// Card component with consistent styling and multiple variants.
class ArcaneCard extends StatelessComponent {
  final Component? _child;
  final List<Component>? _children;
  final CardVariant variant;
  final String? padding;
  final String? borderRadius;
  final void Function()? _onTap;
  final String? backgroundColor;
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

/// Card with header, body, and footer sections.
class ArcaneStructuredCard extends StatelessComponent {
  final Component? header;
  final Component body;
  final Component? footer;
  final EdgeInsets? padding;
  final double? radius;
  final bool border;
  final int elevation;
  final void Function()? _onTap;

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

/// Image card with overlay text.
class ArcaneImageCard extends StatelessComponent {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final Component? overlay;
  final double? height;
  final double? radius;
  final void Function()? _onTap;
  final BoxFit fit;

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
        dom.img(
          src: imageUrl,
          alt: title ?? '',
          styles: dom.Styles(raw: {
            'width': '100%',
            'height': '100%',
            'object-fit': fit.css,
          }),
        ),

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
