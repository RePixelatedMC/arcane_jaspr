/// Style for the check icon
enum CheckStyle {
  /// Checkmark
  check,

  /// Bullet point
  bullet,

  /// Arrow
  arrow,

  /// Plus
  plus,

  /// Star
  star,
}

/// Properties for check item components.
class CheckItemProps {
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

  const CheckItemProps({
    required this.text,
    this.icon = CheckStyle.check,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.gap,
  });
}

/// Properties for check list components.
class CheckListProps {
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

/// Properties for feature row components.
class FeatureRowProps {
  /// Feature text
  final String feature;

  /// Whether the feature is included
  final bool included;

  /// Custom included icon color
  final String? includedColor;

  /// Custom excluded icon color
  final String? excludedColor;

  const FeatureRowProps({
    required this.feature,
    this.included = true,
    this.includedColor,
    this.excludedColor,
  });
}
