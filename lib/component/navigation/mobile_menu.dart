import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/mobile_menu_props.dart';

/// Mobile navigation item
class ArcaneMobileNavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<ArcaneMobileNavItem>? children;
  final Component? icon;

  const ArcaneMobileNavItem({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.icon,
  });
}

/// A mobile hamburger menu (Supabase-style)
class ArcaneMobileMenu extends StatelessComponent {
  /// Navigation items
  final List<ArcaneMobileNavItem> items;

  /// Optional logo
  final Component? logo;

  /// Optional CTA button
  final Component? cta;

  /// Close callback
  final void Function()? onClose;

  /// Whether the menu is open
  final bool isOpen;

  const ArcaneMobileMenu({
    required this.items,
    this.logo,
    this.cta,
    this.onClose,
    this.isOpen = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.mobileMenu(MobileMenuProps(
      items: _convertItems(items),
      logo: logo,
      cta: cta,
      onClose: onClose,
      isOpen: isOpen,
    ));
  }

  List<MobileNavItem> _convertItems(List<ArcaneMobileNavItem> items) {
    return items
        .map((item) => MobileNavItem(
              label: item.label,
              href: item.href,
              onTap: item.onTap,
              children: item.children != null
                  ? _convertItems(item.children!)
                  : null,
              icon: item.icon,
            ))
        .toList();
  }
}

/// Hamburger menu button
class ArcaneHamburgerButton extends StatelessComponent {
  /// Whether the menu is open
  final bool isOpen;

  /// Click handler
  final void Function()? onTap;

  /// Size
  final double size;

  const ArcaneHamburgerButton({
    this.isOpen = false,
    this.onTap,
    this.size = 24,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.hamburgerButton(HamburgerButtonProps(
      isOpen: isOpen,
      onTap: onTap,
      size: size,
    ));
  }
}
