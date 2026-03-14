import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;

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
  final List<MobileNavItem> items;
  final Widget? logo;
  final Widget? cta;
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
