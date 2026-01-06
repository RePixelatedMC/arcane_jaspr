import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr_lucide/jaspr_lucide.dart'
    hide Factory, Target, Key, List, Timer, View, Map;

import '../../../core/props/toast_props.dart';

/// ShadCN Toast renderer.
///
/// Outputs toast HTML matching the ShadCN/ui Sonner design language.
/// Reference: https://ui.shadcn.com/docs/components/toast
class ShadcnToast extends StatelessComponent {
  final ToastProps props;

  const ShadcnToast(this.props, {super.key});

  Component _buildIcon() {
    if (props.icon != null) {
      return props.icon!;
    }

    final iconWidget = switch (props.variant) {
      ToastVariant.success =>
        CircleCheck(width: const dom.Unit.pixels(20), height: const dom.Unit.pixels(20)),
      ToastVariant.error =>
        CircleX(width: const dom.Unit.pixels(20), height: const dom.Unit.pixels(20)),
      ToastVariant.warning =>
        TriangleAlert(width: const dom.Unit.pixels(20), height: const dom.Unit.pixels(20)),
      ToastVariant.info =>
        Info(width: const dom.Unit.pixels(20), height: const dom.Unit.pixels(20)),
      ToastVariant.loading =>
        Loader(width: const dom.Unit.pixels(20), height: const dom.Unit.pixels(20)),
    };

    final isLoading = props.variant == ToastVariant.loading;

    return dom.div(
      styles: dom.Styles(raw: {
        'color': _getIconColor(),
        if (isLoading) 'animation': 'arcane-toast-spin 1s linear infinite',
      }),
      [iconWidget],
    );
  }

  String _getIconColor() {
    return switch (props.variant) {
      ToastVariant.success => 'var(--success)',
      ToastVariant.error => 'var(--destructive)',
      ToastVariant.warning => 'var(--warning)',
      ToastVariant.info => 'var(--info)',
      ToastVariant.loading => 'var(--primary)',
    };
  }

  String _getProgressColor() {
    return switch (props.variant) {
      ToastVariant.success => 'var(--success)',
      ToastVariant.error => 'var(--destructive)',
      ToastVariant.warning => 'var(--warning)',
      ToastVariant.info => 'var(--info)',
      ToastVariant.loading => 'var(--primary)',
    };
  }

  @override
  Component build(BuildContext context) {
    // ShadCN Toast: group pointer-events-auto relative flex w-full items-center justify-between space-x-4 overflow-hidden rounded-md border p-6 pr-8 shadow-lg transition-all
    return dom.div(
      classes: 'arcane-toast arcane-toast-${props.variant.name}',
      id: props.id != null ? 'toast-${props.id}' : null,
      attributes: {
        'role': 'alert',
        'aria-live': props.variant == ToastVariant.error ? 'assertive' : 'polite',
        'aria-atomic': 'true',
        'data-variant': props.variant.name,
        'data-duration': '${props.duration}',
        'data-dismissible': '${props.dismissible}',
        'data-position': props.position.name,
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        // ShadCN: space-x-4
        'gap': '16px',
        // ShadCN: p-6 pr-8
        'padding': '24px',
        'padding-right': '32px',
        // ShadCN: bg-background
        'background-color': 'var(--background)',
        'color': 'var(--foreground)',
        // ShadCN: border
        'border': '1px solid var(--border)',
        // ShadCN: rounded-md (6px)
        'border-radius': '0.375rem',
        // ShadCN: shadow-lg
        'box-shadow':
            '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
        'min-width': '320px',
        'max-width': '420px',
        // ShadCN: pointer-events-auto
        'pointer-events': 'auto',
        'position': 'relative',
        // ShadCN: overflow-hidden
        'overflow': 'hidden',
        // ShadCN: transition-all
        'transition': 'all 200ms cubic-bezier(0.4, 0, 0.2, 1)',
        'animation': props.isExiting
            ? 'arcane-toast-exit 200ms cubic-bezier(0.4, 0, 1, 1) forwards'
            : 'arcane-toast-enter 300ms cubic-bezier(0, 0, 0.2, 1) forwards',
      }),
      events: {
        if (props.onMouseEnter != null) 'mouseenter': (_) => props.onMouseEnter!(),
        if (props.onMouseLeave != null) 'mouseleave': (_) => props.onMouseLeave!(),
      },
      [
        // Icon
        dom.div(
          classes: 'arcane-toast-icon',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '20px',
            'height': '20px',
            'flex-shrink': '0',
            'margin-top': '2px',
          }),
          [_buildIcon()],
        ),

        // Content
        dom.div(
          classes: 'arcane-toast-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          }),
          [
            if (props.title != null)
              dom.span(
                classes: 'arcane-toast-title',
                styles: const dom.Styles(raw: {
                  'font-weight': '600',
                  'font-size': '0.875rem',
                  'color': 'var(--foreground)',
                  'line-height': '1.4',
                }),
                [Component.text(props.title!)],
              ),
            dom.span(
              classes: 'arcane-toast-message',
              styles: dom.Styles(raw: {
                'font-size': '0.875rem',
                'color': props.title != null
                    ? 'var(--muted-foreground)'
                    : 'var(--foreground)',
                'line-height': '1.5',
              }),
              [Component.text(props.message)],
            ),
            if (props.description != null)
              dom.span(
                classes: 'arcane-toast-description',
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.5',
                  'margin-top': '4px',
                }),
                [Component.text(props.description!)],
              ),
            if (props.action != null)
              dom.div(
                styles: const dom.Styles(raw: {'margin-top': '8px'}),
                [
                  dom.button(
                    classes: 'arcane-toast-action',
                    attributes: {'type': 'button'},
                    styles: dom.Styles(raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'padding': '4px 8px',
                      'font-size': '0.75rem',
                      'font-weight': '500',
                      'color': props.action!.destructive
                          ? 'var(--destructive)'
                          : 'var(--primary)',
                      'background': 'transparent',
                      'border': '1px solid var(--border)',
                      'border-radius': '0.25rem',
                      'cursor': 'pointer',
                      'transition': 'opacity 150ms ease',
                    }),
                    events: {'click': (_) => props.action!.onPressed()},
                    [Component.text(props.action!.label)],
                  ),
                ],
              ),
          ],
        ),

        // Close button
        if (props.dismissible && props.onDismiss != null)
          dom.button(
            classes: 'arcane-toast-close',
            attributes: {'type': 'button', 'aria-label': 'Dismiss'},
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '24px',
              'height': '24px',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'border-radius': '0.25rem',
              'transition': 'opacity 150ms ease',
              'flex-shrink': '0',
              'opacity': '0.7',
            }),
            events: {'click': (_) => props.onDismiss!()},
            [X(width: const dom.Unit.pixels(16), height: const dom.Unit.pixels(16))],
          ),

        // Progress bar
        if (props.duration > 0 && !props.isHovered && !props.isExiting)
          dom.div(
            classes: 'arcane-toast-progress',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'left': '0',
              'height': '2px',
              'background': _getProgressColor(),
              'border-radius': '0 0 0 0.5rem',
              'animation': 'arcane-toast-progress ${props.duration}ms linear forwards',
            }),
            [],
          ),
      ],
    );
  }
}

/// ShadCN Toast Container renderer.
class ShadcnToastContainer extends StatelessComponent {
  final ToastContainerProps props;

  const ShadcnToastContainer(this.props, {super.key});

  Map<String, String> _getPositionStyles() {
    final offset = '${props.offset}px';

    return switch (props.position) {
      ToastPosition.topLeft => {
          'top': offset,
          'left': offset,
          'align-items': 'flex-start',
          'flex-direction': 'column',
        },
      ToastPosition.topCenter => {
          'top': offset,
          'left': '50%',
          'transform': 'translateX(-50%)',
          'align-items': 'center',
          'flex-direction': 'column',
        },
      ToastPosition.topRight => {
          'top': offset,
          'right': offset,
          'align-items': 'flex-end',
          'flex-direction': 'column',
        },
      ToastPosition.bottomLeft => {
          'bottom': offset,
          'left': offset,
          'align-items': 'flex-start',
          'flex-direction': 'column-reverse',
        },
      ToastPosition.bottomCenter => {
          'bottom': offset,
          'left': '50%',
          'transform': 'translateX(-50%)',
          'align-items': 'center',
          'flex-direction': 'column-reverse',
        },
      ToastPosition.bottomRight => {
          'bottom': offset,
          'right': offset,
          'align-items': 'flex-end',
          'flex-direction': 'column-reverse',
        },
    };
  }

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-toaster',
      attributes: {
        'role': 'region',
        'aria-label': 'Notifications',
        'data-position': props.position.name,
      },
      styles: dom.Styles(raw: {
        'position': 'fixed',
        // ShadCN: z-[100]
        'z-index': '100',
        'display': 'flex',
        'gap': '${props.gap}px',
        'pointer-events': 'none',
        'max-height': 'calc(100vh - 40px)',
        'overflow': 'visible',
        ..._getPositionStyles(),
      }),
      [
        for (final toastProps in props.toasts.take(props.maxVisible))
          ShadcnToast(toastProps, key: ValueKey(toastProps.id)),
      ],
    );
  }
}
