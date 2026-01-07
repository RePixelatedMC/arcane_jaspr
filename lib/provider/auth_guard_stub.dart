import 'package:jaspr/jaspr.dart';

import '../service/auth_state.dart';

/// Stub route protection for non-web platforms.
class AuthGuard extends StatelessComponent {
  final Component child;
  final Component? loadingIndicator;
  final String redirectTo;
  final bool requireAdmin;
  final bool Function(AuthUser user)? isAdmin;

  const AuthGuard({
    required this.child,
    this.loadingIndicator,
    this.redirectTo = '/login',
    this.requireAdmin = false,
    this.isAdmin,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return child;
  }
}

/// Stub guest route protection for non-web platforms.
class GuestGuard extends StatelessComponent {
  final Component child;
  final Component? loadingIndicator;
  final String redirectTo;

  const GuestGuard({
    required this.child,
    this.loadingIndicator,
    this.redirectTo = '/dashboard',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return child;
  }
}
