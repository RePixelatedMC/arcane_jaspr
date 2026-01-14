import 'package:jaspr/jaspr.dart';

/// Command item data.
class CommandItemProps {
  final String label;
  final Component? icon;
  final String? shortcut;
  final void Function()? onSelect;
  final bool disabled;
  final List<String>? keywords;

  /// Optional href for JavaScript-based navigation.
  /// When set, clicking the item will navigate to this URL.
  /// Use '_blank' target by setting [hrefTarget].
  final String? href;

  /// Target for href navigation (e.g., '_blank' for new tab).
  final String? hrefTarget;

  const CommandItemProps({
    required this.label,
    this.icon,
    this.shortcut,
    this.onSelect,
    this.disabled = false,
    this.keywords,
    this.href,
    this.hrefTarget,
  });
}

/// Command group data.
class CommandGroupProps {
  final String? heading;
  final List<CommandItemProps> items;

  const CommandGroupProps({
    this.heading,
    required this.items,
  });
}

/// Command palette component properties.
class CommandProps {
  final bool isOpen;
  final void Function()? onClose;
  final List<CommandGroupProps> groups;
  final String placeholder;
  final String emptyMessage;
  final String searchQuery;
  final List<CommandItemProps> filteredItems;
  final void Function(String)? onSearch;
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
