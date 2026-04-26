import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

class ArcaneScaffold extends StatelessWidget {
  final String? title;
  final Widget? navigation;
  final Widget? actions;
  final Widget? sidebar;
  final Widget body;
  final Widget? secondary;
  final Widget? footer;
  final Widget? floatingAction;

  const ArcaneScaffold({
    this.title,
    this.navigation,
    this.actions,
    this.sidebar,
    required this.body,
    this.secondary,
    this.footer,
    this.floatingAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) => context.layouts.scaffold(
    ArcaneScaffoldProps(
      title: title,
      navigation: navigation,
      actions: actions,
      sidebar: sidebar,
      body: body,
      secondary: secondary,
      footer: footer,
      floatingAction: floatingAction,
    ),
  );
}
