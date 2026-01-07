enum CheckStyle {
  check,
  bullet,
  arrow,
  plus,
  star,
}

/// Check item component properties.
class CheckItemProps {
  final String text;
  final CheckStyle icon;
  final String? iconColor;
  final String? textColor;
  final String? fontSize;
  final String? gap;

  const CheckItemProps({
    required this.text,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.gap,
  });
}

/// Check list component properties.
class CheckListProps {
  final List<String> items;
  final CheckStyle icon;
  final String? iconColor;
  final String? textColor;
  final String? fontSize;
  final String? itemGap;
  final String? listGap;
  final String? alignItems;

  const CheckListProps({
    required this.items,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.itemGap,
    this.listGap,
    this.alignItems,
  });
}

/// Feature row component properties.
class FeatureRowProps {
  final String feature;
  final bool included;
  final String? includedColor;
  final String? excludedColor;

  const FeatureRowProps({
    required this.feature,
    this.included = true,
    this.includedColor,
    this.excludedColor,
  });
}
