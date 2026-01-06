import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/hovercard_props.dart';

/// ShadCN-style hovercard component
/// Reference: https://ui.shadcn.com/docs/components/hover-card
class ShadcnHovercard extends StatelessComponent {
  final HovercardProps props;

  const ShadcnHovercard(this.props, {super.key});

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

        // Hovercard content - ShadCN HoverCardContent
        if (props.isOpen)
          dom.div(
            classes: 'arcane-hovercard-content',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              positionProp: positionValue,
              ...alignment,
              'z-index': '50',
              'width': '256px',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': '6px',
              'box-shadow':
                  '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
              'padding': '16px',
              'color': 'var(--popover-foreground)',
              'outline': 'none',
            }),
            [
              // Arrow
              if (props.showArrow)
                dom.div(
                  classes: 'arcane-hovercard-arrow',
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'width': '12px',
                    'height': '12px',
                    'background-color': 'var(--popover)',
                    'border-left': '1px solid var(--border)',
                    'border-top': '1px solid var(--border)',
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
