import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/sidebar_props.dart';

class NeubrutalismSidebar extends StatelessComponent {
  final SidebarProps props;

  const NeubrutalismSidebar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    double width = props.isCollapsed ? props.collapsedWidth : props.width;
    String sideClass = props.rightSide ? 'right' : 'left';
    String stateClass = props.isCollapsed ? 'collapsed' : '';
    String classes = 'neubrutalism-sidebar $stateClass $sideClass';

    return dom.aside(
      classes: classes,
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'width': '${width}px',
          'min-width': '${width}px',
          'height': '100%',
          'overflow': 'hidden',
          'transition': 'width 0.2s ease, min-width 0.2s ease',
          'flex-shrink': '0',
        },
      ),
      [
        if (props.header != null)
          dom.div(classes: 'sidebar-header', [props.header!]),
        dom.nav(
          classes: 'sidebar-nav',
          styles: const dom.Styles(
            raw: {
              'flex': '1',
              'min-height': '0',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.5rem',
              'overflow-y': 'auto',
              'overflow-x': 'hidden',
              'padding': '0.75rem',
              'position': 'relative',
              'z-index': '2',
            },
          ),
          props.children,
        ),
        if (props.showCollapseToggle || props.footer != null)
          dom.div(
            classes: 'neubrutalism-sidebar-footer',
            styles: const dom.Styles(
              raw: {
                'flex-shrink': '0',
                'padding': '0.625rem 0.75rem',
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '0.5rem',
                'position': 'relative',
                'z-index': '2',
              },
            ),
            [
              if (props.footer != null && !props.isCollapsed) props.footer!,
              if (props.showCollapseToggle)
                dom.button(
                  classes: 'neubrutalism-button neubrutalism-sidebar-collapse',
                  attributes: const {'type': 'button'},
                  styles: dom.Styles(
                    raw: {
                      'width': '100%',
                      'display': 'flex',
                      'align-items': 'center',
                      'justify-content': props.isCollapsed
                          ? 'center'
                          : 'space-between',
                      'gap': '0.5rem',
                      'padding': '0.5rem 0.75rem',
                      'font-size': '0.6875rem',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.08em',
                    },
                  ),
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
                    if (!props.isCollapsed) const Component.text('Collapse'),
                    dom.span(
                      styles: const dom.Styles(
                        raw: {'font-size': '0.875rem', 'opacity': '0.85'},
                      ),
                      [
                        Component.text(
                          props.isCollapsed
                              ? (props.rightSide ? '\u2190' : '\u2192')
                              : (props.rightSide ? '\u2192' : '\u2190'),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}

class NeubrutalismSidebarItem extends StatelessComponent {
  final SidebarItemProps props;

  const NeubrutalismSidebarItem(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    String linkClasses = 'sidebar-link${props.selected ? ' active' : ''}';

    if (props.href != null) {
      return dom.div(classes: 'sidebar-tree-item', [
        dom.a(href: props.href!, classes: linkClasses, [
          Component.text(props.label),
        ]),
      ]);
    }

    return dom.div(classes: 'sidebar-tree-item', [
      dom.button(
        classes: linkClasses,
        attributes: const {'type': 'button'},
        events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
        [Component.text(props.label)],
      ),
    ]);
  }
}

class NeubrutalismSidebarGroup extends StatelessComponent {
  final SidebarGroupProps props;

  const NeubrutalismSidebarGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-sidebar-group',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-1)',
          'margin-bottom': '1rem',
        },
      ),
      [
        if (props.label != null && !props.collapsed)
          dom.div(
            classes: 'neubrutalism-sidebar-group-label',
            styles: const dom.Styles(
              raw: {
                'padding': '0.375rem 1rem 0.375rem 1.25rem',
                'font-size': '0.6875rem',
                'font-weight': '600',
                'text-transform': 'uppercase',
                'letter-spacing': '0.12em',
                'color': 'var(--nb-accent, var(--primary))',
                'opacity': '0.78',
                'font-family': 'var(--font-heading)',
              },
            ),
            [Component.text(props.label!)],
          ),
        ...props.children,
      ],
    );
  }
}

class NeubrutalismSidebarSubMenu extends StatelessComponent {
  final SidebarSubMenuProps props;

  const NeubrutalismSidebarSubMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(classes: 'sidebar-section', [
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
          dom.div(classes: 'sidebar-tree', props.children),
        ],
      ),
    ]);
  }
}

class NeubrutalismSidebarSection extends StatelessComponent {
  final SidebarSectionProps props;

  const NeubrutalismSidebarSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(classes: 'sidebar-section', [
      dom.div(classes: 'sidebar-section-header', [
        if (props.icon != null) props.icon!,
        dom.span([Component.text(props.label)]),
      ]),
      dom.div(classes: 'sidebar-tree', props.children),
    ]);
  }
}

class NeubrutalismSidebarSeparator extends StatelessComponent {
  const NeubrutalismSidebarSeparator({super.key});

  @override
  Component build(BuildContext context) {
    return const dom.div(
      classes: 'neubrutalism-sidebar-separator',
      styles: dom.Styles(
        raw: {
          'height': '0',
          'border-top': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'margin': '0.875rem 0',
        },
      ),
      [],
    );
  }
}
