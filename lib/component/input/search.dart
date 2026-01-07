import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/search_props.dart' show SearchSize, SearchStyle, SearchResult;

/// A search input component with optional icon, clear button, and results dropdown.
class ArcaneSearch extends StatelessComponent {
  final String placeholder;
  final String? value;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final bool showClear;
  final bool showIcon;
  final bool loading;
  final Component? icon;
  final bool autofocus;
  final bool disabled;
  final SearchSize size;
  final SearchStyle style;
  final String? id;
  final Map<String, String>? attributes;
  final List<SearchResult>? results;
  final String? resultsId;
  final bool showDropdown;
  final String? dropdownMaxHeight;
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
