import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/dialog_props.dart';

/// ShadCN Dialog renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/dialog
///
/// ShadCN Dialog:
/// - Overlay: fixed inset-0 z-50 bg-black/80
/// - Content: fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 border bg-background p-6 shadow-lg duration-200
class ShadcnDialog extends StatelessComponent {
  final DialogProps props;

  const ShadcnDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-dialog-overlay',
      styles: const dom.Styles(raw: {
        // ShadCN: fixed inset-0 z-50
        'position': 'fixed',
        'inset': '0',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': '24px',
        // ShadCN: bg-black/80 (80% black overlay)
        'background-color': 'rgba(0, 0, 0, 0.8)',
        // ShadCN: animate-in fade-in-0
        'animation': 'arcane-fade-in 200ms ease',
      }),
      events: props.barrierDismissible
          ? {
              'click': (event) {
                if (event.target == event.currentTarget && props.onClose != null) {
                  props.onClose!();
                }
              },
            }
          : null,
      [
        dom.div(
          classes: 'arcane-dialog',
          attributes: {
            'role': 'dialog',
            'aria-modal': 'true',
            if (props.title != null) 'aria-labelledby': 'dialog-title',
          },
          styles: dom.Styles(raw: {
            // ShadCN: bg-background
            'background-color': 'var(--background)',
            'color': 'var(--foreground)',
            // ShadCN: rounded-lg (8px)
            'border-radius': '0.5rem',
            // ShadCN: border
            'border': '1px solid var(--border)',
            // ShadCN: shadow-lg
            'box-shadow': '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
            // ShadCN: w-full max-w-lg (512px)
            'max-width': '${props.maxWidth}px',
            'width': '100%',
            'max-height': 'calc(100vh - 48px)',
            'display': 'flex',
            'flex-direction': 'column',
            'overflow': 'hidden',
            // ShadCN: animate-in fade-in-0 zoom-in-95 duration-200
            'animation': 'arcane-scale-in 200ms ease',
          }),
          events: {
            'click': (event) => event.stopPropagation(),
          },
          [
            // Header - ShadCN: flex flex-col space-y-1.5 p-6
            if (props.title != null || props.showCloseButton)
              dom.div(
                classes: 'arcane-dialog-header',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'flex-start',
                  'justify-content': 'space-between',
                  // ShadCN: p-6
                  'padding': '24px',
                  'padding-bottom': '0',
                  'flex-shrink': '0',
                }),
                [
                  if (props.title != null)
                    // ShadCN: text-lg font-semibold leading-none tracking-tight
                    dom.span(
                      id: 'dialog-title',
                      styles: const dom.Styles(raw: {
                        'font-size': '1.125rem',
                        'font-weight': '600',
                        'line-height': '1',
                        'letter-spacing': '-0.025em',
                        'color': 'var(--foreground)',
                      }),
                      [Component.text(props.title!)],
                    )
                  else
                    const dom.div([]),
                  if (props.showCloseButton && props.onClose != null)
                    // ShadCN close button styling
                    dom.button(
                      classes: 'arcane-dialog-close',
                      attributes: {
                        'type': 'button',
                        'aria-label': 'Close dialog'
                      },
                      styles: const dom.Styles(raw: {
                        'position': 'absolute',
                        'right': '16px',
                        'top': '16px',
                        'display': 'inline-flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        // ShadCN: h-4 w-4
                        'width': '24px',
                        'height': '24px',
                        // ShadCN: rounded-sm (4px)
                        'border-radius': '0.25rem',
                        'background': 'transparent',
                        'border': 'none',
                        // ShadCN: opacity-70
                        'opacity': '0.7',
                        'color': 'var(--foreground)',
                        'cursor': 'pointer',
                        // ShadCN: transition-opacity
                        'transition': 'opacity 150ms ease',
                        'font-size': '16px',
                        'padding': '0',
                      }),
                      events: {
                        'click': (event) => props.onClose!(),
                      },
                      [const Component.text('\u00D7')],
                    ),
                ],
              ),

            // Body - ShadCN: p-6 pt-0
            dom.div(
              classes: 'arcane-dialog-body',
              styles: const dom.Styles(raw: {
                // ShadCN: p-6
                'padding': '24px',
                'overflow-y': 'auto',
                'flex': '1',
              }),
              props.content,
            ),

            // Footer - ShadCN: flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2
            if (props.actions != null && props.actions!.isNotEmpty)
              dom.div(
                classes: 'arcane-dialog-footer',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-direction': 'row',
                  'justify-content': 'flex-end',
                  // ShadCN: space-x-2
                  'gap': '8px',
                  // ShadCN: p-6 pt-0
                  'padding': '0 24px 24px 24px',
                  'flex-shrink': '0',
                }),
                props.actions!,
              ),
          ],
        ),
      ],
    );
  }
}

/// ShadCN Sheet renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/sheet
class ShadcnSheet extends StatelessComponent {
  final SheetProps props;

  const ShadcnSheet(this.props, {super.key});

  bool get _isVertical =>
      props.position == SheetPosition.bottom || props.position == SheetPosition.top;

  String? get _sizeValue {
    if (props.size == SheetSizeVariant.auto) return null;
    if (_isVertical) {
      return switch (props.size) {
        SheetSizeVariant.auto => null,
        SheetSizeVariant.sm => '30vh',
        SheetSizeVariant.md => '50vh',
        SheetSizeVariant.lg => '70vh',
        SheetSizeVariant.xl => '90vh',
        SheetSizeVariant.full => '100vh',
      };
    } else {
      return switch (props.size) {
        SheetSizeVariant.auto => null,
        SheetSizeVariant.sm => '280px',
        SheetSizeVariant.md => '400px',
        SheetSizeVariant.lg => '540px',
        SheetSizeVariant.xl => '720px',
        SheetSizeVariant.full => '100vw',
      };
    }
  }

  String get _borderRadius => switch (props.position) {
        SheetPosition.bottom => '0.75rem 0.75rem 0 0',
        SheetPosition.top => '0 0 0.75rem 0.75rem',
        SheetPosition.right => '0.75rem 0 0 0.75rem',
        SheetPosition.left => '0 0.75rem 0.75rem 0',
      };

  @override
  Component build(BuildContext context) {
    if (!props.isOpen) {
      return const dom.div([]);
    }

    final sizeVal = _sizeValue;

    // ShadCN Sheet base styles
    final Map<String, String> sheetStyles = {
      'position': 'fixed',
      // ShadCN: z-50
      'z-index': '50',
      // ShadCN: bg-background
      'background-color': 'var(--background)',
      'color': 'var(--foreground)',
      // ShadCN: shadow-lg
      'box-shadow': '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
      'display': 'flex',
      'flex-direction': 'column',
      'overflow': 'hidden',
      // ShadCN: transition ease-in-out
      'transition': 'transform 300ms cubic-bezier(0.32, 0.72, 0, 1)',
      'border-radius': props.size == SheetSizeVariant.full ? '0' : _borderRadius,
      'border': '1px solid var(--border)',
    };

    // ShadCN position-specific styles
    switch (props.position) {
      case SheetPosition.right:
        sheetStyles.addAll({
          'top': '0',
          'right': '0',
          'bottom': '0',
          'height': '100%',
          'width': sizeVal ?? '400px',
          'max-width': '100vw',
          'animation': 'arcane-slide-left 300ms ease-in-out',
        });
        break;
      case SheetPosition.left:
        sheetStyles.addAll({
          'top': '0',
          'left': '0',
          'bottom': '0',
          'height': '100%',
          'width': sizeVal ?? '400px',
          'max-width': '100vw',
          'animation': 'arcane-slide-right 300ms ease-in-out',
        });
        break;
      case SheetPosition.bottom:
        sheetStyles.addAll({
          'left': props.maxWidth != null ? '50%' : '0',
          'right': props.maxWidth != null ? 'auto' : '0',
          'bottom': '0',
          if (props.maxWidth != null) 'transform': 'translateX(-50%)',
          if (sizeVal != null) 'height': sizeVal,
          'max-height': '90vh',
          'width': props.maxWidth ?? '100%',
          'animation': 'arcane-slide-up 300ms ease-in-out',
        });
        break;
      case SheetPosition.top:
        sheetStyles.addAll({
          'left': '0',
          'right': '0',
          'top': '0',
          if (sizeVal != null) 'height': sizeVal,
          'max-height': '90vh',
          'animation': 'arcane-slide-down 300ms ease-in-out',
        });
        break;
    }

    return dom.div(
      classes: 'arcane-sheet ${props.isOpen ? 'open' : 'closed'}',
      attributes: {
        'data-sheet': 'true',
        'data-position': props.position.name,
      },
      styles: dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '1100',
        'pointer-events': props.isOpen ? 'auto' : 'none',
      }),
      [
        // Backdrop
        if (props.showBackdrop)
          dom.div(
            classes: 'arcane-sheet-backdrop',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              // ShadCN: bg-black/80
              'background-color': 'rgba(0, 0, 0, 0.8)',
              'opacity': props.isOpen ? '1' : '0',
              'transition': 'opacity 300ms ease',
              'animation': 'arcane-fade-in 200ms ease',
            }),
            events: props.closeOnBackdropClick
                ? {'click': (_) => props.onClose?.call()}
                : null,
            [],
          ),

        // Sheet panel
        dom.div(
          classes: 'arcane-sheet-panel arcane-sheet-${props.position.name}',
          styles: dom.Styles(raw: sheetStyles),
          events: {
            'click': (event) => event.stopPropagation(),
          },
          [
            // Drag handle (for bottom/top sheets)
            if (props.showDragHandle && _isVertical)
              const dom.div(
                classes: 'arcane-sheet-drag-handle',
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'padding': '8px 0',
                }),
                [
                  dom.div(
                    styles: dom.Styles(raw: {
                      'width': '36px',
                      'height': '4px',
                      'background': 'var(--muted-foreground)',
                      'border-radius': '9999px',
                      'opacity': '0.4',
                    }),
                    [],
                  ),
                ],
              ),

            // Header
            if (props.header != null || props.title != null || props.showCloseButton)
              dom.div(
                classes: 'arcane-sheet-header',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'flex-start',
                  'justify-content': 'space-between',
                  'gap': '16px',
                  'padding': '24px',
                  'padding-top': '12px',
                  'flex-shrink': '0',
                }),
                [
                  if (props.header != null)
                    dom.div(
                      styles: const dom.Styles(raw: {'flex': '1'}),
                      [props.header!],
                    )
                  else if (props.title != null)
                    dom.div(
                      styles: const dom.Styles(raw: {
                        'flex': '1',
                        'display': 'flex',
                        'flex-direction': 'column',
                        'gap': '4px',
                      }),
                      [
                        dom.span(
                          styles: const dom.Styles(raw: {
                            'font-size': '1.125rem',
                            'font-weight': '600',
                            'color': 'var(--foreground)',
                          }),
                          [Component.text(props.title!)],
                        ),
                        if (props.description != null)
                          dom.span(
                            styles: const dom.Styles(raw: {
                              'font-size': '0.875rem',
                              'color': 'var(--muted-foreground)',
                            }),
                            [Component.text(props.description!)],
                          ),
                      ],
                    )
                  else
                    const dom.div([]),
                  if (props.showCloseButton && props.onClose != null)
                    dom.button(
                      classes: 'arcane-sheet-close',
                      attributes: {'type': 'button', 'aria-label': 'Close sheet'},
                      styles: const dom.Styles(raw: {
                        'width': '32px',
                        'height': '32px',
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'padding': '0',
                        'border': 'none',
                        'background': 'transparent',
                        'color': 'var(--muted-foreground)',
                        'cursor': 'pointer',
                        'border-radius': '0.375rem',
                        'font-size': '1.25rem',
                        'transition': 'color 150ms ease, background 150ms ease',
                        'flex-shrink': '0',
                      }),
                      events: {'click': (_) => props.onClose?.call()},
                      [const Component.text('\u00D7')],
                    ),
                ],
              ),

            // Content
            dom.div(
              classes: 'arcane-sheet-content',
              styles: const dom.Styles(raw: {
                'flex': '1',
                'overflow': 'auto',
                'padding': '0 24px 24px',
              }),
              [props.child],
            ),

            // Footer
            if (props.footer != null)
              dom.div(
                classes: 'arcane-sheet-footer',
                styles: const dom.Styles(raw: {
                  'padding': '24px',
                  'border-top': '1px solid var(--border)',
                  'flex-shrink': '0',
                }),
                [props.footer!],
              ),
          ],
        ),
      ],
    );
  }
}