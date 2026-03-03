import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../../core/props/promo_props.dart';

/// Codex Inline Hero Banner renderer.
///
/// An inline promotional banner with multiple style variants.
class CodexInlineHeroBanner extends StatefulComponent {
  final InlineHeroBannerProps props;

  const CodexInlineHeroBanner(this.props, {super.key});

  @override
  State<CodexInlineHeroBanner> createState() => _CodexInlineHeroBannerState();
}

class _CodexInlineHeroBannerState extends State<CodexInlineHeroBanner> {
  bool _isDismissed = false;

  void _dismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  Map<String, String> _getStyleVariantStyles() {
    return switch (component.props.style) {
      PromoInlineHeroBannerStyle.badge => {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': '0.75rem',
          'padding': '0.5rem 1rem',
          'background': 'rgba(var(--primary-rgb), 0.15)',
          'border': '1px solid rgba(var(--primary-rgb), 0.3)',
          'border-radius': 'var(--arcane-radius-full)',
        },
      PromoInlineHeroBannerStyle.ribbon => {
          'display': 'flex',
          'align-items': 'center',
          'gap': '1rem',
          'padding': '0.75rem 1.5rem',
          'background':
              'linear-gradient(90deg, var(--primary), rgba(var(--primary-rgb), 0.7))',
          'border-radius': '0',
          'color': '#ffffff',
        },
      PromoInlineHeroBannerStyle.pill => {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': '0.875rem',
          'padding': '0.875rem 1.5rem',
          'background': 'rgba(10, 10, 10, 0.9)',
          'border': '1px solid var(--primary)',
          'border-radius': 'var(--arcane-radius-full)',
          'box-shadow': '0 14px 20px rgba(var(--primary-rgb), 0.2)',
        },
      PromoInlineHeroBannerStyle.card => {
          'display': 'flex',
          'align-items': 'center',
          'gap': '1rem',
          'padding': '1.25rem 1.75rem',
          'background': 'rgba(10, 10, 10, 0.95)',
          'backdrop-filter': 'blur(12px)',
          '-webkit-backdrop-filter': 'blur(12px)',
          'border': '1px solid var(--primary)',
          'border-radius': 'var(--radius-lg)',
          'box-shadow':
              '0 0 30px rgba(var(--primary-rgb), 0.2), 0 10px 30px -10px rgba(0, 0, 0, 0.4)',
        },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final Map<String, String> variantStyles = _getStyleVariantStyles();
    final bool isRibbon =
        component.props.style == PromoInlineHeroBannerStyle.ribbon;

    return dom.div(
      classes: 'codex-inline-hero-banner ${component.props.style.name}',
      styles: dom.Styles(raw: variantStyles),
      [
        // Icon
        if (component.props.icon != null)
          dom.div(
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'color': isRibbon ? '#ffffff' : 'var(--primary)',
            }),
            [component.props.icon!],
          ),

        // Message
        dom.span(
          styles: dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-medium)',
            'color': isRibbon ? '#ffffff' : 'var(--foreground)',
          }),
          [Component.text(component.props.message)],
        ),

        // Promo code
        if (component.props.promoCode != null)
          dom.span(
            styles: dom.Styles(raw: {
              'padding': '0.25rem 0.625rem',
              'background':
                  isRibbon ? 'rgba(255, 255, 255, 0.2)' : 'rgba(var(--primary-rgb), 0.15)',
              'border-radius': 'var(--radius-sm)',
              'font-family':
                  'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-bold)',
              'color': isRibbon ? '#ffffff' : 'var(--primary)',
            }),
            [Component.text(component.props.promoCode!)],
          ),

        // CTA
        if (component.props.ctaText != null)
          dom.a(
            href: component.props.ctaHref ?? '#',
            styles: dom.Styles(raw: {
              'padding': '0.5rem 1rem',
              'background': isRibbon ? 'rgba(255, 255, 255, 0.15)' : 'var(--primary)',
              'border': isRibbon ? '1px solid rgba(255, 255, 255, 0.3)' : 'none',
              'border-radius': 'var(--radius-sm)',
              'color': '#ffffff',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'text-decoration': 'none',
              'cursor': 'pointer',
              'transition': 'all var(--transition)',
            }),
            events: component.props.onCtaClick != null
                ? {
                    'click': (e) {
                      e.preventDefault();
                      component.props.onCtaClick!();
                    }
                  }
                : null,
            [Component.text(component.props.ctaText!)],
          ),

        // Dismiss
        if (component.props.dismissible)
          dom.button(
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'margin-left': '0.5rem',
              'padding': '0.25rem',
              'background': 'transparent',
              'border': 'none',
              'color': isRibbon ? 'rgba(255, 255, 255, 0.7)' : 'var(--muted-foreground)',
              'cursor': 'pointer',
              'opacity': '0.7',
            }),
            events: {'click': (_) => _dismiss()},
            [const Component.text('\u2715')],
          ),
      ],
    );
  }
}
