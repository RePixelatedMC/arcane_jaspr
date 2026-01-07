import 'package:jaspr/jaspr.dart';

/// Breadcrumb item data.
class BreadcrumbItemProps {
  final String label;
  final String? href;
  final Component? icon;

  const BreadcrumbItemProps({
    required this.label,
    this.href,
    this.icon,
  });
}

enum BreadcrumbSeparatorStyle {
  slash,
  chevron,
  arrow,
  dot,
}

enum BreadcrumbSizeVariant {
  sm,
  md,
  lg,
}

/// Breadcrumbs component properties.
class BreadcrumbsProps {
  final List<BreadcrumbItemProps> items;
  final BreadcrumbSeparatorStyle separator;
  final BreadcrumbSizeVariant size;
  final bool showHomeIcon;
  final Component? customSeparator;
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
