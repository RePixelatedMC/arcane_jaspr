import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/feedback/status_badge.dart';
import '../../../component/view/check_list.dart';
import '../../../component/view/icon.dart';
import '../../../component/view/spec_row.dart';
import '../../../core/props/pricing_card_props.dart';

/// ShadCN Pricing Card renderer.
class ShadcnPricingCard extends StatelessComponent {
  final PricingCardProps props;

  const ShadcnPricingCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isHighlighted = props.effectiveHighlighted;
    final PricingCardVariant variant = props.variant;
    final bool isCompact = variant == PricingCardVariant.compact;

    return dom.div(
      classes: 'arcane-pricing-card ${variant.name} ${isHighlighted ? 'highlighted' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': isCompact ? '1.5rem' : '2rem',
        'background-color': isHighlighted
            ? 'color-mix(in srgb, var(--accent) 5%, transparent)'
            : 'var(--card)',
        'border': isHighlighted
            ? '2px solid var(--accent)'
            : '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-lg)',
        'position': 'relative',
        if (!isCompact) 'height': '100%',
        'transition': 'all var(--arcane-transition-slow)',
      }),
      [
        // Badge
        if (props.effectiveBadge != null) _buildBadge(),

        // Title
        dom.div(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-xl)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin-bottom': '0.5rem',
          }),
          [Component.text(props.effectiveTitle)],
        ),

        // Subtitle
        if (props.effectiveSubtitle != null)
          dom.p(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-base)',
              'color': 'var(--muted-foreground)',
              'margin': '0 0 1rem 0',
              'line-height': '1.5',
            }),
            [Component.text(props.effectiveSubtitle!)],
          ),

        // Price
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': 'var(--space-1)',
            'margin-bottom': '1.5rem',
          }),
          [
            if (props.originalPrice != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-lg)',
                  'color': 'var(--muted-foreground)',
                  'text-decoration': 'line-through',
                  'margin-right': 'var(--space-2)',
                }),
                [Component.text(props.originalPrice!)],
              ),
            dom.span(
              styles: const dom.Styles(raw: {
                'font-size': '2.5rem',
                'font-weight': 'var(--font-weight-bold)',
                'color': 'var(--foreground)',
                'line-height': '1',
                'letter-spacing': '-0.02em',
              }),
              [Component.text(props.effectivePrice)],
            ),
            dom.span(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
              }),
              [Component.text(props.effectivePeriod)],
            ),
          ],
        ),

        // Specs section
        if (props.specs != null && props.specs!.isNotEmpty) _buildSpecs(),

        // Features
        if (props.effectiveFeatures.isNotEmpty || props.excludedFeatures.isNotEmpty)
          _buildFeatures(isCompact),

        // Spacer
        if (!isCompact)
          const dom.div(
            styles: dom.Styles(raw: {'flex': '1'}),
            [],
          ),

        // CTA Button
        _buildButton(isHighlighted),
      ],
    );
  }

  Component _buildBadge() {
    final String badgeText = props.effectiveBadge!;

    return switch (props.badgeVariant) {
      PricingBadgeVariant.popular => ArcaneStatusBadge.popular(label: badgeText),
      PricingBadgeVariant.recommended => ArcaneStatusBadge.recommended(label: badgeText),
      PricingBadgeVariant.isNew => ArcaneStatusBadge.isNew(label: badgeText),
      PricingBadgeVariant.primary => ArcaneStatusBadge.primary(
          badgeText,
          position: const BadgePosition.topRight(),
          showDefaultIcon: true,
        ),
    };
  }

  Component _buildSpecs() {
    return dom.div(
      styles: const dom.Styles(raw: {
        'padding': 'var(--space-3)',
        'margin-bottom': 'var(--space-4)',
        'border-radius': 'var(--arcane-radius-sm)',
        'background-color': 'var(--muted)',
        'border': '1px solid var(--border)',
      }),
      [
        for (int i = 0; i < props.specs!.length; i++) ...[
          ArcaneSpecRow(
            label: props.specs![i].label,
            value: props.specs![i].value,
            highlight: props.specs![i].highlight,
          ),
          if (i < props.specs!.length - 1)
            const dom.div(
              styles: dom.Styles(raw: {
                'height': '1px',
                'background-color': 'var(--border)',
                'margin': 'var(--space-2) 0',
              }),
              [],
            ),
        ],
      ],
    );
  }

  Component _buildFeatures(bool isCompact) {
    return dom.div(
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': isCompact ? 'var(--space-2)' : 'var(--space-3)',
        'margin-bottom': isCompact ? 'var(--space-3)' : 'var(--space-4)',
      }),
      [
        for (final String feature in props.effectiveFeatures)
          ArcaneFeatureRow(feature: feature, included: true),
        for (final String feature in props.excludedFeatures)
          ArcaneFeatureRow(feature: feature, included: false),
      ],
    );
  }

  Component _buildButton(bool isHighlighted) {
    final void Function()? onButtonClick = props.onButtonClick ?? props.onCtaPressed;

    final Map<String, String> buttonStyles = {
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': 'var(--space-2)',
      'width': '100%',
      'padding': '1rem 1.5rem',
      'font-size': 'var(--font-size-base)',
      'font-weight': 'var(--font-weight-medium)',
      'border-radius': 'var(--arcane-radius-sm)',
      'border': isHighlighted ? 'none' : '1px solid var(--border)',
      'background-color': isHighlighted ? 'var(--accent)' : 'transparent',
      'color': isHighlighted ? 'var(--accent-foreground)' : 'var(--foreground)',
      'cursor': 'pointer',
      'transition': 'all var(--arcane-transition)',
      'text-decoration': 'none',
    };

    final List<Component> buttonContent = [
      Component.text(props.effectiveCtaText),
      ArcaneIcon.arrowRight(size: IconSize.sm),
    ];

    if (onButtonClick != null) {
      return dom.button(
        type: dom.ButtonType.button,
        styles: dom.Styles(raw: buttonStyles),
        events: {'click': (_) => onButtonClick()},
        buttonContent,
      );
    }

    return dom.a(
      href: props.buttonLink ?? '#',
      styles: dom.Styles(raw: buttonStyles),
      buttonContent,
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
        for (final PricingTier tier in props.tiers)
          ShadcnPricingCard(PricingCardProps(
            tier: tier,
            onCtaPressed: () => props.onTierSelected?.call(tier),
          )),
      ],
    );
  }
}