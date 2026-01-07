import 'package:web/web.dart' as web;

/// Web implementation for debug mode.
class USAMapDebugHelper {
  static (double, double)? getMouseSvgCoords(
    Object event,
    double mapWidth,
    double mapHeight,
  ) {
    if (event is! web.MouseEvent) return null;

    final target = event.currentTarget as web.Element?;
    if (target == null) return null;

    final rect = target.getBoundingClientRect();
    final svgWidth = rect.width;
    final svgHeight = rect.height;

    if (svgWidth == 0 || svgHeight == 0) return null;

    final relX = (event.clientX - rect.left) / svgWidth;
    final relY = (event.clientY - rect.top) / svgHeight;

    final svgX = relX * mapWidth;
    final svgY = relY * mapHeight;

    return (svgX, svgY);
  }

  static void copyToClipboard(String text) {
    web.window.navigator.clipboard.writeText(text);
  }
}
