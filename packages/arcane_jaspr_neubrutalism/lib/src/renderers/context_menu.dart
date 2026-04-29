import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/context_menu_props.dart';

/// Neubrutalism-style context menu component with pattern matching on sealed ArcaneMenuItem types.
class NeubrutalismContextMenu extends StatelessComponent {
  final ContextMenuProps props;

  const NeubrutalismContextMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id;

    final Map<String, String> menuAttrs = mergeAttrs(<Map<String, String>>[
      surfaceAttrs(
        surface: 'context-menu',
        id: surfaceId,
        focusTrap: false,
        scrimCloses: true,
      ),
      <String, String>{'role': 'menu'},
      if (props.keepOpenOnAction)
        <String, String>{'data-arcane-keep-open-on-action': 'true'},
    ]);

    return dom.div(
      classes: 'neubrutalism-context-menu-trigger',
      attributes: <String, String>{
        'data-arcane-context-trigger': surfaceId,
      },
      styles: const dom.Styles(raw: {'display': 'contents'}),
      [
        props.trigger,
        dom.div(
          classes: 'neubrutalism-context-menu neubrutalism-popover',
          attributes: menuAttrs,
          styles: const dom.Styles(
            raw: {
              'z-index': '50',
              'min-width': '180px',
              'overflow': 'hidden',
              'padding': '6px',
              'background': 'var(--nb-paper, var(--card))',
              'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
              'border-radius': '0',
              'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
              'color': 'var(--nb-ink, var(--popover-foreground))',
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
      MenuItemAction() => _buildAction(item),
      MenuItemCheckbox() => _buildCheckbox(item),
      MenuItemRadio() => _buildRadio(item),
      MenuItemSubmenu() => _buildSubmenu(item, surfaceId),
    };
  }

  Component _buildSeparator() {
    return const dom.div(
      classes: 'neubrutalism-context-menu-separator',
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
      classes: 'neubrutalism-context-menu-label',
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
    final ArcaneInteraction? itemAction = item.action;
    final Map<String, String> actionAttrs = item.disabled
        ? const <String, String>{}
        : itemAction != null
            ? interactionAttrs(itemAction)
            : const <String, String>{};

    return dom.div(
      classes:
          'neubrutalism-context-menu-item ${item.disabled ? 'disabled' : ''} ${item.destructive ? 'destructive' : ''}',
      attributes: mergeAttrs(<Map<String, String>>[
        <String, String>{
          'role': 'menuitem',
          if (item.disabled) 'aria-disabled': 'true',
          if (item.shortcut != null) 'data-shortcut': item.shortcut!,
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
          'gap': '10px',
          'padding': '8px 12px',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition':
              'color var(--nb-transition, 120ms ease), background-color var(--nb-transition, 120ms ease)',
          'font-size': 'var(--font-size-sm)',
          'user-select': 'none',
          'outline': 'none',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onSelect != null && !item.disabled && itemAction == null
          ? <String, EventCallback>{'click': (_) => item.onSelect!()}
          : null,
      [
        if (item.icon != null) item.icon!,
        dom.span(
          styles: dom.Styles(
            raw: {
              'flex': '1',
              'color': item.destructive
                  ? 'var(--destructive)'
                  : 'var(--foreground)',
            },
          ),
          [Component.text(item.label)],
        ),
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
      classes: 'neubrutalism-context-menu-item checkbox',
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
          'gap': '10px',
          'padding': '8px 12px',
          'padding-left': '36px',
          'font-size': 'var(--font-size-sm)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition':
              'background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
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
                'left': '12px',
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
      classes: 'neubrutalism-context-menu-item radio',
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
          'gap': '10px',
          'padding': '8px 12px',
          'padding-left': '36px',
          'font-size': 'var(--font-size-sm)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition':
              'background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
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
                'left': '12px',
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
          'neubrutalism-context-menu-item neubrutalism-context-menu-submenu-trigger ${item.disabled ? 'disabled' : ''}',
      attributes: triggerAttrs,
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'align-items': 'center',
          'gap': '10px',
          'padding': '8px 12px',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'transition':
              'color var(--nb-transition, 120ms ease), background-color var(--nb-transition, 120ms ease)',
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
            raw: {'flex': '1', 'color': 'var(--foreground)'},
          ),
          [Component.text(item.label)],
        ),
        dom.span(
          styles: dom.Styles(raw: {'color': 'var(--muted-foreground)'}),
          [ArcaneIcon.chevronRight(size: IconSize.sm)],
        ),
        dom.div(
          classes: 'neubrutalism-context-menu-submenu neubrutalism-popover',
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
              'min-width': '160px',
              'padding': '6px',
              'background': 'var(--nb-paper, var(--card))',
              'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
              'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
              'z-index': '101',
            },
          ),
          [for (final child in item.children) _buildMenuItem(child, submenuId)],
        ),
      ],
    );
  }
}
