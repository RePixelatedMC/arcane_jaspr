import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/command_props.dart';

/// Codex Command renderer.
class CodexCommand extends StatelessComponent {
  final CommandProps props;

  const CodexCommand(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (!props.isOpen) {
      return const dom.div(
        styles: dom.Styles(raw: {'display': 'none'}),
        [],
      );
    }

    return dom.div(
      classes: 'codex-command-overlay',
      attributes: {
        'data-command': 'true',
      },
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'flex-start',
        'justify-content': 'center',
        'padding-top': '20vh',
        'background-color': 'rgba(0, 0, 0, 0.8)',
        'animation': 'arcane-fade-in 200ms ease',
      }),
      events: {
        'click': (e) {
          final target = e.target as dynamic;
          if (target.classList.contains('codex-command-overlay')) {
            props.onClose?.call();
          }
        },
      },
      [
        dom.div(
          classes: 'codex-command-dialog',
          attributes: {
            'role': 'dialog',
            'aria-modal': 'true',
            'aria-label': 'Command palette',
          },
          styles: const dom.Styles(raw: {
            'width': '100%',
            'max-width': '640px',
            'background-color': 'var(--card)',
            'color': 'var(--foreground)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'box-shadow': '0 0 40px rgba(var(--codex-accent-rgb), 0.15)',
            'overflow': 'hidden',
            'animation': 'arcane-scale-in 200ms ease',
          }),
          [
            // Search input
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '10px',
                'padding': '16px 20px',
                'border-bottom': '1px solid var(--border)',
              }),
              [
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--muted-foreground)',
                    'font-size': '1.125rem',
                  }),
                  [Component.text('\u{1F50D}')],
                ),
                dom.input(
                  classes: 'codex-command-input',
                  type: dom.InputType.text,
                  attributes: {
                    'placeholder': props.placeholder,
                    'autofocus': 'true',
                    'autocomplete': 'off',
                    'spellcheck': 'false',
                  },
                  styles: const dom.Styles(raw: {
                    'flex': '1',
                    'background': 'transparent',
                    'border': 'none',
                    'font-size': '0.9375rem',
                    'color': 'var(--foreground)',
                    'outline': 'none',
                  }),
                  events: {
                    'input': (e) {
                      final target = e.target as dynamic;
                      props.onSearch?.call(target.value as String);
                    },
                  },
                ),
              ],
            ),

            // Results
            dom.div(
              classes: 'codex-command-list',
              attributes: {
                'role': 'listbox',
              },
              styles: const dom.Styles(raw: {
                'max-height': '400px',
                'overflow-y': 'auto',
                'padding': '10px',
              }),
              [
                if (props.filteredItems.isEmpty)
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'padding': '24px',
                      'text-align': 'center',
                      'color': 'var(--muted-foreground)',
                      'font-size': '0.875rem',
                    }),
                    [Component.text(props.emptyMessage)],
                  )
                else if (props.searchQuery.isEmpty)
                  for (final group in props.groups) ...[
                    if (group.heading != null)
                      dom.div(
                        styles: const dom.Styles(raw: {
                          'padding': '10px 14px',
                          'font-size': '0.75rem',
                          'font-weight': '600',
                          'color': 'var(--muted-foreground)',
                          'text-transform': 'uppercase',
                          'letter-spacing': '0.05em',
                        }),
                        [Component.text(group.heading!)],
                      ),
                    for (final item in group.items) _buildItem(item),
                  ]
                else
                  for (final item in props.filteredItems) _buildItem(item),
              ],
            ),

            // Footer with keyboard hints
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '20px',
                'padding': '10px 16px',
                'border-top': '1px solid var(--border)',
                'font-size': '0.75rem',
                'color': 'var(--muted-foreground)',
              }),
              [
                _buildKeyHint('\u{21B5}', 'Select'),
                _buildKeyHint('\u{2191}\u{2193}', 'Navigate'),
                _buildKeyHint('esc', 'Close'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildItem(CommandItemProps item) {
    return dom.div(
      classes: 'codex-command-item ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'option',
        'aria-selected': 'false',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '10px',
        'padding': '10px 14px',
        'border-radius': 'var(--radius)',
        'cursor': item.disabled ? 'not-allowed' : 'pointer',
        'transition': 'background-color 150ms ease',
        if (item.disabled) 'opacity': '0.5',
      }),
      events: {
        if (!item.disabled && props.onSelectItem != null)
          'click': (e) => props.onSelectItem!(item),
      },
      [
        if (item.icon != null) item.icon!,
        dom.span(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'font-size': '0.875rem',
            'color': 'var(--foreground)',
          }),
          [Component.text(item.label)],
        ),
        if (item.shortcut != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
              'padding': '4px 8px',
              'background-color': 'var(--secondary)',
              'border-radius': 'var(--radius)',
              'font-family':
                  'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
            }),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  Component _buildKeyHint(String key, String label) {
    return dom.div(
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '6px',
      }),
      [
        dom.span(
          styles: const dom.Styles(raw: {
            'padding': '4px 8px',
            'background-color': 'var(--secondary)',
            'border-radius': 'var(--radius)',
            'font-family':
                'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
          }),
          [Component.text(key)],
        ),
        dom.span([Component.text(label)]),
      ],
    );
  }
}
