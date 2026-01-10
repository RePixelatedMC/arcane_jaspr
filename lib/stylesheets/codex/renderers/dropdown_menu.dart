import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/dropdown_menu_props.dart';

/// Codex DropdownMenu renderer.
class CodexDropdownMenu extends StatelessComponent {
  final DropdownMenuProps props;

  const CodexDropdownMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (String left, String right, String transform) = switch (props.alignment) {
      DropdownAlignment.left => ('0', 'auto', 'none'),
      DropdownAlignment.right => ('auto', '0', 'none'),
      DropdownAlignment.center => ('50%', 'auto', 'translateX(-50%)'),
    };

    return dom.div(
      classes: 'codex-dropdown ${props.isOpen ? 'open' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
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
            styles: const dom.Styles(raw: {
              'position': 'fixed',
              'inset': '0',
              'z-index': '99',
            }),
            events: {
              'click': (e) {
                if (props.onClose != null) props.onClose!();
              },
            },
            [],
          ),

        // Menu
        if (props.isOpen)
          dom.div(
            classes: 'codex-dropdown-menu',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': left,
              'right': right,
              'transform': transform,
              'z-index': '100',
              'margin-top': '6px',
              if (props.width != null) 'width': '${props.width}px' else 'min-width': '140px',
              'padding': '6px',
              'background-color': 'var(--card)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 0 30px rgba(var(--codex-accent-rgb), 0.1)',
              'overflow': 'hidden',
              'color': 'var(--foreground)',
              'animation': 'arcane-dropdown-fade var(--arcane-transition)-out',
            }),
            [
              for (final item in props.items)
                if (item.isSeparator)
                  const dom.div(
                    classes: 'codex-dropdown-divider',
                    styles: dom.Styles(raw: {
                      'height': '1px',
                      'margin': '6px -6px',
                      'background-color': 'var(--border)',
                    }),
                    [],
                  )
                else
                  _buildItem(item),
            ],
          ),
      ],
    );
  }

  Component _buildItem(ArcaneMenuItem item) {
    final dom.Styles itemStyles = dom.Styles(raw: {
      'position': 'relative',
      'display': 'flex',
      'align-items': 'center',
      'gap': '10px',
      'padding': '8px 12px',
      'font-size': 'var(--arcane-font-size-sm)',
      'color': item.disabled ? 'var(--muted-foreground)' : 'var(--foreground)',
      'text-decoration': 'none',
      'border-radius': 'var(--radius)',
      'cursor': item.disabled ? 'not-allowed' : 'pointer',
      'transition': 'color var(--arcane-transition), background-color var(--arcane-transition)',
      'background-color': 'transparent',
      'border': 'none',
      'width': '100%',
      'text-align': 'left',
      'user-select': 'none',
      'outline': 'none',
      'opacity': item.disabled ? '0.5' : '1',
      'pointer-events': item.disabled ? 'none' : 'auto',
    });

    final List<Component> content = [
      if (item.icon != null)
        dom.span(
          styles: dom.Styles(raw: {
            'flex-shrink': '0',
            'opacity': item.disabled ? '0.5' : '1',
          }),
          [item.icon!],
        ),
      dom.div(
        styles: const dom.Styles(raw: {
          'flex': '1',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '2px',
        }),
        [
          dom.span([Component.text(item.label)]),
          if (item.description != null)
            dom.span(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--arcane-font-size-xs)',
                'color': 'var(--muted-foreground)',
              }),
              [Component.text(item.description!)],
            ),
        ],
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
      attributes: {
        'type': 'button',
        if (item.disabled) 'disabled': 'true',
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
}
