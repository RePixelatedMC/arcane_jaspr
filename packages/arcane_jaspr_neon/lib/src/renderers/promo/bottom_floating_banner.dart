import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neon Bottom Floating Banner renderer.
///
/// Bottom floating banner that slides up with optional countdown timer.
class NeonBottomFloatingBanner extends StatefulComponent {
  final BottomFloatingBannerProps props;

  const NeonBottomFloatingBanner(this.props, {super.key});

  @override
  State<NeonBottomFloatingBanner> createState() =>
      _NeonBottomFloatingBannerState();
}

class _NeonBottomFloatingBannerState extends State<NeonBottomFloatingBanner> {
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
    } else if (component.props.expiresAt != null) {
      _updateRemainingFromExpiry();
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        _updateRemainingFromExpiry();
      });
    }
  }

  void _updateRemainingFromExpiry() {
    final DateTime now = DateTime.now();
    final Duration diff = component.props.expiresAt!.difference(now);
    setState(() {
      _remainingTime = diff.isNegative ? Duration.zero : diff;
    });
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
      classes: 'neon-bottom-floating-banner',
      styles: const dom.Styles(
        raw: {
          'position': 'fixed',
          'bottom': '1.5rem',
          'left': '50%',
          'transform': 'translateX(-50%)',
          'z-index': '100',
          'display': 'flex',
          'align-items': 'center',
          'gap': '1.5rem',
          'padding': '1.25rem 2rem',
          'max-width': '90vw',
          // Neon: glass effect
          'background-color': 'rgba(10, 10, 10, 0.95)',
          'backdrop-filter': 'blur(12px)',
          '-webkit-backdrop-filter': 'blur(12px)',
          'border': '1px solid var(--neon-accent)',
          'border-radius': 'var(--radius-lg)',
          // Neon: accent glow
          'box-shadow':
              '0 0 40px color-mix(in srgb, var(--neon-accent) 25%, transparent), 0 25px 50px -12px rgba(0, 0, 0, 0.5)',
        },
      ),
      [
        // Content
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.375rem',
            },
          ),
          [
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'font-size': 'var(--font-size-lg)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--foreground)',
                },
              ),
              [Component.text(component.props.title)],
            ),
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                },
              ),
              [Component.text(component.props.message)],
            ),
          ],
        ),

        // Countdown
        if (_remainingTime != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center',
                'padding': '0.75rem 1rem',
                'background': 'color-mix(in srgb, var(--neon-accent) 10%, transparent)',
                'border': '1px solid color-mix(in srgb, var(--neon-accent) 20%, transparent)',
                'border-radius': 'var(--radius)',
              },
            ),
            [
              const dom.span(
                styles: dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                    'text-transform': 'uppercase',
                    'letter-spacing': '0',
                  },
                ),
                [Component.text('Ends in')],
              ),
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'font-size': 'var(--font-size-lg)',
                    'font-weight': 'var(--font-weight-bold)',
                    'color': 'var(--neon-accent)',
                  },
                ),
                [Component.text(_formatCountdown(_remainingTime!))],
              ),
            ],
          ),

        // Promo code
        if (component.props.promoCode != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'padding': '0.5rem 1rem',
                'background': 'color-mix(in srgb, var(--neon-accent) 15%, transparent)',
                'border': '1px dashed var(--neon-accent)',
                'border-radius': 'var(--radius-sm)',
                'font-family':
                    'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--neon-accent)',
                'letter-spacing': '0',
              },
            ),
            [Component.text(component.props.promoCode!)],
          ),

        // CTA Button
        if (component.props.ctaText != null)
          dom.a(
            href: component.props.ctaHref ?? '#',
            styles: const dom.Styles(
              raw: {
                'padding': '0.75rem 1.5rem',
                'background': 'var(--neon-accent)',
                'border': 'none',
                'border-radius': 'var(--radius)',
                'color': '#ffffff',
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'text-decoration': 'none',
                'cursor': 'pointer',
                'transition': 'all var(--transition)',
                'box-shadow': '0 14px 15px color-mix(in srgb, var(--neon-accent) 40%, transparent)',
              },
            ),
            events: component.props.onCtaClick != null
                ? {
                    'click': (e) {
                      e.preventDefault();
                      component.props.onCtaClick!();
                    },
                  }
                : null,
            [Component.text(component.props.ctaText!)],
          ),

        // Dismiss button
        dom.button(
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'top': '0.5rem',
              'right': '0.5rem',
              'width': '28px',
              'height': '28px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'background': 'transparent',
              'border': 'none',
              'border-radius': 'var(--radius-sm)',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'transition': 'all var(--transition)',
            },
          ),
          events: {'click': (_) => _dismiss()},
          [const Component.text('\u2715')],
        ),
      ],
    );
  }
}
