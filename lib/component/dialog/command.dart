import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/command_props.dart'
    show CommandItemProps, CommandGroupProps;

/// A command palette for quick actions and navigation.
///
/// Similar to VS Code's Command Palette or Spotlight.
///
/// Example:
/// ```dart
/// ArcaneCommand(
///   isOpen: showCommand,
///   onClose: () => setState(() => showCommand = false),
///   groups: [
///     CommandGroup(
///       heading: 'Actions',
///       items: [
///         CommandItem(
///           icon: span([Component.text('\u{1F4DD}')]),
///           label: 'New Document',
///           shortcut: '\u{2318}N',
///           onSelect: () => createDoc(),
///         ),
///         CommandItem(
///           icon: span([Component.text('\u{1F50D}')]),
///           label: 'Search',
///           shortcut: '\u{2318}K',
///           onSelect: () => openSearch(),
///         ),
///       ],
///     ),
///   ],
/// )
/// ```
class ArcaneCommand extends StatefulComponent {
  /// Whether the command palette is open
  final bool isOpen;

  /// Called when palette should close
  final void Function()? onClose;

  /// Command groups to display
  final List<CommandGroup> groups;

  /// Placeholder for the search input
  final String placeholder;

  /// Empty state message
  final String emptyMessage;

  /// Called when search value changes
  final void Function(String)? onSearch;

  /// Custom filter function
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
    // Convert CommandGroup to CommandGroupProps
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

    // Convert filtered items to props
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

    // Delegate rendering to the current stylesheet's command renderer
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

/// A group of related commands
class CommandGroup {
  /// Group heading
  final String? heading;

  /// Items in this group
  final List<CommandItem> items;

  const CommandGroup({
    this.heading,
    required this.items,
  });
}

/// A single command item
class CommandItem {
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

  const CommandItem({
    required this.label,
    this.icon,
    this.shortcut,
    this.onSelect,
    this.disabled = false,
    this.keywords,
  });
}
