import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/toast_props.dart';

/// Codex Toast renderer.
///
/// Implements the Codex design language:
/// - Glass effect with subtle blur
/// - Accent-colored variant glows
/// - Larger padding and border radius
class CodexToast extends StatelessComponent {
  final ToastProps props;

  const CodexToast(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex variant colors with glows
    final (String bgColor, String borderColor, String iconColor, String? glowColor) =
        switch (props.variant) {
      ToastVariant.info => (
          'rgba(30, 64, 175, 0.15)',
          'var(--info)',
          'var(--info)',
          '0 0 20px rgba(var(--info-rgb), 0.25)',
        ),
      ToastVariant.success => (
          'rgba(22, 101, 52, 0.15)',
          'var(--success)',
          'var(--success)',
          '0 0 20px rgba(var(--success-rgb), 0.25)',
        ),
      ToastVariant.warning => (
          'rgba(146, 64, 14, 0.15)',
          'var(--warning)',
          'var(--warning)',
          null,
        ),
      ToastVariant.error => (
          'rgba(153, 27, 27, 0.15)',
          'var(--destructive)',
          'var(--destructive)',
          '0 0 20px rgba(var(--destructive-rgb), 0.25)',
        ),
      ToastVariant.loading => (
          'rgba(var(--primary-rgb), 0.1)',
          'var(--primary)',
          'var(--primary)',
          '0 0 15px rgba(var(--primary-rgb), 0.2)',
        ),
    };

    return dom.div(
      classes: 'codex-toast ${props.variant.name} ${props.isExiting ? 'exiting' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0.75rem', // Codex: more gap
        'width': '360px',
        'max-width': '100%',
        // Codex: larger padding
        'padding': '1rem 1.25rem',
        // Codex: glass effect
        'background-color': 'rgba(10, 10, 10, 0.9)',
        'backdrop-filter': 'blur(12px)',
        '-webkit-backdrop-filter': 'blur(12px)',
        'border': '1px solid $borderColor',
        'border-radius': 'var(--radius)', // Codex: larger radius
        // Codex: accent glow
        if (glowColor != null) 'box-shadow': glowColor,
        'transition': 'all var(--transition)',
        if (props.isExiting) 'opacity': '0',
        if (props.isExiting) 'transform': 'translateX(100%)',
      }),
      events: {
        if (props.onMouseEnter != null)
          'mouseenter': (_) => props.onMouseEnter!(),
        if (props.onMouseLeave != null)
          'mouseleave': (_) => props.onMouseLeave!(),
      },
      [
        // Icon
        dom.div(
          classes: 'codex-toast-icon',
          styles: dom.Styles(raw: {
            'flex-shrink': '0',
            'color': iconColor,
          }),
          [props.icon ?? _buildDefaultIcon()],
        ),

        // Content
        dom.div(
          classes: 'codex-toast-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (props.title != null)
              dom.div(
                classes: 'codex-toast-title',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--foreground)',
                  'margin-bottom': '0.25rem',
                }),
                [Component.text(props.title!)],
              ),
            dom.div(
              classes: 'codex-toast-message',
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.message)],
            ),
            if (props.description != null)
              dom.div(
                classes: 'codex-toast-description',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.375rem',
                }),
                [Component.text(props.description!)],
              ),
            if (props.action != null)
              dom.button(
                classes: 'codex-toast-action',
                styles: dom.Styles(raw: {
                  'margin-top': '0.5rem',
                  'padding': '0.375rem 0.75rem',
                  'font-size': 'var(--font-size-xs)',
                  'font-weight': 'var(--font-weight-medium)',
                  'background': props.action!.destructive
                      ? 'var(--destructive)'
                      : 'var(--primary)',
                  'color': '#ffffff',
                  'border': 'none',
                  'border-radius': 'var(--radius-sm)',
                  'cursor': 'pointer',
                  'transition': 'all var(--transition)',
                }),
                events: {'click': (_) => props.action!.onPressed()},
                [Component.text(props.action!.label)],
              ),
          ],
        ),

        // Dismiss button
        if (props.dismissible)
          dom.button(
            classes: 'codex-toast-dismiss',
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
              'transition': 'all var(--transition)',
            }),
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
        classes: 'codex-toast-spinner',
        styles: dom.Styles(raw: {
          'display': 'inline-block',
          'width': '18px',
          'height': '18px',
          'border': '2px solid var(--muted)',
          'border-top-color': 'var(--primary)',
          'border-radius': 'var(--arcane-radius-full)',
          'animation': 'arcane-spin 0.75s linear infinite',
        }),
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
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '20px',
        'height': '20px',
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-bold)',
      }),
      [Component.text(icon)],
    );
  }
}

/// Codex Toast Container renderer.
class CodexToastContainer extends StatelessComponent {
  final ToastContainerProps props;

  const CodexToastContainer(this.props, {super.key});

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
      classes: 'codex-toast-container',
      styles: dom.Styles(raw: {
        'position': 'fixed',
        'z-index': '100',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${props.gap}px',
        'pointer-events': 'none',
        ...positionStyles,
      }),
      [
        for (final toast in props.toasts.take(props.maxVisible))
          dom.div(
            styles: const dom.Styles(raw: {'pointer-events': 'auto'}),
            [CodexToast(toast)],
          ),
      ],
    );
  }
}