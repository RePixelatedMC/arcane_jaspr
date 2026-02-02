import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/header_props.dart' show NavItemProps, NavLinkProps;

/// Navigation link item.
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

/// Website header/navbar component.
class ArcaneHeader extends StatelessComponent {
  final Component logo;
  final List<ArcaneNavItem> navItems;
  final Component? customNav;
  final List<Component>? actions;
  final bool showSearch;
  final String searchPlaceholder;
  final void Function(String)? onSearch;
  final bool sticky;
  final bool transparent;
  final bool bordered;
  final double? height;

  const ArcaneHeader({
    required this.logo,
    this.navItems = const [],
    this.customNav,
    this.actions,
    this.showSearch = false,
    this.searchPlaceholder = 'Search...',
    this.onSearch,
    this.sticky = true,
    this.transparent = false,
    this.bordered = true,
    this.height,
    super.key,
  });

  /// Creates a header with custom navigation content.
  /// Use this when you need complex dropdowns or custom nav components.
  const ArcaneHeader.custom({
    required this.logo,
    required this.customNav,
    this.actions,
    this.showSearch = false,
    this.searchPlaceholder = 'Search...',
    this.onSearch,
    this.sticky = true,
    this.transparent = false,
    this.bordered = true,
    this.height,
    super.key,
  }) : navItems = const [];

  @override
  Component build(BuildContext context) {
    List<NavItemProps> convertNavItems(List<ArcaneNavItem> items) {
      return items.map((ArcaneNavItem item) => NavItemProps(
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
      customNav: customNav,
      actions: actions,
      showSearch: showSearch,
      searchPlaceholder: searchPlaceholder,
      onSearch: onSearch,
      sticky: sticky,
      transparent: transparent,
      bordered: bordered,
      height: height,
    ));
  }
}

/// Simple nav link component.
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
