import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/direction_props.dart';

class NeubrutalismDirection extends StatelessComponent {
  final DirectionProps props;

  const NeubrutalismDirection(this.props, {super.key});

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
