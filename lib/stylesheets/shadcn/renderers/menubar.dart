import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/menubar_props.dart';

/// ShadCN-style menubar component
/// Reference: https://ui.shadcn.com/docs/components/menubar
class ShadcnMenubar extends StatelessComponent {
  final MenubarProps props;

  const ShadcnMenubar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // ShadCN Menubar: flex h-10 items-center space-x-1 rounded-md border bg-background p-1
    return dom.div(
      classes: 'arcane-menubar',
      attributes: {'role': 'menubar'},
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'height': '40px',
        'align-items': 'center',
        'gap': '4px',
        'border-radius': '6px',
        'border': '1px solid var(--border)',
        'background-color': 'var(--background)',
        'padding': '4px',
      }),
      [
        for (var i = 0; i < props.menus.length; i++)
          _buildMenu(props.menus[i], i),
      ],
    );
  }

  Component _buildMenu(MenubarMenuProps menu, int index) {
    final isOpen = props.openMenuIndex == index;

    return dom.div(
      classes: 'arcane-menubar-menu ${isOpen ? 'open' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
      }),
      [
        // ShadCN MenubarTrigger: flex cursor-default select-none items-center rounded-sm px-3 py-1.5 text-sm font-medium outline-none focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground
        dom.button(
          classes: 'arcane-menubar-trigger',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'true',
            'aria-expanded': '$isOpen',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'cursor': 'default',
            'user-select': 'none',
            'align-items': 'center',
            'border-radius': '4px',
            'padding': '6px 12px',
            'font-size': '14px',
            'font-weight': '500',
            'outline': 'none',
            'border': 'none',
            'background-color':
                isOpen ? 'var(--accent)' : 'transparent',
            'color': isOpen
                ? 'var(--accent-foreground)'
                : 'var(--foreground)',
            'transition': 'background-color 150ms ease, color 150ms ease',
          }),
          events: {
            'click': (_) => props.onMenuChange?.call(isOpen ? null : index),
          },
          [dom.text(menu.label)],
        ),

        // ShadCN MenubarContent
        if (isOpen)
          dom.div(
            classes: 'arcane-menubar-content',
            attributes: {'role': 'menu'},
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'z-index': '50',
              'min-width': '192px',
              'overflow': 'hidden',
              'padding': '4px',
              'margin-top': '4px',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': '6px',
              'box-shadow':
                  '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
              'color': 'var(--popover-foreground)',
            }),
            [for (final item in menu.items) _buildMenuItem(item)],
          ),
      ],
    );
  }

  Component _buildMenuItem(MenubarItemProps item) {
    if (item.isSeparator) {
      // ShadCN MenubarSeparator
      return const dom.div(
        classes: 'arcane-menubar-separator',
        styles: dom.Styles(raw: {
          'height': '1px',
          'margin': '4px -4px',
          'background-color': 'var(--muted)',
        }),
        [],
      );
    }

    // ShadCN MenubarItem
    return dom.div(
      classes:
          'arcane-menubar-item ${item.disabled ? 'disabled' : ''} ${item.isCheckbox ? 'checkbox' : ''}',
      attributes: {
        'role': item.isCheckbox ? 'menuitemcheckbox' : 'menuitem',
        if (item.disabled) 'aria-disabled': 'true',
        if (item.isCheckbox) 'aria-checked': '${item.checked}',
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'cursor': item.disabled ? 'not-allowed' : 'default',
        'user-select': 'none',
        'align-items': 'center',
        'gap': '8px',
        'border-radius': '4px',
        'padding': '6px 8px',
        'padding-left': item.isCheckbox ? '32px' : '8px',
        'font-size': '14px',
        'outline': 'none',
        'transition': 'background-color 150ms ease, color 150ms ease',
        if (item.disabled) 'pointer-events': 'none',
        if (item.disabled) 'opacity': '0.5',
      }),
      events: item.onSelect != null && !item.disabled
          ? {'click': (_) => item.onSelect!()}
          : null,
      [
        // Checkbox indicator
        if (item.isCheckbox && item.checked)
          dom.span(
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'left': '8px',
              'color': 'var(--foreground)',
              'font-size': '12px',
            }),
            [dom.text('\u{2713}')], // Checkmark
          ),

        if (item.icon != null) item.icon!,

        dom.span(
          styles: const dom.Styles(raw: {'flex': '1'}),
          [dom.text(item.label)],
        ),

        if (item.shortcut != null)
          // ShadCN MenubarShortcut
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