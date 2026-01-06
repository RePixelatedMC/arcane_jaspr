import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr_lucide/jaspr_lucide.dart' hide Factory, Target, Key, List, Timer, View, Map;

import '../../core/theme_provider.dart';

// Re-export for backwards compatibility
export '../../core/props/tooltip_props.dart' show TooltipPosition;

/// A tooltip component that shows on hover.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/tooltip
///
/// ```dart
/// ArcaneTooltip(
///   content: 'Helpful information',
///   child: ArcaneButton(label: 'Hover me'),
/// )
/// ```
class ArcaneTooltip extends StatelessComponent {
  /// Child widget to wrap
  final Component child;

  /// Tooltip content text
  final String content;

  /// Tooltip position relative to child
  final TooltipPosition position;

  /// Maximum width of tooltip
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
    // Delegate rendering to the current stylesheet's tooltip renderer
    return context.renderers.tooltip(TooltipProps(
      child: child,
      content: content,
      position: position,
      maxWidth: maxWidth,
    ));
  }
}

/// Short alias for ArcaneTooltip
typedef ATooltip = ArcaneTooltip;

/// A tooltip with custom content (not just text)
class ArcaneTooltipCustom extends StatelessComponent {
  /// Child widget to wrap
  final Component child;

  /// Custom tooltip content
  final Component tooltipContent;

  /// Tooltip position
  final TooltipPosition position;

  /// Maximum width
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
    // Delegate rendering to the current stylesheet's tooltip renderer
    return context.renderers.tooltip(TooltipProps(
      child: child,
      customContent: tooltipContent,
      position: position,
      maxWidth: maxWidth ?? 250,
    ));
  }
}

/// An info icon with tooltip
class ArcaneInfoTooltip extends StatelessComponent {
  /// Tooltip content
  final String content;

  /// Icon size
  final double size;

  /// Tooltip position
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