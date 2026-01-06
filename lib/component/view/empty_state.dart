import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for backwards compatibility
export '../../core/props/empty_state_props.dart'
    show EmptyStateStyleVariant, EmptyStateSizeVariant, EmptyStateProps;

/// Empty state style variants (local alias)
typedef EmptyStateStyle = EmptyStateStyleVariant;

/// Empty state size variants (local alias)
typedef EmptyStateSize = EmptyStateSizeVariant;

/// Empty state placeholder component
///
/// Displays a friendly message when there's no content to show.
///
/// ```dart
/// ArcaneEmptyState(
///   icon: '📭',
///   title: 'No messages',
///   description: 'Your inbox is empty.',
///   action: ArcaneButton(label: 'Compose', onPressed: () {}),
/// )
/// ```
class ArcaneEmptyState extends StatelessComponent {
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
  final EmptyStateStyle style;

  /// Size variant
  final EmptyStateSize size;

  const ArcaneEmptyState({
    required this.title,
    this.icon,
    this.emoji,
    this.description,
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  });

  /// No results variant
  const ArcaneEmptyState.noResults({
    this.title = 'No results found',
    this.description = 'Try adjusting your search or filter criteria.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  })  : icon = null,
        emoji = '🔍';

  /// No data variant
  const ArcaneEmptyState.noData({
    this.title = 'No data yet',
    this.description = 'Start by adding your first item.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  })  : icon = null,
        emoji = '📊';

  /// Error variant
  const ArcaneEmptyState.error({
    this.title = 'Something went wrong',
    this.description = 'An error occurred while loading the content.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  })  : icon = null,
        emoji = '⚠️';

  /// Offline variant
  const ArcaneEmptyState.offline({
    this.title = 'You\'re offline',
    this.description = 'Check your internet connection and try again.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    super.key,
  })  : icon = null,
        emoji = '📡';

  EmptyStateStyleVariant get _propsStyle => switch (style) {
        EmptyStateStyle.centered => EmptyStateStyleVariant.centered,
        EmptyStateStyle.compact => EmptyStateStyleVariant.compact,
        EmptyStateStyle.card => EmptyStateStyleVariant.card,
      };

  EmptyStateSizeVariant get _propsSize => switch (size) {
        EmptyStateSize.sm => EmptyStateSizeVariant.sm,
        EmptyStateSize.md => EmptyStateSizeVariant.md,
        EmptyStateSize.lg => EmptyStateSizeVariant.lg,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.emptyState(EmptyStateProps(
      icon: icon,
      emoji: emoji,
      title: title,
      description: description,
      action: action,
      secondaryAction: secondaryAction,
      style: _propsStyle,
      size: _propsSize,
    ));
  }
}