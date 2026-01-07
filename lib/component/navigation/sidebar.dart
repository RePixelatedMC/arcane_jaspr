import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/sidebar_props.dart'
    show SidebarItemProps, SidebarGroupProps, SidebarSubMenuProps;

/// A sidebar navigation component matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/sidebar
///
/// A composable sidebar navigation component for application layouts.
class ArcaneSidebar extends StatefulComponent {
  /// The sidebar content
  final List<Component> children;

  /// Header component
  final Component? header;

  /// Footer component
  final Component? footer;

  /// Whether the sidebar is collapsed
  final bool collapsed;

  /// Callback when collapse state changes
  final void Function(bool collapsed)? onCollapseChanged;

  /// Width of the sidebar
  final double width;

  /// Width when collapsed
  final double collapsedWidth;

  /// Whether to show the collapse toggle
  final bool showCollapseToggle;

  /// Whether the sidebar is on the right side
  final bool rightSide;

  const ArcaneSidebar({
    required this.children,
    this.header,
    this.footer,
    this.collapsed = false,
    this.onCollapseChanged,
    this.width = 280,
    this.collapsedWidth = 64,
    this.showCollapseToggle = true,
    this.rightSide = false,
    super.key,
  });

  @override
  State<ArcaneSidebar> createState() => _ArcaneSidebarState();
}

class _ArcaneSidebarState extends State<ArcaneSidebar> {
  late bool _isCollapsed;

  @override
  void initState() {
    super.initState();
    _isCollapsed = component.collapsed;
  }

  @override
  void didUpdateComponent(ArcaneSidebar oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.collapsed != component.collapsed) {
      _isCollapsed = component.collapsed;
    }
  }

  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
    component.onCollapseChanged?.call(_isCollapsed);
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.sidebar(SidebarProps(
      children: component.children,
      header: component.header,
      footer: component.footer,
      isCollapsed: _isCollapsed,
      onCollapseChanged: component.onCollapseChanged,
      width: component.width,
      collapsedWidth: component.collapsedWidth,
      showCollapseToggle: component.showCollapseToggle,
      rightSide: component.rightSide,
      onToggleCollapse: _toggleCollapse,
    ));
  }
}

/// A sidebar item group with optional label matching shadcn/ui.
class ArcaneSidebarGroup extends StatelessComponent {
  final String? label;
  final List<Component> children;
  final bool collapsed;

  const ArcaneSidebarGroup({
    this.label,
    required this.children,
    this.collapsed = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.sidebarGroup(SidebarGroupProps(
      label: label,
      children: children,
      collapsed: collapsed,
    ));
  }
}

/// A sidebar navigation item matching shadcn/ui.
class ArcaneSidebarItem extends StatelessComponent {
  final String label;
  final Component? icon;
  final void Function()? onTap;
  final String? href;
  final bool selected;
  final bool disabled;
  final String? badge;
  final bool collapsed;
  final String? tooltip;

  const ArcaneSidebarItem({
    required this.label,
    this.icon,
    this.onTap,
    this.href,
    this.selected = false,
    this.disabled = false,
    this.badge,
    this.collapsed = false,
    this.tooltip,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.sidebarItem(SidebarItemProps(
      label: label,
      icon: icon,
      onTap: onTap,
      href: href,
      selected: selected,
      disabled: disabled,
      badge: badge,
      collapsed: collapsed,
      tooltip: tooltip,
    ));
  }
}

/// Content that only displays when sidebar is expanded.
///
/// Use this to show full labels, descriptions, or complex content
/// that should be hidden when the sidebar collapses.
class ArcaneSidebarExpanded extends StatelessComponent {
  final List<Component> children;

  const ArcaneSidebarExpanded({
    required this.children,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.sidebarExpanded(children);
  }
}

/// Content that only displays when sidebar is collapsed.
///
/// Use this to show icons, tooltips, or minimal content
/// that should only appear when the sidebar is collapsed.
class ArcaneSidebarCollapsed extends StatelessComponent {
  final List<Component> children;

  const ArcaneSidebarCollapsed({
    required this.children,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.sidebarCollapsed(children);
  }
}

/// A visual separator between sidebar groups or items.
class ArcaneSidebarSeparator extends StatelessComponent {
  const ArcaneSidebarSeparator({super.key});

  @override
  Component build(BuildContext context) {
    return context.renderers.sidebarSeparator();
  }
}

/// A collapsible submenu within a sidebar item.
///
/// Use this for nested navigation structures where a parent item
/// can expand to reveal child items.
class ArcaneSidebarSubMenu extends StatefulComponent {
  final String label;
  final Component? icon;
  final List<Component> children;
  final bool defaultOpen;
  final bool collapsed;
  final String? badge;

  const ArcaneSidebarSubMenu({
    required this.label,
    required this.children,
    this.icon,
    this.defaultOpen = false,
    this.collapsed = false,
    this.badge,
    super.key,
  });

  @override
  State<ArcaneSidebarSubMenu> createState() => _ArcaneSidebarSubMenuState();
}

class _ArcaneSidebarSubMenuState extends State<ArcaneSidebarSubMenu> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = component.defaultOpen;
  }

  void _toggle() {
    setState(() => _isOpen = !_isOpen);
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.sidebarSubMenu(SidebarSubMenuProps(
      label: component.label,
      icon: component.icon,
      children: component.children,
      isOpen: _isOpen,
      onToggle: _toggle,
      collapsed: component.collapsed,
      badge: component.badge,
    ));
  }
}
