import 'package:jaspr/jaspr.dart';

/// Search input size variants.
enum SearchSize {
  /// Small size
  sm,

  /// Medium/default size
  md,

  /// Large size
  lg,
}

/// Search input style variants.
enum SearchStyle {
  /// Standard bordered style
  standard,

  /// Filled background style
  filled,

  /// Ghost/minimal style
  ghost,
}

/// Properties for search input components.
///
/// This is the shared props class used by all stylesheet renderers.
class SearchProps {
  /// Placeholder text
  final String placeholder;

  /// The current value
  final String? value;

  /// Callback when value changes
  final void Function(String value)? onChanged;

  /// Callback when search is submitted
  final void Function(String value)? onSubmitted;

  /// Whether to show the clear button
  final bool showClear;

  /// Whether to show the search icon
  final bool showIcon;

  /// Whether the search is loading
  final bool loading;

  /// Custom leading icon (overrides default search icon)
  final Component? icon;

  /// Whether to autofocus
  final bool autofocus;

  /// Whether the input is disabled
  final bool disabled;

  /// Size variant
  final SearchSize size;

  /// Style variant
  final SearchStyle style;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const SearchProps({
    this.placeholder = 'Search...',
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.showClear = true,
    this.showIcon = true,
    this.loading = false,
    this.icon,
    this.autofocus = false,
    this.disabled = false,
    this.size = SearchSize.md,
    this.style = SearchStyle.standard,
    this.id,
    this.attributes,
  });

  /// Create a copy with modified properties
  SearchProps copyWith({
    String? placeholder,
    String? value,
    void Function(String value)? onChanged,
    void Function(String value)? onSubmitted,
    bool? showClear,
    bool? showIcon,
    bool? loading,
    Component? icon,
    bool? autofocus,
    bool? disabled,
    SearchSize? size,
    SearchStyle? style,
    String? id,
    Map<String, String>? attributes,
  }) {
    return SearchProps(
      placeholder: placeholder ?? this.placeholder,
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      showClear: showClear ?? this.showClear,
      showIcon: showIcon ?? this.showIcon,
      loading: loading ?? this.loading,
      icon: icon ?? this.icon,
      autofocus: autofocus ?? this.autofocus,
      disabled: disabled ?? this.disabled,
      size: size ?? this.size,
      style: style ?? this.style,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }
}
