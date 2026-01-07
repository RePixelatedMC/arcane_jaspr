import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/pricing_card_props.dart';

/// Codex Pricing Card renderer.
///
/// Implements the Codex design language:
/// - Accent glow for highlighted/popular tiers
/// - Larger padding and spacing
/// - Glass effect on popular card
class CodexPricingCard extends StatelessComponent {
  final PricingCardProps props;

  const CodexPricingCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final PricingTier tier = props.tier;
    final bool isHighlighted = tier.isPopular || tier.isHighlighted;

    return dom.div(
      classes: 'codex-pricing-card ${isHighlighted ? 'highlighted' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': '2.5rem', // Codex: larger padding
        'background-color': 'var(--card)',
        'border': isHighlighted
            ? '1px solid rgba(var(--codex-accent-rgb), 0.4)'
            : '1px solid var(--border)',
        'border-radius': 'var(--radius-2xl)',
        if (isHighlighted) 'box-shadow': 'var(--codex-accent-glow-subtle)',
        'position': 'relative',
        'overflow': 'hidden',
      }),
      [
        // Popular badge
        if (tier.isPopular)
          dom.div(
            classes: 'codex-pricing-popular-badge',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '1rem',
              'right': '1rem',
              'padding': '0.375rem 0.75rem',
              'background-color': 'var(--codex-accent)',
              'color': '#ffffff',
              'font-size': '0.75rem',
              'font-weight': '600',
              'border-radius': 'var(--radius-full)',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
            }),
            [const Component.text('Popular')],
          ),

        // Tier name
        dom.h3(
          classes: 'codex-pricing-name',
          styles: const dom.Styles(raw: {
            'font-size': '1.25rem',
            'font-weight': '600',
            'color': 'var(--foreground)',
            'margin': '0',
          }),
          [Component.text(tier.name)],
        ),

        // Description
        dom.p(
          classes: 'codex-pricing-description',
          styles: const dom.Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--muted-foreground)',
            'margin': '0.5rem 0 0 0',
          }),
          [Component.text(tier.description)],
        ),

        // Price
        dom.div(
          classes: 'codex-pricing-price',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': '0.25rem',
            'margin-top': '1.5rem',
          }),
          [
            if (tier.price != null) ...[
              dom.span(
                classes: 'codex-pricing-currency',
                styles: const dom.Styles(raw: {
                  'font-size': '1.5rem',
                  'font-weight': '600',
                  'color': 'var(--foreground)',
                }),
                [Component.text(tier.currency)],
              ),
              dom.span(
                classes: 'codex-pricing-amount',
                styles: const dom.Styles(raw: {
                  'font-size': '3rem',
                  'font-weight': '700',
                  'color': 'var(--foreground)',
                  'line-height': '1',
                }),
                [Component.text('${tier.price!.toStringAsFixed(tier.price! % 1 == 0 ? 0 : 2)}')],
              ),
              dom.span(
                classes: 'codex-pricing-period',
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text('/${tier.period}')],
              ),
            ] else
              dom.span(
                classes: 'codex-pricing-custom',
                styles: const dom.Styles(raw: {
                  'font-size': '2rem',
                  'font-weight': '600',
                  'color': 'var(--foreground)',
                }),
                [const Component.text('Custom')],
              ),
          ],
        ),

        // CTA Button
        dom.button(
          classes: 'codex-pricing-cta',
          attributes: {'type': 'button'},
          styles: dom.Styles(raw: {
            'width': '100%',
            'margin-top': '1.5rem',
            'padding': '0.875rem 1.5rem', // Codex: larger padding
            'background-color': isHighlighted ? 'var(--codex-accent)' : 'var(--secondary)',
            'color': isHighlighted ? '#ffffff' : 'var(--foreground)',
            'border': isHighlighted ? 'none' : '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'font-size': '0.9375rem',
            'font-weight': '600',
            'cursor': 'pointer',
            'transition': 'all var(--transition)',
            if (isHighlighted) 'box-shadow': 'var(--codex-accent-glow-subtle)',
          }),
          events: props.onCtaPressed == null
              ? null
              : {'click': (_) => props.onCtaPressed!()},
          [Component.text(tier.ctaText)],
        ),

        // Divider
        dom.div(
          styles: const dom.Styles(raw: {
            'height': '1px',
            'background-color': 'var(--border)',
            'margin': '1.5rem 0',
          }),
          [],
        ),

        // Features
        dom.ul(
          classes: 'codex-pricing-features',
          styles: const dom.Styles(raw: {
            'list-style': 'none',
            'padding': '0',
            'margin': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '0.875rem', // Codex: larger gap
          }),
          [
            for (final feature in tier.features)
              dom.li(
                classes: 'codex-pricing-feature',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'flex-start',
                  'gap': '0.75rem',
                  'font-size': '0.875rem',
                  'color': 'var(--foreground)',
                }),
                [
                  dom.span(
                    classes: 'codex-pricing-check',
                    styles: const dom.Styles(raw: {
                      'color': 'var(--codex-success)',
                      'font-weight': '600',
                      'flex-shrink': '0',
                    }),
                    [const Component.text('!')],
                  ),
                  Component.text(feature),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// Codex Pricing Grid renderer.
class CodexPricingGrid extends StatelessComponent {
  final PricingGridProps props;

  const CodexPricingGrid(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final int columns = props.columns ?? props.tiers.length.clamp(1, 4);

    return dom.div(
      classes: 'codex-pricing-grid',
      styles: dom.Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat($columns, minmax(280px, 1fr))',
        'gap': '1.5rem', // Codex: larger gap
        'width': '100%',
        'max-width': '${columns * 350}px',
        'margin': '0 auto',
      }),
      [
        for (final tier in props.tiers)
          CodexPricingCard(
            PricingCardProps(
              tier: tier,
              onCtaPressed: props.onTierSelected == null
                  ? null
                  : () => props.onTierSelected!(tier),
            ),
          ),
      ],
    );
  }
}
