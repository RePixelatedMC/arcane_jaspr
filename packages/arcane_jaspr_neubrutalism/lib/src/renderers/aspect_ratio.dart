import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/aspect_ratio_props.dart';

class NeubrutalismAspectRatio extends StatelessComponent {
  final AspectRatioProps props;

  const NeubrutalismAspectRatio(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String classes = [
      'neubrutalism-aspect-ratio',
      if (props.classes != null) props.classes!,
    ].join(' ');

    return dom.div(
      classes: classes,
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'width': '100%',
          'aspect-ratio': props.ratio.toString(),
          'overflow': 'hidden',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          ...?props.styles,
        },
      ),
      [
        dom.div(
          classes: 'neubrutalism-aspect-ratio-content',
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'inset': '0',
              'width': '100%',
              'height': '100%',
            },
          ),
          [props.child],
        ),
      ],
    );
  }
}
