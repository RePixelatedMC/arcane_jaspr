import 'package:arcane_jaspr/component/card/card.dart';
import 'package:arcane_jaspr/component/layout/section.dart';
import 'package:arcane_jaspr/flutter.dart';

class CardSection extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? subtitle;
  final String? titleText;
  final String? subtitleText;
  final List<Widget> children;
  final void Function()? onPressed;

  const CardSection({
    this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.titleText,
    this.subtitleText,
    this.children = const <Widget>[],
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Card.outlined(
    fillWidth: true,
    onTap: onPressed,
    child: Section(
      title: title,
      subtitle: subtitle,
      titleText: titleText,
      subtitleText: subtitleText,
      trailing: trailing,
      children: children,
      showDivider: children.isNotEmpty,
    ),
  );
}
