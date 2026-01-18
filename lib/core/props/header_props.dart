import 'package:jaspr/jaspr.dart';

/// Navigation item data.
class NavItemProps {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<NavItemProps>? children;
  final bool isActive;

  const NavItemProps({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.isActive = false,
  });
}

/// Header/navbar component properties.
class HeaderProps {
  final Component logo;
  final List<NavItemProps> navItems;
  final List<Component>? actions;
  final bool showSearch;
  final String searchPlaceholder;
  final void Function(String)? onSearch;
  final bool sticky;
  final bool transparent;
  final bool bordered;

  const HeaderProps({
    required this.logo,
    required this.navItems,
    this.actions,
    this.showSearch = false,
    this.searchPlaceholder = 'Search...',
    this.onSearch,
    this.sticky = true,
    this.transparent = false,
    this.bordered = true,
  });
}

/// Navigation link component properties.
class NavLinkProps {
  final String label;
  final String? href;
  final void Function()? onTap;
  final bool isActive;
  final bool showArrow;

  const NavLinkProps({
    required this.label,
    this.href,
    this.onTap,
    this.isActive = false,
    this.showArrow = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for header components.
mixin HeaderRendererContract {
  /// Renders the main header/navbar component.
  Component header(HeaderProps props);

  /// Renders a navigation link.
  Component navLink(NavLinkProps props);
}
