import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/feedback/status_badge.dart';
import '../../../component/view/check_list.dart';
import '../../../component/view/icon.dart';
import '../../../component/view/spec_row.dart';
import '../../../core/props/pricing_card_props.dart';

/// Codex Pricing Card renderer.
///
/// Implements the Codex design language:
/// - Accent glow for highlighted/popular tiers
/// - Larger padding and spacing
/// - Glass effect on popular card
/// - Multiple variants (compact, standard, hero)
/// - Specs section for hardware details
/// - Excluded features with strikethrough
class CodexPricingCard extends StatelessComponent {
  final PricingCardProps props;

  const CodexPricingCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isHighlighted = props.effectiveHighlighted;
    final PricingCardVariant variant = props.variant;
    final bool isCompact = variant == PricingCardVariant.compact;
    final bool isHero = variant == PricingCardVariant.hero;

    // Determine accent color
    final String accent = props.accentColor ??
        (isHighlighted ? 'var(--primary)' : 'var(--muted-foreground)');

    return dom.div(
      classes: 'codex-pricing-card ${variant.name} ${isHighlighted ? 'highlighted' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': _getPadding(variant, isHighlighted),
        'background-color': 'var(--card)',
        'border': isHighlighted
            ? '2px solid $accent'
            : '1px solid color-mix(in srgb, var(--foreground) 10%, transparent)',
        'border-radius': 'var(--radius-xl)',
        if (!isCompact) 'height': '100%',
        if (isHighlighted)
          'box-shadow': '0 0 30px color-mix(in srgb, $accent 20%, transparent)',
        'position': 'relative',
        'overflow': 'hidden',
        'transition': 'all var(--arcane-transition)',
      }),
      [
        // Top accent bar
        _buildAccentBar(accent, isHighlighted),

        // Badge (if provided)
        if (props.effectiveBadge != null) _buildBadge(),

        // Header section (icon + title)
        if (!isCompact) _buildHeader(isHero, accent),

        // Compact variant title (simpler layout)
        if (isCompact) _buildCompactTitle(),

        // Subtitle/description
        if (props.effectiveSubtitle != null) _buildSubtitle(variant),

        // Price display
        _buildPrice(isHero),

        // Specs section
        if (props.specs != null && props.specs!.isNotEmpty)
          _buildSpecs(variant, isHighlighted),

        // Features list
        if (props.effectiveFeatures.isNotEmpty || props.excludedFeatures.isNotEmpty)
          _buildFeatures(variant),

        // Spacer to push button to bottom
        if (!isCompact)
          const dom.div(
            styles: dom.Styles(raw: {'flex': '1'}),
            [],
          ),

        // CTA Button
        _buildButton(isHero, isHighlighted, accent),
      ],
    );
  }

  String _getPadding(PricingCardVariant variant, bool isHighlighted) {
    switch (variant) {
      case PricingCardVariant.compact:
        return '1rem';
      case PricingCardVariant.hero:
        return isHighlighted ? '2.5rem 2rem 2rem' : '2rem';
      case PricingCardVariant.standard:
        return isHighlighted ? '2rem 1.5rem 1.5rem' : '1.5rem';
    }
  }

  Component _buildAccentBar(String accent, bool isHighlighted) {
    return dom.div(
      styles: dom.Styles(raw: {
        'position': 'absolute',
        'top': '0',
        'left': '0',
        'right': '0',
        'height': isHighlighted ? '4px' : '3px',
        'background': 'linear-gradient(90deg, $accent, ${accent}66)',
        'border-radius': 'var(--radius-xl) var(--radius-xl) 0 0',
      }),
      [],
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

  Component _buildHeader(bool isHero, String accent) {
    return dom.div(
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': isHero ? 'var(--space-4)' : 'var(--space-3)',
        'margin-bottom': isHero ? 'var(--space-4)' : 'var(--space-3)',
      }),
      [
        // Icon container
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': isHero ? '48px' : '36px',
            'height': isHero ? '48px' : '36px',
            'border-radius': 'var(--radius-md)',
            'background-color': '${accent}15',
            'border': '1px solid ${accent}30',
            'color': accent,
            'flex-shrink': '0',
          }),
          [
            props.icon ??
                ArcaneIcon.box(size: isHero ? IconSize.md : IconSize.sm),
          ],
        ),
        // Title
        dom.h3(
          styles: dom.Styles(raw: {
            'font-size': isHero ? 'var(--font-size-2xl)' : 'var(--font-size-lg)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0',
          }),
          [Component.text(props.effectiveTitle)],
        ),
      ],
    );
  }

  Component _buildCompactTitle() {
    return dom.div(
      styles: const dom.Styles(raw: {
        'margin-bottom': 'var(--space-2)',
      }),
      [
        dom.h3(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-lg)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0',
          }),
          [Component.text(props.effectiveTitle)],
        ),
      ],
    );
  }

  Component _buildSubtitle(PricingCardVariant variant) {
    return dom.div(
      styles: dom.Styles(raw: {
        'margin-bottom':
            variant == PricingCardVariant.hero ? 'var(--space-4)' : 'var(--space-3)',
        if (variant != PricingCardVariant.compact) 'min-height': '40px',
      }),
      [
        dom.p(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--muted-foreground)',
            'margin': '0',
          }),
          [Component.text(props.effectiveSubtitle!)],
        ),
      ],
    );
  }

  Component _buildPrice(bool isHero) {
    return dom.div(
      styles: dom.Styles(raw: {
        'margin-bottom': isHero ? 'var(--space-6)' : 'var(--space-4)',
      }),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': 'var(--space-1)',
          }),
          [
            // Original price (strikethrough) if provided
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
            // Current price
            dom.span(
              styles: dom.Styles(raw: {
                'font-size': isHero ? 'var(--font-size-4xl)' : 'var(--font-size-3xl)',
                'font-weight': 'var(--font-weight-bold)',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.effectivePrice)],
            ),
            // Period
            dom.span(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
              }),
              [Component.text(props.effectivePeriod)],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildSpecs(PricingCardVariant variant, bool isHighlighted) {
    final bool isHero = variant == PricingCardVariant.hero;

    return dom.div(
      styles: dom.Styles(raw: {
        'padding': isHero ? 'var(--space-4)' : 'var(--space-3)',
        'margin-bottom': isHero ? 'var(--space-6)' : 'var(--space-4)',
        'border-radius': isHero ? 'var(--radius-lg)' : 'var(--radius-md)',
        'background-color': 'color-mix(in srgb, var(--foreground) 2%, transparent)',
        'border': '1px solid color-mix(in srgb, var(--foreground) 6%, transparent)',
      }),
      [
        for (int i = 0; i < props.specs!.length; i++) ...[
          ArcaneSpecRow(
            label: props.specs![i].label,
            value: props.specs![i].value,
            highlight: props.specs![i].highlight || isHighlighted,
          ),
          // Divider between specs (except after last one)
          if (i < props.specs!.length - 1)
            const dom.div(
              styles: dom.Styles(raw: {
                'height': '1px',
                'background-color': 'color-mix(in srgb, var(--foreground) 6%, transparent)',
                'margin': 'var(--space-2) 0',
              }),
              [],
            ),
        ],
      ],
    );
  }

  Component _buildFeatures(PricingCardVariant variant) {
    final bool isCompact = variant == PricingCardVariant.compact;

    return dom.div(
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': isCompact ? 'var(--space-1)' : 'var(--space-2)',
        if (!isCompact) 'flex': '1',
        'margin-bottom': isCompact ? 'var(--space-3)' : 'var(--space-4)',
      }),
      [
        // Included features
        for (final String feature in props.effectiveFeatures)
          ArcaneFeatureRow(feature: feature, included: true),
        // Excluded features
        for (final String feature in props.excludedFeatures)
          ArcaneFeatureRow(feature: feature, included: false),
      ],
    );
  }

  Component _buildButton(bool isHero, bool isHighlighted, String accent) {
    final void Function()? onButtonClick = props.onButtonClick ?? props.onCtaPressed;

    final Map<String, String> buttonStyles = {
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': 'var(--space-2)',
      'width': '100%',
      'padding': isHero ? 'var(--space-4) var(--space-6)' : 'var(--space-3) var(--space-4)',
      'background-color':
          isHighlighted ? accent : 'color-mix(in srgb, var(--foreground) 5%, transparent)',
      'border': isHighlighted ? 'none' : '1px solid color-mix(in srgb, var(--foreground) 20%, transparent)',
      'border-radius': 'var(--radius-md)',
      'color': 'var(--foreground)',
      'font-size': isHero ? 'var(--font-size-base)' : 'var(--font-size-sm)',
      'font-weight': 'var(--font-weight-semibold)',
      'cursor': 'pointer',
      'transition': 'all var(--arcane-transition)',
      'text-decoration': 'none',
      if (isHighlighted && isHero)
        'box-shadow': '0 0 20px color-mix(in srgb, $accent 30%, transparent)',
    };

    final List<Component> buttonContent = [
      Component.text(props.effectiveCtaText),
      ArcaneIcon.arrowRight(size: isHero ? IconSize.md : IconSize.sm),
    ];

    // If there's a click handler, use a button
    if (onButtonClick != null) {
      return dom.button(
        type: dom.ButtonType.button,
        styles: dom.Styles(raw: buttonStyles),
        events: {'click': (_) => onButtonClick()},
        buttonContent,
      );
    }

    // Otherwise use a link
    return dom.a(
      href: props.buttonLink ?? '#',
      styles: dom.Styles(raw: buttonStyles),
      buttonContent,
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
        'gap': 'var(--space-6)',
        'width': '100%',
        'max-width': '${columns * 350}px',
        'margin': '0 auto',
      }),
      [
        for (final PricingTier tier in props.tiers)
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