import 'package:jaspr/jaspr.dart';

/// Size variants for select
enum SelectSize {
  sm,
  md,
  lg,
}

/// Dropdown direction for select
enum SelectDropdownDirection {
  up,
  down,
}

/// Props for a select option
class SelectOptionProps<T> {
  /// The value
  final T value;

  /// Display label
  final String label;

  /// Optional subtitle
  final String? subtitle;

  /// Optional description (shown on right)
  final String? description;

  /// Optional icon
  final Component? icon;

  /// Whether disabled
  final bool disabled;

  /// Search keywords
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

/// Props for the select/selector component
class SelectProps<T> {
  /// Available options
  final List<SelectOptionProps<T>> options;

  /// Current value (single select)
  final T? value;

  /// Current values (multi-select)
  final List<T>? values;

  /// Placeholder text
  final String placeholder;

  /// Whether disabled
  final bool disabled;

  /// Whether clearable
  final bool clearable;

  /// Whether searchable
  final bool searchable;

  /// Whether multi-select
  final bool multiSelect;

  /// Label text
  final String? label;

  /// Helper text
  final String? helperText;

  /// Error message
  final String? error;

  /// Size variant
  final SelectSize size;

  /// Whether required
  final bool required;

  /// Max dropdown height
  final String? maxDropdownHeight;

  /// Whether loading
  final bool loading;

  /// Loading text
  final String loadingText;

  /// Empty message
  final String emptyMessage;

  /// Search placeholder
  final String searchPlaceholder;

  /// Dropdown direction
  final SelectDropdownDirection dropdownDirection;

  /// Close on select (for multi)
  final bool closeOnSelect;

  /// Show selected count (for multi)
  final bool showSelectedCount;

  /// Prefix component
  final Component? prefix;

  /// Max selections (for multi)
  final int? maxSelections;

  /// Show checkboxes (for multi)
  final bool showCheckboxes;

  /// Whether dropdown is open
  final bool isOpen;

  /// Current search query
  final String searchQuery;

  /// Filtered options
  final List<SelectOptionProps<T>> filteredOptions;

  /// Handlers
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
