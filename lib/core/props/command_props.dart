import 'package:jaspr/jaspr.dart';

/// A single command item.
class CommandItemProps {
  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Keyboard shortcut hint
  final String? shortcut;

  /// Called when item is selected
  final void Function()? onSelect;

  /// Whether this item is disabled
  final bool disabled;

  /// Additional search keywords
  final List<String>? keywords;

  const CommandItemProps({
    required this.label,
    this.icon,
    this.shortcut,
    this.onSelect,
    this.disabled = false,
    this.keywords,
  });
}

/// A group of related commands.
class CommandGroupProps {
  /// Group heading
  final String? heading;

  /// Items in this group
  final List<CommandItemProps> items;

  const CommandGroupProps({
    this.heading,
    required this.items,
  });
}

/// Properties for command palette components.
class CommandProps {
  /// Whether the command palette is open
  final bool isOpen;

  /// Called when palette should close
  final void Function()? onClose;

  /// Command groups to display
  final List<CommandGroupProps> groups;

  /// Placeholder for the search input
  final String placeholder;

  /// Empty state message
  final String emptyMessage;

  /// Current search query
  final String searchQuery;

  /// Filtered items based on search
  final List<CommandItemProps> filteredItems;

  /// Called when search value changes
  final void Function(String)? onSearch;

  /// Called when an item is selected
  final void Function(CommandItemProps)? onSelectItem;

  const CommandProps({
    required this.isOpen,
    required this.groups,
    this.onClose,
    this.placeholder = 'Type a command or search...',
    this.emptyMessage = 'No results found.',
    this.searchQuery = '',
    this.filteredItems = const [],
    this.onSearch,
    this.onSelectItem,
  });

  /// Create a copy with modified properties
  CommandProps copyWith({
    bool? isOpen,
    void Function()? onClose,
    List<CommandGroupProps>? groups,
    String? placeholder,
    String? emptyMessage,
    String? searchQuery,
    List<CommandItemProps>? filteredItems,
    void Function(String)? onSearch,
    void Function(CommandItemProps)? onSelectItem,
  }) {
    return CommandProps(
      isOpen: isOpen ?? this.isOpen,
      onClose: onClose ?? this.onClose,
      groups: groups ?? this.groups,
      placeholder: placeholder ?? this.placeholder,
      emptyMessage: emptyMessage ?? this.emptyMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      filteredItems: filteredItems ?? this.filteredItems,
      onSearch: onSearch ?? this.onSearch,
      onSelectItem: onSelectItem ?? this.onSelectItem,
    );
  }
}
