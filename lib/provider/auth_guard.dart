import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:web/web.dart' as web;

/// Route protection for authenticated users.
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
    final AuthState state = context.authState;

    if (state.isUnknown || state.isLoading) {
      return loadingIndicator ?? _buildDefaultLoader();
    }

    if (!state.isAuthenticated) {
      _scheduleRedirect();
      return loadingIndicator ?? _buildDefaultLoader();
    }

    if (requireAdmin) {
      final AuthUser user = state.user!;
      final bool hasAdminAccess = isAdmin?.call(user) ?? false;

      if (!hasAdminAccess) {
        _scheduleRedirect();
        return loadingIndicator ?? _buildDefaultLoader();
      }
    }

    return child;
  }

  void _scheduleRedirect() {
    Future<void>.microtask(() {
      web.window.location.href = redirectTo;
    });
  }

  Component _buildDefaultLoader() {
    return const ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
        height: Size.screen,
        width: Size.full,
        background: Background.background,
      ),
      children: <Component>[
        div(
          styles: Styles(raw: <String, String>{
            'width': '40px',
            'height': '40px',
            'border': '3px solid var(--border)',
            'border-top-color': 'var(--primary)',
            'border-radius': '9999px',
            'animation': 'arcane-spin 0.75s linear infinite',
          }),
          <Component>[],
        ),
      ],
    );
  }
}

/// Route protection for guests (unauthenticated users).
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
    final AuthState state = context.authState;

    if (state.isUnknown || state.isLoading) {
      return loadingIndicator ?? _buildDefaultLoader();
    }

    if (state.isAuthenticated) {
      Future<void>.microtask(() {
        web.window.location.href = redirectTo;
      });
      return loadingIndicator ?? _buildDefaultLoader();
    }

    return child;
  }

  Component _buildDefaultLoader() {
    return const ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
        height: Size.screen,
        width: Size.full,
        background: Background.background,
      ),
      children: <Component>[
        div(
          styles: Styles(raw: <String, String>{
            'width': '40px',
            'height': '40px',
            'border': '3px solid var(--border)',
            'border-top-color': 'var(--primary)',
            'border-radius': '9999px',
            'animation': 'arcane-spin 0.75s linear infinite',
          }),
          <Component>[],
        ),
      ],
    );
  }
}
