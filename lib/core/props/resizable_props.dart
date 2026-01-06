import 'package:jaspr/jaspr.dart';

/// Direction for resizable panels
enum ResizeDirection {
  horizontal,
  vertical,
}

/// A panel within a resizable group
class ResizablePanelData {
  /// The panel content
  final Component child;

  /// Default size as percentage
  final double? defaultSize;

  /// Minimum size as percentage
  final double? minSize;

  /// Maximum size as percentage
  final double? maxSize;

  /// Whether this panel can be collapsed
  final bool collapsible;

  const ResizablePanelData({
    required this.child,
    this.defaultSize,
    this.minSize,
    this.maxSize,
    this.collapsible = false,
  });
}

/// Properties for resizable panel group components.
class ResizableProps {
  /// The panels to display
  final List<ResizablePanelData> panels;

  /// Direction of the resize
  final ResizeDirection direction;

  /// Handle size in pixels
  final double handleSize;

  /// Whether to show the handle grip dots
  final bool showGrip;

  const ResizableProps({
    required this.panels,
    this.direction = ResizeDirection.horizontal,
    this.handleSize = 8,
    this.showGrip = true,
  });
}
