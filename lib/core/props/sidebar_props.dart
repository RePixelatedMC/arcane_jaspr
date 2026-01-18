import 'package:jaspr/jaspr.dart';

/// Sidebar item component properties.
class SidebarItemProps {
  final String label;
  final Component? icon;
  final void Function()? onTap;
  final String? href;
  final bool selected;
  final bool disabled;
  final String? badge;
  final bool collapsed;
  final String? tooltip;

  const SidebarItemProps({
    required this.label,
    this.icon,
    this.onTap,
    this.href,
    this.selected = false,
    this.disabled = false,
    this.badge,
    this.collapsed = false,
    this.tooltip,
  });
}

/// Sidebar group component properties.
class SidebarGroupProps {
  final String? label;
  final List<Component> children;
  final bool collapsed;

  const SidebarGroupProps({
    this.label,
    required this.children,
    this.collapsed = false,
  });
}

/// Sidebar submenu component properties (collapsible section).
///
/// Uses native `<details>/<summary>` for static-site-friendly collapsibles.
class SidebarSubMenuProps {
  final String label;
  final Component? icon;
  final List<Component> children;

  /// Whether the section is open by default (sets `open` attribute on `<details>`).
  final bool defaultOpen;
  final bool collapsed;
  final String? badge;

  const SidebarSubMenuProps({
    required this.label,
    required this.children,
    this.icon,
    this.defaultOpen = false,
    this.collapsed = false,
    this.badge,
  });
}

/// Sidebar section component properties (fixed, non-collapsible section).
///
/// For sections that are always expanded with a header.
class SidebarSectionProps {
  final String label;
  final Component? icon;
  final List<Component> children;

  const SidebarSectionProps({
    required this.label,
    this.icon,
    required this.children,
  });
}

/// Sidebar component properties.
class SidebarProps {
  final List<Component> children;
  final Component? header;
  final Component? footer;
  final bool isCollapsed;
  final void Function(bool collapsed)? onCollapseChanged;
  final double width;
  final double collapsedWidth;
  final bool showCollapseToggle;
  final bool rightSide;
  final void Function()? onToggleCollapse;

  const SidebarProps({
    required this.children,
    this.header,
    this.footer,
    this.isCollapsed = false,
    this.onCollapseChanged,
    this.width = 280,
    this.collapsedWidth = 64,
    this.showCollapseToggle = true,
    this.rightSide = false,
    this.onToggleCollapse,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for sidebar components.
mixin SidebarRendererContract {
  /// Renders the main sidebar container.
  Component sidebar(SidebarProps props);

  /// Renders a sidebar navigation item.
  Component sidebarItem(SidebarItemProps props);

  /// Renders a sidebar group with optional label.
  Component sidebarGroup(SidebarGroupProps props);

  /// Renders a collapsible sidebar submenu.
  Component sidebarSubMenu(SidebarSubMenuProps props);

  /// Renders a fixed (non-collapsible) sidebar section.
  Component sidebarSection(SidebarSectionProps props);

  /// Renders content shown when sidebar is expanded.
  Component sidebarExpanded(List<Component> children);

  /// Renders content shown when sidebar is collapsed.
  Component sidebarCollapsed(List<Component> children);

  /// Renders a sidebar separator.
  Component sidebarSeparator();
}
