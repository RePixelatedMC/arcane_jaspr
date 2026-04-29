import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/toast_props.dart';

/// Neubrutalism Toast renderer.
///
/// Implements the Neubrutalism design language:
/// - Glass effect with subtle blur
/// - Accent-colored variant glows
/// - Larger padding and border radius
class NeubrutalismToast extends StatelessComponent {
  final ToastProps props;

  const NeubrutalismToast(this.props, {super.key});

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
      ToastVariant.loading => ('var(--nb-accent, var(--primary))', 'var(--nb-accent, var(--primary))'),
    };

    return dom.div(
      classes:
          'neubrutalism-toast ${props.variant.name} ${props.isExiting ? 'exiting' : ''}',
      attributes: {'data-variant': props.variant.name},
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': '0.75rem',
          'width': '360px',
          'max-width': '100%',
          'padding': '1rem 1.25rem',
          'background': 'var(--nb-paper, var(--card))',
          'border': 'var(--nb-border-thick, 4px) solid $accentVar',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow':
              'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
          'transition':
              'opacity var(--nb-transition, 120ms ease), transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
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
          classes: 'neubrutalism-toast-icon',
          styles: dom.Styles(raw: {'flex-shrink': '0', 'color': iconColor}),
          [props.icon ?? _buildDefaultIcon()],
        ),

        dom.div(
          classes: 'neubrutalism-toast-content',
          styles: const dom.Styles(raw: {'flex': '1', 'min-width': '0'}),
          [
            if (props.title != null)
              dom.div(
                classes: 'neubrutalism-toast-title',
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
              classes: 'neubrutalism-toast-message',
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
                classes: 'neubrutalism-toast-description',
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
                classes: 'neubrutalism-toast-action',
                styles: dom.Styles(
                  raw: {
                    'margin-top': '0.5rem',
                    'padding': '0.5rem 0.875rem',
                    'font-family': 'var(--font-heading)',
                    'font-size': 'var(--font-size-xs)',
                    'font-weight': '800',
                    'letter-spacing': '0.04em',
                    'text-transform': 'uppercase',
                    'background': props.action!.destructive
                        ? 'var(--destructive)'
                        : 'var(--nb-accent, var(--primary))',
                    'color': props.action!.destructive
                        ? 'var(--destructive-foreground, #fff)'
                        : 'var(--nb-on-accent, #000)',
                    'border':
                        'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                    'border-radius': 'var(--nb-radius-soft, 4px)',
                    'box-shadow':
                        'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
                    'cursor': 'pointer',
                    'transition':
                        'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
                  },
                ),
                events: {'click': (_) => props.action!.onPressed()},
                [Component.text(props.action!.label)],
              ),
          ],
        ),

        if (props.dismissible)
          dom.button(
            classes: 'neubrutalism-toast-dismiss neubrutalism-toast-close',
            styles: const dom.Styles(
              raw: {
                'flex-shrink': '0',
                'width': '28px',
                'height': '28px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background': 'transparent',
                'border': 'var(--nb-border-thin, 2px) solid transparent',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'color': 'var(--foreground)',
                'cursor': 'pointer',
                'font-weight': '900',
                'transition':
                    'background-color var(--nb-transition, 120ms ease), border-color var(--nb-transition, 120ms ease)',
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
        classes: 'neubrutalism-toast-spinner neubrutalism-loading-spinner',
        styles: dom.Styles(
          raw: {
            'display': 'inline-block',
            'width': '20px',
            'height': '20px',
            'border':
                'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
            'border-right-color': 'var(--nb-accent, var(--primary))',
            'border-radius': '9999px',
            'animation': 'arcane-spin 0.75s linear infinite',
            'box-sizing': 'border-box',
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

/// Neubrutalism Toast Container renderer.
class NeubrutalismToastContainer extends StatelessComponent {
  final ToastContainerProps props;

  const NeubrutalismToastContainer(this.props, {super.key});

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
      classes: 'neubrutalism-toast-container',
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
            NeubrutalismToast(toast),
          ]),
      ],
    );
  }
}
