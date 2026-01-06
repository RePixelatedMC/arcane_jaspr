import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

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
    final (String left, String right, String transform) = switch (props.alignment) {
      DropdownAlignment.left => ('0', 'auto', 'none'),
      DropdownAlignment.right => ('auto', '0', 'none'),
      DropdownAlignment.center => ('50%', 'auto', 'translateX(-50%)'),
    };

    return dom.div(
      classes: 'arcane-dropdown ${props.isOpen ? 'open' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
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

        // Menu - ShadCN DropdownMenuContent
        if (props.isOpen)
          dom.div(
            classes: 'arcane-dropdown-menu',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': left,
              'right': right,
              'transform': transform,
              // ShadCN: z-50
              'z-index': '100',
              'margin-top': '4px',
              // ShadCN: min-w-[8rem] (128px)
              if (props.width != null) 'width': '${props.width}px' else 'min-width': '128px',
              // ShadCN: p-1
              'padding': '4px',
              // ShadCN: bg-popover
              'background-color': 'var(--popover)',
              // ShadCN: border
              'border': '1px solid var(--border)',
              // ShadCN: rounded-md (6px)
              'border-radius': '0.375rem',
              // ShadCN: shadow-md
              'box-shadow': '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
              // ShadCN: overflow-hidden
              'overflow': 'hidden',
              // ShadCN: text-popover-foreground
              'color': 'var(--popover-foreground)',
              // Animation
              'animation': 'arcane-dropdown-fade 150ms ease-out',
            }),
            [
              for (final item in props.items)
                if (item.divider)
                  // ShadCN DropdownMenuSeparator: -mx-1 my-1 h-px bg-muted
                  const dom.div(
                    classes: 'arcane-dropdown-divider',
                    styles: dom.Styles(raw: {
                      'height': '1px',
                      'margin': '4px -4px',
                      'background-color': 'var(--muted)',
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

  Component _buildItem(DropdownItemProps item) {
    // ShadCN DropdownMenuItem styles
    final dom.Styles itemStyles = dom.Styles(raw: {
      'position': 'relative',
      'display': 'flex',
      'align-items': 'center',
      'gap': '8px',
      // ShadCN: px-2 py-1.5
      'padding': '6px 8px',
      // ShadCN: text-sm
      'font-size': '0.875rem',
      'color': item.disabled ? 'var(--muted-foreground)' : 'var(--popover-foreground)',
      'text-decoration': 'none',
      // ShadCN: rounded-sm (4px)
      'border-radius': '0.25rem',
      // ShadCN: cursor-default (or pointer)
      'cursor': item.disabled ? 'not-allowed' : 'pointer',
      // ShadCN: transition-colors
      'transition': 'color 150ms ease, background-color 150ms ease',
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
                'font-size': '0.75rem',
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
        classes: 'arcane-dropdown-item',
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
      },
      styles: itemStyles,
      events: {
        if (!item.disabled && item.onTap != null)
          'click': (e) {
            if (props.onClose != null) props.onClose!();
            item.onTap!();
          },
      },
      content,
    );
  }
}