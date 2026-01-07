import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/sidebar_props.dart';

/// Codex Sidebar renderer.
///
/// Implements the Codex design language:
/// - OLED-first dark background
/// - Accent-colored active states with subtle glow
/// - More spacing between items
class CodexSidebar extends StatelessComponent {
  final SidebarProps props;

  const CodexSidebar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex: slightly wider sidebar
    final double width = props.isCollapsed ? props.collapsedWidth : props.width;

    return dom.aside(
      classes: 'codex-sidebar ${props.isCollapsed ? 'collapsed' : 'expanded'}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'width': '${width}px',
        'min-width': '${width}px',
        'height': '100%',
        'background-color': 'var(--card)',
        // Codex: subtle border
        'border-right': props.rightSide ? 'none' : '1px solid var(--border)',
        'border-left': props.rightSide ? '1px solid var(--border)' : 'none',
        'overflow': 'hidden',
        'transition': 'width 0.2s ease, min-width 0.2s ease',
      }),
      [
        // Header
        if (props.header != null)
          dom.div(
            classes: 'codex-sidebar-header',
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'padding': '1.25rem', // Codex: more padding
              'border-bottom': '1px solid var(--border)',
            }),
            [props.header!],
          ),

        // Main content
        dom.div(
          classes: 'codex-sidebar-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'overflow-x': 'hidden',
            'padding': '0.75rem', // Codex: more padding
          }),
          props.children,
        ),

        // Collapse toggle
        if (props.showCollapseToggle)
          dom.div(
            classes: 'codex-sidebar-toggle',
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'padding': '0.75rem',
              'border-top': '1px solid var(--border)',
            }),
            [
              dom.button(
                styles: dom.Styles(raw: {
                  'width': '100%',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': props.isCollapsed ? 'center' : 'flex-end',
                  'gap': '0.5rem',
                  'padding': '0.625rem',
                  'background': 'transparent',
                  'border': '1px solid var(--border)',
                  'border-radius': 'var(--radius-md)',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'transition': 'all var(--transition)',
                }),
                events: {
                  'click': (_) {
                    if (props.onToggleCollapse != null) {
                      props.onToggleCollapse!();
                    } else if (props.onCollapseChanged != null) {
                      props.onCollapseChanged!(!props.isCollapsed);
                    }
                  },
                },
                [
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.875rem',
                    }),
                    [
                      Component.text(
                        props.isCollapsed
                            ? (props.rightSide ? '\u2190' : '\u2192')
                            : (props.rightSide ? '\u2192' : '\u2190'),
                      ),
                    ],
                  ),
                  if (!props.isCollapsed)
                    const Component.text('Collapse'),
                ],
              ),
            ],
          ),

        // Footer
        if (props.footer != null)
          dom.div(
            classes: 'codex-sidebar-footer',
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'padding': '1.25rem',
              'border-top': '1px solid var(--border)',
            }),
            [props.footer!],
          ),
      ],
    );
  }
}

/// Codex Sidebar Item renderer.
class CodexSidebarItem extends StatelessComponent {
  final SidebarItemProps props;

  const CodexSidebarItem(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled;

    final Map<String, String> baseStyles = {
      'display': 'flex',
      'align-items': 'center',
      'gap': props.collapsed ? '0' : '0.75rem', // Codex: more gap
      'width': '100%',
      // Codex: larger padding
      'padding': props.collapsed ? '0.75rem' : '0.75rem 1rem',
      'border-radius': 'var(--radius-md)',
      'font-size': '0.875rem',
      'font-weight': props.selected ? '600' : '500',
      'text-decoration': 'none',
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'opacity': isDisabled ? '0.5' : '1',
      'transition': 'all var(--transition)',
      'justify-content': props.collapsed ? 'center' : 'flex-start',
      // Codex: accent colors for selected state
      'background-color': props.selected
          ? 'rgba(var(--codex-accent-rgb), 0.15)'
          : 'transparent',
      'color': props.selected
          ? 'var(--codex-accent)'
          : 'var(--muted-foreground)',
      // Codex: subtle glow when selected
      if (props.selected) 'box-shadow': 'inset 0 0 0 1px rgba(var(--codex-accent-rgb), 0.2)',
    };

    final List<Component> content = [
      if (props.icon != null)
        dom.span(
          styles: const dom.Styles(raw: {
            'flex-shrink': '0',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
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
          classes: 'codex-sidebar-badge',
          styles: const dom.Styles(raw: {
            'background-color': 'var(--codex-accent)',
            'color': '#ffffff',
            'font-size': '0.625rem',
            'font-weight': '600',
            'padding': '0.125rem 0.375rem',
            'border-radius': '9999px',
          }),
          [Component.text(props.badge!)],
        ),
    ];

    if (props.href != null) {
      return dom.a(
        href: props.href!,
        classes: 'codex-sidebar-item ${props.selected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
        attributes: {
          if (props.tooltip != null && props.collapsed) 'title': props.tooltip!,
        },
        styles: dom.Styles(raw: baseStyles),
        content,
      );
    }

    return dom.button(
      classes: 'codex-sidebar-item ${props.selected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (props.tooltip != null && props.collapsed) 'title': props.tooltip!,
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {...baseStyles, 'border': 'none'}),
      events: isDisabled || props.onTap == null
          ? null
          : {'click': (_) => props.onTap!()},
      content,
    );
  }
}

/// Codex Sidebar Group renderer.
class CodexSidebarGroup extends StatelessComponent {
  final SidebarGroupProps props;

  const CodexSidebarGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-sidebar-group',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
        'margin-bottom': '1rem', // Codex: more spacing between groups
      }),
      [
        if (props.label != null && !props.collapsed)
          dom.div(
            classes: 'codex-sidebar-group-label',
            styles: const dom.Styles(raw: {
              'padding': '0.375rem 1rem',
              'font-size': '0.75rem',
              'font-weight': '600',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
              'color': 'var(--muted-foreground)',
              'opacity': '0.7',
            }),
            [Component.text(props.label!)],
          ),
        ...props.children,
      ],
    );
  }
}

/// Codex Sidebar SubMenu renderer.
class CodexSidebarSubMenu extends StatelessComponent {
  final SidebarSubMenuProps props;

  const CodexSidebarSubMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-sidebar-submenu ${props.isOpen ? 'open' : 'closed'}',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
      }),
      [
        // Trigger button
        dom.button(
          classes: 'codex-sidebar-submenu-trigger',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': props.collapsed ? '0' : '0.75rem',
            'width': '100%',
            'padding': props.collapsed ? '0.75rem' : '0.75rem 1rem',
            'border': 'none',
            'border-radius': 'var(--radius-md)',
            'background': 'transparent',
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--muted-foreground)',
            'cursor': 'pointer',
            'transition': 'all var(--transition)',
            'justify-content': props.collapsed ? 'center' : 'flex-start',
          }),
          events: props.onToggle == null ? null : {'click': (_) => props.onToggle!()},
          [
            if (props.icon != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'flex-shrink': '0',
                  'display': 'flex',
                  'align-items': 'center',
                }),
                [props.icon!],
              ),
            if (!props.collapsed) ...[
              dom.span(
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'text-align': 'left',
                }),
                [Component.text(props.label)],
              ),
              if (props.badge != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'background-color': 'var(--codex-accent)',
                    'color': '#ffffff',
                    'font-size': '0.625rem',
                    'font-weight': '600',
                    'padding': '0.125rem 0.375rem',
                    'border-radius': '9999px',
                  }),
                  [Component.text(props.badge!)],
                ),
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': '0.625rem',
                  'transition': 'transform var(--transition)',
                  'transform': props.isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                }),
                [const Component.text('\u25BC')], // Down arrow
              ),
            ],
          ],
        ),

        // Children (shown when open)
        if (props.isOpen && !props.collapsed)
          dom.div(
            classes: 'codex-sidebar-submenu-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.125rem',
              'padding-left': '1.5rem', // Codex: indent children
              'margin-top': '0.25rem',
            }),
            props.children,
          ),
      ],
    );
  }
}

/// Codex Sidebar Separator renderer.
class CodexSidebarSeparator extends StatelessComponent {
  const CodexSidebarSeparator({super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-sidebar-separator',
      styles: const dom.Styles(raw: {
        'height': '1px',
        'background-color': 'var(--border)',
        'margin': '0.75rem 0', // Codex: more margin
      }),
      [],
    );
  }
}
