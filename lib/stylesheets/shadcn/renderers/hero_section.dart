import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/renderers.dart';
import '../../../component/typography/headline.dart';

/// ShadCN Hero Section renderer.
class ShadcnHeroSection extends StatelessComponent {
  final HeroSectionProps props;

  const ShadcnHeroSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.section(
      classes: 'arcane-hero-section',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': props.centered ? 'center' : 'flex-start',
        'text-align': props.centered ? 'center' : 'left',
        'padding': '${props.verticalPadding}px 1.5rem',
      }),
      [
        // Content wrapper
        dom.div(
          classes: 'arcane-hero-content',
          styles: dom.Styles(raw: {
            'max-width': '${props.maxWidth}px',
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': props.centered ? 'center' : 'flex-start',
            'gap': 'var(--space-6)',
          }),
          [
            // Badge
            if (props.badge != null) props.badge!,

            // Promo banner
            if (props.promoBanner != null) props.promoBanner!,

            // Headline (component or text)
            if (props.headlineComponent != null)
              dom.h1(
                classes: 'arcane-hero-headline',
                styles: dom.Styles(raw: {
                  'font-size': 'clamp(2rem, 5vw, 3rem)',
                  'font-weight': 'var(--font-weight-bold)',
                  'line-height': '1.2',
                  'color': 'var(--foreground)',
                  'margin': '0',
                  'text-align': props.centered ? 'center' : 'left',
                }),
                [props.headlineComponent!],
              )
            else if (props.headline != null)
              ArcaneHeadline.h1(
                props.headline!,
                align: props.centered ? 'center' : 'left',
              ),

            // Subheadline
            if (props.subheadline != null)
              ArcaneSubheadline(
                props.subheadline!,
                size: 'lg',
                align: props.centered ? 'center' : 'left',
              ),

            // CTA buttons
            if (props.primaryCta != null || props.secondaryCta != null)
              dom.div(
                classes: 'arcane-hero-ctas',
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': 'var(--space-2)',
                  'margin-top': '0.5rem',
                  if (props.centered) 'justify-content': 'center',
                }),
                [
                  if (props.primaryCta != null) props.primaryCta!,
                  if (props.secondaryCta != null) props.secondaryCta!,
                ],
              ),

            // Stats row
            if (props.stats != null && props.stats!.isNotEmpty)
              dom.div(
                classes: 'arcane-hero-stats',
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': '2rem',
                  'margin-top': '1.5rem',
                  if (props.centered) 'justify-content': 'center',
                }),
                [
                  for (final HeroStatItem stat in props.stats!)
                    _buildStatItem(stat),
                ],
              ),
          ],
        ),

        // Media
        if (props.media != null)
          dom.div(
            classes: 'arcane-hero-media',
            styles: const dom.Styles(raw: {
              'margin-top': '3rem',
              'width': '100%',
              'max-width': '1200px',
            }),
            [props.media!],
          ),
      ],
    );
  }

  Component _buildStatItem(HeroStatItem stat) {
    return dom.div(
      classes: 'arcane-hero-stat',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': '0.25rem',
      }),
      [
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': '1.25rem',
            'font-weight': '600',
            'color': 'var(--primary)',
          }),
          [Component.text(stat.value)],
        ),
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--muted-foreground)',
          }),
          [Component.text(stat.label)],
        ),
      ],
    );
  }
}

/// ShadCN CTA Group renderer.
class ShadcnCtaGroup extends StatelessComponent {
  final CtaGroupProps props;

  const ShadcnCtaGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-cta-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': '${props.gap}px',
        if (props.centered) 'justify-content': 'center',
      }),
      [
        props.primaryCta,
        if (props.secondaryCta != null) props.secondaryCta!,
      ],
    );
  }
}
