import 'dart:async';

import 'auth_state.dart';

/// Stub implementation of JasprAuthService for non-web platforms.
class JasprAuthService {
  static JasprAuthService? _instance;
  static JasprAuthService get instance {
    _instance ??= JasprAuthService._();
    return _instance!;
  }

  JasprAuthService._();

  Stream<AuthState> get authStateStream => Stream.value(const AuthState.unauthenticated());

  AuthState get currentState => const AuthState.unauthenticated();

  bool get isAuthenticated => false;

  AuthUser? get currentUser => null;

  void initialize({String? serverApiUrl}) {}

  Future<void> signInWithGitHub() async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  Future<void> signInWithGoogle() async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  Future<void> signInWithApple() async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  Future<void> signInWithEmail(String email, String password) async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  Future<void> registerWithEmail(String email, String password, String displayName) async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  Future<void> sendPasswordResetEmail(String email) async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  Future<String?> refreshToken() async => null;

  Future<bool> deleteAccount() async {
    throw UnsupportedError('Auth operations are only available on web platforms');
  }

  Future<void> signOut() async {}

  void dispose() {}
}
