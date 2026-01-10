import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/check_list_props.dart';

/// A single check item with icon and text.
class ArcaneCheckItem extends StatelessComponent {
  final String text;
  final CheckStyle icon;
  final String? iconColor;
  final String? textColor;
  final String? fontSize;
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

  const ArcaneCheckItem.brand({
    required this.text,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.gap,
    super.key,
  }) : iconColor = 'var(--accent)';

  const ArcaneCheckItem.success({
    required this.text,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.gap,
    super.key,
  }) : iconColor = 'var(--success)';

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
class ArcaneCheckList extends StatelessComponent {
  final List<String> items;
  final CheckStyle icon;
  final String? iconColor;
  final String? textColor;
  final String? fontSize;
  final String? itemGap;
  final String? listGap;
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

  const ArcaneCheckList.success({
    required this.items,
    this.icon = CheckStyle.check,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
    super.key,
  }) : iconColor = 'var(--success)';

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
class ArcaneFeatureRow extends StatelessComponent {
  final String feature;
  final bool included;
  final String? includedColor;
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
