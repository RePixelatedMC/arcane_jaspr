import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/core/props/sidebar_props.dart';

class NeonSidebar extends StatelessComponent {
  final SidebarProps props;

  const NeonSidebar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    double width = props.isCollapsed ? props.collapsedWidth : props.width;
    String sideClass = props.rightSide ? 'right' : 'left';
    String stateClass = props.isCollapsed ? 'collapsed' : '';
    String classes = 'neon-sidebar $stateClass $sideClass';

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
            classes: 'neon-sidebar-footer',
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
                  classes: 'neon-button neon-sidebar-collapse',
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

class NeonSidebarItem extends StatelessComponent {
  final SidebarItemProps props;

  const NeonSidebarItem(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(classes: 'sidebar-tree-item', [
      Button(
        href: props.href,
        label: props.label,
        icon: props.icon,
        onPressed: props.onTap,
        variant: props.selected ? ButtonVariant.secondary : ButtonVariant.ghost,
        size: ButtonSize.sm,
        disabled: props.disabled,
        fullWidth: true,
        attributes: {
          'sidebar-item': 'true',
          'sidebar-active': '${props.selected}',
        },
      ),
    ]);
  }
}

class NeonSidebarGroup extends StatelessComponent {
  final SidebarGroupProps props;

  const NeonSidebarGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neon-sidebar-group',
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
            classes: 'neon-sidebar-group-label',
            styles: const dom.Styles(
              raw: {
                'padding': '0.375rem 1rem 0.375rem 1.25rem',
                'font-size': '0.6875rem',
                'font-weight': '600',
                'text-transform': 'uppercase',
                'letter-spacing': '0.12em',
                'color': 'var(--neon-accent)',
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

class NeonSidebarSubMenu extends StatelessComponent {
  final SidebarSubMenuProps props;

  const NeonSidebarSubMenu(this.props, {super.key});

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

class NeonSidebarSection extends StatelessComponent {
  final SidebarSectionProps props;

  const NeonSidebarSection(this.props, {super.key});

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

class NeonSidebarSeparator extends StatelessComponent {
  const NeonSidebarSeparator({super.key});

  @override
  Component build(BuildContext context) {
    return const dom.div(
      classes: 'neon-sidebar-separator',
      styles: dom.Styles(
        raw: {
          'height': '1px',
          'background':
              'linear-gradient(90deg, transparent, var(--neon-panel-border-hot), transparent)',
          'margin': '0.75rem 0',
        },
      ),
      [],
    );
  }
}
