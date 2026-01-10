import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/cta_banner_props.dart';

/// Renders a CTA banner with gradient background.
Component renderCtaBanner(CtaBannerProps props) {
  final String start = props.gradientStart ?? 'var(--success)';
  final String end = props.gradientEnd ?? 'var(--success)';

  return dom.div(
    classes: 'arcane-cta-banner',
    styles: dom.Styles(raw: {
      'position': 'relative',
      'padding': '64px 32px',
      'border-radius': 'var(--arcane-radius-lg)',
      'background': props.backgroundImage != null
          ? 'url(${props.backgroundImage}) center/cover no-repeat'
          : 'linear-gradient(135deg, $start 0%, $end 100%)',
      'overflow': 'hidden',
      'text-align': 'center',
    }),
    [
      // Overlay for background image
      if (props.backgroundImage != null)
        const dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'inset': '0',
            'background':
                'linear-gradient(135deg, hsl(0 0% 0% / 0.7) 0%, hsl(0 0% 0% / 0.5) 100%)',
          }),
          [],
        ),
      // Content
      dom.div(
        styles: const dom.Styles(raw: {
          'position': 'relative',
          'z-index': '1',
          'max-width': '600px',
          'margin': '0 auto',
        }),
        [
          // Title
          dom.h2(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-3xl)',
              'font-weight': 'var(--font-weight-bold)',
              'color': 'var(--foreground)',
              'margin': '0 0 1rem 0',
            }),
            [Component.text(props.title)],
          ),
          // Subtitle
          if (props.subtitle != null)
            dom.p(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-lg)',
                'color': 'color-mix(in srgb, var(--foreground) 70%, transparent)',
                'margin': '0 0 2rem 0',
                'line-height': '1.6',
              }),
              [Component.text(props.subtitle!)],
            ),
          // Actions
          if (props.primaryAction != null || props.secondaryAction != null)
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'justify-content': 'center',
                'gap': 'var(--space-4)',
                'flex-wrap': 'wrap',
              }),
              [
                if (props.primaryAction != null) props.primaryAction!,
                if (props.secondaryAction != null) props.secondaryAction!,
              ],
            ),
        ],
      ),
    ],
  );
}
