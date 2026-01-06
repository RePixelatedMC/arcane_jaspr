import 'package:jaspr/jaspr.dart';

/// Tab item data for tabs components.
class TabItemProps {
  /// Display label for the tab
  final String label;

  /// Content to show when tab is selected
  final Component content;

  /// Optional icon
  final Component? icon;

  /// Optional badge text
  final String? badge;

  /// Whether this tab is disabled
  final bool disabled;

  const TabItemProps({
    required this.label,
    required this.content,
    this.icon,
    this.badge,
    this.disabled = false,
  });
}

/// Tab bar item data (for tab bar without content).
class TabBarItemProps {
  /// Display label for the tab
  final String label;

  /// Optional icon
  final Component? icon;

  const TabBarItemProps({
    required this.label,
    this.icon,
  });
}

/// Properties for tabs components.
class TabsProps {
  /// The tab items
  final List<TabItemProps> tabs;

  /// Currently selected tab index
  final int selectedIndex;

  /// Callback when tab changes
  final void Function(int index)? onChanged;

  /// Whether tabs fill available width
  final bool fill;

  const TabsProps({
    required this.tabs,
    required this.selectedIndex,
    this.onChanged,
    this.fill = false,
  });

  /// Create a copy with modified properties
  TabsProps copyWith({
    List<TabItemProps>? tabs,
    int? selectedIndex,
    void Function(int index)? onChanged,
    bool? fill,
  }) {
    return TabsProps(
      tabs: tabs ?? this.tabs,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      onChanged: onChanged ?? this.onChanged,
      fill: fill ?? this.fill,
    );
  }
}

/// Properties for tab bar components (tabs without content).
class TabBarProps {
  /// The tab items
  final List<TabBarItemProps> tabs;

  /// Currently selected tab index
  final int selectedIndex;

  /// Callback when tab changes
  final void Function(int index) onChanged;

  /// Whether tabs fill available width
  final bool fill;

  const TabBarProps({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.fill = false,
  });

  /// Create a copy with modified properties
  TabBarProps copyWith({
    List<TabBarItemProps>? tabs,
    int? selectedIndex,
    void Function(int index)? onChanged,
    bool? fill,
  }) {
    return TabBarProps(
      tabs: tabs ?? this.tabs,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      onChanged: onChanged ?? this.onChanged,
      fill: fill ?? this.fill,
    );
  }
}
