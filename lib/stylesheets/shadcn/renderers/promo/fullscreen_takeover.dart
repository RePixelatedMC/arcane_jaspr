import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../../core/props/promo_props.dart';

/// ShadCN Fullscreen Takeover renderer.
///
/// A dramatic full-screen takeover for major promotions.
class ShadcnFullscreenTakeover extends StatefulComponent {
  final FullscreenTakeoverProps props;

  const ShadcnFullscreenTakeover(this.props, {super.key});

  @override
  State<ShadcnFullscreenTakeover> createState() =>
      _ShadcnFullscreenTakeoverState();
}

class _ShadcnFullscreenTakeoverState extends State<ShadcnFullscreenTakeover> {
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
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

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
      classes: 'arcane-fullscreen-takeover',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '100',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': '48px 24px',
        'background-color': 'var(--background)',
        'animation': 'arcane-fade-in var(--arcane-transition-slow)',
        'overflow': 'auto',
      }),
      [
        // Close button
        dom.button(
          attributes: {
            'type': 'button',
            'aria-label': 'Close',
          },
          styles: const dom.Styles(raw: {
            'position': 'absolute',
            'top': '24px',
            'right': '24px',
            'display': 'inline-flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '40px',
            'height': '40px',
            'padding': '0',
            'background': 'var(--muted)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--arcane-radius-full)',
            'color': 'var(--foreground)',
            'cursor': 'pointer',
            'font-size': 'var(--font-size-xl)',
            'transition': 'background var(--arcane-transition)',
          }),
          events: {'click': (_) => _handleDismiss()},
          [const Component.text('\u00D7')],
        ),

        // Content container
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'gap': '32px',
            'max-width': '600px',
            'text-align': 'center',
          }),
          [
            // Discount badge
            if (component.props.discount != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'display': 'inline-block',
                  'padding': '12px 24px',
                  'background-color': 'var(--primary)',
                  'color': 'var(--primary-foreground)',
                  'font-size': 'var(--font-size-4xl)',
                  'font-weight': 'var(--font-weight-bold)',
                  'border-radius': 'var(--arcane-radius-sm)',
                }),
                [Component.text(component.props.discount!)],
              ),

            // Text content
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '12px',
              }),
              [
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'text-transform': 'uppercase',
                    'letter-spacing': '0.15em',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text(component.props.subheadline)],
                ),
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-4xl)',
                    'font-weight': 'var(--font-weight-bold)',
                    'color': 'var(--foreground)',
                    'line-height': '1.1',
                  }),
                  [Component.text(component.props.headline)],
                ),
                if (component.props.description != null)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--font-size-lg)',
                      'color': 'var(--muted-foreground)',
                      'line-height': '1.6',
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
                  'gap': '8px',
                }),
                [
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.1em',
                    }),
                    [Component.text('Offer expires in')],
                  ),
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--font-size-3xl)',
                      'font-weight': 'var(--font-weight-bold)',
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'color': 'var(--foreground)',
                      'padding': '8px 16px',
                      'background-color': 'var(--muted)',
                      'border-radius': 'var(--arcane-radius-sm)',
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
                  'gap': '8px',
                }),
                [
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                    }),
                    [Component.text('Use code at checkout')],
                  ),
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'padding': '12px 24px',
                      'background-color': 'var(--muted)',
                      'border': '2px dashed var(--border)',
                      'border-radius': 'var(--arcane-radius-sm)',
                      'font-family':
                          'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                      'font-weight': 'var(--font-weight-bold)',
                      'font-size': 'var(--font-size-2xl)',
                      'color': 'var(--foreground)',
                      'letter-spacing': '0.15em',
                    }),
                    [Component.text(component.props.promoCode!)],
                  ),
                ],
              ),

            // CTA buttons
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center',
                'gap': '12px',
                'width': '100%',
                'max-width': '320px',
              }),
              [
                if (component.props.ctaText != null)
                  dom.a(
                    href: component.props.ctaHref ?? '#',
                    styles: const dom.Styles(raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'gap': '8px',
                      'padding': '16px 32px',
                      'background-color': 'var(--primary)',
                      'color': 'var(--primary-foreground)',
                      'font-size': 'var(--font-size-lg)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'text-decoration': 'none',
                      'border-radius': 'var(--arcane-radius-sm)',
                      'width': '100%',
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
                if (component.props.secondaryCtaText != null)
                  dom.button(
                    attributes: {'type': 'button'},
                    styles: const dom.Styles(raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'padding': '12px 24px',
                      'background': 'transparent',
                      'color': 'var(--muted-foreground)',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'text-decoration': 'underline',
                      'border': 'none',
                      'cursor': 'pointer',
                    }),
                    events: {'click': (_) => _handleDismiss()},
                    [Component.text(component.props.secondaryCtaText!)],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
