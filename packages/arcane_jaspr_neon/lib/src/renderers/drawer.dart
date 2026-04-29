import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/drawer_props.dart';

/// Neon Drawer renderer.
///
/// Implements the Neon design language:
/// - Glass effect with backdrop blur
/// - Subtle accent glow on border
/// - OLED-optimized dark background
class NeonDrawer extends StatelessComponent {
  final DrawerProps props;

  const NeonDrawer(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id ?? _autoId();
    final bool isHorizontal =
        props.position == DrawerPosition.left ||
        props.position == DrawerPosition.right;

    final String sizeValue = switch (props.size) {
      DrawerSize.sm => isHorizontal ? '320px' : '30vh',
      DrawerSize.md => isHorizontal ? '400px' : '50vh',
      DrawerSize.lg => isHorizontal ? '540px' : '70vh',
      DrawerSize.xl => isHorizontal ? '720px' : '90vh',
      DrawerSize.full => '100%',
    };

    final Map<String, String> positionStyles = switch (props.position) {
      DrawerPosition.left => {
        'left': '0',
        'top': '0',
        'bottom': '0',
        'width': props.width ?? sizeValue,
        'border-right': '1px solid var(--neon-panel-border-hot)',
      },
      DrawerPosition.right => {
        'right': '0',
        'top': '0',
        'bottom': '0',
        'width': props.width ?? sizeValue,
        'border-left': '1px solid var(--neon-panel-border-hot)',
      },
      DrawerPosition.top => {
        'left': '0',
        'right': '0',
        'top': '0',
        'height': props.height ?? sizeValue,
        'border-bottom': '1px solid var(--neon-panel-border-hot)',
      },
      DrawerPosition.bottom => {
        'left': '0',
        'right': '0',
        'bottom': '0',
        'height': props.height ?? sizeValue,
        'border-top': '1px solid var(--neon-panel-border-hot)',
      },
    };

    return dom.div(
      classes: 'neon-drawer-overlay',
      attributes: <String, String>{
        ...surfaceAttrs(
          surface: 'drawer',
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
        raw: {
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          if (props.showBackdrop) ...{
            'background-color':
                'color-mix(in srgb, var(--neon-surface-0) 78%, transparent)',
            'backdrop-filter': 'blur(8px) saturate(1.1)',
            '-webkit-backdrop-filter': 'blur(8px) saturate(1.1)',
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
      [
        dom.div(
          classes: 'neon-drawer',
          attributes: const <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            'data-arcane-autofocus': '',
          },
          styles: dom.Styles(
            raw: {
              'position': 'fixed',
              ...positionStyles,
              'display': 'flex',
              'flex-direction': 'column',
              'background':
                  'var(--neon-panel-tint), color-mix(in srgb, var(--neon-panel-surface) 94%, transparent)',
              'backdrop-filter': 'blur(20px) saturate(1.2)',
              '-webkit-backdrop-filter': 'blur(20px) saturate(1.2)',
              'box-shadow': 'var(--neon-shadow-lg), var(--neon-glow-md)',
              'overflow': 'hidden',
            },
          ),
          events: {'click': (e) => e.stopPropagation()},
          [
            if (props.header != null || props.showCloseButton)
              dom.div(
                classes: 'neon-drawer-header',
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'space-between',
                    'flex-shrink': '0',
                    'padding': '1.25rem 1.5rem',
                    'border-bottom': '1px solid var(--neon-panel-border)',
                  },
                ),
                [
                  if (props.header != null)
                    dom.div(styles: const dom.Styles(raw: {'flex': '1'}), [
                      props.header!,
                    ])
                  else
                    const dom.div([], styles: dom.Styles(raw: {'flex': '1'})),
                  if (props.showCloseButton)
                    dom.button(
                      classes: 'neon-drawer-close',
                      attributes: <String, String>{
                        'type': 'button',
                        'aria-label': 'Close drawer',
                        ...dismissAttrs(),
                      },
                      styles: const dom.Styles(
                        raw: {
                          'width': '32px',
                          'height': '32px',
                          'display': 'flex',
                          'align-items': 'center',
                          'justify-content': 'center',
                          'background': 'transparent',
                          'border': 'none',
                          'border-radius': 'var(--neon-radius-control)',
                          'color': 'var(--muted-foreground)',
                          'cursor': 'pointer',
                          'transition':
                              'color 0.15s ease, background 0.15s ease',
                        },
                      ),
                      events: props.onClose == null
                          ? null
                          : {'click': (_) => props.onClose!()},
                      [const Component.text('\u2715')],
                    ),
                ],
              ),

            dom.div(
              classes: 'neon-drawer-content',
              styles: const dom.Styles(
                raw: {
                  'flex': '1',
                  'overflow-y': 'auto',
                  'padding': '1.5rem',
                },
              ),
              [props.child],
            ),

            if (props.footer != null)
              dom.div(
                classes: 'neon-drawer-footer',
                styles: const dom.Styles(
                  raw: {
                    'flex-shrink': '0',
                    'padding': '1.25rem 1.5rem',
                    'border-top': '1px solid var(--neon-panel-border)',
                  },
                ),
                [props.footer!],
              ),
          ],
        ),
      ],
    );
  }

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'neon-drawer-$_autoCounter';
  }
}
