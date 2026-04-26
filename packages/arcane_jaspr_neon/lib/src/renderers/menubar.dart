import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/menubar_props.dart';

/// Neon menubar component.
class NeonMenubar extends StatelessComponent {
  final MenubarProps props;

  const NeonMenubar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neon-menubar',
      attributes: {'role': 'menubar'},
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'height': '48px',
          'align-items': 'center',
          'gap': '6px',
          'border-radius': 'var(--radius)',
          'border': '1px solid var(--border)',
          'background-color': 'var(--card)',
          'padding': '6px',
        },
      ),
      [
        for (var i = 0; i < props.menus.length; i++)
          _buildMenu(props.menus[i], i),
      ],
    );
  }

  Component _buildMenu(MenubarMenuProps menu, int index) {
    final isOpen = props.openMenuIndex == index;

    return dom.div(
      classes: 'neon-menubar-menu ${isOpen ? 'open' : ''}',
      styles: const dom.Styles(raw: {'position': 'relative'}),
      [
        // Trigger
        dom.button(
          classes: 'neon-menubar-trigger',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'true',
            'aria-expanded': '$isOpen',
          },
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'cursor': 'default',
              'user-select': 'none',
              'align-items': 'center',
              'border-radius': 'var(--radius-sm)',
              'padding': '8px 14px',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'outline': 'none',
              'border': 'none',
              'background-color': isOpen
                  ? 'rgba(var(--primary-rgb), 0.15)'
                  : 'transparent',
              'color': isOpen ? 'var(--primary)' : 'var(--foreground)',
              'transition':
                  'background-color var(--arcane-transition), color var(--arcane-transition)',
            },
          ),
          events: {
            'click': (_) => props.onMenuChange?.call(isOpen ? null : index),
          },
          [Component.text(menu.label)],
        ),

        // Content
        if (isOpen)
          dom.div(
            classes: 'neon-menubar-content',
            attributes: {'role': 'menu'},
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'top': '100%',
                'left': '0',
                'z-index': '50',
                'min-width': '200px',
                'overflow': 'hidden',
                'padding': '6px',
                'margin-top': '6px',
                'background-color': 'var(--card)',
                'border': '1px solid var(--border)',
                'border-radius': 'var(--radius)',
                'box-shadow': '0 14px 30px rgba(var(--primary-rgb), 0.1)',
                'color': 'var(--foreground)',
              },
            ),
            [for (final item in menu.items) _buildMenuItem(item)],
          ),
      ],
    );
  }

  Component _buildMenuItem(ArcaneMenuItem item) {
    return switch (item) {
      MenuItemSeparator() => _buildSeparator(),
      MenuItemLabel(:final label) => _buildLabel(label),
      MenuItemAction() => _buildAction(item),
      MenuItemCheckbox() => _buildCheckbox(item),
      MenuItemRadio() => _buildRadio(item),
      MenuItemSubmenu() => _buildSubmenu(item),
    };
  }

  Component _buildSeparator() {
    return const dom.div(
      classes: 'neon-menubar-separator',
      styles: dom.Styles(
        raw: {
          'height': '1px',
          'margin': '6px -6px',
          'background-color': 'var(--border)',
        },
      ),
      [],
    );
  }

  Component _buildLabel(String label) {
    return dom.div(
      classes: 'neon-menubar-label',
      styles: const dom.Styles(
        raw: {
          'padding': '8px 10px',
          'font-size': 'var(--font-size-xs)',
          'font-weight': 'var(--font-weight-semibold)',
          'color': 'var(--muted-foreground)',
          'user-select': 'none',
        },
      ),
      [Component.text(label)],
    );
  }

  Component _buildAction(MenuItemAction item) {
    return dom.div(
      classes: 'neon-menubar-item ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'menuitem',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'user-select': 'none',
          'align-items': 'center',
          'gap': '10px',
          'border-radius': 'var(--radius-sm)',
          'padding': '8px 10px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--arcane-transition), color var(--arcane-transition)',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onSelect != null && !item.disabled
          ? {'click': (_) => item.onSelect!()}
          : null,
      [
        if (item.icon != null) item.icon!,
        dom.span(styles: const dom.Styles(raw: {'flex': '1'}), [
          Component.text(item.label),
        ]),
        if (item.shortcut != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'margin-left': 'auto',
                'font-size': 'var(--font-size-xs)',
                'letter-spacing': '0',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  Component _buildCheckbox(MenuItemCheckbox item) {
    return dom.div(
      classes: 'neon-menubar-item checkbox',
      attributes: {
        'role': 'menuitemcheckbox',
        'aria-checked': '${item.checked}',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'user-select': 'none',
          'align-items': 'center',
          'gap': '10px',
          'border-radius': 'var(--radius-sm)',
          'padding': '8px 10px',
          'padding-left': '36px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--arcane-transition), color var(--arcane-transition)',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onChanged != null && !item.disabled
          ? {'click': (_) => item.onChanged!(!item.checked)}
          : null,
      [
        if (item.checked)
          dom.span(
            styles: dom.Styles(
              raw: {
                'position': 'absolute',
                'left': '10px',
                'color': 'var(--primary)',
              },
            ),
            [ArcaneIcon.check(size: IconSize.xs)],
          ),
        if (item.icon != null) item.icon!,
        dom.span(styles: const dom.Styles(raw: {'flex': '1'}), [
          Component.text(item.label),
        ]),
        if (item.shortcut != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'margin-left': 'auto',
                'font-size': 'var(--font-size-xs)',
                'letter-spacing': '0',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  Component _buildRadio(MenuItemRadio item) {
    return dom.div(
      classes: 'neon-menubar-item radio',
      attributes: {
        'role': 'menuitemradio',
        'aria-checked': '${item.selected}',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'user-select': 'none',
          'align-items': 'center',
          'gap': '10px',
          'border-radius': 'var(--radius-sm)',
          'padding': '8px 10px',
          'padding-left': '36px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--arcane-transition), color var(--arcane-transition)',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onChanged != null && !item.disabled
          ? {'click': (_) => item.onChanged!(item.value)}
          : null,
      [
        if (item.selected)
          dom.span(
            styles: dom.Styles(
              raw: {
                'position': 'absolute',
                'left': '10px',
                'color': 'var(--primary)',
              },
            ),
            [ArcaneIcon.dot(size: IconSize.sm)],
          ),
        if (item.icon != null) item.icon!,
        dom.span(styles: const dom.Styles(raw: {'flex': '1'}), [
          Component.text(item.label),
        ]),
      ],
    );
  }

  Component _buildSubmenu(MenuItemSubmenu item) {
    return dom.div(
      classes:
          'neon-menubar-item submenu-trigger ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'menuitem',
        'aria-haspopup': 'true',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'user-select': 'none',
          'align-items': 'center',
          'gap': '10px',
          'border-radius': 'var(--radius-sm)',
          'padding': '8px 10px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--arcane-transition), color var(--arcane-transition)',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      [
        if (item.icon != null) item.icon!,
        dom.span(styles: const dom.Styles(raw: {'flex': '1'}), [
          Component.text(item.label),
        ]),
        dom.span(
          styles: dom.Styles(raw: {'color': 'var(--muted-foreground)'}),
          [ArcaneIcon.chevronRight(size: IconSize.sm)],
        ),
        // Submenu
        dom.div(
          classes: 'neon-menubar-submenu',
          styles: const dom.Styles(
            raw: {
              'display': 'none',
              'position': 'absolute',
              'left': '100%',
              'top': '0',
              'min-width': '200px',
              'padding': '6px',
              'background-color': 'var(--card)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 14px 30px rgba(var(--primary-rgb), 0.1)',
            },
          ),
          [for (final child in item.children) _buildMenuItem(child)],
        ),
      ],
    );
  }
}
