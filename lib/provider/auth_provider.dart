import 'dart:async';

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:fast_log/fast_log.dart';
import 'package:web/web.dart' as web;

class _AuthInheritedProvider extends InheritedComponent {
  final AuthState state;

  const _AuthInheritedProvider({
    required this.state,
    required super.child,
  });

  static _AuthInheritedProvider? of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_AuthInheritedProvider>();
  }

  @override
  bool updateShouldNotify(_AuthInheritedProvider oldComponent) {
    return state.status != oldComponent.state.status ||
        state.user?.uid != oldComponent.state.user?.uid ||
        state.error != oldComponent.state.error;
  }
}

/// Provides authentication state throughout the component tree.
class ArcaneAuthProvider extends StatefulComponent {
  final Component child;
  final void Function(AuthState)? onAuthStateChanged;
  final String? redirectOnLogin;
  final String? redirectOnLogout;
  final String? serverApiUrl;

  const ArcaneAuthProvider({
    required this.child,
    this.onAuthStateChanged,
    this.redirectOnLogin,
    this.redirectOnLogout,
    this.serverApiUrl,
    super.key,
  });

  @override
  State<ArcaneAuthProvider> createState() => _ArcaneAuthProviderState();
}

class _ArcaneAuthProviderState extends State<ArcaneAuthProvider> {
  late final StreamSubscription<AuthState> _subscription;
  AuthState _state = const AuthState();
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    verbose('ArcaneAuthProvider initializing...');

    JasprAuthService.instance.initialize(serverApiUrl: component.serverApiUrl);

    _subscription = JasprAuthService.instance.authStateStream.listen(_onAuthStateChanged);

    _state = JasprAuthService.instance.currentState;
  }

  void _onAuthStateChanged(AuthState newState) {
    final AuthState previousState = _state;

    setState(() => _state = newState);

    component.onAuthStateChanged?.call(newState);

    if (!_hasInitialized) {
      _hasInitialized = true;
      verbose('Initial auth state received, skipping redirect');
      return;
    }

    if (newState.isAuthenticated && previousState.isLoading) {
      if (component.redirectOnLogin != null) {
        info('User authenticated, redirecting to ${component.redirectOnLogin}');
        _navigateTo(component.redirectOnLogin!);
      }
    } else if (!newState.isAuthenticated &&
               !newState.isLoading &&
               previousState.isAuthenticated) {
      if (component.redirectOnLogout != null) {
        info('User logged out, redirecting to ${component.redirectOnLogout}');
        _navigateTo(component.redirectOnLogout!);
      }
    }
  }

  void _navigateTo(String path) {
    Future<void>.microtask(() {
      web.window.location.href = path;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    return _AuthInheritedProvider(
      state: _state,
      child: component.child,
    );
  }
}

/// Extension for accessing auth state from any component.
extension AuthContextExtension on BuildContext {
  AuthState get authState {
    final _AuthInheritedProvider? provider = _AuthInheritedProvider.of(this);
    return provider?.state ?? const AuthState();
  }

  AuthUser? get currentUser => authState.user;

  bool get isAuthenticated => authState.isAuthenticated;

  bool get isAuthLoading => authState.isLoading;

  String? get uid => currentUser?.uid;

  String? get idToken => currentUser?.idToken;

  Future<void> signInWithGitHub() => JasprAuthService.instance.signInWithGitHub();

  Future<void> signInWithGoogle() => JasprAuthService.instance.signInWithGoogle();

  Future<void> signInWithApple() => JasprAuthService.instance.signInWithApple();

  Future<void> signInWithEmail(String email, String password) =>
      JasprAuthService.instance.signInWithEmail(email, password);

  Future<void> registerWithEmail(
          String email, String password, String displayName) =>
      JasprAuthService.instance.registerWithEmail(email, password, displayName);

  Future<void> sendPasswordResetEmail(String email) =>
      JasprAuthService.instance.sendPasswordResetEmail(email);

  Future<void> signOut() => JasprAuthService.instance.signOut();

  Future<String?> refreshAuthToken() => JasprAuthService.instance.refreshToken();

  Future<bool> deleteAccount() => JasprAuthService.instance.deleteAccount();
}
