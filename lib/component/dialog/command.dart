import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/command_props.dart'
    show CommandItemProps, CommandGroupProps;

/// Command palette for quick actions and navigation.
class ArcaneCommand extends StatefulComponent {
  final bool isOpen;
  final void Function()? onClose;
  final List<CommandGroup> groups;
  final String placeholder;
  final String emptyMessage;
  final void Function(String)? onSearch;
  final bool Function(CommandItem, String)? filterFn;

  const ArcaneCommand({
    required this.groups,
    this.isOpen = false,
    this.onClose,
    this.placeholder = 'Type a command or search...',
    this.emptyMessage = 'No results found.',
    this.onSearch,
    this.filterFn,
    super.key,
  });

  @override
  State<ArcaneCommand> createState() => _ArcaneCommandState();
}

class _ArcaneCommandState extends State<ArcaneCommand> {
  String _searchQuery = '';

  List<CommandItem> get _allItems {
    return component.groups.expand((g) => g.items).toList();
  }

  List<CommandItem> get _filteredItems {
    if (_searchQuery.isEmpty) return _allItems;

    final query = _searchQuery.toLowerCase();
    return _allItems.where((item) {
      if (component.filterFn != null) {
        return component.filterFn!(item, _searchQuery);
      }
      return item.label.toLowerCase().contains(query) ||
          (item.keywords?.any((k) => k.toLowerCase().contains(query)) ?? false);
    }).toList();
  }

  void _handleSearch(String value) {
    setState(() {
      _searchQuery = value;
    });
    component.onSearch?.call(value);
  }

  void _selectItem(CommandItemProps item) {
    item.onSelect?.call();
    component.onClose?.call();
  }

  @override
  Component build(BuildContext context) {
    final groupProps = component.groups
        .map((g) => CommandGroupProps(
              heading: g.heading,
              items: g.items
                  .map((i) => CommandItemProps(
                        label: i.label,
                        icon: i.icon,
                        shortcut: i.shortcut,
                        onSelect: i.onSelect,
                        disabled: i.disabled,
                        keywords: i.keywords,
                      ))
                  .toList(),
            ))
        .toList();

    final filteredItemProps = _filteredItems
        .map((i) => CommandItemProps(
              label: i.label,
              icon: i.icon,
              shortcut: i.shortcut,
              onSelect: i.onSelect,
              disabled: i.disabled,
              keywords: i.keywords,
            ))
        .toList();

    return context.renderers.command(CommandProps(
      isOpen: component.isOpen,
      onClose: component.onClose,
      groups: groupProps,
      placeholder: component.placeholder,
      emptyMessage: component.emptyMessage,
      searchQuery: _searchQuery,
      filteredItems: filteredItemProps,
      onSearch: _handleSearch,
      onSelectItem: _selectItem,
    ));
  }
}

/// A group of related commands.
class CommandGroup {
  final String? heading;
  final List<CommandItem> items;

  const CommandGroup({
    this.heading,
    required this.items,
  });
}

/// A single command item.
class CommandItem {
  final String label;
  final Component? icon;
  final String? shortcut;
  final void Function()? onSelect;
  final bool disabled;
  final List<String>? keywords;

  const CommandItem({
    required this.label,
    this.icon,
    this.shortcut,
    this.onSelect,
    this.disabled = false,
    this.keywords,
  });
}
