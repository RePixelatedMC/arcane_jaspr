import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tooltip_props.dart';

/// Codex Tooltip renderer.
class CodexTooltip extends StatelessComponent {
  final TooltipProps props;

  const CodexTooltip(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String tooltipText = props.content ?? '';
    final Component? tooltipContent = props.customContent;
    final bool hasCustomContent = tooltipContent != null;

    return dom.div(
      classes: 'codex-tooltip-trigger',
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
        // Codex Tooltip content
        dom.div(
          classes: 'codex-tooltip codex-tooltip-${props.position.name}',
          attributes: {'role': 'tooltip'},
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'z-index': '50',
            'padding': hasCustomContent ? '1rem' : '0.5rem 0.875rem',
            'max-width': '${props.maxWidth}px',
            'font-size': '0.875rem',
            'font-weight': '500',
            'line-height': '1.4',
            'color': 'var(--foreground)',
            'background-color': 'var(--card)',
            'border': '1px solid rgba(var(--codex-accent-rgb), 0.2)',
            'border-radius': 'var(--radius)',
            'box-shadow': '0 0 20px rgba(var(--codex-accent-rgb), 0.1)',
            'overflow': 'hidden',
            if (!hasCustomContent) 'white-space': 'nowrap',
            'pointer-events': 'none',
            'opacity': '0',
            'visibility': 'hidden',
            'transition': 'opacity 150ms ease, visibility 150ms ease, transform 150ms ease',
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
          'margin-bottom': '10px',
        },
      TooltipPosition.bottom => {
          'top': '100%',
          'left': '50%',
          'transform': 'translateX(-50%) translateY(4px)',
          'margin-top': '10px',
        },
      TooltipPosition.left => {
          'right': '100%',
          'top': '50%',
          'transform': 'translateY(-50%) translateX(-4px)',
          'margin-right': '10px',
        },
      TooltipPosition.right => {
          'left': '100%',
          'top': '50%',
          'transform': 'translateY(-50%) translateX(4px)',
          'margin-left': '10px',
        },
    };
  }
}
