import 'package:jaspr/jaspr.dart';

enum SelectSize {
  sm,
  md,
  lg,
}

enum SelectDropdownDirection {
  up,
  down,
}

/// Select option data.
class SelectOptionProps<T> {
  final T value;
  final String label;
  final String? subtitle;
  final String? description;
  final Component? icon;
  final bool disabled;
  final List<String>? searchKeywords;

  const SelectOptionProps({
    required this.value,
    required this.label,
    this.subtitle,
    this.description,
    this.icon,
    this.disabled = false,
    this.searchKeywords,
  });
}

/// Select component properties.
class SelectProps<T> {
  final List<SelectOptionProps<T>> options;
  final T? value;
  final List<T>? values;
  final String placeholder;
  final bool disabled;
  final bool clearable;
  final bool searchable;
  final bool multiSelect;
  final String? label;
  final String? helperText;
  final String? error;
  final SelectSize size;
  final bool required;
  final String? maxDropdownHeight;
  final bool loading;
  final String loadingText;
  final String emptyMessage;
  final String searchPlaceholder;
  final SelectDropdownDirection dropdownDirection;
  final bool closeOnSelect;
  final bool showSelectedCount;
  final Component? prefix;
  final int? maxSelections;
  final bool showCheckboxes;
  final bool isOpen;
  final String searchQuery;
  final List<SelectOptionProps<T>> filteredOptions;
  final void Function()? onToggle;
  final void Function(T value)? onSelect;
  final void Function()? onClear;
  final void Function(String query)? onSearchChange;

  const SelectProps({
    required this.options,
    this.value,
    this.values,
    this.placeholder = 'Select...',
    this.disabled = false,
    this.clearable = false,
    this.searchable = false,
    this.multiSelect = false,
    this.label,
    this.helperText,
    this.error,
    this.size = SelectSize.md,
    this.required = false,
    this.maxDropdownHeight,
    this.loading = false,
    this.loadingText = 'Loading...',
    this.emptyMessage = 'No options found',
    this.searchPlaceholder = 'Search...',
    this.dropdownDirection = SelectDropdownDirection.down,
    this.closeOnSelect = true,
    this.showSelectedCount = true,
    this.prefix,
    this.maxSelections,
    this.showCheckboxes = true,
    this.isOpen = false,
    this.searchQuery = '',
    this.filteredOptions = const [],
    this.onToggle,
    this.onSelect,
    this.onClear,
    this.onSearchChange,
  });
}
