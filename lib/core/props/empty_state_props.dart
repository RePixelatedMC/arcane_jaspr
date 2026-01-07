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
  final String? emoji;
  final String title;
  final String? description;
  final Component? action;
  final Component? secondaryAction;
  final EmptyStateStyleVariant style;
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
