import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/breadcrumbs_props.dart'
    show BreadcrumbItemProps, BreadcrumbSeparatorStyle, BreadcrumbSizeVariant;

/// A breadcrumb item in the navigation trail
class BreadcrumbItem {
  /// The display label for this breadcrumb
  final String label;

  /// The navigation href (null for current/last item)
  final String? href;

  /// Optional icon to display before the label
  final Component? icon;

  const BreadcrumbItem({
    required this.label,
    this.href,
    this.icon,
  });
}

/// Breadcrumb separator styles
enum BreadcrumbSeparator {
  /// Slash separator (/)
  slash,

  /// Chevron separator (>)
  chevron,

  /// Arrow separator (->)
  arrow,

  /// Dot separator (.)
  dot,
}

/// Breadcrumb size variants
enum BreadcrumbSize {
  sm,
  md,
  lg,
}

/// Navigation breadcrumbs component matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/breadcrumb
///
/// Shows the current page location within a navigational hierarchy.
///
/// ```dart
/// ArcaneBreadcrumbs(
///   items: [
///     BreadcrumbItem(label: 'Home', href: '/'),
///     BreadcrumbItem(label: 'Products', href: '/products'),
///     BreadcrumbItem(label: 'Widget Pro'),
///   ],
/// )
/// ```
class ArcaneBreadcrumbs extends StatelessComponent {
  /// The list of breadcrumb items
  final List<BreadcrumbItem> items;

  /// The separator style between items
  final BreadcrumbSeparator separator;

  /// Size variant
  final BreadcrumbSize size;

  /// Whether to show home icon for first item
  final bool showHomeIcon;

  /// Custom separator widget (overrides separator enum)
  final Component? customSeparator;

  /// Callback when a breadcrumb is clicked
  final void Function(BreadcrumbItem item, int index)? onItemClick;

  const ArcaneBreadcrumbs({
    required this.items,
    this.separator = BreadcrumbSeparator.chevron,
    this.size = BreadcrumbSize.md,
    this.showHomeIcon = false,
    this.customSeparator,
    this.onItemClick,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // Convert BreadcrumbItem to BreadcrumbItemProps
    final itemProps = items
        .map((item) => BreadcrumbItemProps(
              label: item.label,
              href: item.href,
              icon: item.icon,
            ))
        .toList();

    // Convert separator enum
    final separatorStyle = switch (separator) {
      BreadcrumbSeparator.slash => BreadcrumbSeparatorStyle.slash,
      BreadcrumbSeparator.chevron => BreadcrumbSeparatorStyle.chevron,
      BreadcrumbSeparator.arrow => BreadcrumbSeparatorStyle.arrow,
      BreadcrumbSeparator.dot => BreadcrumbSeparatorStyle.dot,
    };

    // Convert size enum
    final sizeVariant = switch (size) {
      BreadcrumbSize.sm => BreadcrumbSizeVariant.sm,
      BreadcrumbSize.md => BreadcrumbSizeVariant.md,
      BreadcrumbSize.lg => BreadcrumbSizeVariant.lg,
    };

    return context.renderers.breadcrumbs(BreadcrumbsProps(
      items: itemProps,
      separator: separatorStyle,
      size: sizeVariant,
      showHomeIcon: showHomeIcon,
      customSeparator: customSeparator,
      onItemClick: onItemClick != null
          ? (BreadcrumbItemProps itemProp, int index) {
              // Find the original BreadcrumbItem
              if (index < items.length) {
                onItemClick!(items[index], index);
              }
            }
          : null,
    ));
  }
}
