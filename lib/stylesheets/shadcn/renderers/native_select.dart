import 'package:jaspr/jaspr.dart';

import '../../../component/input/text_input.dart';
import '../../../core/props/native_select_props.dart';

class ShadcnNativeSelect extends StatelessComponent {
  final NativeSelectProps props;

  const ShadcnNativeSelect(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final List<ArcaneSelectOption> options = props.options
        .map(
          (NativeSelectOptionProps option) => ArcaneSelectOption(
            label: option.label,
            value: option.value,
            disabled: option.disabled,
          ),
        )
        .toList();

    return ArcaneSelect(
      options: options,
      value: props.value,
      placeholder: props.placeholder,
      size: props.size,
      disabled: props.disabled,
      required: props.required,
      name: props.name,
      id: props.id,
      label: props.label,
      error: props.error,
      fullWidth: props.fullWidth,
      onChange: props.onChange,
    );
  }
}
