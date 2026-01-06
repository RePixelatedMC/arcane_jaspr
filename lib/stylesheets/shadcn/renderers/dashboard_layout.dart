import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/renderers.dart';

/// ShadCN Dashboard Layout renderer.
class ShadcnDashboardLayout extends StatelessComponent {
  final DashboardLayoutProps props;

  const ShadcnDashboardLayout(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-dashboard-layout',
      styles: dom.Styles(raw: {
        'min-height': '100vh',
        'display': 'flex',
        'background': props.backgroundColor,
        'color': 'var(--foreground)',
        'font-family': 'ui-sans-serif, system-ui, sans-serif',
      }),
      [
        // Sidebar
        _buildSidebar(),
        // Main content area
        dom.div(
          classes: 'arcane-dashboard-main',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-height': '100vh',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
          }),
          [
            // Optional top bar
            if (props.topBar != null) props.topBar!,
            // Content
            dom.div(
              classes: 'arcane-dashboard-content',
              styles: const dom.Styles(raw: {
                'flex': '1',
              }),
              [props.child],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildSidebar() {
    return dom.aside(
      classes: 'arcane-dashboard-sidebar',
      styles: dom.Styles(raw: {
        'width': props.sidebarWidth,
        'background': props.sidebarBackgroundColor,
        'border-right': '1px solid var(--border)',
        'display': 'flex',
        'flex-direction': 'column',
        'min-height': '100vh',
        'flex-shrink': '0',
      }),
      [
        // Header (logo area)
        if (props.sidebarHeader != null)
          dom.div(
            classes: 'arcane-dashboard-sidebar-header',
            styles: const dom.Styles(raw: {
              'padding': '1.5rem',
              'border-bottom': '1px solid var(--border)',
              'flex-shrink': '0',
            }),
            [props.sidebarHeader!],
          ),
        // Navigation
        dom.nav(
          classes: 'arcane-dashboard-sidebar-nav',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'padding': '1rem',
            'overflow-y': 'auto',
          }),
          props.navigation.map(_buildNavGroup).toList(),
        ),
        // Footer
        if (props.sidebarFooter != null)
          dom.div(
            classes: 'arcane-dashboard-sidebar-footer',
            styles: const dom.Styles(raw: {
              'padding': '1rem',
              'border-top': '1px solid var(--border)',
              'flex-shrink': '0',
            }),
            [props.sidebarFooter!],
          ),
      ],
    );
  }

  Component _buildNavGroup(DashboardNavGroup group) {
    return dom.div(
      classes: 'arcane-dashboard-nav-group',
      styles: const dom.Styles(raw: {
        'margin-bottom': '1.5rem',
      }),
      [
        // Group label
        if (group.label != null)
          dom.div(
            classes: 'arcane-dashboard-nav-group-label',
            styles: const dom.Styles(raw: {
              'font-size': '0.75rem',
              'font-weight': '600',
              'color': 'var(--muted-foreground)',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
              'padding': '0 1rem',
              'margin-bottom': '0.5rem',
            }),
            [Component.text(group.label!)],
          ),
        // Items
        ...group.items.map(_buildNavItem),
      ],
    );
  }

  Component _buildNavItem(DashboardNavItem item) {
    final bool isActive = props.currentRoute == item.href;
    return dom.a(
      href: item.href,
      classes: 'arcane-dashboard-nav-item ${isActive ? 'active' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'padding': '0.5rem 1rem',
        'color': isActive ? 'var(--accent)' : 'var(--muted-foreground)',
        'text-decoration': 'none',
        'font-size': '0.875rem',
        'font-weight': isActive ? '600' : '500',
        'border-radius': '0.375rem',
        'background': isActive ? 'hsl(var(--accent) / 0.1)' : 'transparent',
        'border': isActive
            ? '1px solid var(--accent)'
            : '1px solid transparent',
        'transition': 'all 150ms ease',
        'margin-bottom': '0.25rem',
      }),
      [
        // Icon
        if (item.icon != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
            }),
            [item.icon!],
          ),
        // Label
        dom.span(
          styles: const dom.Styles(raw: {
            'flex': '1',
          }),
          [Component.text(item.label)],
        ),
        // Badge
        if (item.badge != null)
          dom.span(
            classes: 'arcane-dashboard-nav-badge',
            styles: const dom.Styles(raw: {
              'background': 'var(--accent)',
              'color': 'var(--accent-foreground)',
              'font-size': '0.75rem',
              'padding': '2px 6px',
              'border-radius': '9999px',
              'font-weight': '500',
            }),
            [Component.text(item.badge!)],
          ),
      ],
    );
  }
}

/// ShadCN Dashboard Top Bar renderer.
class ShadcnDashboardTopBar extends StatelessComponent {
  final DashboardTopBarProps props;

  const ShadcnDashboardTopBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-dashboard-topbar',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '1rem 2rem',
        'background': props.backgroundColor,
        'border-bottom': '1px solid var(--border)',
        'flex-shrink': '0',
      }),
      [
        // Leading (breadcrumbs/title)
        dom.div(
          classes: 'arcane-dashboard-topbar-leading',
          [if (props.leading != null) props.leading!],
        ),
        // Trailing (user menu)
        dom.div(
          classes: 'arcane-dashboard-topbar-trailing',
          [if (props.trailing != null) props.trailing!],
        ),
      ],
    );
  }
}
