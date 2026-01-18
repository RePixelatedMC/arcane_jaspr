import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../../core/props/promo_props.dart';

/// Codex Progress Claim Banner renderer.
///
/// A banner showing how many people have claimed an offer.
class CodexProgressClaimBanner extends StatefulComponent {
  final ProgressClaimBannerProps props;

  const CodexProgressClaimBanner(this.props, {super.key});

  @override
  State<CodexProgressClaimBanner> createState() =>
      _CodexProgressClaimBannerState();
}

class _CodexProgressClaimBannerState extends State<CodexProgressClaimBanner> {
  bool _isVisible = false;
  bool _isDismissed = false;
  late int _currentClaimed;
  Timer? _delayTimer;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _currentClaimed = component.props.claimedCount;

    _delayTimer = Timer(Duration(milliseconds: component.props.delayMs), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
        _startProgressSimulation();
      }
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _progressTimer?.cancel();
    super.dispose();
  }

  void _startProgressSimulation() {
    if (!component.props.simulateProgress) return;
    if (_currentClaimed >= component.props.totalCount) return;

    _progressTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_currentClaimed < component.props.totalCount) {
        setState(() {
          _currentClaimed++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _dismiss() {
    setState(() {
      _isDismissed = true;
    });
    component.props.onDismiss?.call();
  }

  @override
  Component build(BuildContext context) {
    if (_isDismissed || !_isVisible) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final double progressPercent =
        (_currentClaimed / component.props.totalCount).clamp(0.0, 1.0);
    final int remaining = component.props.totalCount - _currentClaimed;

    return dom.div(
      classes: 'codex-progress-claim-banner',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'bottom': '1.5rem',
        'left': '50%',
        'transform': 'translateX(-50%)',
        'z-index': '100',
        'width': '420px',
        'max-width': '90vw',
        // Codex: glass effect
        'background-color': 'rgba(10, 10, 10, 0.95)',
        'backdrop-filter': 'blur(12px)',
        '-webkit-backdrop-filter': 'blur(12px)',
        'border': '1px solid var(--primary)',
        'border-radius': 'var(--radius-lg)',
        // Codex: accent glow
        'box-shadow':
            '0 0 40px rgba(var(--primary-rgb), 0.25), 0 25px 50px -12px rgba(0, 0, 0, 0.5)',
        'padding': '1.25rem 1.5rem',
      }),
      [
        // Header
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'justify-content': 'space-between',
            'margin-bottom': '0.75rem',
          }),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'flex': '1',
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
                  }),
                  [Component.text(component.props.message)],
                ),
              ],
            ),
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

        // Progress bar
        dom.div(
          styles: const dom.Styles(raw: {
            'position': 'relative',
            'height': '8px',
            'background': 'var(--muted)',
            'border-radius': 'var(--arcane-radius-full)',
            'overflow': 'hidden',
            'margin-bottom': '0.75rem',
          }),
          [
            dom.div(
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'top': '0',
                'left': '0',
                'height': '100%',
                'width': '${(progressPercent * 100).toStringAsFixed(1)}%',
                'background':
                    'linear-gradient(90deg, var(--primary), rgba(var(--primary-rgb), 0.7))',
                'border-radius': 'var(--arcane-radius-full)',
                'transition': 'width 0.5s ease-out',
                'box-shadow': '0 0 10px rgba(var(--primary-rgb), 0.4)',
              }),
              [],
            ),
          ],
        ),

        // Stats row
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'margin-bottom': '1rem',
          }),
          [
            dom.span(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
              }),
              [
                Component.text(
                    '$_currentClaimed of ${component.props.totalCount} claimed'),
              ],
            ),
            dom.span(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--warning)',
              }),
              [Component.text('Only $remaining left!')],
            ),
          ],
        ),

        // Bottom row with promo code and CTA
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '1rem',
          }),
          [
            // Promo code
            if (component.props.promoCode != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'padding': '0.5rem 0.875rem',
                  'background': 'rgba(var(--primary-rgb), 0.15)',
                  'border': '1px dashed var(--primary)',
                  'border-radius': 'var(--radius-sm)',
                  'font-family':
                      'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                  'font-size': 'var(--font-size-sm)',
                  'font-weight': 'var(--font-weight-bold)',
                  'color': 'var(--primary)',
                }),
                [Component.text(component.props.promoCode!)],
              ),

            // CTA
            if (component.props.ctaText != null)
              dom.a(
                href: component.props.ctaHref ?? '#',
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'padding': '0.75rem 1rem',
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
                  'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.4)',
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
