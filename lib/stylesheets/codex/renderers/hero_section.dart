import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/hero_section_props.dart';

/// Codex Hero Section renderer.
///
/// Implements the Codex design language:
/// - Larger vertical padding
/// - OLED-optimized dark background
/// - Accent-colored headline gradient
class CodexHeroSection extends StatelessComponent {
  final HeroSectionProps props;

  const CodexHeroSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.section(
      classes: 'codex-hero-section',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': props.centered ? 'center' : 'flex-start',
        'padding': '${props.verticalPadding * 1.25}px 2rem', // Codex: 1.25x padding
        'max-width': '${props.maxWidth}px',
        'margin': '0 auto',
        'text-align': props.centered ? 'center' : 'left',
      }),
      [
        // Badge
        if (props.badge != null)
          dom.div(
            classes: 'codex-hero-badge',
            styles: const dom.Styles(raw: {
              'margin-bottom': '1.5rem',
            }),
            [props.badge!],
          ),

        // Headline
        dom.h1(
          classes: 'codex-hero-headline',
          styles: const dom.Styles(raw: {
            'font-size': 'clamp(2.5rem, 6vw, 4rem)',
            'font-weight': '700',
            'line-height': '1.1',
            'color': 'var(--foreground)',
            'margin': '0',
            'letter-spacing': '-0.02em',
          }),
          [Component.text(props.headline)],
        ),

        // Subheadline
        if (props.subheadline != null)
          dom.p(
            classes: 'codex-hero-subheadline',
            styles: dom.Styles(raw: {
              'font-size': 'clamp(1.125rem, 2.5vw, 1.5rem)',
              'color': 'var(--muted-foreground)',
              'line-height': '1.6',
              'margin': '1.5rem 0 0 0',
              'max-width': props.centered ? '600px' : '100%',
            }),
            [Component.text(props.subheadline!)],
          ),

        // CTAs
        if (props.primaryCta != null || props.secondaryCta != null)
          dom.div(
            classes: 'codex-hero-cta-group',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'flex-wrap': 'wrap',
              'gap': '1rem', // Codex: larger gap
              'margin-top': '2.5rem', // Codex: larger margin
              'justify-content': props.centered ? 'center' : 'flex-start',
            }),
            [
              if (props.primaryCta != null) props.primaryCta!,
              if (props.secondaryCta != null) props.secondaryCta!,
            ],
          ),

        // Media
        if (props.media != null)
          dom.div(
            classes: 'codex-hero-media',
            styles: const dom.Styles(raw: {
              'margin-top': '3rem',
              'width': '100%',
            }),
            [props.media!],
          ),
      ],
    );
  }
}

/// Codex CTA Group renderer.
class CodexCtaGroup extends StatelessComponent {
  final CtaGroupProps props;

  const CodexCtaGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-cta-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': '${props.gap * 1.25}px', // Codex: 1.25x gap
        'justify-content': props.centered ? 'center' : 'flex-start',
      }),
      [
        props.primaryCta,
        if (props.secondaryCta != null) props.secondaryCta!,
      ],
    );
  }
}
