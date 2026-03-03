import 'package:jaspr/jaspr.dart';

import '../../../core/props/direction_props.dart';

class CodexDirection extends StatelessComponent {
  final DirectionProps props;

  const CodexDirection(this.props, {super.key});

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
