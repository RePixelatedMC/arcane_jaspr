import 'package:jaspr/jaspr.dart';

/// Props for center body components.
class CenterBodyProps {
  /// The child component
  final Component child;

  /// Maximum width of the content
  final double? maxWidth;

  /// Custom padding
  final String? padding;

  /// Whether to fill the entire viewport height
  final bool fillHeight;

  const CenterBodyProps({
    required this.child,
    this.maxWidth,
    this.padding,
    this.fillHeight = true,
  });
}

/// Props for page body components.
class PageBodyProps {
  /// The child components
  final List<Component> children;

  /// Maximum width
  final double maxWidth;

  /// Custom padding
  final String? padding;

  const PageBodyProps({
    required this.children,
    this.maxWidth = 1200,
    this.padding,
  });
}

/// Props for loading state components.
class LoadingStateProps {
  /// Loading message
  final String? message;

  const LoadingStateProps({
    this.message,
  });
}

/// Props for error state components.
class ErrorStateProps {
  /// Error title
  final String? title;

  /// Error message
  final String? message;

  /// Action button
  final Component? action;

  const ErrorStateProps({
    this.title,
    this.message,
    this.action,
  });
}
