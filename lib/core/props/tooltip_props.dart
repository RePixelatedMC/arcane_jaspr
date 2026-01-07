import 'package:jaspr/jaspr.dart';

enum TooltipPosition {
  top,
  bottom,
  left,
  right,
}

/// Tooltip component properties.
class TooltipProps {
  final Component child;
  final String? content;
  final Component? customContent;
  final TooltipPosition position;
  final double maxWidth;

  const TooltipProps({
    required this.child,
    this.content,
    this.customContent,
    this.position = TooltipPosition.top,
    this.maxWidth = 250,
  });

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
