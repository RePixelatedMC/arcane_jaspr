import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/gutter_props.dart';

/// Renders a gutter/spacing component.
Component renderGutter(GutterProps props) {
  return dom.div(
    classes: 'arcane-gutter',
    styles: dom.Styles(
      raw: {
        if (props.horizontal)
          'width': '${props.size.pixels}px'
        else
          'height': '${props.size.pixels}px',
        'flex-shrink': '0',
      },
    ),
    [],
  );
}

/// Renders a gap component.
Component renderGap(GapProps props) {
  return dom.div(
    styles: dom.Styles(
      raw: {
        if (props.horizontal)
          'width': '${props.size}px'
        else
          'height': '${props.size}px',
        'flex-shrink': '0',
      },
    ),
    [],
  );
}
