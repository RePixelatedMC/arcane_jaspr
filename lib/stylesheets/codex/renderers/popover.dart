import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/popover_props.dart';

/// Codex Popover renderer.
///
/// Implements the Codex design language:
/// - Glass effect with backdrop blur
/// - Subtle accent border glow
/// - Larger padding
class CodexPopover extends StatelessComponent {
  final PopoverProps props;

  const CodexPopover(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Position-specific alignment
    final Map<String, String> contentPositionStyles = switch (props.position) {
      PopoverPosition.top || PopoverPosition.topStart || PopoverPosition.topEnd => {
          'bottom': '100%',
          'margin-bottom': '${props.offset}px',
        },
      PopoverPosition.bottom || PopoverPosition.bottomStart || PopoverPosition.bottomEnd => {
          'top': '100%',
          'margin-top': '${props.offset}px',
        },
      PopoverPosition.left => {
          'right': '100%',
          'top': '50%',
          'transform': 'translateY(-50%)',
          'margin-right': '${props.offset}px',
        },
      PopoverPosition.right => {
          'left': '100%',
          'top': '50%',
          'transform': 'translateY(-50%)',
          'margin-left': '${props.offset}px',
        },
    };

    // Horizontal alignment
    final Map<String, String> horizontalAlign = switch (props.position) {
      PopoverPosition.top || PopoverPosition.bottom => {
          'left': '50%',
          'transform': 'translateX(-50%)',
        },
      PopoverPosition.topStart || PopoverPosition.bottomStart => {
          'left': '0',
        },
      PopoverPosition.topEnd || PopoverPosition.bottomEnd => {
          'right': '0',
        },
      PopoverPosition.left || PopoverPosition.right => {},
    };

    return dom.div(
      classes: 'codex-popover-wrapper',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
      events: {
        if (props.triggerType == PopoverTrigger.hover &&
            props.onMouseEnter != null)
          'mouseenter': (_) => props.onMouseEnter!(),
        if (props.triggerType == PopoverTrigger.hover &&
            props.onMouseLeave != null)
          'mouseleave': (_) => props.onMouseLeave!(),
      },
      [
        // Trigger
        dom.div(
          classes: 'codex-popover-trigger',
          events: props.triggerType == PopoverTrigger.click && props.onToggle != null
              ? {'click': (_) => props.onToggle!()}
              : null,
          [props.trigger],
        ),

        // Popover content
        if (props.isOpen)
          dom.div(
            classes: 'codex-popover-content',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              ...contentPositionStyles,
              ...horizontalAlign,
              'z-index': '50',
              'min-width': '200px',
              // Codex: more padding
              'padding': '1rem 1.25rem',
              // Codex: glass effect
              'background-color': 'rgba(10, 10, 10, 0.95)',
              'backdrop-filter': 'blur(12px)',
              '-webkit-backdrop-filter': 'blur(12px)',
              'border': '1px solid var(--primary)',
              'border-radius': 'var(--radius)', // Codex: larger radius
              // Codex: subtle glow
              'box-shadow': '0 0 20px rgba(var(--primary-rgb), 0.15), 0 10px 40px rgba(0, 0, 0, 0.3)',
            }),
            [props.content],
          ),
      ],
    );
  }
}
