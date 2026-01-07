import 'package:jaspr/jaspr.dart';

/// A search result item for search dropdown.
class SearchResult {
  /// Display title
  final String title;

  /// Optional subtitle/category
  final String? subtitle;

  /// URL to navigate to when clicked
  final String? href;

  /// Callback when clicked (alternative to href)
  final VoidCallback? onTap;

  const SearchResult({
    required this.title,
    this.subtitle,
    this.href,
    this.onTap,
  });
}

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

  // Results dropdown properties (from ArcaneSearchBar)

  /// Search results to display in dropdown
  final List<SearchResult>? results;

  /// Optional ID for the results container (for JS hooks)
  final String? resultsId;

  /// Whether to show the dropdown results container
  final bool showDropdown;

  /// Maximum height of dropdown
  final String? dropdownMaxHeight;

  /// Custom width
  final String? width;

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
    this.results,
    this.resultsId,
    this.showDropdown = false,
    this.dropdownMaxHeight,
    this.width,
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
    List<SearchResult>? results,
    String? resultsId,
    bool? showDropdown,
    String? dropdownMaxHeight,
    String? width,
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
      results: results ?? this.results,
      resultsId: resultsId ?? this.resultsId,
      showDropdown: showDropdown ?? this.showDropdown,
      dropdownMaxHeight: dropdownMaxHeight ?? this.dropdownMaxHeight,
      width: width ?? this.width,
    );
  }
}
