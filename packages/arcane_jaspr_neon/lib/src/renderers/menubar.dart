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
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'height': '44px',
          'align-items': 'center',
          'gap': '4px',
          'border': '1px solid var(--neon-panel-border)',
          'background': 'var(--neon-panel-tint)',
          'padding': '4px',
          'clip-path': 'var(--neon-clip-sm)',
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
              'padding': '6px 12px',
              'font-size': 'var(--font-size-sm)',
              'font-weight': '500',
              'letter-spacing': '0.04em',
              'outline': 'none',
              'border': 'none',
              'background': isOpen
                  ? 'var(--neon-accent-soft)'
                  : 'transparent',
              'color': isOpen ? 'var(--neon-accent)' : 'var(--foreground)',
              'clip-path': 'var(--neon-clip-xs)',
              'transition':
                  'background-color 140ms ease, color 140ms ease',
            },
          ),
          events: {
            'click': (_) => props.onMenuChange?.call(isOpen ? null : index),
          },
          [Component.text(menu.label)],
        ),

        if (isOpen)
          dom.div(
            classes: 'neon-menubar-content neon-popover',
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
                'margin-top': '8px',
                'color': 'var(--popover-foreground)',
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
          'background': 'var(--neon-panel-border)',
          'opacity': '0.6',
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
          'padding': '8px 10px 4px',
          'font-family': 'var(--font-heading)',
          'font-size': '0.6875rem',
          'font-weight': '600',
          'letter-spacing': '0.12em',
          'text-transform': 'uppercase',
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
                'color': 'var(--neon-accent)',
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
                'color': 'var(--neon-accent)',
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
        dom.div(
          classes: 'neon-menubar-submenu neon-popover',
          styles: const dom.Styles(
            raw: {
              'display': 'none',
              'position': 'absolute',
              'left': '100%',
              'top': '0',
              'min-width': '200px',
              'padding': '6px',
            },
          ),
          [for (final child in item.children) _buildMenuItem(child)],
        ),
      ],
    );
  }
}
