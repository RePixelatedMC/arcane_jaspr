import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/logo_carousel_props.dart';

/// Renders an infinite scrolling logo carousel.
Component renderLogoCarousel(LogoCarouselProps props) {
  final String animationName =
      props.reverse ? 'arcane-scroll-reverse' : 'arcane-scroll';

  return dom.div(
    classes: 'arcane-logo-carousel',
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '1.5rem',
      'width': '100%',
      'overflow': 'hidden',
    }),
    [
      // Optional title
      if (props.title != null)
        dom.div(
          classes: 'arcane-logo-carousel-title',
          styles: const dom.Styles(raw: {
            'text-align': 'center',
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--muted-foreground)',
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
          }),
          [dom.text(props.title!)],
        ),

      // Carousel track
      dom.div(
        classes:
            'arcane-logo-carousel-track ${props.pauseOnHover ? 'pause-on-hover' : ''}',
        styles: dom.Styles(raw: {
          'display': 'flex',
          'width': 'max-content',
          'animation': '$animationName ${props.duration}s linear infinite',
        }),
        [
          // First set of logos
          _buildLogoSet(props),
          // Duplicate set for seamless loop
          _buildLogoSet(props),
        ],
      ),
    ],
  );
}

Component _buildLogoSet(LogoCarouselProps props) {
  return dom.div(
    classes: 'arcane-logo-carousel-set',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'gap': '${props.gap}px',
      'padding': '0 ${props.gap / 2}px',
    }),
    [
      for (final logo in props.logos) _buildLogo(logo, props),
    ],
  );
}

Component _buildLogo(LogoItem logo, LogoCarouselProps props) {
  final Component logoContent = logo.customLogo ??
      (logo.imageUrl != null
          ? dom.img(
              src: logo.imageUrl!,
              alt: logo.name,
              styles: dom.Styles(raw: {
                'height': '${props.logoHeight}px',
                'width': 'auto',
                'object-fit': 'contain',
                if (props.grayscale) 'filter': 'grayscale(100%)',
                'opacity': props.grayscale ? '0.6' : '1',
                'transition': 'all 150ms ease',
              }),
            )
          : dom.span(
              styles: dom.Styles(raw: {
                'font-size': '1.125rem',
                'font-weight': '600',
                'color': 'var(--muted-foreground)',
                if (props.grayscale) 'filter': 'grayscale(100%)',
                'opacity': props.grayscale ? '0.6' : '1',
              }),
              [dom.text(logo.name)],
            ));

  if (logo.href != null) {
    return dom.a(
      href: logo.href!,
      classes: 'arcane-logo-carousel-item',
      attributes: {
        'target': '_blank',
        'rel': 'noopener noreferrer',
        'aria-label': logo.name,
      },
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'flex-shrink': '0',
        'text-decoration': 'none',
      }),
      [logoContent],
    );
  }

  return dom.div(
    classes: 'arcane-logo-carousel-item',
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'flex-shrink': '0',
    }),
    [logoContent],
  );
}

/// Renders a static logo grid.
Component renderLogoGrid(LogoGridProps props) {
  return dom.div(
    classes: 'arcane-logo-grid',
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '1.5rem',
    }),
    [
      if (props.title != null)
        dom.div(
          styles: const dom.Styles(raw: {
            'text-align': 'center',
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--muted-foreground)',
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
          }),
          [dom.text(props.title!)],
        ),
      dom.div(
        classes: 'arcane-logo-grid-container',
        styles: dom.Styles(raw: {
          'display': 'grid',
          'grid-template-columns': 'repeat(${props.columns}, 1fr)',
          'gap': '${props.gap}px',
          'align-items': 'center',
          'justify-items': 'center',
        }),
        [
          for (final logo in props.logos)
            dom.div(
              classes: 'arcane-logo-grid-item',
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
              }),
              [
                if (logo.customLogo != null)
                  logo.customLogo!
                else if (logo.imageUrl != null)
                  dom.img(
                    src: logo.imageUrl!,
                    alt: logo.name,
                    styles: dom.Styles(raw: {
                      'height': '${props.logoHeight}px',
                      'width': 'auto',
                      'object-fit': 'contain',
                      if (props.grayscale) 'filter': 'grayscale(100%)',
                      'opacity': props.grayscale ? '0.6' : '1',
                      'transition': 'all 150ms ease',
                    }),
                  )
                else
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': '1rem',
                      'font-weight': '600',
                      'color': 'var(--muted-foreground)',
                    }),
                    [dom.text(logo.name)],
                  ),
              ],
            ),
        ],
      ),
    ],
  );
}
