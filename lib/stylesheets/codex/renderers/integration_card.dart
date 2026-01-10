import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/integration_card_props.dart';

/// Codex IntegrationCard renderer.
class CodexIntegrationCard extends StatelessComponent {
  final IntegrationCardProps props;

  const CodexIntegrationCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isInteractive = props.href != null || props.onTap != null;

    Component card = dom.div(
      classes:
          'codex-integration-card ${props.featured ? 'featured' : ''} ${isInteractive ? 'interactive' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'text-align': 'center',
        'gap': 'var(--arcane-space-4)',
        'padding': '1.5rem',
        'background-color': 'var(--card)',
        'border': props.featured
            ? '1px solid var(--codex-accent)'
            : '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'transition': 'all var(--arcane-transition)',
        if (isInteractive) 'cursor': 'pointer',
        if (props.featured)
          'box-shadow': '0 0 20px rgba(var(--codex-accent-rgb), 0.15)',
      }),
      events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
      [
        // Logo
        if (props.logo != null)
          props.logo!
        else if (props.logoUrl != null)
          dom.img(
            src: props.logoUrl!,
            classes: 'codex-integration-logo',
            styles: const dom.Styles(raw: {
              'width': '48px',
              'height': '48px',
              'object-fit': 'contain',
            }),
          )
        else
          dom.div(
            classes: 'codex-integration-logo-placeholder',
            styles: const dom.Styles(raw: {
              'width': '48px',
              'height': '48px',
              'background-color': 'var(--secondary)',
              'border-radius': 'var(--radius)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': 'var(--muted-foreground)',
              'font-weight': 'var(--arcane-font-weight-semibold)',
            }),
            [Component.text(props.name.substring(0, 1).toUpperCase())],
          ),

        // Content
        dom.div(
          classes: 'codex-integration-content',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--arcane-space-1)',
          }),
          [
            // Category badge
            if (props.category != null)
              dom.span(
                classes: 'codex-integration-category',
                styles: const dom.Styles(raw: {
                  'font-size': '0.6875rem',
                  'font-weight': 'var(--arcane-font-weight-medium)',
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'color': 'var(--codex-accent)',
                }),
                [Component.text(props.category!)],
              ),

            // Name
            dom.span(
              classes: 'codex-integration-name',
              styles: const dom.Styles(raw: {
                'font-size': '0.9375rem',
                'font-weight': 'var(--arcane-font-weight-semibold)',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.name)],
            ),

            // Description
            if (props.description != null)
              dom.span(
                classes: 'codex-integration-description',
                styles: const dom.Styles(raw: {
                  'font-size': '0.8125rem',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.4',
                }),
                [Component.text(props.description!)],
              ),
          ],
        ),
      ],
    );

    if (props.href != null) {
      return dom.a(
        href: props.href!,
        styles: const dom.Styles(raw: {
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        [card],
      );
    }

    return card;
  }
}

/// Codex IntegrationGrid renderer.
class CodexIntegrationGrid extends StatelessComponent {
  final IntegrationGridProps props;

  const CodexIntegrationGrid(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-integration-grid',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '2rem',
      }),
      [
        // Header
        if (props.title != null || props.description != null)
          dom.div(
            classes: 'codex-integration-grid-header',
            styles: const dom.Styles(raw: {
              'text-align': 'center',
            }),
            [
              if (props.title != null)
                dom.h2(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-2xl)',
                    'font-weight': 'var(--arcane-font-weight-bold)',
                    'color': 'var(--foreground)',
                    'margin': '0 0 0.5rem 0',
                  }),
                  [Component.text(props.title!)],
                ),
              if (props.description != null)
                dom.p(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-base)',
                    'color': 'var(--muted-foreground)',
                    'margin': '0',
                  }),
                  [Component.text(props.description!)],
                ),
            ],
          ),

        // Grid
        dom.div(
          classes: 'codex-integration-grid-items',
          styles: dom.Styles(raw: {
            'display': 'grid',
            'grid-template-columns':
                'repeat(auto-fit, minmax(250px, 1fr))',
            'gap': '${props.gap}px',
          }),
          [
            for (final integration in props.integrations)
              CodexIntegrationCard(integration),
          ],
        ),
      ],
    );
  }
}
