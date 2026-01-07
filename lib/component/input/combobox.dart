import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/select_props.dart'
    show SelectSize, SelectProps, SelectOptionProps;

/// An autocomplete combobox with search filtering.
class ArcaneCombobox<T> extends StatefulComponent {
  final List<ComboboxOption<T>> options;
  final T? value;
  final void Function(T?)? onChanged;
  final String? placeholder;
  final String? searchPlaceholder;
  final bool searchable;
  final String Function(T)? displayValue;
  final bool Function(ComboboxOption<T>, String)? filterFn;
  final String emptyMessage;
  final bool disabled;
  final String? error;
  final String? label;
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

/// A combobox option.
class ComboboxOption<T> {
  final T value;
  final String label;
  final String? description;
  final Component? icon;
  final bool disabled;
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

/// Size variants for combobox.
enum ComboboxSize {
  sm,
  md,
  lg,
}
