import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/integration_card_props.dart';

/// ShadCN Integration Card renderer.
class ShadcnIntegrationCard extends StatelessComponent {
  final IntegrationCardProps props;

  const ShadcnIntegrationCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isClickable = props.href != null || props.onTap != null;

    final Component content = dom.div(
      classes: 'arcane-integration-card ${props.featured ? 'featured' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1.5rem',
        'padding': '2rem',
        'background-color': 'var(--card)',
        'border': '1px solid ${props.featured ? 'var(--accent)' : 'var(--border)'}',
        'border-radius': '0.375rem',
        'transition': 'all 150ms ease',
        'cursor': isClickable ? 'pointer' : 'default',
      }),
      [
        // Header with logo and category
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'justify-content': 'space-between',
          }),
          [
            // Logo
            dom.div(
              classes: 'arcane-integration-logo',
              styles: const dom.Styles(raw: {
                'width': '48px',
                'height': '48px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background-color': 'var(--muted)',
                'border-radius': '0.375rem',
                'overflow': 'hidden',
              }),
              [
                if (props.logo != null)
                  props.logo!
                else if (props.logoUrl != null)
                  dom.img(
                    src: props.logoUrl!,
                    alt: props.name,
                    styles: const dom.Styles(raw: {
                      'width': '32px',
                      'height': '32px',
                      'object-fit': 'contain',
                    }),
                  )
                else
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': '1.25rem',
                      'font-weight': '600',
                      'color': 'var(--muted-foreground)',
                    }),
                    [Component.text(props.name.substring(0, 1).toUpperCase())],
                  ),
              ],
            ),

            // Category badge
            if (props.category != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'padding': '0.25rem 0.5rem',
                  'font-size': '0.75rem',
                  'font-weight': '500',
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'color': 'var(--muted-foreground)',
                  'background-color': 'var(--muted)',
                  'border-radius': '9999px',
                }),
                [Component.text(props.category!)],
              ),
          ],
        ),

        // Content
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '0.5rem',
          }),
          [
            // Name
            dom.div(
              styles: const dom.Styles(raw: {
                'font-size': '1rem',
                'font-weight': '600',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.name)],
            ),

            // Description
            if (props.description != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'line-height': '1.5',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(props.description!)],
              ),
          ],
        ),

        // Learn more link
        if (isClickable)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.25rem',
              'margin-top': 'auto',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--accent)',
            }),
            [
              Component.text('Learn more'),
              dom.span([Component.text('\u2192')]),
            ],
          ),
      ],
    );

    if (props.href != null) {
      return dom.a(
        href: props.href!,
        classes: 'arcane-integration-link',
        styles: const dom.Styles(raw: {
          'text-decoration': 'none',
          'display': 'block',
        }),
        [content],
      );
    }

    if (props.onTap != null) {
      return dom.div(
        events: {'click': (e) => props.onTap!()},
        [content],
      );
    }

    return content;
  }
}

/// ShadCN Integration Grid renderer.
class ShadcnIntegrationGrid extends StatelessComponent {
  final IntegrationGridProps props;

  const ShadcnIntegrationGrid(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-integration-grid',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '3rem',
      }),
      [
        if (props.title != null || props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.5rem',
            }),
            [
              if (props.title != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '1.5rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.title!)],
                ),
              if (props.description != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '1rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text(props.description!)],
                ),
            ],
          ),
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'grid',
            'grid-template-columns': 'repeat(${props.columns}, 1fr)',
            'gap': '${props.gap}px',
          }),
          [
            for (final integration in props.integrations)
              ShadcnIntegrationCard(integration),
          ],
        ),
      ],
    );
  }
}
