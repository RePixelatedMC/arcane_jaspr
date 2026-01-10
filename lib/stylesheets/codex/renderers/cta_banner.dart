import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/cta_banner_props.dart';

/// Renders a Codex CTA banner with gradient background.
Component renderCodexCtaBanner(CtaBannerProps props) {
  final String start = props.gradientStart ?? 'var(--primary)';
  final String end = props.gradientEnd ?? 'var(--accent)';

  return dom.div(
    classes: 'codex-cta-banner',
    styles: dom.Styles(raw: {
      'position': 'relative',
      'padding': '80px 40px',
      'border-radius': 'var(--radius)',
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
                'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(0, 0, 0, 0.6) 100%)',
          }),
          [],
        ),
      // Content
      dom.div(
        styles: const dom.Styles(raw: {
          'position': 'relative',
          'z-index': '1',
          'max-width': '640px',
          'margin': '0 auto',
        }),
        [
          // Title
          dom.h2(
            styles: const dom.Styles(raw: {
              'font-size': '2rem',
              'font-weight': 'var(--font-weight-bold)',
              'color': '#ffffff',
              'margin': '0 0 1.25rem 0',
            }),
            [Component.text(props.title)],
          ),
          // Subtitle
          if (props.subtitle != null)
            dom.p(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-lg)',
                'color': 'rgba(255, 255, 255, 0.8)',
                'margin': '0 0 2.5rem 0',
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
                'gap': '1.25rem',
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
