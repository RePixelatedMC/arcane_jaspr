import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/bottom_navigation_props.dart';

/// Bottom navigation item.
class ArcaneBottomNavItem {
  final String label;
  final Component icon;
  final Component? activeIcon;
  final String? badge;

  const ArcaneBottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badge,
  });
}

/// Bottom navigation bar component.
class ArcaneBottomNavigationBar extends StatelessComponent {
  final List<ArcaneBottomNavItem> items;
  final int selectedIndex;
  final void Function(int index)? onChanged;
  final bool showLabels;
  final bool showSelectedLabels;
  final double height;

  const ArcaneBottomNavigationBar({
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.showLabels = true,
    this.showSelectedLabels = false,
    this.height = 64,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.bottomNavigationBar(BottomNavigationBarProps(
      items: items
          .map((item) => BottomNavItem(
                label: item.label,
                icon: item.icon,
                activeIcon: item.activeIcon,
                badge: item.badge,
              ))
          .toList(),
      selectedIndex: selectedIndex,
      onChanged: onChanged,
      showLabels: showLabels,
      showSelectedLabels: showSelectedLabels,
      height: height,
    ));
  }
}

/// Fixed position bottom bar container.
class ArcaneBottomBar extends StatelessComponent {
  final Component child;
  final bool safeArea;

  const ArcaneBottomBar({
    required this.child,
    this.safeArea = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.bottomBar(BottomBarProps(
      child: child,
      safeArea: safeArea,
    ));
  }
}
