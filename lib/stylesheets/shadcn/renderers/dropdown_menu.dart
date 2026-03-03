import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/dropdown_menu_props.dart';

/// ShadCN DropdownMenu renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/dropdown-menu
///
/// ShadCN DropdownMenuContent:
/// - z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md
///
/// ShadCN DropdownMenuItem:
/// - relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm
/// - outline-none transition-colors
/// - focus:bg-accent focus:text-accent-foreground
/// - data-[disabled]:pointer-events-none data-[disabled]:opacity-50
class ShadcnDropdownMenu extends StatelessComponent {
  final DropdownMenuProps props;

  const ShadcnDropdownMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (
      String left,
      String right,
      String transform,
    ) = switch (props.alignment) {
      DropdownAlignment.left => ('0', 'auto', 'none'),
      DropdownAlignment.right => ('auto', '0', 'none'),
      DropdownAlignment.center => ('50%', 'auto', 'translateX(-50%)'),
    };

    return dom.div(
      classes: 'arcane-dropdown ${props.isOpen ? 'open' : ''}',
      attributes: {'data-state': props.isOpen ? 'open' : 'closed'},
      styles: const dom.Styles(
        raw: {'position': 'relative', 'display': 'inline-block'},
      ),
      [
        // Trigger
        dom.div(
          classes: 'arcane-dropdown-trigger',
          events: {
            'click': (e) {
              if (props.onToggle != null) props.onToggle!();
            },
          },
          [props.trigger],
        ),

        // Backdrop to close on click outside
        if (props.isOpen)
          dom.div(
            classes: 'arcane-dropdown-backdrop',
            styles: const dom.Styles(
              raw: {'position': 'fixed', 'inset': '0', 'z-index': '99'},
            ),
            events: {
              'click': (e) {
                if (props.onClose != null) props.onClose!();
              },
            },
            [],
          ),

        // Menu - ShadCN DropdownMenuContent
        if (props.isOpen)
          dom.div(
            classes: 'arcane-dropdown-menu',
            attributes: {'data-state': 'open'},
            styles: dom.Styles(
              raw: {
                'position': 'absolute',
                'top': '100%',
                'left': left,
                'right': right,
                'transform': transform,
                // ShadCN: z-50
                'z-index': '100',
                'margin-top': '4px',
                // ShadCN: min-w-[8rem] (128px)
                if (props.width != null)
                  'width': '${props.width}px'
                else
                  'min-width': '128px',
                // ShadCN: p-1
                'padding': '4px',
                // ShadCN: bg-popover
                'background-color': 'var(--popover)',
                // ShadCN: border
                'border': '1px solid var(--border)',
                // ShadCN: rounded-md (6px)
                'border-radius': 'var(--radius-sm)',
                // ShadCN: shadow-md
                'box-shadow': 'var(--shadow-md)',
                // ShadCN: overflow-hidden
                'overflow': 'hidden',
                // ShadCN: text-popover-foreground
                'color': 'var(--popover-foreground)',
                // Animation
                'animation': 'arcane-dropdown-fade var(--transition)',
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
    // ShadCN DropdownMenuSeparator: -mx-1 my-1 h-px bg-muted
    return const dom.div(
      classes: 'arcane-dropdown-divider',
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
      classes: 'arcane-dropdown-label',
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
    // ShadCN DropdownMenuItem styles
    final dom.Styles itemStyles = dom.Styles(
      raw: {
        'position': 'relative',
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        // ShadCN: px-2 py-1.5
        'padding': '6px 8px',
        // ShadCN: text-sm
        'font-size': 'var(--font-size-sm)',
        'color': item.disabled
            ? 'var(--muted-foreground)'
            : item.destructive
            ? 'var(--destructive)'
            : 'var(--popover-foreground)',
        'text-decoration': 'none',
        // ShadCN: rounded-sm (4px)
        'border-radius': 'var(--radius-xs)',
        // ShadCN: cursor-default (or pointer)
        'cursor': item.disabled ? 'not-allowed' : 'pointer',
        // ShadCN: transition-colors
        'transition':
            'color var(--transition), background-color var(--transition)',
        'background-color': 'transparent',
        'border': 'none',
        'width': '100%',
        'text-align': 'left',
        // ShadCN: select-none
        'user-select': 'none',
        // ShadCN: outline-none
        'outline': 'none',
        // ShadCN: data-[disabled]:opacity-50
        'opacity': item.disabled ? '0.5' : '1',
        // ShadCN: data-[disabled]:pointer-events-none
        'pointer-events': item.disabled ? 'none' : 'auto',
      },
    );

    final List<Component> content = [
      if (item.icon != null)
        dom.span(
          styles: dom.Styles(
            raw: {'flex-shrink': '0', 'opacity': item.disabled ? '0.5' : '1'},
          ),
          [item.icon!],
        ),
      dom.div(
        styles: const dom.Styles(
          raw: {
            'flex': '1',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          },
        ),
        [
          dom.span([Component.text(item.label)]),
          if (item.description != null)
            dom.span(
              styles: const dom.Styles(
                raw: {
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                },
              ),
              [Component.text(item.description!)],
            ),
        ],
      ),
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
    ];

    if (item.href != null && !item.disabled) {
      return dom.a(
        href: item.href!,
        classes: 'arcane-dropdown-item',
        attributes: {
          'data-state': 'unchecked',
          'data-disabled': '${item.disabled}',
        },
        styles: itemStyles,
        events: {
          'click': (e) {
            if (props.onClose != null) props.onClose!();
          },
        },
        content,
      );
    }

    return dom.button(
      classes: 'arcane-dropdown-item',
      attributes: {
        'type': 'button',
        if (item.disabled) 'disabled': 'true',
        'data-state': 'unchecked',
        'data-disabled': '${item.disabled}',
      },
      styles: itemStyles,
      events: {
        if (!item.disabled && item.onSelect != null)
          'click': (e) {
            if (props.onClose != null) props.onClose!();
            item.onSelect!();
          },
      },
      content,
    );
  }

  Component _buildCheckbox(MenuItemCheckbox item) {
    return dom.div(
      classes: 'arcane-dropdown-item checkbox',
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
      classes: 'arcane-dropdown-item radio',
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
    return dom.div(
      classes:
          'arcane-dropdown-item submenu-trigger ${item.disabled ? 'disabled' : ''}',
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
          'font-size': 'var(--font-size-sm)',
          'border-radius': 'var(--radius-xs)',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'transition':
              'background-color var(--transition), color var(--transition)',
          'user-select': 'none',
          'outline': 'none',
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
          classes: 'arcane-dropdown-submenu',
          attributes: {'data-state': 'closed'},
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
              'box-shadow': 'var(--shadow-md)',
            },
          ),
          [for (final child in item.children) _buildMenuItem(child)],
        ),
      ],
    );
  }
}
