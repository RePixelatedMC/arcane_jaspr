import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;

/// Auth split layout component properties.
class AuthSplitLayoutProps {
  final Widget brandingContent;
  final Widget formContent;
  final Widget? mobileHeader;
  final bool reverseSides;

  const AuthSplitLayoutProps({
    required this.brandingContent,
    required this.formContent,
    this.mobileHeader,
    this.reverseSides = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for auth split layout components.
mixin AuthSplitLayoutRendererContract {
  Widget authSplitLayout(AuthSplitLayoutProps props);
}
