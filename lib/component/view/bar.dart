import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

// Re-export props for usage
export '../../core/props/bar_props.dart';

/// An app bar / header component.
class ArcaneBar extends StatelessComponent {
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

  /// Custom height
  final double? height;

  /// Custom padding
  final EdgeInsets? padding;

  const ArcaneBar({
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
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.bar(BarProps(
      titleText: titleText,
      title: title,
      subtitleText: subtitleText,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      backButton: backButton,
      onBack: onBack,
      transparent: transparent,
      centerTitle: centerTitle,
      height: height,
      padding: padding?.padding,
    ));
  }
}

/// A simple top bar for dialogs
class ArcaneDialogBar extends StatelessComponent {
  final String? title;
  final void Function()? onClose;

  const ArcaneDialogBar({
    this.title,
    this.onClose,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.dialogBar(DialogBarProps(
      title: title,
      onClose: onClose,
    ));
  }
}
