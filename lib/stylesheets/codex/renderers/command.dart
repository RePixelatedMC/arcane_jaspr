import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
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
        'data-command-closable': 'true', // JavaScript handles close
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
        'animation': 'arcane-fade-in var(--arcane-transition-slow)',
      }),
      // Note: No Dart event handlers - JavaScript handles all interactions
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
            'box-shadow': '0 0 40px rgba(var(--primary-rgb), 0.15)',
            'overflow': 'hidden',
            'animation': 'arcane-scale-in var(--arcane-transition-slow)',
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
                dom.span(
                  styles: const dom.Styles(raw: {
                    'color': 'var(--muted-foreground)',
                    'display': 'flex',
                    'align-items': 'center',
                  }),
                  [ArcaneIcon.search(size: IconSize.md)],
                ),
                // Raw HTML input to prevent Jaspr client hydration crashes
                dom.RawText(
                  '<input class="codex-command-input" type="text" '
                  'placeholder="${props.placeholder}" '
                  'autofocus autocomplete="off" spellcheck="false" '
                  'style="flex:1;background:transparent;border:none;'
                  'font-size:0.9375rem;color:var(--foreground);outline:none;">',
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
                      'font-size': 'var(--font-size-sm)',
                    }),
                    [Component.text(props.emptyMessage)],
                  )
                else if (props.searchQuery.isEmpty)
                  for (final group in props.groups) ...[
                    if (group.heading != null)
                      dom.div(
                        styles: const dom.Styles(raw: {
                          'padding': '10px 14px',
                          'font-size': 'var(--font-size-xs)',
                          'font-weight': 'var(--font-weight-semibold)',
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
                'font-size': 'var(--font-size-xs)',
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
        // Data attributes for JavaScript navigation
        if (item.href != null) 'data-href': item.href!,
        if (item.hrefTarget != null) 'data-target': item.hrefTarget!,
        // Store keywords for JS filtering
        if (item.keywords != null && item.keywords!.isNotEmpty)
          'data-keywords': item.keywords!.join(','),
        'data-label': item.label,
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '10px',
        'padding': '10px 14px',
        'border-radius': 'var(--radius)',
        'cursor': item.disabled ? 'not-allowed' : 'pointer',
        'transition': 'background-color var(--arcane-transition)',
        if (item.disabled) 'opacity': '0.5',
      }),
      // Note: No Dart event handlers - JavaScript handles clicks via data-href
      [
        if (item.icon != null) item.icon!,
        dom.span(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--foreground)',
          }),
          [Component.text(item.label)],
        ),
        if (item.shortcut != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
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
