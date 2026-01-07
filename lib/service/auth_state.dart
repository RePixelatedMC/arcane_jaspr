/// Authentication status enumeration.
enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  loading,
  error,
}

/// Represents an authenticated user.
class AuthUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final String? idToken;
  final bool isAnonymous;
  final bool emailVerified;

  const AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.idToken,
    this.isAnonymous = false,
    this.emailVerified = false,
  });

  AuthUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? idToken,
    bool? isAnonymous,
    bool? emailVerified,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      idToken: idToken ?? this.idToken,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  String toString() =>
      'AuthUser(uid: $uid, email: $email, displayName: $displayName)';
}

/// Authentication state container.
class AuthState {
  final AuthStatus status;
  final AuthUser? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.error,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;

  bool get isLoading => status == AuthStatus.loading;

  bool get hasError => status == AuthStatus.error;

  bool get isUnknown => status == AuthStatus.unknown;

  const AuthState.loading()
      : status = AuthStatus.loading,
        user = null,
        error = null;

  AuthState.authenticated(AuthUser authenticatedUser)
      : status = AuthStatus.authenticated,
        user = authenticatedUser,
        error = null;

  const AuthState.unauthenticated()
      : status = AuthStatus.unauthenticated,
        user = null,
        error = null;

  AuthState.withError(String errorMessage)
      : status = AuthStatus.error,
        user = null,
        error = errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'AuthState(status: $status, user: $user, error: $error)';
}

/// Supported authentication methods.
enum AuthMethod {
  email,
  github,
  google,
  apple,
  anonymous,
}
