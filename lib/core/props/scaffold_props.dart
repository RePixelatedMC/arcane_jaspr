import 'package:arcane_jaspr/flutter.dart';

class ArcaneScaffoldProps {
  final String? title;
  final Widget? navigation;
  final Widget? actions;
  final Widget? sidebar;
  final Widget body;
  final Widget? secondary;
  final Widget? footer;
  final Widget? floatingAction;

  const ArcaneScaffoldProps({
    this.title,
    this.navigation,
    this.actions,
    this.sidebar,
    required this.body,
    this.secondary,
    this.footer,
    this.floatingAction,
  });
}

mixin ScaffoldRendererContract {
  Widget scaffold(ArcaneScaffoldProps props);
}
