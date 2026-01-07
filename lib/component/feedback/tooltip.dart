import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr_lucide/jaspr_lucide.dart' hide Factory, Target, Key, List, Timer, View, Map;

import '../../core/theme_provider.dart';

export '../../core/props/tooltip_props.dart' show TooltipPosition;

/// Tooltip component that shows on hover.
class ArcaneTooltip extends StatelessComponent {
  final Component child;
  final String content;
  final TooltipPosition position;
  final double maxWidth;

  const ArcaneTooltip({
    required this.child,
    required this.content,
    this.position = TooltipPosition.top,
    this.maxWidth = 250,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.tooltip(TooltipProps(
      child: child,
      content: content,
      position: position,
      maxWidth: maxWidth,
    ));
  }
}

typedef ATooltip = ArcaneTooltip;

/// Tooltip with custom component content.
class ArcaneTooltipCustom extends StatelessComponent {
  final Component child;
  final Component tooltipContent;
  final TooltipPosition position;
  final double? maxWidth;

  const ArcaneTooltipCustom({
    required this.child,
    required this.tooltipContent,
    this.position = TooltipPosition.top,
    this.maxWidth,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.tooltip(TooltipProps(
      child: child,
      customContent: tooltipContent,
      position: position,
      maxWidth: maxWidth ?? 250,
    ));
  }
}

/// Info icon with tooltip.
class ArcaneInfoTooltip extends StatelessComponent {
  final String content;
  final double size;
  final TooltipPosition position;

  const ArcaneInfoTooltip({
    required this.content,
    this.size = 16,
    this.position = TooltipPosition.top,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneTooltip(
      content: content,
      position: position,
      child: dom.span(
        classes: 'arcane-info-tooltip-icon',
        styles: dom.Styles(raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '${size}px',
          'height': '${size}px',
          'color': 'var(--muted-foreground)',
          'cursor': 'help',
          'transition': 'color 150ms ease',
        }),
        [Info(width: const dom.Unit.pixels(16), height: const dom.Unit.pixels(16))],
      ),
    );
  }
}
