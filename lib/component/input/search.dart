import 'package:arcane_jaspr/component/card/card.dart';
import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/input/icon_button.dart';
import 'package:arcane_jaspr/component/input/text_input.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/component/support/icons.dart';
import 'package:arcane_jaspr/component/view/item.dart';
import 'package:arcane_jaspr/component/view/separator.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/component/typography/text.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class SearchResult {
  final String title;
  final String? subtitle;
  final String? href;
  final void Function()? onTap;

  const SearchResult({
    required this.title,
    this.subtitle,
    this.href,
    this.onTap,
  });
}

class Search extends StatelessWidget {
  final String placeholder;
  final String? value;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final List<SearchResult> results;
  final bool showDropdown;
  final bool showClear;
  final bool autofocus;
  final bool disabled;

  const Search({
    this.placeholder = 'Search...',
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.results = const <SearchResult>[],
    this.showDropdown = false,
    this.showClear = true,
    this.autofocus = false,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Widget input = TextInput(
      type: TextInputType.search,
      placeholder: placeholder,
      value: value,
      disabled: disabled,
      onChange: onChanged,
      onSubmit: onSubmitted,
      prefix: Icon(Icons.search),
      suffix: showClear && (value?.isNotEmpty ?? false)
          ? IconButton(
              icon: Icon(Icons.x),
              onPressed: onChanged == null ? null : () => onChanged!(''),
            )
          : null,
    );

    if (!showDropdown || results.isEmpty) {
      return input;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 8,
      children: <Widget>[
        input,
        Card.outlined(
          fillWidth: true,
          children: <Widget>[
            for (int index = 0; index < results.length; index++) ...<Widget>[
              ArcaneItem(
                href: results[index].href,
                child: Button.ghost(
                  fullWidth: true,
                  onPressed: results[index].onTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    gap: 4,
                    children: <Widget>[
                      Text.label(results[index].title),
                      if (results[index].subtitle != null)
                        Text.bodySmall(results[index].subtitle!),
                    ],
                  ),
                ),
              ),
              if (index < results.length - 1) const ArcaneSeparator.subtle(),
            ],
          ],
        ),
      ],
    );
  }
}
