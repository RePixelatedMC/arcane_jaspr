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
            'gap': '1.5rem',
          }),
          [
            // Badge
            if (props.badge != null) props.badge!,

            // Headline
            ArcaneHeadline.h1(
              props.headline,
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
                  'gap': '0.5rem',
                  'margin-top': '0.5rem',
                  if (props.centered) 'justify-content': 'center',
                }),
                [
                  if (props.primaryCta != null) props.primaryCta!,
                  if (props.secondaryCta != null) props.secondaryCta!,
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
