import 'package:jaspr/jaspr.dart';

/// Properties for auth split layout components.
class AuthSplitLayoutProps {
  /// Content for the left branding panel
  final Component brandingContent;

  /// Content for the right form panel
  final Component formContent;

  /// Optional header shown on mobile (when branding panel is hidden)
  final Component? mobileHeader;

  /// Swap the left and right panels
  final bool reverseSides;

  const AuthSplitLayoutProps({
    required this.brandingContent,
    required this.formContent,
    this.mobileHeader,
    this.reverseSides = false,
  });
}
