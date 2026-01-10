import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/drawer_props.dart';

/// Codex Drawer renderer.
///
/// Implements the Codex design language:
/// - Glass effect with backdrop blur
/// - Subtle accent glow on border
/// - OLED-optimized dark background
class CodexDrawer extends StatelessComponent {
  final DrawerProps props;

  const CodexDrawer(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (!props.isOpen) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    final bool isHorizontal =
        props.position == DrawerPosition.left ||
        props.position == DrawerPosition.right;

    // Codex sizes - 1.25x larger
    final String sizeValue = switch (props.size) {
      DrawerSize.sm => isHorizontal ? '320px' : '30vh',
      DrawerSize.md => isHorizontal ? '400px' : '50vh',
      DrawerSize.lg => isHorizontal ? '540px' : '70vh',
      DrawerSize.xl => isHorizontal ? '720px' : '90vh',
      DrawerSize.full => '100%',
    };

    // Position-specific styles
    final Map<String, String> positionStyles = switch (props.position) {
      DrawerPosition.left => {
          'left': '0',
          'top': '0',
          'bottom': '0',
          'width': props.width ?? sizeValue,
          'border-right': '1px solid var(--primary)',
        },
      DrawerPosition.right => {
          'right': '0',
          'top': '0',
          'bottom': '0',
          'width': props.width ?? sizeValue,
          'border-left': '1px solid var(--primary)',
        },
      DrawerPosition.top => {
          'left': '0',
          'right': '0',
          'top': '0',
          'height': props.height ?? sizeValue,
          'border-bottom': '1px solid var(--primary)',
        },
      DrawerPosition.bottom => {
          'left': '0',
          'right': '0',
          'bottom': '0',
          'height': props.height ?? sizeValue,
          'border-top': '1px solid var(--primary)',
        },
    };

    return dom.div(
      classes: 'codex-drawer-overlay',
      styles: dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '50',
        if (props.showBackdrop) ...{
          'background-color': 'rgba(0, 0, 0, 0.85)',
          'backdrop-filter': 'blur(4px)',
          '-webkit-backdrop-filter': 'blur(4px)',
        },
      }),
      events: props.closeOnBackdropClick && props.onClose != null
          ? {'click': (_) => props.onClose!()}
          : null,
      [
        // Drawer panel
        dom.div(
          classes: 'codex-drawer',
          styles: dom.Styles(raw: {
            'position': 'fixed',
            ...positionStyles,
            'display': 'flex',
            'flex-direction': 'column',
            // Codex: glass effect
            'background-color': 'rgba(10, 10, 10, 0.95)',
            'backdrop-filter': 'blur(12px)',
            '-webkit-backdrop-filter': 'blur(12px)',
            // Codex: subtle accent glow
            'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.15)',
            'overflow': 'hidden',
          }),
          events: {'click': (e) => e.stopPropagation()},
          [
            // Header
            if (props.header != null || props.showCloseButton)
              dom.div(
                classes: 'codex-drawer-header',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'flex-shrink': '0',
                  'padding': '1.25rem 1.5rem', // Codex: more padding
                  'border-bottom': '1px solid var(--border)',
                }),
                [
                  if (props.header != null)
                    dom.div(
                      styles: const dom.Styles(raw: {'flex': '1'}),
                      [props.header!],
                    )
                  else
                    const dom.div([], styles: dom.Styles(raw: {'flex': '1'})),
                  if (props.showCloseButton)
                    dom.button(
                      classes: 'codex-drawer-close',
                      styles: const dom.Styles(raw: {
                        'width': '32px',
                        'height': '32px',
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'background': 'transparent',
                        'border': 'none',
                        'border-radius': 'var(--radius-md)',
                        'color': 'var(--muted-foreground)',
                        'cursor': 'pointer',
                        'transition': 'all var(--transition)',
                      }),
                      events: props.onClose == null
                          ? null
                          : {'click': (_) => props.onClose!()},
                      [const Component.text('\u2715')],
                    ),
                ],
              ),

            // Content
            dom.div(
              classes: 'codex-drawer-content',
              styles: const dom.Styles(raw: {
                'flex': '1',
                'overflow-y': 'auto',
                'padding': '1.5rem', // Codex: more padding
              }),
              [props.child],
            ),

            // Footer
            if (props.footer != null)
              dom.div(
                classes: 'codex-drawer-footer',
                styles: const dom.Styles(raw: {
                  'flex-shrink': '0',
                  'padding': '1.25rem 1.5rem',
                  'border-top': '1px solid var(--border)',
                }),
                [props.footer!],
              ),
          ],
        ),
      ],
    );
  }
}
