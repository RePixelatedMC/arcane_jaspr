import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for backwards compatibility
export '../../core/props/select_props.dart'
    show SelectSize, SelectProps, SelectOptionProps;

/// An autocomplete combobox with search filtering.
///
/// Combines a text input with a dropdown of filterable options.
///
/// Example:
/// ```dart
/// ArcaneCombobox<String>(
///   options: [
///     ComboboxOption(value: 'apple', label: 'Apple'),
///     ComboboxOption(value: 'banana', label: 'Banana'),
///     ComboboxOption(value: 'cherry', label: 'Cherry'),
///   ],
///   value: selectedFruit,
///   onChanged: (fruit) => setState(() => selectedFruit = fruit),
///   placeholder: 'Select a fruit...',
/// )
/// ```
class ArcaneCombobox<T> extends StatefulComponent {
  /// Available options
  final List<ComboboxOption<T>> options;

  /// Currently selected value
  final T? value;

  /// Called when selection changes
  final void Function(T?)? onChanged;

  /// Placeholder text when no selection
  final String? placeholder;

  /// Search input placeholder
  final String? searchPlaceholder;

  /// Whether to show the search input
  final bool searchable;

  /// Custom display function for selected value
  final String Function(T)? displayValue;

  /// Custom filter function
  final bool Function(ComboboxOption<T>, String)? filterFn;

  /// Empty state message
  final String emptyMessage;

  /// Whether the combobox is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Label above the combobox
  final String? label;

  /// Size variant
  final ComboboxSize size;

  const ArcaneCombobox({
    required this.options,
    this.value,
    this.onChanged,
    this.placeholder,
    this.searchPlaceholder,
    this.searchable = true,
    this.displayValue,
    this.filterFn,
    this.emptyMessage = 'No results found',
    this.disabled = false,
    this.error,
    this.label,
    this.size = ComboboxSize.md,
    super.key,
  });

  @override
  State<ArcaneCombobox<T>> createState() => _ArcaneComboboxState<T>();
}

class _ArcaneComboboxState<T> extends State<ArcaneCombobox<T>> {
  bool _isOpen = false;
  String _searchQuery = '';

  List<ComboboxOption<T>> get _filteredOptions {
    if (_searchQuery.isEmpty) return component.options;

    final query = _searchQuery.toLowerCase();
    return component.options.where((option) {
      if (component.filterFn != null) {
        return component.filterFn!(option, _searchQuery);
      }
      return option.label.toLowerCase().contains(query) ||
          (option.keywords?.any((k) => k.toLowerCase().contains(query)) ??
              false);
    }).toList();
  }

  void _toggleOpen() {
    if (component.disabled) return;
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _searchQuery = '';
      }
    });
  }

  void _selectOption(T value) {
    component.onChanged?.call(value);
    setState(() {
      _isOpen = false;
      _searchQuery = '';
    });
  }

  void _handleSearch(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  SelectSize get _propsSize => switch (component.size) {
        ComboboxSize.sm => SelectSize.sm,
        ComboboxSize.md => SelectSize.md,
        ComboboxSize.lg => SelectSize.lg,
      };

  @override
  Component build(BuildContext context) {
    // Convert ComboboxOption to SelectOptionProps
    final selectOptions = component.options.map((opt) => SelectOptionProps<T>(
      value: opt.value,
      label: opt.label,
      description: opt.description,
      icon: opt.icon,
      disabled: opt.disabled,
      searchKeywords: opt.keywords,
    )).toList();

    final filteredSelectOptions = _filteredOptions.map((opt) => SelectOptionProps<T>(
      value: opt.value,
      label: opt.label,
      description: opt.description,
      icon: opt.icon,
      disabled: opt.disabled,
      searchKeywords: opt.keywords,
    )).toList();

    return context.renderers.select<T>(SelectProps<T>(
      options: selectOptions,
      value: component.value,
      placeholder: component.placeholder ?? 'Select...',
      disabled: component.disabled,
      searchable: component.searchable,
      label: component.label,
      error: component.error,
      size: _propsSize,
      emptyMessage: component.emptyMessage,
      searchPlaceholder: component.searchPlaceholder ?? 'Search...',
      isOpen: _isOpen,
      searchQuery: _searchQuery,
      filteredOptions: filteredSelectOptions,
      onToggle: _toggleOpen,
      onSelect: _selectOption,
      onSearchChange: _handleSearch,
    ));
  }
}

/// A combobox option
class ComboboxOption<T> {
  /// The option's value
  final T value;

  /// Display label
  final String label;

  /// Optional description
  final String? description;

  /// Optional icon
  final Component? icon;

  /// Whether this option is disabled
  final bool disabled;

  /// Additional keywords for searching
  final List<String>? keywords;

  const ComboboxOption({
    required this.value,
    required this.label,
    this.description,
    this.icon,
    this.disabled = false,
    this.keywords,
  });
}

/// Size variants for combobox
enum ComboboxSize {
  sm,
  md,
  lg,
}

