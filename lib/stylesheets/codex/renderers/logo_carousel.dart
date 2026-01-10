import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/logo_carousel_props.dart';

/// Renders a Codex infinite scrolling logo carousel.
Component renderLogoCarousel(LogoCarouselProps props) {
  final String animationName =
      props.reverse ? 'arcane-scroll-reverse' : 'arcane-scroll';

  return dom.div(
    classes: 'codex-logo-carousel',
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '2rem',
      'width': '100%',
      'overflow': 'hidden',
    }),
    [
      // Optional title
      if (props.title != null)
        dom.div(
          classes: 'codex-logo-carousel-title',
          styles: const dom.Styles(raw: {
            'text-align': 'center',
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-medium)',
            'color': 'var(--muted-foreground)',
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
          }),
          [Component.text(props.title!)],
        ),

      // Carousel track
      dom.div(
        classes:
            'codex-logo-carousel-track ${props.pauseOnHover ? 'pause-on-hover' : ''}',
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
    classes: 'codex-logo-carousel-set',
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
                'opacity': props.grayscale ? '0.5' : '1',
                'transition': 'all var(--arcane-transition)',
              }),
            )
          : dom.span(
              styles: dom.Styles(raw: {
                'font-size': 'var(--font-size-lg)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--muted-foreground)',
                if (props.grayscale) 'filter': 'grayscale(100%)',
                'opacity': props.grayscale ? '0.5' : '1',
              }),
              [Component.text(logo.name)],
            ));

  if (logo.href != null) {
    return dom.a(
      href: logo.href!,
      classes: 'codex-logo-carousel-item',
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
    classes: 'codex-logo-carousel-item',
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'flex-shrink': '0',
    }),
    [logoContent],
  );
}

/// Renders a Codex static logo grid.
Component renderLogoGrid(LogoGridProps props) {
  return dom.div(
    classes: 'codex-logo-grid',
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '2rem',
    }),
    [
      if (props.title != null)
        dom.div(
          styles: const dom.Styles(raw: {
            'text-align': 'center',
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-medium)',
            'color': 'var(--muted-foreground)',
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
          }),
          [Component.text(props.title!)],
        ),
      dom.div(
        classes: 'codex-logo-grid-container',
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
              classes: 'codex-logo-grid-item',
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
                      'opacity': props.grayscale ? '0.5' : '1',
                      'transition': 'all var(--arcane-transition)',
                    }),
                  )
                else
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--font-size-base)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--muted-foreground)',
                    }),
                    [Component.text(logo.name)],
                  ),
              ],
            ),
        ],
      ),
    ],
  );
}
