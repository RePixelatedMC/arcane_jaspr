import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../../core/props/promo_props.dart';

/// Codex Promo Modal renderer.
///
/// Full-screen modal popup for high-priority promotions.
class CodexPromoModal extends StatefulComponent {
  final PromoModalProps props;

  const CodexPromoModal(this.props, {super.key});

  @override
  State<CodexPromoModal> createState() => _CodexPromoModalState();
}

class _CodexPromoModalState extends State<CodexPromoModal> {
  bool _isVisible = false;
  bool _isDismissed = false;
  Duration? _remainingTime;
  Timer? _countdownTimer;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _delayTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
        _startCountdown();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _delayTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    if (component.props.countdownDuration != null) {
      _remainingTime = component.props.countdownDuration;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          if (_remainingTime != null && _remainingTime!.inSeconds > 0) {
            _remainingTime = _remainingTime! - const Duration(seconds: 1);
          } else {
            timer.cancel();
          }
        });
      });
    }
  }

  void _dismiss() {
    setState(() {
      _isDismissed = true;
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
    if (_isDismissed || !_isVisible) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    return dom.div(
      classes: 'codex-promo-modal-overlay',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '100',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': '1.5rem',
        // Codex: darker backdrop
        'background-color': 'rgba(0, 0, 0, 0.9)',
        'backdrop-filter': 'blur(8px)',
        '-webkit-backdrop-filter': 'blur(8px)',
      }),
      events: {'click': (_) => _dismiss()},
      [
        // Modal content
        dom.div(
          classes: 'codex-promo-modal',
          styles: const dom.Styles(raw: {
            'position': 'relative',
            'max-width': '480px',
            'width': '100%',
            // Codex: glass effect
            'background-color': 'rgba(10, 10, 10, 0.95)',
            'backdrop-filter': 'blur(12px)',
            '-webkit-backdrop-filter': 'blur(12px)',
            'border': '1px solid var(--primary)',
            'border-radius': 'var(--radius-2xl)',
            // Codex: intense accent glow
            'box-shadow':
                '0 0 60px rgba(var(--primary-rgb), 0.3), 0 25px 50px -12px rgba(0, 0, 0, 0.5)',
            'padding': '2.5rem',
            'text-align': 'center',
          }),
          events: {'click': (e) => e.stopPropagation()},
          [
            // Close button
            dom.button(
              styles: const dom.Styles(raw: {
                'position': 'absolute',
                'top': '1rem',
                'right': '1rem',
                'width': '32px',
                'height': '32px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background': 'transparent',
                'border': 'none',
                'border-radius': 'var(--radius-md)',
                'color': 'var(--muted-foreground)',
                'cursor': 'pointer',
                'transition': 'all var(--transition)',
              }),
              events: {'click': (_) => _dismiss()},
              [const Component.text('\u2715')],
            ),

            // Hero image
            if (component.props.heroImage != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'margin-bottom': '1.5rem',
                }),
                [component.props.heroImage!],
              ),

            // Subtitle
            dom.div(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--primary)',
                'text-transform': 'uppercase',
                'letter-spacing': '0.1em',
                'margin-bottom': '0.5rem',
              }),
              [Component.text(component.props.subtitle)],
            ),

            // Discount badge
            if (component.props.discount != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'inline-block',
                  'padding': '0.75rem 1.5rem',
                  'background':
                      'linear-gradient(135deg, var(--primary) 0%, rgba(var(--primary-rgb), 0.7) 100%)',
                  'border-radius': 'var(--radius-lg)',
                  'font-size': '2.5rem',
                  'font-weight': 'var(--font-weight-bold)',
                  'color': '#ffffff',
                  'margin-bottom': '1rem',
                  'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.5)',
                }),
                [Component.text(component.props.discount!)],
              ),

            // Title
            dom.h2(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-2xl)',
                'font-weight': 'var(--font-weight-bold)',
                'color': 'var(--foreground)',
                'margin': '0 0 1rem 0',
              }),
              [Component.text(component.props.title)],
            ),

            // Description
            if (component.props.description != null)
              dom.p(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-base)',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.6',
                  'margin': '0 0 1.5rem 0',
                }),
                [Component.text(component.props.description!)],
              ),

            // Countdown
            if (_remainingTime != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'gap': '0.5rem',
                  'margin-bottom': '1.5rem',
                }),
                [
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                    }),
                    [Component.text('Offer ends in')],
                  ),
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-bold)',
                      'color': 'var(--primary)',
                    }),
                    [Component.text(_formatCountdown(_remainingTime!))],
                  ),
                ],
              ),

            // Promo code
            if (component.props.promoCode != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'padding': '1rem',
                  'background': 'rgba(var(--primary-rgb), 0.1)',
                  'border': '2px dashed var(--primary)',
                  'border-radius': 'var(--radius)',
                  'margin-bottom': '1.5rem',
                }),
                [
                  const dom.div(
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--font-size-xs)',
                      'color': 'var(--muted-foreground)',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.05em',
                      'margin-bottom': '0.375rem',
                    }),
                    [Component.text('Use code')],
                  ),
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-size': 'var(--font-size-xl)',
                      'font-weight': 'var(--font-weight-bold)',
                      'color': 'var(--primary)',
                      'letter-spacing': '0.15em',
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
                  'display': 'inline-block',
                  'padding': '1rem 2.5rem',
                  'background': 'var(--primary)',
                  'border': 'none',
                  'border-radius': 'var(--radius-lg)',
                  'color': '#ffffff',
                  'font-size': 'var(--font-size-base)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'text-decoration': 'none',
                  'cursor': 'pointer',
                  'transition': 'all var(--transition)',
                  'box-shadow': '0 0 25px rgba(var(--primary-rgb), 0.5)',
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
        ),
      ],
    );
  }
}
