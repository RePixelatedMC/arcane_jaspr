import 'package:jaspr/jaspr.dart';

/// Props for a sidebar item
class SidebarItemProps {
  /// Display label
  final String label;

  /// Optional icon component
  final Component? icon;

  /// Click handler
  final void Function()? onTap;

  /// Optional href for navigation items
  final String? href;

  /// Whether this item is selected/active
  final bool selected;

  /// Whether this item is disabled
  final bool disabled;

  /// Optional badge text
  final String? badge;

  /// Whether the sidebar is collapsed (affects display)
  final bool collapsed;

  /// Tooltip text (shown on hover when collapsed)
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

/// Props for a sidebar group
class SidebarGroupProps {
  /// Optional label for the group
  final String? label;

  /// Items in this group (rendered as SidebarItemProps)
  final List<Component> children;

  /// Whether the sidebar is collapsed
  final bool collapsed;

  const SidebarGroupProps({
    this.label,
    required this.children,
    this.collapsed = false,
  });
}

/// Props for a sidebar submenu (collapsible nested items)
class SidebarSubMenuProps {
  /// Label for the submenu trigger
  final String label;

  /// Optional icon component
  final Component? icon;

  /// Child items in the submenu
  final List<Component> children;

  /// Whether the submenu is currently open
  final bool isOpen;

  /// Toggle handler for open/close
  final void Function()? onToggle;

  /// Whether the sidebar is collapsed
  final bool collapsed;

  /// Optional badge text
  final String? badge;

  const SidebarSubMenuProps({
    required this.label,
    required this.children,
    this.icon,
    this.isOpen = false,
    this.onToggle,
    this.collapsed = false,
    this.badge,
  });
}

/// Props for the sidebar component
class SidebarProps {
  /// Main content children
  final List<Component> children;

  /// Optional header component
  final Component? header;

  /// Optional footer component
  final Component? footer;

  /// Whether the sidebar is collapsed
  final bool isCollapsed;

  /// Callback when collapse state changes
  final void Function(bool collapsed)? onCollapseChanged;

  /// Width of the sidebar when expanded
  final double width;

  /// Width when collapsed
  final double collapsedWidth;

  /// Whether to show the collapse toggle button
  final bool showCollapseToggle;

  /// Whether the sidebar is on the right side
  final bool rightSide;

  /// Internal toggle handler (for state management in wrapper)
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
