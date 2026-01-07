import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/hovercard_props.dart';

/// Codex Hovercard component.
class CodexHovercard extends StatelessComponent {
  final HovercardProps props;

  const CodexHovercard(this.props, {super.key});

  (String, String, Map<String, String>) get _positionStyles {
    final offsetPx = '${props.offset}px';

    return switch (props.position) {
      HovercardPositionVariant.top => (
          'bottom',
          'calc(100% + $offsetPx)',
          {'left': '50%', 'transform': 'translateX(-50%)'}
        ),
      HovercardPositionVariant.bottom => (
          'top',
          'calc(100% + $offsetPx)',
          {'left': '50%', 'transform': 'translateX(-50%)'}
        ),
      HovercardPositionVariant.left => (
          'right',
          'calc(100% + $offsetPx)',
          {'top': '50%', 'transform': 'translateY(-50%)'}
        ),
      HovercardPositionVariant.right => (
          'left',
          'calc(100% + $offsetPx)',
          {'top': '50%', 'transform': 'translateY(-50%)'}
        ),
      HovercardPositionVariant.topStart => (
          'bottom',
          'calc(100% + $offsetPx)',
          {'left': '0'}
        ),
      HovercardPositionVariant.topEnd => (
          'bottom',
          'calc(100% + $offsetPx)',
          {'right': '0'}
        ),
      HovercardPositionVariant.bottomStart => (
          'top',
          'calc(100% + $offsetPx)',
          {'left': '0'}
        ),
      HovercardPositionVariant.bottomEnd => (
          'top',
          'calc(100% + $offsetPx)',
          {'right': '0'}
        ),
    };
  }

  Map<String, String> get _arrowStyles => switch (props.position) {
        HovercardPositionVariant.top ||
        HovercardPositionVariant.topStart ||
        HovercardPositionVariant.topEnd =>
          {
            'bottom': '-6px',
            'left': '50%',
            'transform': 'translateX(-50%) rotate(45deg)'
          },
        HovercardPositionVariant.bottom ||
        HovercardPositionVariant.bottomStart ||
        HovercardPositionVariant.bottomEnd =>
          {
            'top': '-6px',
            'left': '50%',
            'transform': 'translateX(-50%) rotate(45deg)'
          },
        HovercardPositionVariant.left => {
            'right': '-6px',
            'top': '50%',
            'transform': 'translateY(-50%) rotate(45deg)'
          },
        HovercardPositionVariant.right => {
            'left': '-6px',
            'top': '50%',
            'transform': 'translateY(-50%) rotate(45deg)'
          },
      };

  @override
  Component build(BuildContext context) {
    final (positionProp, positionValue, alignment) = _positionStyles;

    return dom.div(
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
      events: {
        'mouseenter': (_) => props.onMouseEnter?.call(),
        'mouseleave': (_) => props.onMouseLeave?.call(),
      },
      [
        // Trigger
        props.trigger,

        // Hovercard content
        if (props.isOpen)
          dom.div(
            classes: 'codex-hovercard-content',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              positionProp: positionValue,
              ...alignment,
              'z-index': '50',
              'width': '280px',
              'background-color': 'var(--card)',
              'border': '1px solid rgba(var(--codex-accent-rgb), 0.2)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 0 30px rgba(var(--codex-accent-rgb), 0.1)',
              'padding': '1.25rem',
              'color': 'var(--foreground)',
              'outline': 'none',
            }),
            [
              // Arrow
              if (props.showArrow)
                dom.div(
                  classes: 'codex-hovercard-arrow',
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'width': '12px',
                    'height': '12px',
                    'background-color': 'var(--card)',
                    'border-left': '1px solid rgba(var(--codex-accent-rgb), 0.2)',
                    'border-top': '1px solid rgba(var(--codex-accent-rgb), 0.2)',
                    ..._arrowStyles,
                  }),
                  [],
                ),

              // Content
              props.content,
            ],
          ),
      ],
    );
  }
}
