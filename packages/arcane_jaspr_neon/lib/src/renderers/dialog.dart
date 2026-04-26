import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/dialog_props.dart';

/// Neon Dialog renderer.
///
/// Implements the Neon design language:
/// - Glass effect with backdrop blur
/// - Subtle accent glow
/// - Larger padding and border radius
/// - OLED-optimized dark background
class NeonDialog extends StatelessComponent {
  final DialogProps props;

  const NeonDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neon-dialog-overlay',
      styles: const dom.Styles(
        raw: {
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'padding': '1.5rem',
          // Neon: darker backdrop for OLED
          'background-color': 'rgba(0, 0, 0, 0.85)',
          'backdrop-filter': 'blur(4px)',
          '-webkit-backdrop-filter': 'blur(4px)',
        },
      ),
      events: props.barrierDismissible && props.onClose != null
          ? {'click': (_) => props.onClose!()}
          : null,
      [
        // Dialog content
        dom.div(
          classes: 'neon-dialog',
          styles: dom.Styles(
            raw: {
              'position': 'relative',
              'max-width': '${props.maxWidth}px',
              'width': '100%',
              // Neon: glass effect
              'background-color': 'rgba(10, 10, 10, 0.95)',
              'backdrop-filter': 'blur(12px)',
              '-webkit-backdrop-filter': 'blur(12px)',
              'border': '1px solid var(--primary)',
              'border-radius': 'var(--radius-2xl)', // Neon: larger radius
              // Neon: subtle accent glow
              'box-shadow':
                  '0 14px 40px rgba(var(--primary-rgb), 0.15), 0 25px 50px -12px rgba(0, 0, 0, 0.25)',
              // Neon: more padding
              'padding': '2rem',
            },
          ),
          events: {'click': (e) => e.stopPropagation()},
          [
            // Close button
            if (props.showCloseButton)
              dom.button(
                classes: 'neon-dialog-close',
                styles: const dom.Styles(
                  raw: {
                    'position': 'absolute',
                    'top': '1rem',
                    'right': '1rem',
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
                  },
                ),
                events: props.onClose == null
                    ? null
                    : {'click': (_) => props.onClose!()},
                [const Component.text('\u2715')], // X mark
              ),

            // Title
            if (props.title != null)
              dom.h2(
                classes: 'neon-dialog-title',
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xl)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--foreground)',
                    'margin': '0 0 1rem 0',
                    'padding-right': '2rem', // Space for close button
                  },
                ),
                [Component.text(props.title!)],
              ),

            // Content
            dom.div(
              classes: 'neon-dialog-content',
              styles: const dom.Styles(raw: {'color': 'var(--foreground)'}),
              props.content,
            ),

            // Actions
            if (props.actions != null && props.actions!.isNotEmpty)
              dom.div(
                classes: 'neon-dialog-actions',
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'justify-content': 'flex-end',
                    'gap': '0.75rem', // Neon: more gap
                    'margin-top': '1.5rem', // Neon: more spacing
                  },
                ),
                props.actions!,
              ),
          ],
        ),
      ],
    );
  }
}

/// Neon Sheet renderer.
class NeonSheet extends StatelessComponent {
  final SheetProps props;

  const NeonSheet(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (!props.isOpen) {
      return const dom.div([], styles: dom.Styles(raw: {'display': 'none'}));
    }

    // Size calculations
    final String sizeValue = switch (props.size) {
      SheetSizeVariant.auto => 'auto',
      SheetSizeVariant.sm => _isHorizontal ? '320px' : '30vh',
      SheetSizeVariant.md => _isHorizontal ? '440px' : '50vh',
      SheetSizeVariant.lg => _isHorizontal ? '600px' : '70vh',
      SheetSizeVariant.xl => _isHorizontal ? '800px' : '90vh',
      SheetSizeVariant.full => '100%',
    };

    // Position-specific styles
    final Map<String, String> positionStyles = switch (props.position) {
      SheetPosition.left => {
        'left': '0',
        'top': '0',
        'bottom': '0',
        'width': props.maxWidth ?? sizeValue,
        'max-width': '100vw',
        'border-right': '1px solid var(--border)',
      },
      SheetPosition.right => {
        'right': '0',
        'top': '0',
        'bottom': '0',
        'width': props.maxWidth ?? sizeValue,
        'max-width': '100vw',
        'border-left': '1px solid var(--border)',
      },
      SheetPosition.top => {
        'left': '0',
        'right': '0',
        'top': '0',
        'height': sizeValue,
        'max-height': '100vh',
        'border-bottom': '1px solid var(--border)',
      },
      SheetPosition.bottom => {
        'left': '0',
        'right': '0',
        'bottom': '0',
        'height': sizeValue,
        'max-height': '100vh',
        'border-top': '1px solid var(--border)',
      },
    };

    return dom.div(
      classes: 'neon-sheet-overlay',
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          if (props.showBackdrop) ...{
            'background-color': 'rgba(0, 0, 0, 0.85)',
            'backdrop-filter': 'blur(4px)',
            '-webkit-backdrop-filter': 'blur(4px)',
          },
        },
      ),
      events: props.closeOnBackdropClick && props.onClose != null
          ? {'click': (_) => props.onClose!()}
          : null,
      [
        // Sheet content
        dom.div(
          classes: 'neon-sheet',
          styles: dom.Styles(
            raw: {
              'position': 'fixed',
              ...positionStyles,
              'display': 'flex',
              'flex-direction': 'column',
              // Neon: glass effect
              'background-color': 'rgba(10, 10, 10, 0.95)',
              'backdrop-filter': 'blur(12px)',
              '-webkit-backdrop-filter': 'blur(12px)',
              // Neon: subtle glow
              'box-shadow': '0 14px 30px rgba(var(--primary-rgb), 0.1)',
            },
          ),
          events: {'click': (e) => e.stopPropagation()},
          [
            // Drag handle for bottom/top sheets
            if (props.showDragHandle && !_isHorizontal)
              const dom.div(
                classes: 'neon-sheet-drag-handle',
                styles: dom.Styles(
                  raw: {
                    'display': 'flex',
                    'justify-content': 'center',
                    'padding': '0.75rem 0 0.5rem',
                  },
                ),
                [
                  dom.div(
                    styles: dom.Styles(
                      raw: {
                        'width': '48px',
                        'height': '4px',
                        'background-color': 'var(--muted)',
                        'border-radius': 'var(--arcane-radius-full)',
                      },
                    ),
                    [],
                  ),
                ],
              ),

            // Header
            if (props.header != null ||
                props.title != null ||
                props.showCloseButton)
              _buildHeader(),

            // Content
            dom.div(
              classes: 'neon-sheet-content',
              styles: const dom.Styles(
                raw: {
                  'flex': '1',
                  'overflow-y': 'auto',
                  'padding': '1.5rem', // Neon: more padding
                },
              ),
              [props.child],
            ),

            // Footer
            if (props.footer != null)
              dom.div(
                classes: 'neon-sheet-footer',
                styles: const dom.Styles(
                  raw: {
                    'flex-shrink': '0',
                    'padding': '1.25rem 1.5rem',
                    'border-top': '1px solid var(--border)',
                  },
                ),
                [props.footer!],
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
        classes: 'neon-sheet-header',
        styles: const dom.Styles(
          raw: {
            'flex-shrink': '0',
            'padding': '1.25rem 1.5rem',
            'border-bottom': '1px solid var(--border)',
          },
        ),
        [props.header!],
      );
    }

    return dom.div(
      classes: 'neon-sheet-header',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'flex-start',
          'justify-content': 'space-between',
          'flex-shrink': '0',
          'padding': '1.25rem 1.5rem',
          'border-bottom': '1px solid var(--border)',
        },
      ),
      [
        dom.div(styles: const dom.Styles(raw: {'flex': '1'}), [
          if (props.title != null)
            dom.h2(
              styles: const dom.Styles(
                raw: {
                  'font-size': 'var(--font-size-lg)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--foreground)',
                  'margin': '0',
                },
              ),
              [Component.text(props.title!)],
            ),
          if (props.description != null)
            dom.p(
              styles: const dom.Styles(
                raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                  'margin': '0.375rem 0 0 0',
                },
              ),
              [Component.text(props.description!)],
            ),
        ]),
        if (props.showCloseButton)
          dom.button(
            classes: 'neon-sheet-close',
            styles: const dom.Styles(
              raw: {
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
            events: props.onClose == null
                ? null
                : {'click': (_) => props.onClose!()},
            [const Component.text('\u2715')],
          ),
      ],
    );
  }
}
