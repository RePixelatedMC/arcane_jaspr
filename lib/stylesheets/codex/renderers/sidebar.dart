import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/sidebar_props.dart';

/// Codex Sidebar renderer.
///
/// Uses the same HTML structure as ShadCN for consistency.
/// CSS handles visual differences via [class*="codex-"] selectors.
class CodexSidebar extends StatelessComponent {
  final SidebarProps props;

  const CodexSidebar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double width = props.isCollapsed ? props.collapsedWidth : props.width;

    return dom.aside(
      classes: 'arcane-sidebar ${props.isCollapsed ? 'collapsed' : ''} ${props.rightSide ? 'right' : 'left'}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'width': '${width}px',
        'min-width': '${width}px',
        'height': '100%',
        'background-color': 'var(--card)',
        'border-right': props.rightSide ? 'none' : '1px solid var(--border)',
        'border-left': props.rightSide ? '1px solid var(--border)' : 'none',
        'overflow': 'hidden',
        'transition': 'width 0.2s ease, min-width 0.2s ease',
        'flex-shrink': '0',
      }),
      [
        // Header (uses .sidebar-header for CSS targeting)
        if (props.header != null)
          dom.div(
            classes: 'sidebar-header',
            [props.header!],
          ),

        // Main content with nav wrapper (matches codex structure)
        dom.nav(
          classes: 'sidebar-nav',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-height': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '0.5rem',
            'overflow-y': 'auto',
            'overflow-x': 'hidden',
            'padding': '0.75rem',
          }),
          props.children,
        ),

        // Footer/collapse toggle
        if (props.showCollapseToggle || props.footer != null)
          dom.div(
            classes: 'arcane-sidebar-footer',
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'padding': '0.75rem',
              'border-top': '1px solid var(--border)',
            }),
            [
              if (props.footer != null && !props.isCollapsed) props.footer!,
              if (props.showCollapseToggle)
                dom.button(
                  styles: dom.Styles(raw: {
                    'width': '100%',
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': props.isCollapsed ? 'center' : 'flex-end',
                    'gap': 'var(--space-2)',
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
                        'font-size': 'var(--font-size-sm)',
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
      ],
    );
  }
}

/// Codex Sidebar Item using same structure as ShadCN.
/// Renders as: <div class="sidebar-tree-item"><a class="sidebar-link">...</a></div>
class CodexSidebarItem extends StatelessComponent {
  final SidebarItemProps props;

  const CodexSidebarItem(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final linkClasses = 'sidebar-link${props.selected ? ' active' : ''}';

    // Use anchor if href is provided
    if (props.href != null) {
      return dom.div(
        classes: 'sidebar-tree-item',
        [
          dom.a(
            href: props.href!,
            classes: linkClasses,
            [Component.text(props.label)],
          ),
        ],
      );
    }

    // Otherwise use button
    return dom.div(
      classes: 'sidebar-tree-item',
      [
        dom.button(
          classes: linkClasses,
          attributes: {'type': 'button'},
          events: props.onTap != null
              ? {'click': (_) => props.onTap!()}
              : null,
          [Component.text(props.label)],
        ),
      ],
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
        'gap': 'var(--space-1)',
        'margin-bottom': '1rem',
      }),
      [
        if (props.label != null && !props.collapsed)
          dom.div(
            classes: 'codex-sidebar-group-label',
            styles: const dom.Styles(raw: {
              'padding': '0.375rem 1rem',
              'font-size': 'var(--font-size-xs)',
              'font-weight': 'var(--font-weight-semibold)',
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

/// Codex Sidebar SubMenu using native details/summary.
/// Same HTML structure as ShadCN for CSS consistency.
class CodexSidebarSubMenu extends StatelessComponent {
  final SidebarSubMenuProps props;

  const CodexSidebarSubMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'sidebar-section',
      [
        Component.element(
          tag: 'details',
          classes: 'sidebar-details',
          attributes: props.defaultOpen ? {'open': ''} : {},
          children: [
            Component.element(
              tag: 'summary',
              classes: 'sidebar-summary',
              children: [
                if (props.icon != null) props.icon!,
                dom.span([Component.text(props.label)]),
                const dom.span(classes: 'sidebar-chevron', []),
              ],
            ),
            dom.div(
              classes: 'sidebar-tree',
              props.children,
            ),
          ],
        ),
      ],
    );
  }
}

/// Codex Sidebar Section (fixed, non-collapsible).
/// Same HTML structure as ShadCN.
class CodexSidebarSection extends StatelessComponent {
  final SidebarSectionProps props;

  const CodexSidebarSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'sidebar-section',
      [
        dom.div(
          classes: 'sidebar-section-header',
          [
            if (props.icon != null) props.icon!,
            dom.span([Component.text(props.label)]),
          ],
        ),
        dom.div(
          classes: 'sidebar-tree',
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
    return const dom.div(
      classes: 'codex-sidebar-separator',
      styles: dom.Styles(raw: {
        'height': '1px',
        'background-color': 'var(--border)',
        'margin': '0.75rem 0',
      }),
      [],
    );
  }
}