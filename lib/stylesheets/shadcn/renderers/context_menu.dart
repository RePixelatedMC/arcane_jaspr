import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
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
          styles: const dom.Styles(
            raw: {
              'display': 'none',
              'position': 'fixed',
              'z-index': '50',
              'min-width': '128px',
              'overflow': 'hidden',
              'padding': '4px',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius-sm)',
              'box-shadow':
                  '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
              'color': 'var(--popover-foreground)',
            },
          ),
          [for (final item in props.items) _buildMenuItem(item)],
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
    // ShadCN ContextMenuSeparator
    return const dom.div(
      classes: 'arcane-context-menu-separator',
      styles: dom.Styles(
        raw: {
          'height': '1px',
          'margin': '4px -4px',
          'background-color': 'var(--muted)',
        },
      ),
      [],
    );
  }

  Component _buildLabel(String label) {
    return dom.div(
      classes: 'arcane-context-menu-label',
      styles: const dom.Styles(
        raw: {
          'padding': '6px 8px',
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
    // ShadCN ContextMenuItem
    return dom.div(
      classes:
          'arcane-context-menu-item ${item.disabled ? 'disabled' : ''} ${item.destructive ? 'destructive' : ''}',
      attributes: {
        'role': 'menuitem',
        if (item.disabled) 'aria-disabled': 'true',
        if (item.shortcut != null) 'data-shortcut': item.shortcut!,
        'data-disabled': '${item.disabled}',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'padding': '6px 8px',
          'border-radius': 'var(--radius-xs)',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'transition':
              'color var(--transition), background-color var(--transition)',
          'font-size': 'var(--font-size-sm)',
          'user-select': 'none',
          'outline': 'none',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onSelect != null && !item.disabled
          ? {'click': (_) => item.onSelect!()}
          : null,
      [
        if (item.icon != null) item.icon!,
        dom.span(
          styles: dom.Styles(
            raw: {
              'flex': '1',
              'color': item.destructive
                  ? 'var(--destructive)'
                  : 'var(--popover-foreground)',
            },
          ),
          [Component.text(item.label)],
        ),
        if (item.shortcut != null)
          // ShadCN ContextMenuShortcut
          dom.span(
            styles: const dom.Styles(
              raw: {
                'margin-left': 'auto',
                'font-size': 'var(--font-size-xs)',
                'letter-spacing': '0.1em',
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
      classes: 'arcane-context-menu-item checkbox',
      attributes: {
        'role': 'menuitemcheckbox',
        'aria-checked': '${item.checked}',
        if (item.disabled) 'aria-disabled': 'true',
        'data-state': item.checked ? 'checked' : 'unchecked',
        'data-disabled': '${item.disabled}',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'padding': '6px 8px',
          'padding-left': '32px',
          'font-size': 'var(--font-size-sm)',
          'border-radius': 'var(--radius-xs)',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition':
              'background-color var(--transition), color var(--transition)',
          'user-select': 'none',
          'outline': 'none',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onChanged != null && !item.disabled
          ? {'click': (_) => item.onChanged!(!item.checked)}
          : null,
      [
        // Checkbox indicator
        if (item.checked)
          dom.span(
            styles: dom.Styles(
              raw: {
                'position': 'absolute',
                'left': '8px',
                'color': 'var(--foreground)',
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
                'letter-spacing': '0.1em',
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
      classes: 'arcane-context-menu-item radio',
      attributes: {
        'role': 'menuitemradio',
        'aria-checked': '${item.selected}',
        if (item.disabled) 'aria-disabled': 'true',
        'data-state': item.selected ? 'checked' : 'unchecked',
        'data-disabled': '${item.disabled}',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'padding': '6px 8px',
          'padding-left': '32px',
          'font-size': 'var(--font-size-sm)',
          'border-radius': 'var(--radius-xs)',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition':
              'background-color var(--transition), color var(--transition)',
          'user-select': 'none',
          'outline': 'none',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onChanged != null && !item.disabled
          ? {'click': (_) => item.onChanged!(item.value)}
          : null,
      [
        // Radio indicator
        if (item.selected)
          dom.span(
            styles: dom.Styles(
              raw: {
                'position': 'absolute',
                'left': '8px',
                'color': 'var(--foreground)',
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
    // ShadCN ContextMenuSubTrigger
    return dom.div(
      classes:
          'arcane-context-menu-item arcane-context-menu-submenu-trigger ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'menuitem',
        'aria-haspopup': 'true',
        if (item.disabled) 'aria-disabled': 'true',
        'data-disabled': '${item.disabled}',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'padding': '6px 8px',
          'border-radius': 'var(--radius-xs)',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'transition':
              'color var(--transition), background-color var(--transition)',
          'font-size': 'var(--font-size-sm)',
          'user-select': 'none',
          'outline': 'none',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      [
        if (item.icon != null) item.icon!,
        dom.span(
          styles: const dom.Styles(
            raw: {'flex': '1', 'color': 'var(--popover-foreground)'},
          ),
          [Component.text(item.label)],
        ),
        dom.span(
          styles: dom.Styles(raw: {'color': 'var(--muted-foreground)'}),
          [ArcaneIcon.chevronRight(size: IconSize.sm)],
        ),
        // Submenu - ShadCN ContextMenuSubContent
        dom.div(
          classes: 'arcane-context-menu-submenu',
          styles: const dom.Styles(
            raw: {
              'display': 'none',
              'position': 'absolute',
              'left': '100%',
              'top': '0',
              'min-width': '128px',
              'padding': '4px',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius-sm)',
              'box-shadow':
                  '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
            },
          ),
          [for (final child in item.children) _buildMenuItem(child)],
        ),
      ],
    );
  }
}
