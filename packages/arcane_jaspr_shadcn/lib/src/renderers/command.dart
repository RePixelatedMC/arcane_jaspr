import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/command_props.dart';

/// ShadCN Command renderer.
///
/// Outputs command palette HTML matching the ShadCN/ui cmdk design language.
/// Reference: https://ui.shadcn.com/docs/components/command
class ShadcnCommand extends StatelessComponent {
  final CommandProps props;

  const ShadcnCommand(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id ?? _autoId();

    final Map<String, String> surfAttrs = surfaceAttrs(
      surface: 'command',
      id: surfaceId,
      initiallyOpen: props.isOpen,
      dismissible: true,
      escapeCloses: props.escapeCloses,
      focusTrap: props.focusTrap,
      scrimCloses: props.scrimCloses,
      restoreFocus: props.restoreFocus,
    );

    return dom.div(
      classes: 'arcane-command-overlay arcane-overlay-scrim',
      attributes: <String, String>{
        ...surfAttrs,
        'data-arcane-command': surfaceId,
      },
      styles: const dom.Styles(
        raw: {
          'position': 'fixed',
          'inset': '0',
          // ShadCN: z-50
          'z-index': '50',
          'display': 'flex',
          'align-items': 'flex-start',
          'justify-content': 'center',
          'padding-top': '20vh',
          // ShadCN: bg-black/80
          'background-color': 'rgba(0, 0, 0, 0.5)',
          'animation': 'arcane-fade-in var(--transition-slow)',
        },
      ),
      [
        dom.div(
          classes: 'arcane-command-dialog',
          attributes: const <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            'aria-label': 'Command palette',
          },
          styles: const dom.Styles(
            raw: {
              'width': '100%',
              // ShadCN: max-w-lg
              'max-width': '640px',
              // ShadCN: bg-popover
              'background-color': 'var(--popover)',
              'color': 'var(--popover-foreground)',
              // ShadCN: border
              'border': '1px solid var(--border)',
              // ShadCN: rounded-lg
              'border-radius': 'var(--radius-md)',
              // ShadCN: shadow-lg
              'box-shadow':
                  '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
              'overflow': 'hidden',
              'animation': 'arcane-scale-in var(--transition-slow)',
            },
          ),
          [
            // Search input - ShadCN: flex items-center border-b px-3
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': 'var(--space-2)',
                  'padding': '12px 16px',
                  'border-bottom': '1px solid var(--border)',
                },
              ),
              [
                // ShadCN: Search icon
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'color': 'var(--muted-foreground)',
                      'display': 'flex',
                      'align-items': 'center',
                    },
                  ),
                  [ArcaneIcon.search(size: IconSize.md)],
                ),
                // Raw HTML input to prevent Jaspr client hydration crashes
                dom.RawText(
                  '<input class="arcane-command-input" type="text" '
                  'placeholder="${props.placeholder}" '
                  'autofocus autocomplete="off" spellcheck="false" '
                  'data-arcane-command-input="$surfaceId" '
                  'data-arcane-input="command.filter:$surfaceId" '
                  'value="${props.searchQuery}" '
                  'style="flex:1;background:transparent;border:none;'
                  'font-size:var(--font-size-sm);color:var(--foreground);outline:none;">',
                ),
              ],
            ),

            // Results - ShadCN: max-h-[300px] overflow-y-auto overflow-x-hidden
            dom.div(
              classes: 'arcane-command-list',
              attributes: const <String, String>{'role': 'listbox'},
              styles: const dom.Styles(
                raw: {
                  'max-height': '400px',
                  'overflow-y': 'auto',
                  'padding': '8px',
                },
              ),
              [
                // ShadCN: py-6 text-center text-sm
                dom.div(
                  attributes: <String, String>{
                    'data-arcane-command-empty': 'true',
                    if (props.filteredItems.isNotEmpty) 'hidden': '',
                  },
                  styles: const dom.Styles(
                    raw: {
                      'padding': '24px',
                      'text-align': 'center',
                      'color': 'var(--muted-foreground)',
                      'font-size': 'var(--font-size-sm)',
                    },
                  ),
                  [Component.text(props.emptyMessage)],
                ),

                for (final group in props.groups)
                  _buildGroup(group, surfaceId),
              ],
            ),

            // Footer with keyboard hints - ShadCN: border-t
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '16px',
                  'padding': '8px 12px',
                  'border-top': '1px solid var(--border)',
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                },
              ),
              [
                _buildKeyHint('Enter', 'Select'),
                _buildKeyHint('Up/Down', 'Navigate'),
                _buildKeyHint('esc', 'Close'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildGroup(CommandGroupProps group, String surfaceId) {
    final String groupId = (group.heading ?? 'group').toLowerCase().replaceAll(
          RegExp(r'[^a-z0-9]+'),
          '-',
        );
    return dom.div(
      attributes: <String, String>{
        'data-arcane-command-group': groupId,
      },
      [
        if (group.heading != null)
          // ShadCN: px-2 py-1.5 text-xs font-medium text-muted-foreground
          dom.div(
            classes: 'arcane-command-group-heading',
            styles: const dom.Styles(
              raw: {
                'padding': '8px 12px',
                'font-size': 'var(--font-size-xs)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--muted-foreground)',
                'text-transform': 'uppercase',
                'letter-spacing': '0.05em',
              },
            ),
            [Component.text(group.heading!)],
          ),
        for (final item in group.items)
          _buildItem(item, group.heading, surfaceId, groupId),
      ],
    );
  }

  Component _buildItem(
    CommandItemProps item,
    String? groupName,
    String surfaceId,
    String groupId,
  ) {
    final List<String> actions = <String>[];
    if (item.href != null && item.href!.isNotEmpty) {
      final String target = item.hrefTarget ?? '_self';
      if (target == '_blank') {
        actions.add('nav.external:${item.href}');
      } else {
        actions.add('nav.go:${item.href}');
      }
    }
    actions.add('surface.close:command:$surfaceId');
    final String actionStr = actions.join(' ; ');

    // ShadCN: relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none
    return dom.div(
      classes: 'arcane-command-item ${item.disabled ? 'disabled' : ''}',
      attributes: <String, String>{
        'role': 'option',
        'aria-selected': 'false',
        if (item.disabled) 'aria-disabled': 'true',
        // Data attributes for JavaScript navigation and filtering
        'data-arcane-command-item': 'true',
        'data-arcane-command-group-id': groupId,
        if (item.href != null) 'data-href': item.href!,
        if (item.hrefTarget != null) 'data-target': item.hrefTarget!,
        // Store keywords for JS filtering
        if (item.keywords != null && item.keywords!.isNotEmpty)
          'data-keywords': item.keywords!.join(','),
        'data-label': item.label,
        if (groupName != null) 'data-group': groupName,
        if (item.disabled) 'data-arcane-disabled': 'true',
        if (!item.disabled) 'data-arcane-action': actionStr,
        'tabindex': item.disabled ? '-1' : '0',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'padding': '8px 12px',
          // ShadCN: rounded-sm
          'border-radius': 'var(--radius-xs)',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition': 'background-color var(--transition)',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      [
        if (item.icon != null) item.icon!,
        dom.span(
          styles: const dom.Styles(
            raw: {
              'flex': '1',
              // ShadCN: text-sm
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--foreground)',
            },
          ),
          [Component.text(item.label)],
        ),
        if (item.shortcut != null)
          // ShadCN: ml-auto text-xs tracking-widest text-muted-foreground
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-xs)',
                'color': 'var(--muted-foreground)',
                'padding': '2px 4px',
                'background-color': 'var(--muted)',
                'border-radius': 'var(--radius-xs)',
                'font-family':
                    'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
              },
            ),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  Component _buildKeyHint(String key, String label) {
    return dom.div(
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-1)',
        },
      ),
      [
        dom.span(
          styles: const dom.Styles(
            raw: {
              'padding': '2px 6px',
              'background-color': 'var(--muted)',
              'border-radius': 'var(--radius-xs)',
              'font-family':
                  'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
            },
          ),
          [Component.text(key)],
        ),
        dom.span([Component.text(label)]),
      ],
    );
  }

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'arcane-command-$_autoCounter';
  }
}
