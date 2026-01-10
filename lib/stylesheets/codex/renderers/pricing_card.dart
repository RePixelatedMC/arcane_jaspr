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
            ? '1px solid rgba(var(--primary-rgb), 0.4)'
            : '1px solid var(--border)',
        'border-radius': 'var(--radius-2xl)',
        if (isHighlighted)
          'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.15)',
        'position': 'relative',
        'overflow': 'hidden',
      }),
      [
        // Popular badge
        if (tier.isPopular)
          const dom.div(
            classes: 'codex-pricing-popular-badge',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '1rem',
              'right': '1rem',
              'padding': '0.375rem 0.75rem',
              'background-color': 'var(--primary)',
              'color': 'var(--primary-foreground)',
              'font-size': 'var(--font-size-xs)',
              'font-weight': 'var(--font-weight-semibold)',
              'border-radius': 'var(--radius-full)',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
            }),
            [Component.text('Popular')],
          ),

        // Tier name
        dom.h3(
          classes: 'codex-pricing-name',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-xl)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0',
          }),
          [Component.text(tier.name)],
        ),

        // Description
        dom.p(
          classes: 'codex-pricing-description',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
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
            'gap': 'var(--space-1)',
            'margin-top': '1.5rem',
          }),
          [
            if (tier.price != null) ...[
              dom.span(
                classes: 'codex-pricing-currency',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-2xl)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--foreground)',
                }),
                [Component.text(tier.currency)],
              ),
              dom.span(
                classes: 'codex-pricing-amount',
                styles: const dom.Styles(raw: {
                  'font-size': '3rem',
                  'font-weight': 'var(--font-weight-bold)',
                  'color': 'var(--foreground)',
                  'line-height': '1',
                }),
                [Component.text('${tier.price!.toStringAsFixed(tier.price! % 1 == 0 ? 0 : 2)}')],
              ),
              dom.span(
                classes: 'codex-pricing-period',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text('/${tier.period}')],
              ),
            ] else
              const dom.span(
                classes: 'codex-pricing-custom',
                styles: dom.Styles(raw: {
                  'font-size': '2rem',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--foreground)',
                }),
                [Component.text('Custom')],
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
            'background-color': isHighlighted ? 'var(--primary)' : 'var(--muted)',
            'color': isHighlighted ? 'var(--primary-foreground)' : 'var(--foreground)',
            'border': isHighlighted ? 'none' : '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'font-size': '0.9375rem',
            'font-weight': 'var(--font-weight-semibold)',
            'cursor': 'pointer',
            'transition': 'all var(--transition)',
            if (isHighlighted)
              'box-shadow': '0 0 20px rgba(var(--primary-rgb), 0.3)',
          }),
          events: props.onCtaPressed == null
              ? null
              : {'click': (_) => props.onCtaPressed!()},
          [Component.text(tier.ctaText)],
        ),

        // Divider
        const dom.div(
          styles: dom.Styles(raw: {
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
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--foreground)',
                }),
                [
                  const dom.span(
                    classes: 'codex-pricing-check',
                    styles: dom.Styles(raw: {
                      'color': 'var(--success)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'flex-shrink': '0',
                    }),
                    [Component.text('+')],
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
        'gap': 'var(--space-6)', // Codex: larger gap
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