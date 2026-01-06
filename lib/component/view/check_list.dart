import 'package:jaspr/jaspr.dart';

import '../../core/props/check_list_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/check_list_props.dart';

/// A single check item with icon and text.
///
/// ```dart
/// ArcaneCheckItem(
///   text: 'Shared models across web and server',
/// )
///
/// ArcaneCheckItem.success(
///   text: 'All tests passing',
/// )
/// ```
class ArcaneCheckItem extends StatelessComponent {
  /// The text content
  final String text;

  /// Icon style
  final CheckStyle icon;

  /// Icon color
  final String? iconColor;

  /// Text color
  final String? textColor;

  /// Font size
  final String? fontSize;

  /// Gap between icon and text
  final String? gap;

  const ArcaneCheckItem({
    required this.text,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.gap,
    super.key,
  });

  /// Create with brand/accent colored icon
  const ArcaneCheckItem.brand({
    required this.text,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.gap,
    super.key,
  }) : iconColor = 'var(--accent)';

  /// Create with success/green colored icon
  const ArcaneCheckItem.success({
    required this.text,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.gap,
    super.key,
  }) : iconColor = 'hsl(142 76% 36%)';

  @override
  Component build(BuildContext context) {
    return context.renderers.checkItem(CheckItemProps(
      text: text,
      icon: icon,
      iconColor: iconColor,
      textColor: textColor,
      fontSize: fontSize,
      gap: gap,
    ));
  }
}

/// A list of check items.
///
/// Common for feature lists, benefits, and requirements.
///
/// ```dart
/// ArcaneCheckList(
///   items: [
///     'Shared models across web and server',
///     'Type-safe API calls',
///     'Hot reload in development',
///     'Server-side rendering',
///   ],
/// )
///
/// ArcaneCheckList.brand(
///   items: ['Feature 1', 'Feature 2', 'Feature 3'],
/// )
/// ```
class ArcaneCheckList extends StatelessComponent {
  /// List of text items
  final List<String> items;

  /// Icon style for all items
  final CheckStyle icon;

  /// Icon color for all items
  final String? iconColor;

  /// Text color for all items
  final String? textColor;

  /// Font size for all items
  final String? fontSize;

  /// Gap between icon and text in each item
  final String? itemGap;

  /// Gap between items in the list
  final String? listGap;

  /// Cross axis alignment
  final String? alignItems;

  const ArcaneCheckList({
    required this.items,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
    super.key,
  });

  /// Create with brand/accent colored icons
  const ArcaneCheckList.brand({
    required this.items,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
    super.key,
  }) : iconColor = 'var(--accent)';

  /// Create with success/green colored icons
  const ArcaneCheckList.success({
    required this.items,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
    super.key,
  }) : iconColor = 'hsl(142 76% 36%)';

  @override
  Component build(BuildContext context) {
    return context.renderers.checkList(CheckListProps(
      items: items,
      icon: icon,
      iconColor: iconColor,
      textColor: textColor,
      fontSize: fontSize,
      itemGap: itemGap,
      listGap: listGap,
      alignItems: alignItems,
    ));
  }
}

/// A feature/benefit row commonly used in pricing or comparison sections.
///
/// ```dart
/// ArcaneFeatureRow(
///   feature: 'Unlimited API calls',
///   included: true,
/// )
/// ```
class ArcaneFeatureRow extends StatelessComponent {
  /// Feature text
  final String feature;

  /// Whether the feature is included
  final bool included;

  /// Custom included icon color
  final String? includedColor;

  /// Custom excluded icon color
  final String? excludedColor;

  const ArcaneFeatureRow({
    required this.feature,
    this.included = true,
    this.includedColor,
    this.excludedColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.featureRow(FeatureRowProps(
      feature: feature,
      included: included,
      includedColor: includedColor,
      excludedColor: excludedColor,
    ));
  }
}
