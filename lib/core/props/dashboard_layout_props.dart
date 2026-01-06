import 'package:jaspr/jaspr.dart';

/// A navigation item for the dashboard sidebar
class DashboardNavItem {
  /// The display label
  final String label;

  /// The route/href for navigation
  final String href;

  /// Optional icon component
  final Component? icon;

  /// Optional badge text (e.g., notification count)
  final String? badge;

  const DashboardNavItem({
    required this.label,
    required this.href,
    this.icon,
    this.badge,
  });
}

/// A group of navigation items with an optional label
class DashboardNavGroup {
  /// Optional group label (uppercase header)
  final String? label;

  /// The items in this group
  final List<DashboardNavItem> items;

  const DashboardNavGroup({
    this.label,
    required this.items,
  });
}

/// Properties for dashboard layout components.
class DashboardLayoutProps {
  /// The main content to display
  final Component child;

  /// The current route path for active state highlighting
  final String currentRoute;

  /// Navigation groups to display in the sidebar
  final List<DashboardNavGroup> navigation;

  /// Header component for the sidebar (typically a logo)
  final Component? sidebarHeader;

  /// Footer component for the sidebar (typically settings/logout)
  final Component? sidebarFooter;

  /// Top bar component (typically user info/notifications)
  final Component? topBar;

  /// Sidebar width
  final String sidebarWidth;

  /// Background color for the main area
  final String backgroundColor;

  /// Background color for the sidebar
  final String sidebarBackgroundColor;

  const DashboardLayoutProps({
    required this.child,
    required this.currentRoute,
    required this.navigation,
    this.sidebarHeader,
    this.sidebarFooter,
    this.topBar,
    this.sidebarWidth = '256px',
    this.backgroundColor = 'var(--background)',
    this.sidebarBackgroundColor = 'var(--card)',
  });
}

/// Properties for dashboard top bar components.
class DashboardTopBarProps {
  /// Left side content (e.g., breadcrumbs, page title)
  final Component? leading;

  /// Right side content (e.g., notifications, user menu)
  final Component? trailing;

  /// Background color
  final String backgroundColor;

  const DashboardTopBarProps({
    this.leading,
    this.trailing,
    this.backgroundColor = 'var(--card)',
  });
}
