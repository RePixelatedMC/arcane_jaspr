import 'package:jaspr/jaspr.dart';

/// Auth split layout component properties.
class AuthSplitLayoutProps {
  final Component brandingContent;
  final Component formContent;
  final Component? mobileHeader;
  final bool reverseSides;

  const AuthSplitLayoutProps({
    required this.brandingContent,
    required this.formContent,
    this.mobileHeader,
    this.reverseSides = false,
  });
}
