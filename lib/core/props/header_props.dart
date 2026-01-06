import 'package:jaspr/jaspr.dart';

/// Props for a navigation item in the header
class NavItemProps {
  /// Display label
  final String label;

  /// Navigation href (for links)
  final String? href;

  /// Click handler (for buttons)
  final void Function()? onTap;

  /// Child navigation items (for dropdowns)
  final List<NavItemProps>? children;

  /// Whether this item is active/selected
  final bool isActive;

  const NavItemProps({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.isActive = false,
  });
}

/// Props for the header/navbar component
class HeaderProps {
  /// Logo component
  final Component logo;

  /// Navigation items
  final List<NavItemProps> navItems;

  /// Right-side action components (buttons, etc.)
  final List<Component>? actions;

  /// Whether to show a search bar
  final bool showSearch;

  /// Search input placeholder
  final String searchPlaceholder;

  /// Search callback
  final void Function(String)? onSearch;

  /// Whether the header is sticky
  final bool sticky;

  /// Whether to use transparent background
  final bool transparent;

  /// Whether to show border bottom
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

/// Props for a standalone navigation link
class NavLinkProps {
  /// Display label
  final String label;

  /// Navigation href
  final String? href;

  /// Click handler
  final void Function()? onTap;

  /// Whether this link is active
  final bool isActive;

  /// Whether to show arrow indicator
  final bool showArrow;

  const NavLinkProps({
    required this.label,
    this.href,
    this.onTap,
    this.isActive = false,
    this.showArrow = false,
  });
}
