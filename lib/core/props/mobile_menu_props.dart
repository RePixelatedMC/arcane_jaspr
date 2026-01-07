import 'package:jaspr/jaspr.dart';

/// Mobile navigation item data.
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

/// Mobile menu component properties.
class MobileMenuProps {
  final List<MobileNavItem> items;
  final Component? logo;
  final Component? cta;
  final void Function()? onClose;
  final bool isOpen;

  const MobileMenuProps({
    required this.items,
    this.logo,
    this.cta,
    this.onClose,
    this.isOpen = false,
  });
}

/// Hamburger button component properties.
class HamburgerButtonProps {
  final bool isOpen;
  final void Function()? onTap;
  final double size;

  const HamburgerButtonProps({
    this.isOpen = false,
    this.onTap,
    this.size = 24,
  });
}
