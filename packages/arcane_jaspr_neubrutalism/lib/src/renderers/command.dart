import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/command_props.dart';

/// Neubrutalism Command renderer.
class NeubrutalismCommand extends StatelessComponent {
  final CommandProps props;

  const NeubrutalismCommand(this.props, {super.key});

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
      classes: 'neubrutalism-command-overlay arcane-overlay-scrim',
      attributes: <String, String>{
        ...surfAttrs,
        'data-arcane-command': surfaceId,
      },
      styles: const dom.Styles(
        raw: {
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          'display': 'flex',
          'align-items': 'flex-start',
          'justify-content': 'center',
          'padding-top': '20vh',
          'background': 'rgba(0, 0, 0, 0.55)',
          'animation': 'arcane-fade-in var(--arcane-transition-slow)',
        },
      ),
      [
        dom.div(
          classes: 'neubrutalism-command-dialog neubrutalism-panel',
          attributes: const <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            'aria-label': 'Command palette',
          },
          styles: const dom.Styles(
            raw: {
              'width': '100%',
              'max-width': '640px',
              'color': 'var(--foreground)',
              'overflow': 'hidden',
              'animation': 'arcane-scale-in var(--arcane-transition-slow)',
            },
          ),
          [
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '12px',
                  'padding': '14px 18px',
                  'border-bottom':
                      'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                },
              ),
              [
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'color': 'var(--nb-accent, var(--primary))',
                      'display': 'flex',
                      'align-items': 'center',
                    },
                  ),
                  [ArcaneIcon.search(size: IconSize.md)],
                ),
                dom.RawText(
                  '<input class="neubrutalism-command-input" type="text" '
                  'placeholder="${props.placeholder}" '
                  'autofocus autocomplete="off" spellcheck="false" '
                  'data-arcane-command-input="$surfaceId" '
                  'data-arcane-input="command.filter:$surfaceId" '
                  'value="${props.searchQuery}" '
                  'style="flex:1;background:transparent;border:none;'
                  'font-size:0.9375rem;color:var(--foreground);outline:none;letter-spacing:0.01em;">',
                ),
              ],
            ),

            // Results
            dom.div(
              classes: 'neubrutalism-command-list',
              attributes: const <String, String>{'role': 'listbox'},
              styles: const dom.Styles(
                raw: {
                  'max-height': '400px',
                  'overflow-y': 'auto',
                  'padding': '10px',
                },
              ),
              [
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

            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '20px',
                  'padding': '10px 16px',
                  'border-top':
                      'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                },
              ),
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
          dom.div(
            classes: 'neubrutalism-command-group-heading',
            styles: const dom.Styles(
              raw: {
                'padding': '10px 14px 4px',
                'font-family': 'var(--font-heading)',
                'font-size': '0.6875rem',
                'font-weight': '600',
                'color': 'var(--muted-foreground)',
                'text-transform': 'uppercase',
                'letter-spacing': '0.12em',
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

    return dom.div(
      classes: 'neubrutalism-command-item ${item.disabled ? 'disabled' : ''}',
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
          'gap': '10px',
          'padding': '10px 14px',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition': 'background-color var(--nb-transition, 120ms ease)',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      // Note: No Dart event handlers - JavaScript handles clicks via data-href
      [
        if (item.icon != null) item.icon!,
        dom.span(
          styles: const dom.Styles(
            raw: {
              'flex': '1',
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--foreground)',
            },
          ),
          [Component.text(item.label)],
        ),
        if (item.shortcut != null)
          dom.span(
            classes: 'neubrutalism-kbd',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-xs)',
                'padding': '3px 8px',
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
        raw: {'display': 'flex', 'align-items': 'center', 'gap': '6px'},
      ),
      [
        dom.span(
          classes: 'neubrutalism-kbd',
          styles: const dom.Styles(
            raw: {'padding': '3px 8px'},
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
    return 'neubrutalism-command-$_autoCounter';
  }
}
