import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/menubar_props.dart';

/// Codex menubar component.
class CodexMenubar extends StatelessComponent {
  final MenubarProps props;

  const CodexMenubar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-menubar',
      attributes: {'role': 'menubar'},
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'height': '48px',
        'align-items': 'center',
        'gap': '6px',
        'border-radius': 'var(--radius)',
        'border': '1px solid var(--border)',
        'background-color': 'var(--card)',
        'padding': '6px',
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
      classes: 'codex-menubar-menu ${isOpen ? 'open' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
      }),
      [
        // Trigger
        dom.button(
          classes: 'codex-menubar-trigger',
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
            'border-radius': 'var(--radius-sm)',
            'padding': '8px 14px',
            'font-size': '0.875rem',
            'font-weight': '500',
            'outline': 'none',
            'border': 'none',
            'background-color':
                isOpen ? 'rgba(var(--codex-accent-rgb), 0.15)' : 'transparent',
            'color': isOpen
                ? 'var(--codex-accent)'
                : 'var(--foreground)',
            'transition': 'background-color 150ms ease, color 150ms ease',
          }),
          events: {
            'click': (_) => props.onMenuChange?.call(isOpen ? null : index),
          },
          [Component.text(menu.label)],
        ),

        // Content
        if (isOpen)
          dom.div(
            classes: 'codex-menubar-content',
            attributes: {'role': 'menu'},
            styles: const dom.Styles(raw: {
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
              'box-shadow': '0 0 30px rgba(var(--codex-accent-rgb), 0.1)',
              'color': 'var(--foreground)',
            }),
            [for (final item in menu.items) _buildMenuItem(item)],
          ),
      ],
    );
  }

  Component _buildMenuItem(ArcaneMenuItem item) {
    if (item.isSeparator) {
      return const dom.div(
        classes: 'codex-menubar-separator',
        styles: dom.Styles(raw: {
          'height': '1px',
          'margin': '6px -6px',
          'background-color': 'var(--border)',
        }),
        [],
      );
    }

    return dom.div(
      classes:
          'codex-menubar-item ${item.disabled ? 'disabled' : ''} ${item.isCheckbox ? 'checkbox' : ''}',
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
        'gap': '10px',
        'border-radius': 'var(--radius-sm)',
        'padding': '8px 10px',
        'padding-left': item.isCheckbox ? '36px' : '10px',
        'font-size': '0.875rem',
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
          const dom.span(
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'left': '10px',
              'color': 'var(--codex-accent)',
              'font-size': '0.75rem',
            }),
            [Component.text('\u{2713}')],
          ),

        if (item.icon != null) item.icon!,

        dom.span(
          styles: const dom.Styles(raw: {'flex': '1'}),
          [Component.text(item.label)],
        ),

        if (item.shortcut != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'margin-left': 'auto',
              'font-size': '0.75rem',
              'letter-spacing': '0.1em',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }
}
