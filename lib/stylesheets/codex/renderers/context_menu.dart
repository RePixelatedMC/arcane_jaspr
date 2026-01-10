import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/context_menu_props.dart';

/// Codex-style context menu component
class CodexContextMenu extends StatelessComponent {
  final ContextMenuProps props;

  const CodexContextMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-context-menu-trigger',
      attributes: {'data-context-menu': 'true'},
      styles: const dom.Styles(raw: {'display': 'contents'}),
      [
        props.trigger,
        // Hidden menu template
        dom.div(
          classes: 'codex-context-menu',
          attributes: {'role': 'menu', 'aria-hidden': 'true'},
          styles: const dom.Styles(raw: {
            'display': 'none',
            'position': 'fixed',
            'z-index': '50',
            'min-width': '140px',
            'overflow': 'hidden',
            'padding': '6px',
            'background-color': 'var(--card)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'box-shadow': '0 0 30px rgba(var(--codex-accent-rgb), 0.1)',
            'color': 'var(--foreground)',
          }),
          [for (final item in props.items) _buildMenuItem(item)],
        ),
      ],
    );
  }

  Component _buildMenuItem(ArcaneMenuItem item) {
    if (item.isSeparator) {
      return const dom.div(
        classes: 'codex-context-menu-separator',
        styles: dom.Styles(raw: {
          'height': '1px',
          'margin': '6px -6px',
          'background-color': 'var(--border)',
        }),
        [],
      );
    }

    if (item.submenu != null && item.submenu!.isNotEmpty) {
      return dom.div(
        classes:
            'codex-context-menu-item codex-context-menu-submenu-trigger ${item.disabled ? 'disabled' : ''}',
        attributes: {
          'role': 'menuitem',
          'aria-haspopup': 'true',
          if (item.disabled) 'aria-disabled': 'true',
        },
        styles: dom.Styles(raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': '10px',
          'padding': '8px 12px',
          'border-radius': 'var(--radius)',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'transition': 'color var(--arcane-transition), background-color var(--arcane-transition)',
          'font-size': 'var(--arcane-font-size-sm)',
          'user-select': 'none',
          'outline': 'none',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        }),
        [
          if (item.icon != null) item.icon!,
          dom.span(
            styles: dom.Styles(raw: {
              'flex': '1',
              'color': item.destructive
                  ? 'var(--destructive)'
                  : 'var(--foreground)',
            }),
            [Component.text(item.label)],
          ),
          const dom.span(
            styles: dom.Styles(raw: {
              'color': 'var(--muted-foreground)',
              'font-size': 'var(--arcane-font-size-xs)',
            }),
            [Component.text('\u{203A}')],
          ),
          dom.div(
            classes: 'codex-context-menu-submenu',
            styles: const dom.Styles(raw: {
              'display': 'none',
              'position': 'absolute',
              'left': '100%',
              'top': '0',
              'min-width': '140px',
              'padding': '6px',
              'background-color': 'var(--card)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 0 30px rgba(var(--codex-accent-rgb), 0.1)',
            }),
            [for (final subitem in item.submenu!) _buildMenuItem(subitem)],
          ),
        ],
      );
    }

    return dom.div(
      classes:
          'codex-context-menu-item ${item.disabled ? 'disabled' : ''} ${item.destructive ? 'destructive' : ''}',
      attributes: {
        'role': 'menuitem',
        if (item.disabled) 'aria-disabled': 'true',
        if (item.shortcut != null) 'data-shortcut': item.shortcut!,
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'align-items': 'center',
        'gap': '10px',
        'padding': '8px 12px',
        'border-radius': 'var(--radius)',
        'cursor': item.disabled ? 'not-allowed' : 'default',
        'transition': 'color var(--arcane-transition), background-color var(--arcane-transition)',
        'font-size': 'var(--arcane-font-size-sm)',
        'user-select': 'none',
        'outline': 'none',
        if (item.disabled) 'pointer-events': 'none',
        if (item.disabled) 'opacity': '0.5',
      }),
      events: item.onSelect != null && !item.disabled
          ? {'click': (_) => item.onSelect!()}
          : null,
      [
        if (item.icon != null) item.icon!,
        dom.span(
          styles: dom.Styles(raw: {
            'flex': '1',
            'color': item.destructive
                ? 'var(--destructive)'
                : 'var(--foreground)',
          }),
          [Component.text(item.label)],
        ),
        if (item.shortcut != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'margin-left': 'auto',
              'font-size': 'var(--arcane-font-size-xs)',
              'letter-spacing': '0.1em',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }
}
