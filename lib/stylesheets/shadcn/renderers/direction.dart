import 'package:jaspr/jaspr.dart';

import '../../../core/props/direction_props.dart';

class ShadcnDirection extends StatelessComponent {
  final DirectionProps props;

  const ShadcnDirection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'div',
      classes: props.classes,
      attributes: <String, String>{'dir': props.value.name},
      children: props.children,
    );
  }
}
