import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export from props for convenience
export '../../core/props/resizable_props.dart' show ResizeDirection, ResizablePanelData;

/// Type alias for backwards compatibility
typedef ResizablePanel = ResizablePanelData;

/// A resizable panel group with draggable dividers matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/resizable
///
/// Allows users to resize panels by dragging the handles between them.
/// ShadCN ResizablePanelGroup: flex h-full w-full data-[panel-group-direction=vertical]:flex-col
/// ShadCN ResizableHandle: relative flex w-px items-center justify-center bg-border after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2
///
/// ```dart
/// ArcaneResizable(
///   direction: ResizeDirection.horizontal,
///   panels: [
///     ResizablePanelData(
///       defaultSize: 30,
///       minSize: 20,
///       child: Sidebar(),
///     ),
///     ResizablePanelData(
///       child: MainContent(),
///     ),
///   ],
/// )
/// ```
class ArcaneResizable extends StatelessComponent {
  /// The panels to display
  final List<ResizablePanelData> panels;

  /// Direction of the resize
  final ResizeDirection direction;

  /// Handle size in pixels
  final double handleSize;

  /// Whether to show the handle grip dots
  final bool showGrip;

  const ArcaneResizable({
    required this.panels,
    this.direction = ResizeDirection.horizontal,
    this.handleSize = 8,
    this.showGrip = true,
    super.key,
  });

  /// Creates a horizontal resizable with two panels (sidebar + content)
  factory ArcaneResizable.sidebarLayout({
    required Component sidebar,
    required Component content,
    double sidebarSize = 25,
    double sidebarMinSize = 15,
    double sidebarMaxSize = 40,
    Key? key,
  }) {
    return ArcaneResizable(
      key: key,
      direction: ResizeDirection.horizontal,
      panels: [
        ResizablePanelData(
          child: sidebar,
          defaultSize: sidebarSize,
          minSize: sidebarMinSize,
          maxSize: sidebarMaxSize,
        ),
        ResizablePanelData(child: content),
      ],
    );
  }

  /// Creates a vertical resizable with two panels (top + bottom)
  factory ArcaneResizable.splitView({
    required Component top,
    required Component bottom,
    double topSize = 50,
    double topMinSize = 20,
    double topMaxSize = 80,
    Key? key,
  }) {
    return ArcaneResizable(
      key: key,
      direction: ResizeDirection.vertical,
      panels: [
        ResizablePanelData(
          child: top,
          defaultSize: topSize,
          minSize: topMinSize,
          maxSize: topMaxSize,
        ),
        ResizablePanelData(child: bottom),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.resizable(ResizableProps(
      panels: panels,
      direction: direction,
      handleSize: handleSize,
      showGrip: showGrip,
    ));
  }
}
