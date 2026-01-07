import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/resizable_props.dart' show ResizeDirection, ResizablePanelData;

typedef ResizablePanel = ResizablePanelData;

/// A resizable panel group with draggable dividers.
class ArcaneResizable extends StatelessComponent {
  final List<ResizablePanelData> panels;
  final ResizeDirection direction;
  final double handleSize;
  final bool showGrip;

  const ArcaneResizable({
    required this.panels,
    this.direction = ResizeDirection.horizontal,
    this.handleSize = 8,
    this.showGrip = true,
    super.key,
  });

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
