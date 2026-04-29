import 'package:arcane_jaspr/flutter.dart';

/// Mobile navigation item data.
class MobileNavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<MobileNavItem>? children;
  final Widget? icon;

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
  final String id;
  final List<MobileNavItem> items;
  final Widget? logo;
  final Widget? cta;
  final void Function()? onClose;
  final bool isOpen;
  final bool escapeCloses;
  final bool focusTrap;
  final bool restoreFocus;

  const MobileMenuProps({
    required this.id,
    required this.items,
    this.logo,
    this.cta,
    this.onClose,
    this.isOpen = false,
    this.escapeCloses = true,
    this.focusTrap = true,
    this.restoreFocus = true,
  });
}

/// Hamburger button component properties.
class HamburgerButtonProps {
  final String? targetMenuId;
  final bool isOpen;
  final void Function()? onTap;
  final double size;

  const HamburgerButtonProps({
    this.targetMenuId,
    this.isOpen = false,
    this.onTap,
    this.size = 24,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for mobile menu components.
mixin MobileMenuRendererContract {
  /// Renders a mobile navigation menu.
  Widget mobileMenu(MobileMenuProps props);

  /// Renders a hamburger menu button.
  Widget hamburgerButton(HamburgerButtonProps props);
}
