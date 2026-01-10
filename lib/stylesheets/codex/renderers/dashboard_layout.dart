import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/dashboard_layout_props.dart';

/// Codex DashboardLayout renderer.
class CodexDashboardLayout extends StatelessComponent {
  final DashboardLayoutProps props;

  const CodexDashboardLayout(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-dashboard-layout',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'min-height': '100vh',
      }),
      [
        // Sidebar
        dom.aside(
          classes: 'codex-dashboard-sidebar',
          styles: dom.Styles(raw: {
            'width': props.sidebarWidth,
            'flex-shrink': '0',
            'background-color': props.sidebarBackgroundColor,
            'border-right': '1px solid var(--border)',
            'display': 'flex',
            'flex-direction': 'column',
            'position': 'fixed',
            'top': '0',
            'left': '0',
            'bottom': '0',
            'z-index': '50',
          }),
          [
            // Sidebar header (logo)
            if (props.sidebarHeader != null)
              dom.div(
                classes: 'codex-dashboard-sidebar-header',
                styles: const dom.Styles(raw: {
                  'padding': '1.5rem',
                  'border-bottom': '1px solid var(--border)',
                }),
                [props.sidebarHeader!],
              ),

            // Navigation
            dom.nav(
              classes: 'codex-dashboard-nav',
              styles: const dom.Styles(raw: {
                'flex': '1',
                'overflow-y': 'auto',
                'padding': '1rem',
                'display': 'flex',
                'flex-direction': 'column',
                'gap': 'var(--arcane-space-6)',
              }),
              [
                for (final group in props.navigation)
                  _buildNavGroup(group, props.currentRoute),
              ],
            ),

            // Sidebar footer
            if (props.sidebarFooter != null)
              dom.div(
                classes: 'codex-dashboard-sidebar-footer',
                styles: const dom.Styles(raw: {
                  'padding': '1rem',
                  'border-top': '1px solid var(--border)',
                }),
                [props.sidebarFooter!],
              ),
          ],
        ),

        // Main area
        dom.div(
          classes: 'codex-dashboard-main',
          styles: dom.Styles(raw: {
            'flex': '1',
            'margin-left': props.sidebarWidth,
            'display': 'flex',
            'flex-direction': 'column',
            'background-color': props.backgroundColor,
          }),
          [
            // Top bar
            if (props.topBar != null) props.topBar!,

            // Content
            dom.div(
              classes: 'codex-dashboard-content',
              styles: const dom.Styles(raw: {
                'flex': '1',
                'padding': '1.5rem',
                'overflow-y': 'auto',
              }),
              [props.child],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildNavGroup(DashboardNavGroup group, String currentRoute) {
    return dom.div(
      classes: 'codex-dashboard-nav-group',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--arcane-space-1)',
      }),
      [
        // Group label
        if (group.label != null)
          dom.div(
            classes: 'codex-dashboard-nav-group-label',
            styles: const dom.Styles(raw: {
              'font-size': '0.6875rem',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
              'color': 'var(--muted-foreground)',
              'padding': '0 0.75rem 0.5rem',
            }),
            [Component.text(group.label!)],
          ),

        // Items
        for (final item in group.items)
          _buildNavItem(item, currentRoute),
      ],
    );
  }

  Component _buildNavItem(DashboardNavItem item, String currentRoute) {
    final bool isActive = currentRoute == item.href ||
        (item.href != '/' && currentRoute.startsWith(item.href));

    return dom.a(
      classes: 'codex-dashboard-nav-item ${isActive ? 'active' : ''}',
      href: item.href,
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.75rem',
        'padding': '0.625rem 0.75rem',
        'font-size': 'var(--arcane-font-size-sm)',
        'font-weight': isActive ? '500' : '400',
        'color': isActive ? 'var(--codex-accent)' : 'var(--foreground)',
        'text-decoration': 'none',
        'border-radius': 'var(--radius)',
        'background-color': isActive
            ? 'rgba(var(--codex-accent-rgb), 0.1)'
            : 'transparent',
        'transition': 'all var(--arcane-transition)',
      }),
      [
        // Icon
        if (item.icon != null)
          dom.div(
            classes: 'codex-dashboard-nav-item-icon',
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'color': isActive
                  ? 'var(--codex-accent)'
                  : 'var(--muted-foreground)',
            }),
            [item.icon!],
          ),

        // Label
        dom.span(
          classes: 'codex-dashboard-nav-item-label',
          styles: const dom.Styles(raw: {
            'flex': '1',
          }),
          [Component.text(item.label)],
        ),

        // Badge
        if (item.badge != null)
          dom.span(
            classes: 'codex-dashboard-nav-item-badge',
            styles: const dom.Styles(raw: {
              'padding': '0.125rem 0.5rem',
              'font-size': '0.6875rem',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'background-color': 'var(--codex-accent)',
              'color': '#ffffff',
              'border-radius': 'var(--arcane-radius-full)',
            }),
            [Component.text(item.badge!)],
          ),
      ],
    );
  }
}

/// Codex DashboardTopBar renderer.
class CodexDashboardTopBar extends StatelessComponent {
  final DashboardTopBarProps props;

  const CodexDashboardTopBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.header(
      classes: 'codex-dashboard-top-bar',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'padding': '1rem 1.5rem',
        'background-color': props.backgroundColor,
        'border-bottom': '1px solid var(--border)',
        'position': 'sticky',
        'top': '0',
        'z-index': '40',
      }),
      [
        // Leading (breadcrumbs, page title)
        if (props.leading != null)
          dom.div(
            classes: 'codex-dashboard-top-bar-leading',
            [props.leading!],
          )
        else
          const dom.div([]),

        // Trailing (notifications, user menu)
        if (props.trailing != null)
          dom.div(
            classes: 'codex-dashboard-top-bar-trailing',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--arcane-space-4)',
            }),
            [props.trailing!],
          ),
      ],
    );
  }
}