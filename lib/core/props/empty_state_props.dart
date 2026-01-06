import 'package:jaspr/jaspr.dart';

/// Empty state style variants
enum EmptyStateStyleVariant {
  /// Default centered style
  centered,

  /// Compact inline style
  compact,

  /// Card-wrapped style
  card,
}

/// Empty state size variants
enum EmptyStateSizeVariant {
  sm,
  md,
  lg,
}

/// Properties for empty state components.
class EmptyStateProps {
  /// Icon or illustration (can be emoji, icon component, or image)
  final Component? icon;

  /// Emoji shortcut (alternative to icon)
  final String? emoji;

  /// Title text
  final String title;

  /// Description text
  final String? description;

  /// Primary action button
  final Component? action;

  /// Secondary action button
  final Component? secondaryAction;

  /// Style variant
  final EmptyStateStyleVariant style;

  /// Size variant
  final EmptyStateSizeVariant size;

  const EmptyStateProps({
    required this.title,
    this.icon,
    this.emoji,
    this.description,
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyleVariant.centered,
    this.size = EmptyStateSizeVariant.md,
  });

  /// Create a copy with modified properties
  EmptyStateProps copyWith({
    Component? icon,
    String? emoji,
    String? title,
    String? description,
    Component? action,
    Component? secondaryAction,
    EmptyStateStyleVariant? style,
    EmptyStateSizeVariant? size,
  }) {
    return EmptyStateProps(
      icon: icon ?? this.icon,
      emoji: emoji ?? this.emoji,
      title: title ?? this.title,
      description: description ?? this.description,
      action: action ?? this.action,
      secondaryAction: secondaryAction ?? this.secondaryAction,
      style: style ?? this.style,
      size: size ?? this.size,
    );
  }
}
