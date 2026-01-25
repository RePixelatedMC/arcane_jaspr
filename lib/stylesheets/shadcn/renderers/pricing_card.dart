import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/badge_props.dart';
import '../../../core/props/pricing_card_props.dart';
import 'badge.dart';

/// ShadCN Pricing Card renderer.
class ShadcnPricingCard extends StatelessComponent {
  final PricingCardProps props;

  const ShadcnPricingCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final tier = props.tier;

    return dom.div(
      classes: 'arcane-pricing-card ${tier.isHighlighted ? 'highlighted' : ''} ${tier.isPopular ? 'popular' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': '2rem',
        'background-color': tier.isHighlighted
            ? 'color-mix(in srgb, var(--accent) 5%, transparent)'
            : 'var(--card)',
        'border': tier.isHighlighted
            ? '2px solid var(--accent)'
            : '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-lg)',
        'position': 'relative',
        'transition': 'all var(--arcane-transition-slow)',
      }),
      [
        // Popular badge
        if (tier.isPopular)
          const dom.div(
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '-12px',
              'left': '50%',
              'transform': 'translateX(-50%)',
            }),
            [ShadcnBadge(BadgeProps(label: 'Most Popular', color: ColorVariant.primary))],
          ),

        // Tier name
        dom.div(
          classes: 'arcane-pricing-name',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-xl)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin-bottom': '0.5rem',
          }),
          [Component.text(tier.name)],
        ),

        // Price
        dom.div(
          classes: 'arcane-pricing-price',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': 'var(--space-1)',
            'margin-bottom': '0.5rem',
          }),
          [
            if (tier.price != null) ...[
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(tier.currency)],
              ),
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '2.5rem',
                  'font-weight': 'var(--font-weight-bold)',
                  'color': 'var(--foreground)',
                  'line-height': '1',
                  'letter-spacing': '-0.02em',
                }),
                [Component.text(tier.price!.toStringAsFixed(tier.price! % 1 == 0 ? 0 : 2))],
              ),
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text('/${tier.period}')],
              ),
            ] else
              const dom.span(
                styles: dom.Styles(raw: {
                  'font-size': 'var(--font-size-2xl)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--foreground)',
                }),
                [Component.text('Custom')],
              ),
          ],
        ),

        // Description
        dom.p(
          classes: 'arcane-pricing-description',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-base)',
            'color': 'var(--muted-foreground)',
            'margin': '0 0 2rem 0',
            'line-height': '1.5',
          }),
          [Component.text(tier.description)],
        ),

        // CTA Button
        dom.button(
          classes: 'arcane-pricing-cta',
          type: dom.ButtonType.button,
          styles: dom.Styles(raw: {
            'width': '100%',
            'padding': '1rem 1.5rem',
            'font-size': 'var(--font-size-base)',
            'font-weight': 'var(--font-weight-medium)',
            'border-radius': 'var(--arcane-radius-sm)',
            'border': tier.isHighlighted
                ? 'none'
                : '1px solid var(--border)',
            'background-color': tier.isHighlighted
                ? 'var(--accent)'
                : 'transparent',
            'color': tier.isHighlighted
                ? 'var(--accent-foreground)'
                : 'var(--foreground)',
            'cursor': 'pointer',
            'transition': 'all var(--arcane-transition)',
            'margin-bottom': '2rem',
          }),
          events: {
            'click': (e) => props.onCtaPressed?.call(),
          },
          [Component.text(tier.ctaText)],
        ),

        // Features list
        dom.div(
          classes: 'arcane-pricing-features',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--space-4)',
          }),
          [
            for (final feature in tier.features)
              dom.div(
                classes: 'arcane-pricing-feature',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'flex-start',
                  'gap': 'var(--space-4)',
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--foreground)',
                }),
                [
                  // Checkmark
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'color': 'var(--success)',
                      'flex-shrink': '0',
                      'font-size': 'var(--font-size-base)',
                    }),
                    [Component.text('\u2713')],
                  ),
                  dom.span([Component.text(feature)]),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// ShadCN Pricing Grid renderer.
class ShadcnPricingGrid extends StatelessComponent {
  final PricingGridProps props;

  const ShadcnPricingGrid(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final int cols = props.columns ?? props.tiers.length.clamp(1, 4);

    return dom.div(
      classes: 'arcane-pricing-grid',
      styles: dom.Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat($cols, minmax(280px, 1fr))',
        'gap': 'var(--space-8)',
        'align-items': 'start',
      }),
      [
        for (final tier in props.tiers)
          ShadcnPricingCard(PricingCardProps(
            tier: tier,
            onCtaPressed: () => props.onTierSelected?.call(tier),
          )),
      ],
    );
  }
}