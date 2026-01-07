import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/gutter_props.dart';

/// Codex Gutter renderer.
class CodexGutter extends StatelessComponent {
  final GutterProps props;

  const CodexGutter(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double size = props.size.pixels;
    return dom.div(
      classes: 'codex-gutter',
      styles: dom.Styles(raw: {
        if (props.horizontal) 'width': '${size}px' else 'height': '${size}px',
        'flex-shrink': '0',
      }),
      [],
    );
  }
}
