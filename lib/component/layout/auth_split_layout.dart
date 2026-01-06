import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/auth_split_layout_props.dart';

/// Split-screen layout for authentication pages.
///
/// Renders a two-column layout with branding content on the left
/// and form content on the right. On mobile, only the form panel
/// is shown with an optional header.
class AuthSplitLayout extends StatelessComponent {
  /// Content for the left branding panel
  final Component brandingContent;

  /// Content for the right form panel
  final Component formContent;

  /// Optional header shown on mobile (when branding panel is hidden)
  final Component? mobileHeader;

  /// Swap the left and right panels
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
