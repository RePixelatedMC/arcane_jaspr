import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/aspect_ratio_props.dart';

/// Renders a Codex aspect ratio container.
Component renderCodexAspectRatio(AspectRatioProps props) {
  final allClasses = [
    'codex-aspect-ratio',
    if (props.classes != null) props.classes,
  ].join(' ');

  return Component.element(
    tag: 'div',
    classes: allClasses,
    styles: dom.Styles(raw: {
      'position': 'relative',
      'width': '100%',
      'aspect-ratio': props.ratio.toString(),
      'overflow': 'hidden',
      'border-radius': 'var(--radius)',
      ...?props.styles,
    }),
    children: [
      // Child wrapper for absolute positioning fallback
      Component.element(
        tag: 'div',
        classes: 'codex-aspect-ratio-content',
        styles: const dom.Styles(raw: {
          'position': 'absolute',
          'top': '0',
          'left': '0',
          'width': '100%',
          'height': '100%',
        }),
        children: [props.child],
      ),
    ],
  );
}
