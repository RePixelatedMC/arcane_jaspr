import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export for backwards compatibility
export '../../core/props/header_props.dart' show NavItemProps, NavLinkProps;

/// A navigation link item
class ArcaneNavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<ArcaneNavItem>? children;
  final bool isActive;

  const ArcaneNavItem({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.isActive = false,
  });
}

/// A website header/navbar component
class ArcaneHeader extends StatelessComponent {
  /// Logo component (usually an image or text)
  final Component logo;

  /// Navigation items
  final List<ArcaneNavItem> navItems;

  /// Right-side actions (buttons, etc.)
  final List<Component>? actions;

  /// Whether to show a search bar
  final bool showSearch;

  /// Search placeholder text
  final String searchPlaceholder;

  /// Search callback
  final void Function(String)? onSearch;

  /// Whether the header is fixed/sticky
  final bool sticky;

  /// Whether to use transparent background
  final bool transparent;

  /// Whether to add border bottom
  final bool bordered;

  const ArcaneHeader({
    required this.logo,
    required this.navItems,
    this.actions,
    this.showSearch = false,
    this.searchPlaceholder = 'Search...',
    this.onSearch,
    this.sticky = true,
    this.transparent = false,
    this.bordered = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // Convert ArcaneNavItem to NavItemProps
    List<NavItemProps> convertNavItems(List<ArcaneNavItem> items) {
      return items.map((item) => NavItemProps(
        label: item.label,
        href: item.href,
        onTap: item.onTap,
        children: item.children != null ? convertNavItems(item.children!) : null,
        isActive: item.isActive,
      )).toList();
    }

    return context.renderers.header(HeaderProps(
      logo: logo,
      navItems: convertNavItems(navItems),
      actions: actions,
      showSearch: showSearch,
      searchPlaceholder: searchPlaceholder,
      onSearch: onSearch,
      sticky: sticky,
      transparent: transparent,
      bordered: bordered,
    ));
  }
}

/// A simple nav link component
class ArcaneNavLink extends StatelessComponent {
  final String label;
  final String? href;
  final void Function()? onTap;
  final bool isActive;
  final bool showArrow;

  const ArcaneNavLink({
    required this.label,
    this.href,
    this.onTap,
    this.isActive = false,
    this.showArrow = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.navLink(NavLinkProps(
      label: label,
      href: href,
      onTap: onTap,
      isActive: isActive,
      showArrow: showArrow,
    ));
  }
}
