import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Call-to-action banner with gradient background
class ArcaneCtaBanner extends StatelessComponent {
  final String title;
  final String? subtitle;
  final Component? primaryAction;
  final Component? secondaryAction;
  final String? gradientStart;
  final String? gradientEnd;
  final String? backgroundImage;

  const ArcaneCtaBanner({
    required this.title,
    this.subtitle,
    this.primaryAction,
    this.secondaryAction,
    this.gradientStart,
    this.gradientEnd,
    this.backgroundImage,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String start = gradientStart ?? 'hsl(142 76% 36%)';
    final String end = gradientEnd ?? 'hsl(142 76% 30%)';

    return div(
      classes: 'arcane-cta-banner',
      styles: Styles(raw: {
        'position': 'relative',
        'padding': '64px 32px',
        'border-radius': '0.75rem',
        'background': backgroundImage != null
            ? 'url($backgroundImage) center/cover no-repeat'
            : 'linear-gradient(135deg, $start 0%, $end 100%)',
        'overflow': 'hidden',
        'text-align': 'center',
      }),
      [
        // Overlay for background image
        if (backgroundImage != null)
          const div(
            styles: Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background':
                  'linear-gradient(135deg, hsl(0 0% 0% / 0.7) 0%, hsl(0 0% 0% / 0.5) 100%)',
            }),
            [],
          ),
        // Content
        div(
          styles: const Styles(raw: {
            'position': 'relative',
            'z-index': '1',
            'max-width': '600px',
            'margin': '0 auto',
          }),
          [
            // Title
            h2(
              styles: const Styles(raw: {
                'font-size': '1.875rem',
                'font-weight': '700',
                'color': 'var(--foreground)',
                'margin': '0 0 1rem 0',
              }),
              [text(title)],
            ),
            // Subtitle
            if (subtitle != null)
              p(
                styles: const Styles(raw: {
                  'font-size': '1.125rem',
                  'color': 'hsl(var(--foreground) / 0.7)',
                  'margin': '0 0 2rem 0',
                  'line-height': '1.6',
                }),
                [text(subtitle!)],
              ),
            // Actions
            if (primaryAction != null || secondaryAction != null)
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'gap': '1rem',
                  'flex-wrap': 'wrap',
                }),
                [
                  if (primaryAction != null) primaryAction!,
                  if (secondaryAction != null) secondaryAction!,
                ],
              ),
          ],
        ),
      ],
    );
  }
}
