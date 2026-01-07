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

/// Sidebar submenu component properties.
class SidebarSubMenuProps {
  final String label;
  final Component? icon;
  final List<Component> children;
  final bool isOpen;
  final void Function()? onToggle;
  final bool collapsed;
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
