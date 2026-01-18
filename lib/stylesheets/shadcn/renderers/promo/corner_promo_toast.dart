import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../../core/props/promo_props.dart';

/// ShadCN Corner Promo Toast renderer.
///
/// A corner toast-style promo notification that slides in from a corner.
class ShadcnCornerPromoToast extends StatefulComponent {
  final CornerPromoToastProps props;

  const ShadcnCornerPromoToast(this.props, {super.key});

  @override
  State<ShadcnCornerPromoToast> createState() => _ShadcnCornerPromoToastState();
}

class _ShadcnCornerPromoToastState extends State<ShadcnCornerPromoToast> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Timer? _showTimer;

  @override
  void initState() {
    super.initState();
    _showTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted && !_isDismissed) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _showTimer?.cancel();
    super.dispose();
  }

  void _handleDismiss() {
    setState(() {
      _isDismissed = true;
      _isVisible = false;
    });
    component.props.onDismiss?.call();
  }

  Map<String, String> _getPositionStyles() {
    return switch (component.props.position) {
      PromoCornerPosition.topLeft => {
          'top': '24px',
          'left': '24px',
          'transform': _isVisible ? 'translateX(0)' : 'translateX(-120%)',
        },
      PromoCornerPosition.topRight => {
          'top': '24px',
          'right': '24px',
          'transform': _isVisible ? 'translateX(0)' : 'translateX(120%)',
        },
      PromoCornerPosition.bottomLeft => {
          'bottom': '24px',
          'left': '24px',
          'transform': _isVisible ? 'translateX(0)' : 'translateX(-120%)',
        },
      PromoCornerPosition.bottomRight => {
          'bottom': '24px',
          'right': '24px',
          'transform': _isVisible ? 'translateX(0)' : 'translateX(120%)',
        },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed) {
      return const dom.div(
        styles: dom.Styles(raw: {'display': 'none'}),
        [],
      );
    }

    return dom.div(
      classes: 'arcane-corner-promo-toast',
      styles: dom.Styles(raw: {
        'position': 'fixed',
        'z-index': '50',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '12px',
        'padding': '16px',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-md)',
        'box-shadow': 'var(--arcane-shadow-lg)',
        'transition': 'transform 300ms cubic-bezier(0.4, 0, 0.2, 1)',
        'max-width': '320px',
        ..._getPositionStyles(),
      }),
      [
        // Header with icon and dismiss
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'justify-content': 'space-between',
            'gap': '12px',
          }),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'flex-start',
                'gap': '12px',
              }),
              [
                if (component.props.icon != null)
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'width': '20px',
                      'height': '20px',
                      'flex-shrink': '0',
                      'color': 'var(--primary)',
                    }),
                    [component.props.icon!],
                  ),
                dom.div(
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'flex-direction': 'column',
                    'gap': '4px',
                  }),
                  [
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'font-size': 'var(--font-size-sm)',
                        'font-weight': 'var(--font-weight-semibold)',
                        'color': 'var(--foreground)',
                      }),
                      [Component.text(component.props.title)],
                    ),
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'font-size': 'var(--font-size-sm)',
                        'color': 'var(--muted-foreground)',
                        'line-height': '1.5',
                      }),
                      [Component.text(component.props.message)],
                    ),
                  ],
                ),
              ],
            ),
            dom.button(
              attributes: {
                'type': 'button',
                'aria-label': 'Dismiss',
              },
              styles: const dom.Styles(raw: {
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '20px',
                'height': '20px',
                'padding': '0',
                'background': 'transparent',
                'border': 'none',
                'color': 'var(--muted-foreground)',
                'cursor': 'pointer',
                'opacity': '0.7',
              }),
              events: {'click': (_) => _handleDismiss()},
              [const Component.text('\u00D7')],
            ),
          ],
        ),

        // Promo code and CTA
        if (component.props.promoCode != null || component.props.ctaText != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '8px',
              'flex-wrap': 'wrap',
            }),
            [
              if (component.props.promoCode != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'padding': '4px 8px',
                    'background-color': 'var(--muted)',
                    'border-radius': 'var(--arcane-radius-xs)',
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'font-weight': 'var(--font-weight-semibold)',
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(component.props.promoCode!)],
                ),
              if (component.props.ctaText != null)
                dom.a(
                  href: component.props.ctaHref ?? '#',
                  styles: const dom.Styles(raw: {
                    'display': 'inline-flex',
                    'align-items': 'center',
                    'gap': '4px',
                    'padding': '6px 12px',
                    'background-color': 'var(--primary)',
                    'color': 'var(--primary-foreground)',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'text-decoration': 'none',
                    'border-radius': 'var(--arcane-radius-xs)',
                    'transition': 'opacity var(--arcane-transition)',
                  }),
                  events: {
                    'click': (e) {
                      if (component.props.onCtaClick != null) {
                        e.preventDefault();
                        component.props.onCtaClick!();
                      }
                    },
                  },
                  [Component.text(component.props.ctaText!)],
                ),
            ],
          ),
      ],
    );
  }
}
