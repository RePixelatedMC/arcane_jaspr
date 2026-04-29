import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/fade_edge_props.dart';

/// Neubrutalism Fade Edge renderer.
class NeubrutalismFadeEdge extends StatelessComponent {
  final FadeEdgeProps props;

  const NeubrutalismFadeEdge(this.props, {super.key});

  String _getGradient(String color) {
    return switch (props.direction) {
      FadeDirection.left => 'linear-gradient(to right, $color, transparent)',
      FadeDirection.right => 'linear-gradient(to left, $color, transparent)',
      FadeDirection.top => 'linear-gradient(to bottom, $color, transparent)',
      FadeDirection.bottom => 'linear-gradient(to top, $color, transparent)',
    };
  }

  Map<String, String> _getPositioning() {
    return switch (props.direction) {
      FadeDirection.left => {'left': '0', 'top': '0', 'bottom': '0'},
      FadeDirection.right => {'right': '0', 'top': '0', 'bottom': '0'},
      FadeDirection.top => {'top': '0', 'left': '0', 'right': '0'},
      FadeDirection.bottom => {'bottom': '0', 'left': '0', 'right': '0'},
    };
  }

  @override
  Component build(BuildContext context) {
    final effectiveColor = props.color ?? 'var(--background)';
    final isHorizontal =
        props.direction == FadeDirection.left ||
        props.direction == FadeDirection.right;

    final effectiveWidth = isHorizontal ? (props.width ?? '150px') : '100%';
    final effectiveHeight = !isHorizontal ? (props.height ?? '100px') : '100%';
    final effectiveZIndex = props.zIndex ?? '10';

    return dom.div(
      classes: 'neubrutalism-fade-edge neubrutalism-fade-edge-${props.direction.name}',
      styles: dom.Styles(
        raw: {
          'position': 'absolute',
          'width': effectiveWidth,
          'height': effectiveHeight,
          'z-index': effectiveZIndex,
          'pointer-events': 'none',
          'background': _getGradient(effectiveColor),
          ..._getPositioning(),
        },
      ),
      [],
    );
  }
}
