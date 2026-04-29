import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/menubar_props.dart';

/// Neubrutalism menubar component.
class NeubrutalismMenubar extends StatelessComponent {
  final MenubarProps props;

  const NeubrutalismMenubar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-menubar',
      attributes: {'role': 'menubar'},
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'height': '44px',
          'align-items': 'center',
          'gap': '4px',
          'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'background': 'transparent',
          'padding': '4px',
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
      classes: 'neubrutalism-menubar-menu ${isOpen ? 'open' : ''}',
      styles: const dom.Styles(raw: {'position': 'relative'}),
      [
        dom.button(
          classes: 'neubrutalism-menubar-trigger',
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
              'padding': '6px 14px',
              'font-family': 'var(--font-heading)',
              'font-size': 'var(--font-size-sm)',
              'font-weight': '700',
              'letter-spacing': '0.06em',
              'text-transform': 'uppercase',
              'outline': 'none',
              'border': 'none',
              'background': isOpen
                  ? 'var(--nb-accent, var(--primary))'
                  : 'transparent',
              'color': isOpen ? 'var(--nb-ink, #000)' : 'var(--nb-ink, var(--foreground))',
              'transition': 'background-color 120ms ease',
            },
          ),
          events: {
            'click': (_) => props.onMenuChange?.call(isOpen ? null : index),
          },
          [Component.text(menu.label)],
        ),

        if (isOpen)
          dom.div(
            classes: 'neubrutalism-menubar-content neubrutalism-popover',
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
                'background': 'var(--nb-paper, var(--card))',
                'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
                'border-radius': '0',
                'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
                'color': 'var(--nb-ink, var(--popover-foreground))',
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
      classes: 'neubrutalism-menubar-separator',
      styles: dom.Styles(
        raw: {
          'height': '2px',
          'margin': '6px -6px',
          'background': 'var(--nb-line, #000)',
        },
      ),
      [],
    );
  }

  Component _buildLabel(String label) {
    return dom.div(
      classes: 'neubrutalism-menubar-label',
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
      classes: 'neubrutalism-menubar-item ${item.disabled ? 'disabled' : ''}',
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
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'padding': '8px 10px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
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
      classes: 'neubrutalism-menubar-item checkbox',
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
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'padding': '8px 10px',
          'padding-left': '36px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
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
                'color': 'var(--nb-accent, var(--primary))',
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
      classes: 'neubrutalism-menubar-item radio',
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
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'padding': '8px 10px',
          'padding-left': '36px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
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
                'color': 'var(--nb-accent, var(--primary))',
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
          'neubrutalism-menubar-item submenu-trigger ${item.disabled ? 'disabled' : ''}',
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
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'padding': '8px 10px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
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
          classes: 'neubrutalism-menubar-submenu neubrutalism-popover',
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
