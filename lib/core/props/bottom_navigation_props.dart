import 'package:jaspr/jaspr.dart';

/// A bottom navigation item
class BottomNavItem {
  final String label;
  final Component icon;
  final Component? activeIcon;
  final String? badge;

  const BottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badge,
  });
}

/// Properties for bottom navigation bar components.
class BottomNavigationBarProps {
  /// The navigation items
  final List<BottomNavItem> items;

  /// The currently selected index
  final int selectedIndex;

  /// Callback when selection changes
  final void Function(int index)? onChanged;

  /// Whether to show labels
  final bool showLabels;

  /// Whether to show labels only when selected
  final bool showSelectedLabels;

  /// Height of the navigation bar
  final double height;

  const BottomNavigationBarProps({
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.showLabels = true,
    this.showSelectedLabels = false,
    this.height = 64,
  });
}

/// Properties for bottom bar container components.
class BottomBarProps {
  final Component child;
  final bool safeArea;

  const BottomBarProps({
    required this.child,
    this.safeArea = true,
  });
}
