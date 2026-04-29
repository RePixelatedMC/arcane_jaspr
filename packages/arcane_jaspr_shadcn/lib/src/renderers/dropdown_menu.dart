import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/dropdown_menu_props.dart';

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
    final String surfaceId = props.id;
    final String anchorId = '$surfaceId-trigger';
    final String alignName = switch (props.alignment) {
      DropdownAlignment.left => 'start',
      DropdownAlignment.right => 'end',
      DropdownAlignment.center => 'center',
    };

    final Map<String, String> menuAttrs = mergeAttrs(<Map<String, String>>[
      surfaceAttrs(
        surface: 'menu',
        id: surfaceId,
        initiallyOpen: props.initiallyOpen,
        focusTrap: false,
        scrimCloses: true,
        anchorId: anchorId,
        anchorPlacement: 'bottom',
        anchorAlign: alignName,
        anchorOffset: '4',
      ),
      <String, String>{'role': 'menu'},
      if (props.keepOpenOnAction)
        <String, String>{'data-arcane-keep-open-on-action': 'true'},
    ]);

    final Map<String, String> triggerAttrs = mergeAttrs(<Map<String, String>>[
      anchorAttrs(anchorId),
      interactionAttrs(ArcaneInteraction.toggleMenu(surfaceId)),
      <String, String>{
        'aria-haspopup': 'menu',
        'aria-controls': surfaceId,
        'aria-expanded': props.initiallyOpen ? 'true' : 'false',
      },
    ]);

    return dom.div(
      classes: 'arcane-dropdown',
      attributes: <String, String>{
        'data-arcane-dropdown-root': surfaceId,
      },
      styles: const dom.Styles(
        raw: {'position': 'relative', 'display': 'inline-block'},
      ),
      [
        dom.div(
          classes: 'arcane-dropdown-trigger',
          attributes: triggerAttrs,
          styles: const dom.Styles(raw: {'display': 'inline-block'}),
          [props.trigger],
        ),

        // Menu - ShadCN DropdownMenuContent
        dom.div(
          classes: 'arcane-dropdown-menu',
          attributes: menuAttrs,
          styles: dom.Styles(
            raw: {
              // ShadCN: z-50
              'z-index': '100',
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
          [for (final item in props.items) _buildMenuItem(item, surfaceId)],
        ),
      ],
    );
  }

  Component _buildMenuItem(ArcaneMenuItem item, String surfaceId) {
    return switch (item) {
      MenuItemSeparator() => _buildSeparator(),
      MenuItemLabel(:final label) => _buildLabel(label),
      MenuItemAction() => _buildAction(item, surfaceId),
      MenuItemCheckbox() => _buildCheckbox(item, surfaceId),
      MenuItemRadio() => _buildRadio(item, surfaceId),
      MenuItemSubmenu() => _buildSubmenu(item, surfaceId),
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

  Component _buildAction(MenuItemAction item, String surfaceId) {
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

    final List<Component> content = <Component>[
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

    final ArcaneInteraction? itemAction = item.action;
    final Map<String, String> baseItemAttrs = <String, String>{
      'role': 'menuitem',
      'data-state': 'unchecked',
      'data-disabled': '${item.disabled}',
      if (item.disabled) 'data-arcane-disabled': 'true',
    };
    final Map<String, String> actionAttrs = item.disabled
        ? const <String, String>{}
        : itemAction != null
            ? interactionAttrs(itemAction)
            : const <String, String>{};

    if (item.href != null && !item.disabled) {
      return dom.a(
        href: item.href!,
        classes: 'arcane-dropdown-item',
        attributes: mergeAttrs(<Map<String, String>>[baseItemAttrs, actionAttrs]),
        styles: itemStyles,
        events: item.onSelect != null && itemAction == null
            ? <String, EventCallback>{
                'click': (e) {
                  item.onSelect!();
                },
              }
            : null,
        content,
      );
    }

    return dom.button(
      classes: 'arcane-dropdown-item',
      attributes: mergeAttrs(<Map<String, String>>[
        baseItemAttrs,
        <String, String>{
          'type': 'button',
          if (item.disabled) 'disabled': 'true',
        },
        actionAttrs,
      ]),
      styles: itemStyles,
      events: !item.disabled && item.onSelect != null && itemAction == null
          ? <String, EventCallback>{
              'click': (e) {
                item.onSelect!();
              },
            }
          : null,
      content,
    );
  }

  Component _buildCheckbox(MenuItemCheckbox item, String surfaceId) {
    final ArcaneInteraction? itemAction = item.action;
    final Map<String, String> actionAttrs = item.disabled
        ? const <String, String>{}
        : itemAction != null
            ? mergeAttrs(<Map<String, String>>[
                interactionAttrs(itemAction),
                <String, String>{'data-arcane-keep-open': 'true'},
              ])
            : const <String, String>{};
    return dom.div(
      classes: 'arcane-dropdown-item checkbox',
      attributes: mergeAttrs(<Map<String, String>>[
        <String, String>{
          'role': 'menuitemcheckbox',
          'aria-checked': '${item.checked}',
          if (item.disabled) 'aria-disabled': 'true',
          'data-state': item.checked ? 'checked' : 'unchecked',
          'data-disabled': '${item.disabled}',
          if (item.disabled) 'data-arcane-disabled': 'true',
          'tabindex': '0',
        },
        actionAttrs,
      ]),
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
      events: item.onChanged != null && !item.disabled && itemAction == null
          ? <String, EventCallback>{'click': (_) => item.onChanged!(!item.checked)}
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

  Component _buildRadio(MenuItemRadio item, String surfaceId) {
    final ArcaneInteraction? itemAction = item.action;
    final Map<String, String> actionAttrs = item.disabled
        ? const <String, String>{}
        : itemAction != null
            ? interactionAttrs(itemAction)
            : const <String, String>{};
    final Map<String, String> groupItem = groupItemAttrs(
      groupId: item.group,
      value: item.value,
      selected: item.selected,
      disabled: item.disabled,
    );
    return dom.div(
      classes: 'arcane-dropdown-item radio',
      attributes: mergeAttrs(<Map<String, String>>[
        groupItem,
        <String, String>{
          'role': 'menuitemradio',
          'aria-checked': '${item.selected}',
          if (item.disabled) 'aria-disabled': 'true',
          'data-disabled': '${item.disabled}',
          'tabindex': '0',
        },
        actionAttrs,
      ]),
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
      events: item.onChanged != null && !item.disabled && itemAction == null
          ? <String, EventCallback>{'click': (_) => item.onChanged!(item.value)}
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

  Component _buildSubmenu(MenuItemSubmenu item, String parentSurfaceId) {
    final String submenuId = item.id ?? '$parentSurfaceId-sub-${item.label.hashCode}';
    final String submenuAnchorId = '$submenuId-trigger';

    final Map<String, String> triggerAttrs = mergeAttrs(<Map<String, String>>[
      anchorAttrs(submenuAnchorId),
      if (!item.disabled)
        interactionAttrs(ArcaneInteraction.toggleMenu(submenuId)),
      <String, String>{
        'role': 'menuitem',
        'aria-haspopup': 'menu',
        'aria-expanded': 'false',
        'aria-controls': submenuId,
        if (item.disabled) 'aria-disabled': 'true',
        'data-disabled': '${item.disabled}',
        if (item.disabled) 'data-arcane-disabled': 'true',
        'data-arcane-keep-open': 'true',
        'tabindex': '0',
      },
    ]);

    return dom.div(
      classes:
          'arcane-dropdown-item submenu-trigger ${item.disabled ? 'disabled' : ''}',
      attributes: triggerAttrs,
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
          attributes: surfaceAttrs(
            surface: 'menu',
            id: submenuId,
            focusTrap: false,
            scrimCloses: true,
            anchorId: submenuAnchorId,
            anchorPlacement: 'right',
            anchorAlign: 'start',
            anchorOffset: '4',
          ),
          styles: const dom.Styles(
            raw: {
              'min-width': '128px',
              'padding': '4px',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius-sm)',
              'box-shadow': 'var(--shadow-md)',
              'z-index': '101',
            },
          ),
          [for (final child in item.children) _buildMenuItem(child, submenuId)],
        ),
      ],
    );
  }
}
