import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import 'selector_types.dart';

export 'selector_types.dart';
export '../../core/props/select_props.dart'
    show SelectSize, SelectDropdownDirection, SelectOptionProps, SelectProps;

/// A dropdown selector component with extensive customization options.
class ArcaneSelector<T> extends StatefulComponent {
  /// The available options
  final List<ArcaneSelectorOption<T>> options;

  /// The currently selected value (for single select)
  final T? value;

  /// The currently selected values (for multi-select)
  final List<T>? values;

  /// Callback when selection changes (single select)
  final void Function(T value)? onChanged;

  /// Callback when selection changes (multi-select)
  final void Function(List<T> values)? onMultiChanged;

  /// Placeholder text when no selection
  final String placeholder;

  /// Whether the selector is disabled
  final bool disabled;

  /// Whether to allow clearing the selection
  final bool clearable;

  /// Whether the dropdown is searchable
  final bool searchable;

  /// Whether multiple selections are allowed
  final bool multiSelect;

  /// Label for the field
  final String? label;

  /// Helper text below the selector
  final String? helperText;

  /// Error message
  final String? error;

  /// Size variant
  final SelectorSize size;

  /// Whether the field is required (shows asterisk)
  final bool required;

  /// Maximum height of the dropdown
  final String? maxDropdownHeight;

  /// Loading state - shows spinner instead of options
  final bool loading;

  /// Custom loading text
  final String loadingText;

  /// Custom empty state message
  final String emptyMessage;

  /// Custom search placeholder
  final String searchPlaceholder;

  /// Direction for dropdown to open
  final DropdownDirection dropdownDirection;

  /// Whether to close dropdown after selection (multi-select)
  final bool closeOnSelect;

  /// Show selected count badge for multi-select
  final bool showSelectedCount;

  /// Prefix component (icon/text before value)
  final Component? prefix;

  /// Custom filter function for search
  final bool Function(ArcaneSelectorOption<T> option, String query)? filterFn;

  /// Max number of selections (multi-select, null = unlimited)
  final int? maxSelections;

  /// Show checkboxes for multi-select options
  final bool showCheckboxes;

  const ArcaneSelector({
    required this.options,
    this.value,
    this.values,
    this.onChanged,
    this.onMultiChanged,
    this.placeholder = 'Select...',
    this.disabled = false,
    this.clearable = false,
    this.searchable = false,
    this.multiSelect = false,
    this.label,
    this.helperText,
    this.error,
    this.size = SelectorSize.md,
    this.required = false,
    this.maxDropdownHeight,
    this.loading = false,
    this.loadingText = 'Loading...',
    this.emptyMessage = 'No options found',
    this.searchPlaceholder = 'Search...',
    this.dropdownDirection = DropdownDirection.down,
    this.closeOnSelect = true,
    this.showSelectedCount = true,
    this.prefix,
    this.filterFn,
    this.maxSelections,
    this.showCheckboxes = true,
    super.key,
  });

  @override
  State<ArcaneSelector<T>> createState() => _ArcaneSelectorState<T>();
}

class _ArcaneSelectorState<T> extends State<ArcaneSelector<T>> {
  bool _isOpen = false;
  String _searchQuery = '';

  void _toggleOpen() {
    if (component.disabled || component.loading) return;
    setState(() {
      _isOpen = !_isOpen;
      if (!_isOpen) _searchQuery = '';
    });
  }

  void _selectOption(SelectOptionProps<T> option) {
    if (component.multiSelect) {
      final currentValues = List<T>.from(component.values ?? []);

      if (currentValues.contains(option.value)) {
        currentValues.remove(option.value);
      } else {
        // Check max selections
        if (component.maxSelections != null &&
            currentValues.length >= component.maxSelections!) {
          return;
        }
        currentValues.add(option.value);
      }

      component.onMultiChanged?.call(currentValues);

      if (component.closeOnSelect) {
        setState(() {
          _isOpen = false;
          _searchQuery = '';
        });
      } else {
        setState(() {});
      }
    } else {
      setState(() {
        _isOpen = false;
        _searchQuery = '';
      });
      component.onChanged?.call(option.value);
    }
  }

  void _clear() {
    setState(() {
      _isOpen = false;
    });
    if (component.multiSelect) {
      component.onMultiChanged?.call([]);
    }
  }

  List<SelectOptionProps<T>> get _propsOptions {
    return component.options
        .map((opt) => SelectOptionProps<T>(
              value: opt.value,
              label: opt.label,
              subtitle: opt.subtitle,
              description: opt.description,
              icon: opt.icon,
              disabled: opt.disabled,
              searchKeywords: opt.searchKeywords,
            ))
        .toList();
  }

  List<SelectOptionProps<T>> get _filteredOptions {
    final allOptions = _propsOptions;
    if (_searchQuery.isEmpty) return allOptions;

    if (component.filterFn != null) {
      return allOptions.where((opt) {
        // Convert back to ArcaneSelectorOption for custom filter
        final arcaneOpt = ArcaneSelectorOption<T>(
          value: opt.value,
          label: opt.label,
          subtitle: opt.subtitle,
          description: opt.description,
          icon: opt.icon,
          disabled: opt.disabled,
          searchKeywords: opt.searchKeywords,
        );
        return component.filterFn!(arcaneOpt, _searchQuery);
      }).toList();
    }

    final query = _searchQuery.toLowerCase();
    return allOptions.where((opt) {
      return opt.label.toLowerCase().contains(query) ||
          (opt.subtitle?.toLowerCase().contains(query) ?? false) ||
          (opt.searchKeywords?.any((k) => k.toLowerCase().contains(query)) ??
              false);
    }).toList();
  }

  void _onSearchChange(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  SelectSize get _selectSize => switch (component.size) {
        SelectorSize.sm => SelectSize.sm,
        SelectorSize.md => SelectSize.md,
        SelectorSize.lg => SelectSize.lg,
      };

  SelectDropdownDirection get _dropdownDirection =>
      switch (component.dropdownDirection) {
        DropdownDirection.up => SelectDropdownDirection.up,
        DropdownDirection.down => SelectDropdownDirection.down,
        DropdownDirection.auto => SelectDropdownDirection.down, // Default to down for auto
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.select<T>(SelectProps<T>(
      options: _propsOptions,
      value: component.value,
      values: component.values,
      placeholder: component.placeholder,
      disabled: component.disabled,
      clearable: component.clearable,
      searchable: component.searchable,
      multiSelect: component.multiSelect,
      label: component.label,
      helperText: component.helperText,
      error: component.error,
      size: _selectSize,
      required: component.required,
      maxDropdownHeight: component.maxDropdownHeight,
      loading: component.loading,
      loadingText: component.loadingText,
      emptyMessage: component.emptyMessage,
      searchPlaceholder: component.searchPlaceholder,
      dropdownDirection: _dropdownDirection,
      closeOnSelect: component.closeOnSelect,
      showSelectedCount: component.showSelectedCount,
      prefix: component.prefix,
      maxSelections: component.maxSelections,
      showCheckboxes: component.showCheckboxes,
      isOpen: _isOpen,
      searchQuery: _searchQuery,
      filteredOptions: _filteredOptions,
      onToggle: _toggleOpen,
      onSelect: (value) => _selectOption(SelectOptionProps<T>(
        value: value,
        label: '', // Label not needed for selection
      )),
      onClear: _clear,
      onSearchChange: _onSearchChange,
    ));
  }
}
