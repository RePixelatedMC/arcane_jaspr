import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/dropdown_menu_props.dart';

/// Codex DropdownMenu renderer.
class CodexDropdownMenu extends StatelessComponent {
  final DropdownMenuProps props;

  const CodexDropdownMenu(this.props, {super.key});

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
      classes: 'codex-dropdown ${props.isOpen ? 'open' : ''}',
      styles: const dom.Styles(
        raw: {'position': 'relative', 'display': 'inline-block'},
      ),
      [
        // Trigger
        dom.div(
          classes: 'codex-dropdown-trigger',
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
            classes: 'codex-dropdown-backdrop',
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

        if (props.isOpen)
          dom.div(
            classes: 'codex-dropdown-menu',
            styles: dom.Styles(
              raw: {
                'position': 'absolute',
                'top': '100%',
                'left': left,
                'right': right,
                'transform': transform,
                'z-index': '100',
                'margin-top': '6px',
                if (props.width != null)
                  'width': '${props.width}px'
                else
                  'min-width': '140px',
                'padding': '6px',
                'background':
                    'linear-gradient(180deg, color-mix(in srgb, var(--primary) 5%, var(--card)), var(--card))',
                'border': '1px solid var(--codex-accent-border)',
                'border-radius': 'var(--radius)',
                'box-shadow':
                    '0 14px 36px rgba(0, 0, 0, 0.45), 0 14px 0 1px color-mix(in srgb, var(--primary) 10%, transparent)',
                'overflow': 'hidden',
                'color': 'var(--foreground)',
                'animation': 'arcane-dropdown-fade 0.16s ease-out',
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
    return const dom.div(
      classes: 'codex-dropdown-divider',
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
      classes: 'codex-dropdown-label',
      styles: const dom.Styles(
        raw: {
          'padding': '8px 12px',
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
    final dom.Styles itemStyles = dom.Styles(
      raw: {
        'position': 'relative',
        'display': 'flex',
        'align-items': 'center',
        'gap': '10px',
        'padding': '8px 12px',
        'font-size': 'var(--font-size-sm)',
        'color': item.disabled
            ? 'var(--muted-foreground)'
            : item.destructive
            ? 'var(--destructive)'
            : 'var(--foreground)',
        'text-decoration': 'none',
        'border-radius': 'var(--radius)',
        'cursor': item.disabled ? 'not-allowed' : 'pointer',
        'transition':
            'color var(--arcane-transition), background-color var(--arcane-transition)',
        'background-color': 'transparent',
        'border': 'none',
        'width': '100%',
        'text-align': 'left',
        'user-select': 'none',
        'outline': 'none',
        'opacity': item.disabled ? '0.5' : '1',
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
        classes: 'codex-dropdown-item',
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
      classes: 'codex-dropdown-item',
      attributes: {'type': 'button', if (item.disabled) 'disabled': 'true'},
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
      classes: 'codex-dropdown-item checkbox',
      attributes: {
        'role': 'menuitemcheckbox',
        'aria-checked': '${item.checked}',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': '10px',
          'padding': '8px 12px',
          'padding-left': '36px',
          'font-size': 'var(--font-size-sm)',
          'border-radius': 'var(--radius)',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition':
              'background-color var(--arcane-transition), color var(--arcane-transition)',
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
                'left': '12px',
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
      classes: 'codex-dropdown-item radio',
      attributes: {
        'role': 'menuitemradio',
        'aria-checked': '${item.selected}',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': '10px',
          'padding': '8px 12px',
          'padding-left': '36px',
          'font-size': 'var(--font-size-sm)',
          'border-radius': 'var(--radius)',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition':
              'background-color var(--arcane-transition), color var(--arcane-transition)',
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
                'left': '12px',
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
          'codex-dropdown-item submenu-trigger ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'menuitem',
        'aria-haspopup': 'true',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': '10px',
          'padding': '8px 12px',
          'font-size': 'var(--font-size-sm)',
          'border-radius': 'var(--radius)',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'transition':
              'background-color var(--arcane-transition), color var(--arcane-transition)',
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
          classes: 'codex-dropdown-submenu',
          styles: const dom.Styles(
            raw: {
              'display': 'none',
              'position': 'absolute',
              'left': '100%',
              'top': '0',
              'min-width': '140px',
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
