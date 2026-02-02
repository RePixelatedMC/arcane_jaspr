import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/hero_section_props.dart';

/// Codex Hero Section renderer.
///
/// Implements the Codex design language:
/// - Larger vertical padding
/// - OLED-optimized dark background
/// - Optional radial gradient glow effect
/// - Stats row with value/label pairs
/// - Support for custom headline components (gradient text)
class CodexHeroSection extends StatelessComponent {
  final HeroSectionProps props;

  const CodexHeroSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String glowColor =
        props.glowColor ?? 'color-mix(in srgb, var(--primary) 30%, transparent)';

    return dom.section(
      classes: 'codex-hero-section',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'overflow': 'hidden',
        'padding': '${props.verticalPadding * 1.25}px 2rem',
        'text-align': props.centered ? 'center' : 'left',
      }),
      [
        // Background glow effect
        if (props.showBackgroundGlow)
          dom.div(
            classes: 'codex-hero-glow',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '-50%',
              'left': '50%',
              'transform': 'translateX(-50%)',
              'width': '800px',
              'height': '800px',
              'pointer-events': 'none',
              'opacity': '0.5',
              'background': 'radial-gradient(circle, $glowColor 0%, transparent 70%)',
            }),
            [],
          ),

        // Content container
        dom.div(
          classes: 'codex-hero-content',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': props.centered ? 'center' : 'flex-start',
            'max-width': '${props.maxWidth}px',
            'margin': '0 auto',
            'position': 'relative',
            'z-index': '1',
          }),
          [
            // Badge
            if (props.badge != null)
              dom.div(
                classes: 'codex-hero-badge',
                styles: const dom.Styles(raw: {
                  'margin-bottom': '1rem',
                }),
                [props.badge!],
              ),

            // Promo banner
            if (props.promoBanner != null)
              dom.div(
                classes: 'codex-hero-promo',
                styles: const dom.Styles(raw: {
                  'margin-bottom': '1.5rem',
                }),
                [props.promoBanner!],
              ),

            // Headline (component or text)
            if (props.headlineComponent != null)
              dom.h1(
                classes: 'codex-hero-headline',
                styles: const dom.Styles(raw: {
                  'font-size': 'clamp(2.5rem, 6vw, 4rem)',
                  'font-weight': '800',
                  'line-height': '1.1',
                  'color': 'var(--foreground)',
                  'margin': '0 0 1.5rem 0',
                  'letter-spacing': '-0.02em',
                }),
                [props.headlineComponent!],
              )
            else if (props.headline != null)
              dom.h1(
                classes: 'codex-hero-headline',
                styles: const dom.Styles(raw: {
                  'font-size': 'clamp(2.5rem, 6vw, 4rem)',
                  'font-weight': '800',
                  'line-height': '1.1',
                  'color': 'var(--foreground)',
                  'margin': '0 0 1.5rem 0',
                  'letter-spacing': '-0.02em',
                }),
                [Component.text(props.headline!)],
              ),

            // Subheadline
            if (props.subheadline != null)
              dom.p(
                classes: 'codex-hero-subheadline',
                styles: dom.Styles(raw: {
                  'font-size': 'clamp(1.125rem, 2.5vw, 1.25rem)',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.7',
                  'margin': '0 0 2.5rem 0',
                  'max-width': props.centered ? '650px' : '100%',
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
                  'gap': '1rem',
                  'margin-bottom':
                      props.stats != null && props.stats!.isNotEmpty ? '3rem' : '0',
                  'justify-content': props.centered ? 'center' : 'flex-start',
                }),
                [
                  if (props.primaryCta != null) props.primaryCta!,
                  if (props.secondaryCta != null) props.secondaryCta!,
                ],
              ),

            // Stats row
            if (props.stats != null && props.stats!.isNotEmpty)
              dom.div(
                classes: 'codex-hero-stats',
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': '3rem',
                  'justify-content': props.centered ? 'center' : 'flex-start',
                }),
                [
                  for (final HeroStatItem stat in props.stats!)
                    _buildStatItem(stat),
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
        ),
      ],
    );
  }

  Component _buildStatItem(HeroStatItem stat) {
    return dom.div(
      classes: 'codex-hero-stat',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': '0.25rem',
      }),
      [
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': '1.5rem',
            'font-weight': '700',
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
        'gap': '${props.gap * 1.25}px',
        'justify-content': props.centered ? 'center' : 'flex-start',
      }),
      [
        props.primaryCta,
        if (props.secondaryCta != null) props.secondaryCta!,
      ],
    );
  }
}
