import 'package:jaspr/jaspr.dart';

/// Back button display mode
enum BarBackButtonMode {
  always,
  never,
  auto,
}

/// Properties for bar/app bar components.
class BarProps {
  /// Title text
  final String? titleText;

  /// Title component (overrides titleText)
  final Component? title;

  /// Subtitle text
  final String? subtitleText;

  /// Subtitle component (overrides subtitleText)
  final Component? subtitle;

  /// Leading components
  final List<Component>? leading;

  /// Trailing components
  final List<Component>? trailing;

  /// Back button mode
  final BarBackButtonMode backButton;

  /// Custom back button handler
  final void Function()? onBack;

  /// Whether the bar is transparent
  final bool transparent;

  /// Whether to center the title
  final bool centerTitle;

  /// Custom height (in pixels)
  final double? height;

  /// Custom padding (as CSS string)
  final String? padding;

  const BarProps({
    this.titleText,
    this.title,
    this.subtitleText,
    this.subtitle,
    this.leading,
    this.trailing,
    this.backButton = BarBackButtonMode.auto,
    this.onBack,
    this.transparent = false,
    this.centerTitle = false,
    this.height,
    this.padding,
  });
}

/// Properties for dialog bar components.
class DialogBarProps {
  final String? title;
  final void Function()? onClose;

  const DialogBarProps({
    this.title,
    this.onClose,
  });
}
