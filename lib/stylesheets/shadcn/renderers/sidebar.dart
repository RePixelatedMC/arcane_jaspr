import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/sidebar_props.dart';

/// ShadCN-style sidebar component
/// Reference: https://ui.shadcn.com/docs/components/sidebar
class ShadcnSidebar extends StatelessComponent {
  final SidebarProps props;

  const ShadcnSidebar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double currentWidth =
        props.isCollapsed ? props.collapsedWidth : props.width;

    // ShadCN Sidebar: flex h-full w-[--sidebar-width] flex-col bg-sidebar
    return dom.aside(
      classes: 'arcane-sidebar ${props.isCollapsed ? 'collapsed' : ''} ${props.rightSide ? 'right' : 'left'}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'width': '${currentWidth}px',
        'height': '100%',
        'background-color': 'var(--background)',
        'border-${props.rightSide ? 'left' : 'right'}': '1px solid var(--border)',
        'transition': 'width 200ms ease',
        'flex-shrink': '0',
        'overflow': 'hidden',
      }),
      [
        // ShadCN SidebarHeader
        if (props.header != null)
          dom.div(
            classes: 'arcane-sidebar-header',
            styles: const dom.Styles(raw: {
              'padding': '8px',
              'border-bottom': '1px solid var(--border)',
              'flex-shrink': '0',
            }),
            [props.header!],
          ),

        // ShadCN SidebarContent
        dom.div(
          classes: 'arcane-sidebar-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-height': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '8px',
            'overflow-y': 'auto',
            'overflow-x': 'hidden',
            'padding': '8px',
          }),
          props.children,
        ),

        // ShadCN SidebarFooter
        dom.div(
          classes: 'arcane-sidebar-footer',
          styles: const dom.Styles(raw: {
            'padding': '8px',
            'border-top': '1px solid var(--border)',
            'flex-shrink': '0',
          }),
          [
            if (props.footer != null && !props.isCollapsed) props.footer!,
            if (props.showCollapseToggle)
              dom.button(
                classes: 'arcane-sidebar-toggle',
                attributes: {
                  'type': 'button',
                  'aria-label':
                      props.isCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
                },
                styles: dom.Styles(raw: {
                  'display': 'inline-flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': props.isCollapsed ? '32px' : '100%',
                  'height': '32px',
                  'margin': props.isCollapsed ? '0 auto' : '0',
                  'margin-top':
                      props.footer != null && !props.isCollapsed ? '8px' : '0',
                  'border-radius': '6px',
                  'background': 'transparent',
                  'border': 'none',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'transition': 'color 150ms ease, background-color 150ms ease',
                  'font-size': '14px',
                }),
                events: props.onToggleCollapse != null
                    ? {'click': (_) => props.onToggleCollapse!()}
                    : null,
                [
                  dom.span(
                    styles: dom.Styles(raw: {
                      'transition': 'transform 200ms ease',
                      'transform': props.rightSide
                          ? (props.isCollapsed ? 'rotate(180deg)' : 'rotate(0)')
                          : (props.isCollapsed
                              ? 'rotate(0)'
                              : 'rotate(180deg)'),
                    }),
                    [const Component.text('<')],
                  ),
                  if (!props.isCollapsed)
                    const dom.span(
                      styles: dom.Styles(raw: {
                        'margin-left': '8px',
                        'font-size': '14px',
                      }),
                      [Component.text('Collapse')],
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// ShadCN-style sidebar item
class ShadcnSidebarItem extends StatelessComponent {
  final SidebarItemProps props;

  const ShadcnSidebarItem(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final tooltipText = props.tooltip ?? props.label;
    final itemStyles = dom.Styles(raw: {
      'display': 'flex',
      'width': '100%',
      'align-items': 'center',
      'justify-content': props.collapsed ? 'center' : 'flex-start',
      'gap': '8px',
      'padding': '8px',
      'border-radius': '6px',
      'overflow': 'hidden',
      'border': 'none',
      'text-align': 'left',
      'font-size': '14px',
      'outline': 'none',
      'text-decoration': 'none',
      'transition':
          'color 150ms ease, background-color 150ms ease, width 200ms ease, padding 200ms ease',
      'background-color': props.selected ? 'var(--accent)' : 'transparent',
      'color':
          props.selected ? 'var(--accent-foreground)' : 'var(--foreground)',
      'font-weight': props.selected ? '600' : '500',
      'cursor': props.disabled ? 'not-allowed' : 'pointer',
      'pointer-events': props.disabled ? 'none' : 'auto',
      'opacity': props.disabled ? '0.5' : '1',
    });

    final content = [
      if (props.icon != null)
        dom.div(
          styles: const dom.Styles(raw: {
            'width': '16px',
            'height': '16px',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
          }),
          [props.icon!],
        ),
      if (!props.collapsed)
        dom.span(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'overflow': 'hidden',
            'text-overflow': 'ellipsis',
            'white-space': 'nowrap',
          }),
          [Component.text(props.label)],
        ),
      if (!props.collapsed && props.badge != null)
        dom.span(
          classes: 'arcane-sidebar-item-badge',
          styles: const dom.Styles(raw: {
            'background-color': 'var(--primary)',
            'color': 'var(--primary-foreground)',
            'font-size': '12px',
            'padding': '2px 8px',
            'border-radius': '9999px',
            'font-weight': '500',
          }),
          [Component.text(props.badge!)],
        ),
    ];

    // Use anchor if href is provided, otherwise button
    if (props.href != null) {
      return dom.a(
        href: props.href!,
        classes:
            'arcane-sidebar-item ${props.selected ? 'selected' : ''} ${props.disabled ? 'disabled' : ''}',
        attributes: {
          if (props.collapsed) 'title': tooltipText,
        },
        styles: itemStyles,
        content,
      );
    }

    // ShadCN SidebarMenuButton
    return dom.button(
      classes:
          'arcane-sidebar-item ${props.selected ? 'selected' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (props.disabled) 'disabled': 'true',
        if (props.collapsed) 'title': tooltipText,
      },
      styles: itemStyles,
      events: {
        'click': (event) {
          if (!props.disabled && props.onTap != null) {
            props.onTap!();
          }
        },
      },
      content,
    );
  }
}

/// ShadCN-style sidebar group
class ShadcnSidebarGroup extends StatelessComponent {
  final SidebarGroupProps props;

  const ShadcnSidebarGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // ShadCN SidebarGroup
    return dom.div(
      classes: 'arcane-sidebar-group',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'width': '100%',
        'min-width': '0',
        'flex-direction': 'column',
        'padding': '8px',
      }),
      [
        // ShadCN SidebarGroupLabel
        if (props.label != null && !props.collapsed)
          dom.div(
            classes: 'arcane-sidebar-group-label',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'height': '32px',
              'flex-shrink': '0',
              'align-items': 'center',
              'border-radius': '6px',
              'padding': '0 8px',
              'font-size': '12px',
              'font-weight': '500',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.label!)],
          ),
        // ShadCN SidebarGroupContent
        dom.div(
          classes: 'arcane-sidebar-group-items',
          styles: const dom.Styles(raw: {
            'width': '100%',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '4px',
            'font-size': '14px',
          }),
          props.children,
        ),
      ],
    );
  }
}

/// ShadCN-style sidebar submenu (collapsible nested items)
class ShadcnSidebarSubMenu extends StatelessComponent {
  final SidebarSubMenuProps props;

  const ShadcnSidebarSubMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-sidebar-submenu ${props.isOpen ? 'open' : ''}',
      styles: const dom.Styles(raw: {
        'width': '100%',
      }),
      [
        // Trigger button
        dom.button(
          classes: 'arcane-sidebar-submenu-trigger',
          attributes: {
            'type': 'button',
            if (props.collapsed) 'title': props.label,
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'width': '100%',
            'align-items': 'center',
            'justify-content': props.collapsed ? 'center' : 'space-between',
            'gap': '8px',
            'padding': '8px',
            'border-radius': '6px',
            'border': 'none',
            'background': 'transparent',
            'text-align': 'left',
            'font-size': '14px',
            'font-weight': '500',
            'color': 'var(--foreground)',
            'cursor': 'pointer',
            'transition': 'color 150ms ease, background-color 150ms ease',
          }),
          events: props.onToggle != null ? {'click': (_) => props.onToggle!()} : null,
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '8px',
              }),
              [
                if (props.icon != null)
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'width': '16px',
                      'height': '16px',
                      'display': 'flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'flex-shrink': '0',
                    }),
                    [props.icon!],
                  ),
                if (!props.collapsed)
                  dom.span([Component.text(props.label)]),
              ],
            ),
            if (!props.collapsed)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '8px',
                }),
                [
                  if (props.badge != null)
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'background-color': 'var(--primary)',
                        'color': 'var(--primary-foreground)',
                        'font-size': '12px',
                        'padding': '2px 8px',
                        'border-radius': '9999px',
                        'font-weight': '500',
                      }),
                      [Component.text(props.badge!)],
                    ),
                  dom.span(
                    styles: dom.Styles(raw: {
                      'font-size': '12px',
                      'transition': 'transform 150ms ease',
                      'transform': props.isOpen ? 'rotate(180deg)' : 'rotate(0)',
                    }),
                    [const Component.text('\u25BC')],
                  ),
                ],
              ),
          ],
        ),
        // Submenu content
        if (props.isOpen && !props.collapsed)
          dom.div(
            classes: 'arcane-sidebar-submenu-content',
            styles: const dom.Styles(raw: {
              'padding-left': '24px',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '4px',
              'margin-top': '4px',
            }),
            props.children,
          ),
      ],
    );
  }
}

/// Content only visible when sidebar is expanded
class ShadcnSidebarExpanded extends StatelessComponent {
  final List<Component> children;

  const ShadcnSidebarExpanded(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    // The visibility is controlled by CSS class on parent
    return dom.div(
      classes: 'arcane-sidebar-expanded-only',
      styles: const dom.Styles(raw: {
        'display': 'var(--sidebar-expanded-display, block)',
      }),
      children,
    );
  }
}

/// Content only visible when sidebar is collapsed
class ShadcnSidebarCollapsed extends StatelessComponent {
  final List<Component> children;

  const ShadcnSidebarCollapsed(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    // The visibility is controlled by CSS class on parent
    return dom.div(
      classes: 'arcane-sidebar-collapsed-only',
      styles: const dom.Styles(raw: {
        'display': 'var(--sidebar-collapsed-display, none)',
      }),
      children,
    );
  }
}

/// Sidebar separator
class ShadcnSidebarSeparator extends StatelessComponent {
  const ShadcnSidebarSeparator({super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-sidebar-separator',
      styles: const dom.Styles(raw: {
        'height': '1px',
        'background-color': 'var(--border)',
        'margin': '8px 0',
      }),
      const [],
    );
  }
}