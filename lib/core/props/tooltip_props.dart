import 'package:jaspr/jaspr.dart';

/// Tooltip position relative to the trigger element.
enum TooltipPosition {
  top,
  bottom,
  left,
  right,
}

/// Properties for tooltip components.
class TooltipProps {
  /// The child element that triggers the tooltip on hover
  final Component child;

  /// Plain text content for the tooltip (used if customContent is null)
  final String? content;

  /// Custom component content for the tooltip
  final Component? customContent;

  /// Tooltip position relative to the trigger
  final TooltipPosition position;

  /// Maximum width of the tooltip in pixels
  final double maxWidth;

  const TooltipProps({
    required this.child,
    this.content,
    this.customContent,
    this.position = TooltipPosition.top,
    this.maxWidth = 250,
  });

  /// Create a copy with modified properties
  TooltipProps copyWith({
    Component? child,
    String? content,
    Component? customContent,
    TooltipPosition? position,
    double? maxWidth,
  }) {
    return TooltipProps(
      child: child ?? this.child,
      content: content ?? this.content,
      customContent: customContent ?? this.customContent,
      position: position ?? this.position,
      maxWidth: maxWidth ?? this.maxWidth,
    );
  }
}
