import 'package:jaspr/jaspr.dart';

/// Props for a single breadcrumb item
class BreadcrumbItemProps {
  /// Display label
  final String label;

  /// Navigation href (null for current/last item)
  final String? href;

  /// Optional icon component
  final Component? icon;

  const BreadcrumbItemProps({
    required this.label,
    this.href,
    this.icon,
  });
}

/// Separator style for breadcrumbs
enum BreadcrumbSeparatorStyle {
  /// Slash separator (/)
  slash,

  /// Chevron separator (>)
  chevron,

  /// Arrow separator (->)
  arrow,

  /// Dot separator (.)
  dot,
}

/// Size variants for breadcrumbs
enum BreadcrumbSizeVariant {
  sm,
  md,
  lg,
}

/// Props for the breadcrumbs component
class BreadcrumbsProps {
  /// List of breadcrumb items
  final List<BreadcrumbItemProps> items;

  /// Separator style
  final BreadcrumbSeparatorStyle separator;

  /// Size variant
  final BreadcrumbSizeVariant size;

  /// Whether to show home icon for first item
  final bool showHomeIcon;

  /// Custom separator component (overrides separator style)
  final Component? customSeparator;

  /// Click handler for breadcrumb items
  final void Function(BreadcrumbItemProps item, int index)? onItemClick;

  const BreadcrumbsProps({
    required this.items,
    this.separator = BreadcrumbSeparatorStyle.chevron,
    this.size = BreadcrumbSizeVariant.md,
    this.showHomeIcon = false,
    this.customSeparator,
    this.onItemClick,
  });
}
