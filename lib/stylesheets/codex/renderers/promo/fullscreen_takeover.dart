import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../../core/props/promo_props.dart';

/// Codex Fullscreen Takeover renderer.
///
/// A dramatic full-screen takeover for major promotions.
class CodexFullscreenTakeover extends StatefulComponent {
  final FullscreenTakeoverProps props;

  const CodexFullscreenTakeover(this.props, {super.key});

  @override
  State<CodexFullscreenTakeover> createState() =>
      _CodexFullscreenTakeoverState();
}

class _CodexFullscreenTakeoverState extends State<CodexFullscreenTakeover> {
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
      classes: 'codex-fullscreen-takeover',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '200',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': '2rem',
        // Codex: dramatic dark background with gradient
        'background':
            'linear-gradient(180deg, rgba(0, 0, 0, 0.98) 0%, rgba(10, 10, 10, 0.95) 50%, rgba(0, 0, 0, 0.98) 100%)',
        'backdrop-filter': 'blur(16px)',
        '-webkit-backdrop-filter': 'blur(16px)',
      }),
      [
        // Close button
        dom.button(
          styles: const dom.Styles(raw: {
            'position': 'absolute',
            'top': '2rem',
            'right': '2rem',
            'width': '48px',
            'height': '48px',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'background': 'rgba(255, 255, 255, 0.1)',
            'border': '1px solid rgba(255, 255, 255, 0.2)',
            'border-radius': 'var(--arcane-radius-full)',
            'color': 'var(--foreground)',
            'font-size': 'var(--font-size-xl)',
            'cursor': 'pointer',
            'transition': 'all var(--transition)',
          }),
          events: {'click': (_) => _dismiss()},
          [const Component.text('\u2715')],
        ),

        // Content container
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'text-align': 'center',
            'max-width': '640px',
          }),
          [
            // Subheadline
            dom.div(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-lg)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--primary)',
                'text-transform': 'uppercase',
                'letter-spacing': '0.2em',
                'margin-bottom': '1rem',
                // Codex: text glow
              }),
              [Component.text(component.props.subheadline)],
            ),

            // Discount badge
            if (component.props.discount != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'inline-block',
                  'padding': '1rem 2.5rem',
                  'background':
                      'linear-gradient(135deg, var(--primary) 0%, rgba(var(--primary-rgb), 0.6) 100%)',
                  'border-radius': 'var(--radius-xl)',
                  'font-size': '4rem',
                  'font-weight': 'var(--font-weight-bold)',
                  'color': '#ffffff',
                  'margin-bottom': '1.5rem',
                  // Codex: intense glow
                  'box-shadow':
                      '0 0 60px rgba(var(--primary-rgb), 0.6), 0 14px 120px rgba(var(--primary-rgb), 0.3)',
                }),
                [Component.text(component.props.discount!)],
              ),

            // Headline
            dom.h1(
              styles: const dom.Styles(raw: {
                'font-size': '3.5rem',
                'font-weight': 'var(--font-weight-bold)',
                'color': 'var(--foreground)',
                'margin': '0 0 1.5rem 0',
                'line-height': '1.1',
              }),
              [Component.text(component.props.headline)],
            ),

            // Description
            if (component.props.description != null)
              dom.p(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-xl)',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.6',
                  'margin': '0 0 2rem 0',
                  'max-width': '500px',
                }),
                [Component.text(component.props.description!)],
              ),

            // Countdown
            if (_remainingTime != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-direction': 'column',
                  'align-items': 'center',
                  'gap': '0.5rem',
                  'margin-bottom': '2rem',
                }),
                [
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.1em',
                    }),
                    [Component.text('Offer ends in')],
                  ),
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-size': 'var(--font-size-3xl)',
                      'font-weight': 'var(--font-weight-bold)',
                      'color': 'var(--primary)',
                      'letter-spacing': '0.1em',
                    }),
                    [Component.text(_formatCountdown(_remainingTime!))],
                  ),
                ],
              ),

            // Promo code
            if (component.props.promoCode != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'padding': '1.25rem 2rem',
                  'background': 'rgba(var(--primary-rgb), 0.1)',
                  'border': '2px dashed var(--primary)',
                  'border-radius': 'var(--radius-lg)',
                  'margin-bottom': '2rem',
                }),
                [
                  const dom.div(
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.05em',
                      'margin-bottom': '0.5rem',
                    }),
                    [Component.text('Use code')],
                  ),
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-size': 'var(--font-size-2xl)',
                      'font-weight': 'var(--font-weight-bold)',
                      'color': 'var(--primary)',
                      'letter-spacing': '0.2em',
                    }),
                    [Component.text(component.props.promoCode!)],
                  ),
                ],
              ),

            // CTA Buttons
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'flex-wrap': 'wrap',
                'justify-content': 'center',
                'gap': '1rem',
              }),
              [
                // Primary CTA
                if (component.props.ctaText != null)
                  dom.a(
                    href: component.props.ctaHref ?? '#',
                    styles: const dom.Styles(raw: {
                      'display': 'inline-block',
                      'padding': '1.25rem 3rem',
                      'background': 'var(--primary)',
                      'border': 'none',
                      'border-radius': 'var(--radius-lg)',
                      'color': '#ffffff',
                      'font-size': 'var(--font-size-lg)',
                      'font-weight': 'var(--font-weight-bold)',
                      'text-decoration': 'none',
                      'cursor': 'pointer',
                      'transition': 'all var(--transition)',
                      // Codex: intense glow
                      'box-shadow':
                          '0 0 40px rgba(var(--primary-rgb), 0.5), 0 10px 40px -10px rgba(var(--primary-rgb), 0.4)',
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

                // Secondary CTA (dismiss)
                if (component.props.secondaryCtaText != null)
                  dom.button(
                    styles: const dom.Styles(raw: {
                      'padding': '1.25rem 2rem',
                      'background': 'transparent',
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius-lg)',
                      'color': 'var(--muted-foreground)',
                      'font-size': 'var(--font-size-base)',
                      'font-weight': 'var(--font-weight-medium)',
                      'cursor': 'pointer',
                      'transition': 'all var(--transition)',
                    }),
                    events: {'click': (_) => _dismiss()},
                    [Component.text(component.props.secondaryCtaText!)],
                  ),
              ],
            ),
          ],
        ),

        // Decorative glow elements
        const dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'top': '20%',
            'left': '10%',
            'width': '300px',
            'height': '300px',
            'background': 'radial-gradient(circle, rgba(var(--primary-rgb), 0.15) 0%, transparent 70%)',
            'pointer-events': 'none',
          }),
          [],
        ),
        const dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'bottom': '20%',
            'right': '10%',
            'width': '400px',
            'height': '400px',
            'background': 'radial-gradient(circle, rgba(var(--primary-rgb), 0.1) 0%, transparent 70%)',
            'pointer-events': 'none',
          }),
          [],
        ),
      ],
    );
  }
}
