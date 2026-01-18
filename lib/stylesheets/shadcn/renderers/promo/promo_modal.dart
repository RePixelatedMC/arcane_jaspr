import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../../core/props/promo_props.dart';

/// ShadCN Promo Modal renderer.
///
/// Full-screen modal popup for high-priority promotions.
class ShadcnPromoModal extends StatefulComponent {
  final PromoModalProps props;

  const ShadcnPromoModal(this.props, {super.key});

  @override
  State<ShadcnPromoModal> createState() => _ShadcnPromoModalState();
}

class _ShadcnPromoModalState extends State<ShadcnPromoModal> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Timer? _showTimer;
  Timer? _countdownTimer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _showTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted && !_isDismissed) {
        setState(() {
          _isVisible = true;
        });
        _startCountdown();
      }
    });
  }

  void _startCountdown() {
    if (component.props.countdownDuration != null) {
      _remainingTime = component.props.countdownDuration!;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingTime.inSeconds > 0) {
          setState(() {
            _remainingTime = _remainingTime - const Duration(seconds: 1);
          });
        } else {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _showTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _handleDismiss() {
    setState(() {
      _isDismissed = true;
      _isVisible = false;
    });
    component.props.onDismiss?.call();
  }

  String _formatCountdown(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Component build(BuildContext context) {
    if (!_isVisible || _isDismissed) {
      return const dom.div(
        styles: dom.Styles(raw: {'display': 'none'}),
        [],
      );
    }

    return dom.div(
      classes: 'arcane-promo-modal-overlay',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': '24px',
        'background-color': 'rgba(0, 0, 0, 0.8)',
        'animation': 'arcane-fade-in var(--arcane-transition-slow)',
      }),
      events: {
        'click': (event) {
          if (event.target == event.currentTarget) {
            _handleDismiss();
          }
        },
      },
      [
        dom.div(
          classes: 'arcane-promo-modal',
          styles: const dom.Styles(raw: {
            'position': 'relative',
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'gap': '24px',
            'padding': '32px',
            'background-color': 'var(--card)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--arcane-radius-lg)',
            'box-shadow': 'var(--arcane-shadow-lg)',
            'max-width': '480px',
            'width': '100%',
            'text-align': 'center',
            'animation': 'arcane-scale-in var(--arcane-transition-slow)',
          }),
          events: {
            'click': (event) => event.stopPropagation(),
          },
          [
            // Close button
            dom.button(
              attributes: {
                'type': 'button',
                'aria-label': 'Close modal',
              },
              styles: const dom.Styles(raw: {
                'position': 'absolute',
                'top': '16px',
                'right': '16px',
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '24px',
                'height': '24px',
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

            // Hero image
            if (component.props.heroImage != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'width': '100%',
                  'max-height': '200px',
                  'overflow': 'hidden',
                  'border-radius': 'var(--arcane-radius-sm)',
                }),
                [component.props.heroImage!],
              ),

            // Discount badge
            if (component.props.discount != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'display': 'inline-block',
                  'padding': '8px 16px',
                  'background-color': 'var(--primary)',
                  'color': 'var(--primary-foreground)',
                  'font-size': 'var(--font-size-2xl)',
                  'font-weight': 'var(--font-weight-bold)',
                  'border-radius': 'var(--arcane-radius-xs)',
                }),
                [Component.text(component.props.discount!)],
              ),

            // Text content
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '8px',
              }),
              [
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'text-transform': 'uppercase',
                    'letter-spacing': '0.1em',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text(component.props.subtitle)],
                ),
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-2xl)',
                    'font-weight': 'var(--font-weight-bold)',
                    'color': 'var(--foreground)',
                    'line-height': '1.2',
                  }),
                  [Component.text(component.props.title)],
                ),
                if (component.props.description != null)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'line-height': '1.5',
                    }),
                    [Component.text(component.props.description!)],
                  ),
              ],
            ),

            // Countdown
            if (_remainingTime.inSeconds > 0)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'align-items': 'center',
                  'gap': '4px',
                }),
                [
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--font-size-xs)',
                      'color': 'var(--muted-foreground)',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.05em',
                    }),
                    [Component.text('Offer expires in')],
                  ),
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--font-size-xl)',
                      'font-weight': 'var(--font-weight-bold)',
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'color': 'var(--foreground)',
                    }),
                    [Component.text(_formatCountdown(_remainingTime))],
                  ),
                ],
              ),

            // Promo code
            if (component.props.promoCode != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'align-items': 'center',
                  'gap': '4px',
                }),
                [
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--font-size-xs)',
                      'color': 'var(--muted-foreground)',
                    }),
                    [Component.text('Use code')],
                  ),
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'padding': '8px 16px',
                      'background-color': 'var(--muted)',
                      'border': '2px dashed var(--border)',
                      'border-radius': 'var(--arcane-radius-xs)',
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-weight': 'var(--font-weight-bold)',
                      'font-size': 'var(--font-size-lg)',
                      'color': 'var(--foreground)',
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
                  'display': 'inline-flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'gap': '8px',
                  'padding': '12px 32px',
                  'background-color': 'var(--primary)',
                  'color': 'var(--primary-foreground)',
                  'font-size': 'var(--font-size-base)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'text-decoration': 'none',
                  'border-radius': 'var(--arcane-radius-sm)',
                  'transition': 'opacity var(--arcane-transition)',
                  'width': '100%',
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
