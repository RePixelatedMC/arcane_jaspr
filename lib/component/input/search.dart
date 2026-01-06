import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/search_props.dart' show SearchSize, SearchStyle;

/// A search input component with optional icon and clear button.
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
    super.key,
  });

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
    ));
  }
}
