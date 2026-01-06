import 'package:jaspr/jaspr.dart';

/// Mobile navigation item
class MobileNavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<MobileNavItem>? children;
  final Component? icon;

  const MobileNavItem({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.icon,
  });
}

/// Properties for mobile menu components.
class MobileMenuProps {
  /// Navigation items
  final List<MobileNavItem> items;

  /// Optional logo
  final Component? logo;

  /// Optional CTA button
  final Component? cta;

  /// Close callback
  final void Function()? onClose;

  /// Whether the menu is open
  final bool isOpen;

  const MobileMenuProps({
    required this.items,
    this.logo,
    this.cta,
    this.onClose,
    this.isOpen = false,
  });
}

/// Properties for hamburger button components.
class HamburgerButtonProps {
  /// Whether the menu is open
  final bool isOpen;

  /// Click handler
  final void Function()? onTap;

  /// Size
  final double size;

  const HamburgerButtonProps({
    this.isOpen = false,
    this.onTap,
    this.size = 24,
  });
}
