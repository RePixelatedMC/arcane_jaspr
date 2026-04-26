import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/promo_props.dart';

/// Neon Sliding Sidebar Banner renderer.
///
/// A vertical sidebar banner that slides in from the edge.
class NeonSlidingSidebarBanner extends StatefulComponent {
  final SlidingSidebarBannerProps props;

  const NeonSlidingSidebarBanner(this.props, {super.key});

  @override
  State<NeonSlidingSidebarBanner> createState() =>
      _NeonSlidingSidebarBannerState();
}

class _NeonSlidingSidebarBannerState extends State<NeonSlidingSidebarBanner> {
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

  @override
  Component build(BuildContext context) {
    if (_isDismissed || !_isVisible) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final bool isLeft = component.props.position == PromoSidebarPosition.left;

    return dom.div(
      classes: 'neon-sliding-sidebar-banner',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'top': '50%',
          'transform': 'translateY(-50%)',
          if (isLeft) 'left': '1.5rem' else 'right': '1.5rem',
          'z-index': '100',
          'width': '320px',
          'max-width': 'calc(100vw - 3rem)',
          // Neon: glass effect
          'background-color': 'rgba(10, 10, 10, 0.95)',
          'backdrop-filter': 'blur(12px)',
          '-webkit-backdrop-filter': 'blur(12px)',
          'border': '1px solid var(--primary)',
          'border-radius': 'var(--radius-xl)',
          // Neon: accent glow
          'box-shadow':
              '0 0 40px rgba(var(--primary-rgb), 0.25), 0 25px 50px -12px rgba(0, 0, 0, 0.5)',
          'padding': '1.5rem',
        },
      ),
      [
        // Dismiss button
        dom.button(
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'top': '0.75rem',
              'right': '0.75rem',
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

        // Discount badge
        if (component.props.discount != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'inline-block',
                'padding': '0.5rem 1rem',
                'background': 'var(--primary)',
                'border-radius': 'var(--radius)',
                'font-size': 'var(--font-size-xl)',
                'font-weight': 'var(--font-weight-bold)',
                'color': '#ffffff',
                'margin-bottom': '1rem',
                'box-shadow': '0 14px 20px rgba(var(--primary-rgb), 0.4)',
              },
            ),
            [Component.text(component.props.discount!)],
          ),

        // Subtitle
        if (component.props.subtitle != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-xs)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--primary)',
                'text-transform': 'uppercase',
                'letter-spacing': '0',
                'margin-bottom': '0.375rem',
              },
            ),
            [Component.text(component.props.subtitle!)],
          ),

        // Title
        dom.div(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-lg)',
              'font-weight': 'var(--font-weight-bold)',
              'color': 'var(--foreground)',
              'margin-bottom': '0.5rem',
            },
          ),
          [Component.text(component.props.title)],
        ),

        // Message
        dom.div(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'line-height': '1.6',
              'margin-bottom': '1rem',
            },
          ),
          [Component.text(component.props.message)],
        ),

        // Features list
        if (component.props.features != null &&
            component.props.features!.isNotEmpty)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '0.5rem',
                'margin-bottom': '1.25rem',
              },
            ),
            [
              for (final String feature in component.props.features!)
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': '0.5rem',
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--foreground)',
                    },
                  ),
                  [
                    const dom.span(
                      styles: dom.Styles(
                        raw: {
                          'color': 'var(--success)',
                          'font-weight': 'var(--font-weight-bold)',
                        },
                      ),
                      [Component.text('\u2713')],
                    ),
                    Component.text(feature),
                  ],
                ),
            ],
          ),

        // Promo code
        if (component.props.promoCode != null)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'padding': '0.75rem',
                'background': 'rgba(var(--primary-rgb), 0.1)',
                'border': '1px dashed rgba(var(--primary-rgb), 0.3)',
                'border-radius': 'var(--radius)',
                'margin-bottom': '1rem',
                'text-align': 'center',
              },
            ),
            [
              const dom.div(
                styles: dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                    'margin-bottom': '0.25rem',
                  },
                ),
                [Component.text('Use code')],
              ),
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'font-family':
                        'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace',
                    'font-size': 'var(--font-size-base)',
                    'font-weight': 'var(--font-weight-bold)',
                    'color': 'var(--primary)',
                    'letter-spacing': '0',
                  },
                ),
                [Component.text(component.props.promoCode!)],
              ),
            ],
          ),

        // CTA Button
        if (component.props.ctaText != null)
          dom.a(
            href: component.props.ctaHref ?? '#',
            styles: const dom.Styles(
              raw: {
                'display': 'block',
                'width': '100%',
                'padding': '0.875rem',
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
                'box-shadow': '0 14px 15px rgba(var(--primary-rgb), 0.4)',
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
      ],
    );
  }
}
