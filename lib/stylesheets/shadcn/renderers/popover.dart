import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/popover_props.dart';

/// ShadCN Popover renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/popover
///
/// ShadCN Popover:
/// - z-50 w-72 rounded-md border bg-popover p-4 text-popover-foreground shadow-md outline-none
/// - data-[state=open]:animate-in data-[state=closed]:animate-out
/// - data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0
/// - data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95
class ShadcnPopover extends StatelessComponent {
  final PopoverProps props;

  const ShadcnPopover(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (positionProp, positionValue, alignment) = _getPositionStyles();
    final useOuterEvents = props.triggerType == PopoverTrigger.hover;

    return dom.div(
      classes: 'arcane-popover',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-block',
      }),
      events: useOuterEvents
          ? {
              'mouseenter': (_) {
                if (props.onMouseEnter != null) props.onMouseEnter!();
              },
              'mouseleave': (_) {
                if (props.onMouseLeave != null) props.onMouseLeave!();
              },
            }
          : null,
      [
        // Trigger wrapper (click events need to be on inner wrapper)
        if (!useOuterEvents && props.triggerType == PopoverTrigger.click)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'inline-block',
            }),
            events: {
              'click': (_) {
                if (props.onToggle != null) props.onToggle!();
              },
            },
            [props.trigger],
          )
        else
          props.trigger,

        // ShadCN Popover content
        if (props.isOpen)
          dom.div(
            classes: 'arcane-popover-content',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              positionProp: positionValue,
              ..._parseAlignmentString(alignment),
              // ShadCN: z-50
              'z-index': '50',
              // ShadCN: min-width
              'min-width': '180px',
              // ShadCN: bg-popover
              'background-color': 'var(--popover)',
              // ShadCN: border
              'border': '1px solid var(--border)',
              // ShadCN: rounded-md (6px)
              'border-radius': 'var(--arcane-radius-sm)',
              // ShadCN: shadow-md
              'box-shadow': 'var(--arcane-shadow-md)',
              // ShadCN: p-4
              'padding': '16px',
              // ShadCN: text-popover-foreground
              'color': 'var(--popover-foreground)',
              // ShadCN: outline-none
              'outline': 'none',
            }),
            [
              // Arrow (optional)
              if (props.showArrow)
                dom.div(
                  classes: 'arcane-popover-arrow',
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'width': '12px',
                    'height': '12px',
                    'background-color': 'var(--popover)',
                    'border-left': '1px solid var(--border)',
                    'border-top': '1px solid var(--border)',
                    ..._parseAlignmentString(_getArrowPosition()),
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

  (String, String, String) _getPositionStyles() {
    final offsetPx = '${props.offset}px';

    return switch (props.position) {
      PopoverPosition.top => (
          'bottom',
          'calc(100% + $offsetPx)',
          'left: 50%; transform: translateX(-50%);'
        ),
      PopoverPosition.bottom => (
          'top',
          'calc(100% + $offsetPx)',
          'left: 50%; transform: translateX(-50%);'
        ),
      PopoverPosition.left => (
          'right',
          'calc(100% + $offsetPx)',
          'top: 50%; transform: translateY(-50%);'
        ),
      PopoverPosition.right => (
          'left',
          'calc(100% + $offsetPx)',
          'top: 50%; transform: translateY(-50%);'
        ),
      PopoverPosition.topStart => (
          'bottom',
          'calc(100% + $offsetPx)',
          'left: 0;'
        ),
      PopoverPosition.topEnd => (
          'bottom',
          'calc(100% + $offsetPx)',
          'right: 0;'
        ),
      PopoverPosition.bottomStart => (
          'top',
          'calc(100% + $offsetPx)',
          'left: 0;'
        ),
      PopoverPosition.bottomEnd => (
          'top',
          'calc(100% + $offsetPx)',
          'right: 0;'
        ),
    };
  }

  String _getArrowPosition() {
    return switch (props.position) {
      PopoverPosition.top ||
      PopoverPosition.topStart ||
      PopoverPosition.topEnd =>
        'bottom: -6px; left: 50%; transform: translateX(-50%) rotate(45deg);',
      PopoverPosition.bottom ||
      PopoverPosition.bottomStart ||
      PopoverPosition.bottomEnd =>
        'top: -6px; left: 50%; transform: translateX(-50%) rotate(45deg);',
      PopoverPosition.left =>
        'right: -6px; top: 50%; transform: translateY(-50%) rotate(45deg);',
      PopoverPosition.right =>
        'left: -6px; top: 50%; transform: translateY(-50%) rotate(45deg);',
    };
  }

  Map<String, String> _parseAlignmentString(String styleString) {
    final result = <String, String>{};
    for (final part in styleString.split(';')) {
      if (part.trim().isNotEmpty && part.contains(':')) {
        final key = part.split(':')[0].trim();
        final value = part.split(':')[1].trim().replaceAll(';', '');
        result[key] = value;
      }
    }
    return result;
  }
}
