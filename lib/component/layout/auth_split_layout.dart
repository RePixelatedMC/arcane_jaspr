import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/auth_split_layout_props.dart';

/// Split-screen layout for authentication pages.
class AuthSplitLayout extends StatelessComponent {
  final Component brandingContent;
  final Component formContent;
  final Component? mobileHeader;
  final bool reverseSides;

  const AuthSplitLayout({
    super.key,
    required this.brandingContent,
    required this.formContent,
    this.mobileHeader,
    this.reverseSides = false,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.authSplitLayout(AuthSplitLayoutProps(
      brandingContent: brandingContent,
      formContent: formContent,
      mobileHeader: mobileHeader,
      reverseSides: reverseSides,
    ));
  }
}
