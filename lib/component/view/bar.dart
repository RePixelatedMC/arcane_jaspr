import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

export '../../core/props/bar_props.dart';

/// An app bar / header component.
class ArcaneBar extends StatelessComponent {
  final String? titleText;
  final Component? title;
  final String? subtitleText;
  final Component? subtitle;
  final List<Component>? leading;
  final List<Component>? trailing;
  final BarBackButtonMode backButton;
  final void Function()? onBack;
  final bool transparent;
  final bool centerTitle;
  final double? height;
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

/// A simple top bar for dialogs.
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
