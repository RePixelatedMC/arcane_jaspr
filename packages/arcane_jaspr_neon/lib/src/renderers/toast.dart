import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/toast_props.dart';

/// Neon Toast renderer.
///
/// Implements the Neon design language:
/// - Glass effect with subtle blur
/// - Accent-colored variant glows
/// - Larger padding and border radius
class NeonToast extends StatelessComponent {
  final ToastProps props;

  const NeonToast(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (
      String accentVar,
      String iconColor,
    ) = switch (props.variant) {
      ToastVariant.info => ('var(--info)', 'var(--info)'),
      ToastVariant.success => ('var(--success)', 'var(--success)'),
      ToastVariant.warning => ('var(--warning)', 'var(--warning)'),
      ToastVariant.error => ('var(--destructive)', 'var(--destructive)'),
      ToastVariant.loading => ('var(--neon-accent)', 'var(--neon-accent)'),
    };

    return dom.div(
      classes:
          'neon-toast ${props.variant.name} ${props.isExiting ? 'exiting' : ''}',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': '0.75rem',
          'width': '360px',
          'max-width': '100%',
          'padding': '1rem 1.25rem',
          'background':
              'linear-gradient(140deg, color-mix(in srgb, $accentVar 9%, transparent), transparent 60%), color-mix(in srgb, var(--neon-panel-surface) 94%, transparent)',
          'backdrop-filter': 'blur(18px) saturate(1.18)',
          '-webkit-backdrop-filter': 'blur(18px) saturate(1.18)',
          'border':
              '1px solid color-mix(in srgb, $accentVar 38%, var(--neon-panel-border))',
          'border-radius': 'var(--neon-radius-panel)',
          'clip-path': 'var(--neon-clip-sm)',
          'box-shadow':
              'var(--neon-shadow-md), 0 0 22px color-mix(in srgb, $accentVar 22%, transparent), var(--neon-inset)',
          'transition':
              'opacity 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease',
          if (props.isExiting) 'opacity': '0',
          if (props.isExiting) 'transform': 'translateX(100%)',
        },
      ),
      events: {
        if (props.onMouseEnter != null)
          'mouseenter': (_) => props.onMouseEnter!(),
        if (props.onMouseLeave != null)
          'mouseleave': (_) => props.onMouseLeave!(),
      },
      [
        dom.div(
          classes: 'neon-toast-icon',
          styles: dom.Styles(raw: {'flex-shrink': '0', 'color': iconColor}),
          [props.icon ?? _buildDefaultIcon()],
        ),

        dom.div(
          classes: 'neon-toast-content',
          styles: const dom.Styles(raw: {'flex': '1', 'min-width': '0'}),
          [
            if (props.title != null)
              dom.div(
                classes: 'neon-toast-title',
                styles: const dom.Styles(
                  raw: {
                    'font-family': 'var(--font-heading)',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': '600',
                    'letter-spacing': '0.04em',
                    'color': 'var(--foreground)',
                    'margin-bottom': '0.25rem',
                  },
                ),
                [Component.text(props.title!)],
              ),
            dom.div(
              classes: 'neon-toast-message',
              styles: const dom.Styles(
                raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--foreground)',
                },
              ),
              [Component.text(props.message)],
            ),
            if (props.description != null)
              dom.div(
                classes: 'neon-toast-description',
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                    'margin-top': '0.375rem',
                  },
                ),
                [Component.text(props.description!)],
              ),
            if (props.action != null)
              dom.button(
                classes: 'neon-toast-action',
                styles: dom.Styles(
                  raw: {
                    'margin-top': '0.5rem',
                    'padding': '0.375rem 0.75rem',
                    'font-family': 'var(--font-heading)',
                    'font-size': 'var(--font-size-xs)',
                    'font-weight': '600',
                    'letter-spacing': '0.06em',
                    'text-transform': 'uppercase',
                    'background': props.action!.destructive
                        ? 'var(--destructive)'
                        : 'var(--neon-accent)',
                    'color': props.action!.destructive
                        ? '#ffffff'
                        : 'var(--neon-on-accent)',
                    'border': 'none',
                    'border-radius': 'var(--neon-radius-control)',
                    'clip-path': 'var(--neon-clip-xs)',
                    'cursor': 'pointer',
                    'transition': 'filter 0.15s ease',
                  },
                ),
                events: {'click': (_) => props.action!.onPressed()},
                [Component.text(props.action!.label)],
              ),
          ],
        ),

        if (props.dismissible)
          dom.button(
            classes: 'neon-toast-dismiss',
            styles: const dom.Styles(
              raw: {
                'flex-shrink': '0',
                'width': '24px',
                'height': '24px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background': 'transparent',
                'border': 'none',
                'border-radius': 'var(--neon-radius-control)',
                'color': 'var(--muted-foreground)',
                'cursor': 'pointer',
                'opacity': '0.7',
                'transition': 'opacity 0.15s ease, color 0.15s ease',
              },
            ),
            events: props.onDismiss == null
                ? null
                : {'click': (_) => props.onDismiss!()},
            [const Component.text('\u2715')],
          ),
      ],
    );
  }

  Component _buildDefaultIcon() {
    if (props.variant == ToastVariant.loading) {
      return const dom.span(
        classes: 'neon-toast-spinner',
        styles: dom.Styles(
          raw: {
            'display': 'inline-block',
            'width': '18px',
            'height': '18px',
            'border':
                '2px solid color-mix(in srgb, var(--neon-accent) 12%, transparent)',
            'border-top-color': 'var(--neon-accent)',
            'border-radius': 'var(--arcane-radius-full)',
            'animation': 'arcane-spin 0.75s linear infinite',
          },
        ),
        [],
      );
    }

    final String icon = switch (props.variant) {
      ToastVariant.info => 'i',
      ToastVariant.success => '\u2713',
      ToastVariant.warning => '!',
      ToastVariant.error => '\u2717',
      ToastVariant.loading => '',
    };

    return dom.span(
      styles: const dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '20px',
          'height': '20px',
          'font-size': 'var(--font-size-sm)',
          'font-weight': '700',
        },
      ),
      [Component.text(icon)],
    );
  }
}

/// Neon Toast Container renderer.
class NeonToastContainer extends StatelessComponent {
  final ToastContainerProps props;

  const NeonToastContainer(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Position styles
    final Map<String, String> positionStyles = switch (props.position) {
      ToastPosition.topLeft => {
        'top': '${props.offset}px',
        'left': '${props.offset}px',
        'align-items': 'flex-start',
      },
      ToastPosition.topCenter => {
        'top': '${props.offset}px',
        'left': '50%',
        'transform': 'translateX(-50%)',
        'align-items': 'center',
      },
      ToastPosition.topRight => {
        'top': '${props.offset}px',
        'right': '${props.offset}px',
        'align-items': 'flex-end',
      },
      ToastPosition.bottomLeft => {
        'bottom': '${props.offset}px',
        'left': '${props.offset}px',
        'align-items': 'flex-start',
      },
      ToastPosition.bottomCenter => {
        'bottom': '${props.offset}px',
        'left': '50%',
        'transform': 'translateX(-50%)',
        'align-items': 'center',
      },
      ToastPosition.bottomRight => {
        'bottom': '${props.offset}px',
        'right': '${props.offset}px',
        'align-items': 'flex-end',
      },
    };

    return dom.div(
      classes: 'neon-toast-container',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'z-index': '100',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '${props.gap}px',
          'pointer-events': 'none',
          ...positionStyles,
        },
      ),
      [
        for (final toast in props.toasts.take(props.maxVisible))
          dom.div(styles: const dom.Styles(raw: {'pointer-events': 'auto'}), [
            NeonToast(toast),
          ]),
      ],
    );
  }
}
