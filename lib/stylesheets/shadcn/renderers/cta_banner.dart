import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/cta_banner_props.dart';

/// Renders a CTA banner with gradient background.
Component renderCtaBanner(CtaBannerProps props) {
  final String start = props.gradientStart ?? 'hsl(142 76% 36%)';
  final String end = props.gradientEnd ?? 'hsl(142 76% 30%)';

  return dom.div(
    classes: 'arcane-cta-banner',
    styles: dom.Styles(raw: {
      'position': 'relative',
      'padding': '64px 32px',
      'border-radius': '0.75rem',
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
              'font-size': '1.875rem',
              'font-weight': '700',
              'color': 'var(--foreground)',
              'margin': '0 0 1rem 0',
            }),
            [Component.text(props.title)],
          ),
          // Subtitle
          if (props.subtitle != null)
            dom.p(
              styles: const dom.Styles(raw: {
                'font-size': '1.125rem',
                'color': 'hsl(var(--foreground) / 0.7)',
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
                'gap': '1rem',
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
