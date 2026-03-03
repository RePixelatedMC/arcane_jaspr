import 'package:jaspr/jaspr.dart';

enum EmptyStateStyleVariant {
  centered,
  compact,
  card,
}

enum EmptyStateSizeVariant {
  sm,
  md,
  lg,
}

/// Empty state component properties.
class EmptyStateProps {
  final Component? icon;
  final String title;
  final String? description;
  final Component? action;
  final Component? secondaryAction;
  final EmptyStateStyleVariant style;
  final EmptyStateSizeVariant size;

  const EmptyStateProps({
    required this.title,
    this.icon,
    this.description,
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyleVariant.centered,
    this.size = EmptyStateSizeVariant.md,
  });

  EmptyStateProps copyWith({
    Component? icon,
    String? title,
    String? description,
    Component? action,
    Component? secondaryAction,
    EmptyStateStyleVariant? style,
    EmptyStateSizeVariant? size,
  }) {
    return EmptyStateProps(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      action: action ?? this.action,
      secondaryAction: secondaryAction ?? this.secondaryAction,
      style: style ?? this.style,
      size: size ?? this.size,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for empty state components.
mixin EmptyStateRendererContract {
  /// Renders an empty state placeholder component.
  Component emptyState(EmptyStateProps props);
}
