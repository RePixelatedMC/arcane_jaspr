import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/context_menu_props.dart';

/// ShadCN-style context menu component
/// Reference: https://ui.shadcn.com/docs/components/context-menu
class ShadcnContextMenu extends StatelessComponent {
  final ContextMenuProps props;

  const ShadcnContextMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-context-menu-trigger',
      attributes: {'data-context-menu': 'true'},
      styles: const dom.Styles(raw: {'display': 'contents'}),
      [
        props.trigger,
        // Hidden menu template - ShadCN ContextMenuContent
        dom.div(
          classes: 'arcane-context-menu',
          attributes: {'role': 'menu', 'aria-hidden': 'true'},
          styles: const dom.Styles(raw: {
            'display': 'none',
            'position': 'fixed',
            'z-index': '50',
            'min-width': '128px',
            'overflow': 'hidden',
            'padding': '4px',
            'background-color': 'var(--popover)',
            'border': '1px solid var(--border)',
            'border-radius': '6px',
            'box-shadow':
                '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
            'color': 'var(--popover-foreground)',
          }),
          [for (final item in props.items) _buildMenuItem(item)],
        ),
      ],
    );
  }

  Component _buildMenuItem(ContextMenuItemProps item) {
    if (item.isSeparator) {
      // ShadCN ContextMenuSeparator
      return const dom.div(
        classes: 'arcane-context-menu-separator',
        styles: dom.Styles(raw: {
          'height': '1px',
          'margin': '4px -4px',
          'background-color': 'var(--muted)',
        }),
        [],
      );
    }

    if (item.submenu != null && item.submenu!.isNotEmpty) {
      // ShadCN ContextMenuSubTrigger
      return dom.div(
        classes:
            'arcane-context-menu-item arcane-context-menu-submenu-trigger ${item.disabled ? 'disabled' : ''}',
        attributes: {
          'role': 'menuitem',
          'aria-haspopup': 'true',
          if (item.disabled) 'aria-disabled': 'true',
        },
        styles: dom.Styles(raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': '8px',
          'padding': '6px 8px',
          'border-radius': '4px',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'transition': 'color 150ms ease, background-color 150ms ease',
          'font-size': '14px',
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
                  : 'var(--popover-foreground)',
            }),
            [dom.text(item.label)],
          ),
          dom.span(
            styles: const dom.Styles(raw: {
              'color': 'var(--muted-foreground)',
              'font-size': '12px',
            }),
            [dom.text('\u{203A}')], // Right arrow
          ),
          // Submenu - ShadCN ContextMenuSubContent
          dom.div(
            classes: 'arcane-context-menu-submenu',
            styles: const dom.Styles(raw: {
              'display': 'none',
              'position': 'absolute',
              'left': '100%',
              'top': '0',
              'min-width': '128px',
              'padding': '4px',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': '6px',
              'box-shadow':
                  '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
            }),
            [for (final subitem in item.submenu!) _buildMenuItem(subitem)],
          ),
        ],
      );
    }

    // ShadCN ContextMenuItem
    return dom.div(
      classes:
          'arcane-context-menu-item ${item.disabled ? 'disabled' : ''} ${item.destructive ? 'destructive' : ''}',
      attributes: {
        'role': 'menuitem',
        if (item.disabled) 'aria-disabled': 'true',
        if (item.shortcut != null) 'data-shortcut': item.shortcut!,
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'align-items': 'center',
        'gap': '8px',
        'padding': '6px 8px',
        'border-radius': '4px',
        'cursor': item.disabled ? 'not-allowed' : 'default',
        'transition': 'color 150ms ease, background-color 150ms ease',
        'font-size': '14px',
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
                : 'var(--popover-foreground)',
          }),
          [dom.text(item.label)],
        ),
        if (item.shortcut != null)
          // ShadCN ContextMenuShortcut
          dom.span(
            styles: const dom.Styles(raw: {
              'margin-left': 'auto',
              'font-size': '12px',
              'letter-spacing': '0.1em',
              'color': 'var(--muted-foreground)',
            }),
            [dom.text(item.shortcut!)],
          ),
      ],
    );
  }
}