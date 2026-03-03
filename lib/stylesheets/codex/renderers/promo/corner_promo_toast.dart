import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../../core/props/promo_props.dart';

/// Codex Corner Promo Toast renderer.
///
/// A corner toast-style promo notification that slides in from a corner.
class CodexCornerPromoToast extends StatefulComponent {
  final CornerPromoToastProps props;

  const CodexCornerPromoToast(this.props, {super.key});

  @override
  State<CodexCornerPromoToast> createState() => _CodexCornerPromoToastState();
}

class _CodexCornerPromoToastState extends State<CodexCornerPromoToast> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _delayTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }

  void _dismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  Map<String, String> _getPositionStyles() {
    return switch (component.props.position) {
      PromoCornerPosition.topLeft => {
          'top': '1.5rem',
          'left': '1.5rem',
        },
      PromoCornerPosition.topRight => {
          'top': '1.5rem',
          'right': '1.5rem',
        },
      PromoCornerPosition.bottomLeft => {
          'bottom': '1.5rem',
          'left': '1.5rem',
        },
      PromoCornerPosition.bottomRight => {
          'bottom': '1.5rem',
          'right': '1.5rem',
        },
    };
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed || !_isVisible) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final Map<String, String> positionStyles = _getPositionStyles();

    return dom.div(
      classes: 'codex-corner-promo-toast',
      styles: dom.Styles(raw: {
        'position': 'fixed',
        ...positionStyles,
        'z-index': '100',
        'width': '340px',
        'max-width': 'calc(100vw - 3rem)',
        // Codex: glass effect
        'background-color': 'rgba(10, 10, 10, 0.95)',
        'backdrop-filter': 'blur(12px)',
        '-webkit-backdrop-filter': 'blur(12px)',
        'border': '1px solid var(--primary)',
        'border-radius': 'var(--radius-lg)',
        // Codex: accent glow
        'box-shadow':
            '0 0 30px rgba(var(--primary-rgb), 0.2), 0 20px 40px -12px rgba(0, 0, 0, 0.4)',
        'padding': '1.25rem',
      }),
      [
        // Header with icon and dismiss
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'gap': '0.75rem',
            'margin-bottom': '0.75rem',
          }),
          [
            // Icon
            if (component.props.icon != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'flex-shrink': '0',
                  'width': '40px',
                  'height': '40px',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'background': 'rgba(var(--primary-rgb), 0.15)',
                  'border-radius': 'var(--radius)',
                  'color': 'var(--primary)',
                }),
                [component.props.icon!],
              ),

            // Title and message
            dom.div(
              styles: const dom.Styles(raw: {
                'flex': '1',
                'min-width': '0',
              }),
              [
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-base)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--foreground)',
                    'margin-bottom': '0.25rem',
                  }),
                  [Component.text(component.props.title)],
                ),
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                    'line-height': '1.5',
                  }),
                  [Component.text(component.props.message)],
                ),
              ],
            ),

            // Dismiss button
            dom.button(
              styles: const dom.Styles(raw: {
                'flex-shrink': '0',
                'width': '24px',
                'height': '24px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background': 'transparent',
                'border': 'none',
                'border-radius': 'var(--radius-sm)',
                'color': 'var(--muted-foreground)',
                'cursor': 'pointer',
                'opacity': '0.7',
              }),
              events: {'click': (_) => _dismiss()},
              [const Component.text('\u2715')],
            ),
          ],
        ),

        // Promo code
        if (component.props.promoCode != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'padding': '0.625rem',
              'background': 'rgba(var(--primary-rgb), 0.1)',
              'border': '1px dashed rgba(var(--primary-rgb), 0.3)',
              'border-radius': 'var(--radius-sm)',
              'margin-bottom': '0.875rem',
              'text-align': 'center',
            }),
            [
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-family':
                      'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                  'font-size': 'var(--font-size-base)',
                  'font-weight': 'var(--font-weight-bold)',
                  'color': 'var(--primary)',
                  'letter-spacing': '0.1em',
                }),
                [Component.text(component.props.promoCode!)],
              ),
            ],
          ),

        // CTA Button
        if (component.props.ctaText != null)
          dom.a(
            href: component.props.ctaHref ?? '#',
            styles: const dom.Styles(raw: {
              'display': 'block',
              'width': '100%',
              'padding': '0.75rem',
              'background': 'var(--primary)',
              'border': 'none',
              'border-radius': 'var(--radius)',
              'color': '#ffffff',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'text-align': 'center',
              'text-decoration': 'none',
              'cursor': 'pointer',
              'transition': 'all var(--transition)',
              'box-shadow': '0 14px 15px rgba(var(--primary-rgb), 0.3)',
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
      ],
    );
  }
}
