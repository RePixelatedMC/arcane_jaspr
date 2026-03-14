import 'package:arcane_jaspr/component/input/combobox.dart';
import 'package:arcane_jaspr/flutter.dart';

class Selector<T> extends StatelessWidget {
  final T? value;
  final void Function(T?)? onChanged;
  final List<T> values;
  final String Function(T) labelBuilder;
  final bool canUnselect;
  final String? placeholder;

  const Selector({
    required this.values,
    required this.labelBuilder,
    this.value,
    this.onChanged,
    this.canUnselect = false,
    this.placeholder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ArcaneCombobox<T>(
    value: value,
    onChanged: onChanged,
    placeholder: placeholder,
    options: values
        .map(
          (T entry) => ComboboxOption<T>(
            value: entry,
            label: labelBuilder(entry),
          ),
        )
        .toList(),
  );
}
