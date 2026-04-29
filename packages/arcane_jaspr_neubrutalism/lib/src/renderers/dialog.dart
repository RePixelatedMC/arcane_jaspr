import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/dialog_props.dart';

class NeubrutalismDialog extends StatelessComponent {
  final DialogProps props;

  const NeubrutalismDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id ?? _autoId();
    final Map<String, String> surfAttrs = surfaceAttrs(
      surface: 'dialog',
      id: surfaceId,
      initiallyOpen: props.isOpen,
      dismissible: props.barrierDismissible,
      escapeCloses: props.escapeCloses,
      focusTrap: props.focusTrap,
      scrimCloses: props.barrierDismissible,
      restoreFocus: props.restoreFocus,
    );

    return dom.div(
      classes: 'neubrutalism-dialog-overlay',
      attributes: <String, String>{
        ...surfAttrs,
        'data-arcane-scrim': '',
      },
      styles: const dom.Styles(
        raw: <String, String>{
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'padding': '1.5rem',
          'background-color': 'rgba(0, 0, 0, 0.55)',
        },
      ),
      events: <String, EventCallback>{
        if (props.barrierDismissible && props.onClose != null)
          'click': (dynamic e) {
            if ((e as dynamic).target == (e as dynamic).currentTarget) {
              props.onClose!();
            }
          },
      },
      <Component>[
        dom.div(
          classes: 'neubrutalism-dialog',
          attributes: <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            'data-arcane-autofocus': '',
            if (props.title != null)
              'aria-labelledby': 'neubrutalism-dialog-title-$surfaceId',
          },
          styles: dom.Styles(
            raw: <String, String>{
              'position': 'relative',
              'max-width': '${props.maxWidth}px',
              'width': '100%',
              'padding': '2rem',
              'color': 'var(--foreground)',
            },
          ),
          events: <String, EventCallback>{
            'click': (dynamic e) => (e as dynamic).stopPropagation(),
          },
          <Component>[
            if (props.showCloseButton)
              dom.button(
                classes: 'neubrutalism-dialog-close',
                attributes: <String, String>{
                  'type': 'button',
                  'aria-label': 'Close dialog',
                  ...dismissAttrs(),
                },
                styles: const dom.Styles(
                  raw: <String, String>{
                    'position': 'absolute',
                    'top': '0.875rem',
                    'right': '0.875rem',
                    'width': '32px',
                    'height': '32px',
                    'display': 'inline-flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'background': 'transparent',
                    'border': 'none',
                    'color': 'var(--foreground)',
                    'cursor': 'pointer',
                    'font-size': '1.125rem',
                    'font-weight': '700',
                    'transition':
                        'transform var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
                  },
                ),
                events: <String, EventCallback>{
                  if (props.onClose != null)
                    'click': (dynamic _) => props.onClose!(),
                },
                <Component>[const Component.text('\u2715')],
              ),
            if (props.title != null)
              dom.h2(
                id: 'neubrutalism-dialog-title-$surfaceId',
                classes: 'neubrutalism-dialog-title',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'font-family': 'var(--font-heading)',
                    'font-size': 'var(--font-size-xl)',
                    'font-weight': '600',
                    'letter-spacing': '0.04em',
                    'color': 'var(--foreground)',
                    'margin': '0 0 0.875rem 0',
                    'padding-right': '2rem',
                  },
                ),
                <Component>[Component.text(props.title!)],
              ),
            dom.div(
              classes: 'neubrutalism-dialog-content',
              styles: const dom.Styles(
                raw: <String, String>{'color': 'var(--foreground)'},
              ),
              props.content,
            ),
            if (props.actions != null && props.actions!.isNotEmpty)
              dom.div(
                classes: 'neubrutalism-dialog-actions',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'justify-content': 'flex-end',
                    'gap': '0.625rem',
                    'margin-top': '1.5rem',
                  },
                ),
                props.actions!,
              ),
          ],
        ),
      ],
    );
  }

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'neubrutalism-dialog-$_autoCounter';
  }
}

class NeubrutalismSheet extends StatelessComponent {
  final SheetProps props;

  const NeubrutalismSheet(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id ?? _autoId();

    final String sizeValue = switch (props.size) {
      SheetSizeVariant.auto => 'auto',
      SheetSizeVariant.sm => _isHorizontal ? '320px' : '30vh',
      SheetSizeVariant.md => _isHorizontal ? '440px' : '50vh',
      SheetSizeVariant.lg => _isHorizontal ? '600px' : '70vh',
      SheetSizeVariant.xl => _isHorizontal ? '800px' : '90vh',
      SheetSizeVariant.full => '100%',
    };

    final Map<String, String> positionStyles = switch (props.position) {
      SheetPosition.left => <String, String>{
        'left': '0',
        'top': '0',
        'bottom': '0',
        'width': props.maxWidth ?? sizeValue,
        'max-width': '100vw',
      },
      SheetPosition.right => <String, String>{
        'right': '0',
        'top': '0',
        'bottom': '0',
        'width': props.maxWidth ?? sizeValue,
        'max-width': '100vw',
      },
      SheetPosition.top => <String, String>{
        'left': '0',
        'right': '0',
        'top': '0',
        'height': sizeValue,
        'max-height': '100vh',
      },
      SheetPosition.bottom => <String, String>{
        'left': '0',
        'right': '0',
        'bottom': '0',
        'height': sizeValue,
        'max-height': '100vh',
      },
    };

    return dom.div(
      classes: 'neubrutalism-sheet-overlay',
      attributes: <String, String>{
        ...surfaceAttrs(
          surface: 'sheet',
          id: surfaceId,
          initiallyOpen: props.isOpen,
          dismissible: props.closeOnBackdropClick,
          escapeCloses: props.escapeCloses,
          focusTrap: props.focusTrap,
          scrimCloses: props.closeOnBackdropClick,
          restoreFocus: props.restoreFocus,
        ),
        'data-arcane-scrim': '',
        'data-position': props.position.name,
      },
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          if (props.showBackdrop) ...<String, String>{
            'background-color': 'rgba(0, 0, 0, 0.55)',
          },
        },
      ),
      events: <String, EventCallback>{
        if (props.closeOnBackdropClick && props.onClose != null)
          'click': (dynamic e) {
            if ((e as dynamic).target == (e as dynamic).currentTarget) {
              props.onClose!();
            }
          },
      },
      <Component>[
        dom.div(
          classes: 'neubrutalism-sheet',
          attributes: const <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            'data-arcane-autofocus': '',
          },
          styles: dom.Styles(
            raw: <String, String>{
              'position': 'fixed',
              ...positionStyles,
              'display': 'flex',
              'flex-direction': 'column',
            },
          ),
          events: <String, EventCallback>{
            'click': (dynamic e) => (e as dynamic).stopPropagation(),
          },
          <Component>[
            if (props.showDragHandle && !_isHorizontal)
              const dom.div(
                classes: 'neubrutalism-sheet-drag-handle',
                styles: dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'justify-content': 'center',
                    'padding': '0.625rem 0 0.375rem',
                  },
                ),
                <Component>[
                  dom.div(
                    styles: dom.Styles(
                      raw: <String, String>{
                        'width': '40px',
                        'height': '3px',
                        'background': 'var(--nb-ink, #000)',
                        'border-radius': '9999px',
                        'opacity': '0.7',
                      },
                    ),
                    <Component>[],
                  ),
                ],
              ),
            if (props.header != null ||
                props.title != null ||
                props.showCloseButton)
              _buildHeader(),
            dom.div(
              classes: 'neubrutalism-sheet-content',
              styles: const dom.Styles(
                raw: <String, String>{
                  'flex': '1',
                  'overflow-y': 'auto',
                  'padding': '1.5rem',
                },
              ),
              <Component>[props.child],
            ),
            if (props.footer != null)
              dom.div(
                classes: 'neubrutalism-sheet-footer',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'flex-shrink': '0',
                    'padding': '1rem 1.5rem',
                    'border-top':
                        'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                  },
                ),
                <Component>[props.footer!],
              ),
          ],
        ),
      ],
    );
  }

  bool get _isHorizontal =>
      props.position == SheetPosition.left ||
      props.position == SheetPosition.right;

  Component _buildHeader() {
    if (props.header != null) {
      return dom.div(
        classes: 'neubrutalism-sheet-header',
        styles: const dom.Styles(
          raw: <String, String>{
            'flex-shrink': '0',
            'padding': '1rem 1.5rem',
            'border-bottom':
                'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          },
        ),
        <Component>[props.header!],
      );
    }

    return dom.div(
      classes: 'neubrutalism-sheet-header',
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'align-items': 'flex-start',
          'justify-content': 'space-between',
          'flex-shrink': '0',
          'padding': '1rem 1.5rem',
          'border-bottom':
              'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        },
      ),
      <Component>[
        dom.div(
          styles: const dom.Styles(raw: <String, String>{'flex': '1'}),
          <Component>[
            if (props.title != null)
              dom.h2(
                styles: const dom.Styles(
                  raw: <String, String>{
                    'font-family': 'var(--font-heading)',
                    'font-size': 'var(--font-size-lg)',
                    'font-weight': '600',
                    'letter-spacing': '0.04em',
                    'color': 'var(--foreground)',
                    'margin': '0',
                  },
                ),
                <Component>[Component.text(props.title!)],
              ),
            if (props.description != null)
              dom.p(
                styles: const dom.Styles(
                  raw: <String, String>{
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                    'margin': '0.375rem 0 0 0',
                  },
                ),
                <Component>[Component.text(props.description!)],
              ),
          ],
        ),
        if (props.showCloseButton)
          dom.button(
            classes: 'neubrutalism-sheet-close',
            attributes: <String, String>{
              'type': 'button',
              'aria-label': 'Close sheet',
              ...dismissAttrs(),
            },
            styles: const dom.Styles(
              raw: <String, String>{
                'width': '28px',
                'height': '28px',
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background': 'transparent',
                'border': 'none',
                'color': 'var(--foreground)',
                'cursor': 'pointer',
                'font-weight': '700',
                'transition':
                    'transform var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
              },
            ),
            events: <String, EventCallback>{
              if (props.onClose != null)
                'click': (dynamic _) => props.onClose!(),
            },
            <Component>[const Component.text('\u2715')],
          ),
      ],
    );
  }

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'neubrutalism-sheet-$_autoCounter';
  }
}
