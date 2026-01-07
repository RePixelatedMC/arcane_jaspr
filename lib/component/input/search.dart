import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/search_props.dart' show SearchSize, SearchStyle, SearchResult;

/// A search input component with optional icon, clear button, and results dropdown.
///
/// This component consolidates basic search input and search bar with results functionality.
///
/// Basic search input:
/// ```dart
/// ArcaneSearch(
///   placeholder: 'Search...',
///   onChanged: (value) => print(value),
/// )
/// ```
///
/// Search with results dropdown:
/// ```dart
/// ArcaneSearch(
///   placeholder: 'Search docs...',
///   showDropdown: true,
///   results: searchResults,
///   onChanged: (value) => performSearch(value),
/// )
/// ```
class ArcaneSearch extends StatelessComponent {
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

  const ArcaneSearch({
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
    super.key,
  });

  /// Creates a search with dropdown results functionality.
  const ArcaneSearch.withResults({
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
    this.dropdownMaxHeight = '300px',
    this.width = '240px',
    super.key,
  }) : showDropdown = true;

  @override
  Component build(BuildContext context) {
    return context.renderers.search(SearchProps(
      placeholder: placeholder,
      value: value,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      showClear: showClear,
      showIcon: showIcon,
      loading: loading,
      icon: icon,
      autofocus: autofocus,
      disabled: disabled,
      size: size,
      style: style,
      id: id,
      attributes: attributes,
      results: results,
      resultsId: resultsId,
      showDropdown: showDropdown,
      dropdownMaxHeight: dropdownMaxHeight,
      width: width,
    ));
  }
}
