import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tooltip_props.dart';

/// ShadCN Tooltip renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/tooltip
///
/// ShadCN Tooltip:
/// - z-50 overflow-hidden rounded-md border bg-popover px-3 py-1.5 text-sm text-popover-foreground shadow-md
/// - animate-in fade-in-0 zoom-in-95
class ShadcnTooltip extends StatelessComponent {
  final TooltipProps props;

  const ShadcnTooltip(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String tooltipText = props.content ?? '';
    final Component? tooltipContent = props.customContent;
    final bool hasCustomContent = tooltipContent != null;

    return dom.div(
      classes: 'arcane-tooltip-trigger',
      attributes: {
        if (!hasCustomContent) 'data-tooltip': tooltipText,
        'data-tooltip-position': props.position.name,
      },
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
      }),
      [
        props.child,
        // ShadCN Tooltip content
        dom.div(
          classes: 'arcane-tooltip arcane-tooltip-${props.position.name}',
          attributes: {'role': 'tooltip'},
          styles: dom.Styles(raw: {
            'position': 'absolute',
            // ShadCN: z-50
            'z-index': '50',
            // ShadCN: px-3 py-1.5
            'padding': hasCustomContent ? '12px' : '6px 12px',
            'max-width': '${props.maxWidth}px',
            // ShadCN: text-sm
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'line-height': '1.4',
            // ShadCN: text-popover-foreground
            'color': 'var(--popover-foreground)',
            // ShadCN: bg-popover
            'background-color': 'var(--popover)',
            // ShadCN: border
            'border': '1px solid var(--border)',
            // ShadCN: rounded-md (6px)
            'border-radius': 'var(--arcane-radius-sm)',
            // ShadCN: shadow-md
            'box-shadow': 'var(--arcane-shadow-md)',
            // ShadCN: overflow-hidden
            'overflow': 'hidden',
            if (!hasCustomContent) 'white-space': 'nowrap',
            'pointer-events': 'none',
            'opacity': '0',
            'visibility': 'hidden',
            // ShadCN: animate-in fade-in-0 zoom-in-95
            'transition': 'opacity var(--arcane-transition), visibility var(--arcane-transition), transform var(--arcane-transition)',
            ..._getPositionStyles(props.position),
          }),
          [
            if (hasCustomContent)
              tooltipContent
            else
              Component.text(tooltipText),
          ],
        ),
      ],
    );
  }

  Map<String, String> _getPositionStyles(TooltipPosition position) {
    return switch (position) {
      TooltipPosition.top => {
          'bottom': '100%',
          'left': '50%',
          'transform': 'translateX(-50%) translateY(-4px)',
          'margin-bottom': '8px',
        },
      TooltipPosition.bottom => {
          'top': '100%',
          'left': '50%',
          'transform': 'translateX(-50%) translateY(4px)',
          'margin-top': '8px',
        },
      TooltipPosition.left => {
          'right': '100%',
          'top': '50%',
          'transform': 'translateY(-50%) translateX(-4px)',
          'margin-right': '8px',
        },
      TooltipPosition.right => {
          'left': '100%',
          'top': '50%',
          'transform': 'translateY(-50%) translateX(4px)',
          'margin-left': '8px',
        },
    };
  }
}
