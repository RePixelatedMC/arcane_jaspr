import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import 'selector_types.dart';

export 'selector_types.dart';
export '../../core/props/select_props.dart'
    show SelectSize, SelectDropdownDirection, SelectOptionProps, SelectProps;

/// A dropdown selector component with extensive customization options.
class ArcaneSelector<T> extends StatefulComponent {
  final List<ArcaneSelectorOption<T>> options;
  final T? value;
  final List<T>? values;
  final void Function(T value)? onChanged;
  final void Function(List<T> values)? onMultiChanged;
  final String placeholder;
  final bool disabled;
  final bool clearable;
  final bool searchable;
  final bool multiSelect;
  final String? label;
  final String? helperText;
  final String? error;
  final SelectorSize size;
  final bool required;
  final String? maxDropdownHeight;
  final bool loading;
  final String loadingText;
  final String emptyMessage;
  final String searchPlaceholder;
  final DropdownDirection dropdownDirection;
  final bool closeOnSelect;
  final bool showSelectedCount;
  final Component? prefix;
  final bool Function(ArcaneSelectorOption<T> option, String query)? filterFn;
  final int? maxSelections;
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
        DropdownDirection.auto => SelectDropdownDirection.down,
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
        label: '',
      )),
      onClear: _clear,
      onSearchChange: _onSearchChange,
    ));
  }
}
