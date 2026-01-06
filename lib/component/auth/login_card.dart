import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Login card component
///
/// Provides a complete login UI with email/password form and social sign-in buttons.
///
/// ```dart
/// ArcaneLoginCard(
///   methods: [AuthMethod.email, AuthMethod.github, AuthMethod.google],
///   signupRoute: '/signup',
///   forgotPasswordRoute: '/forgot-password',
///   header: Logo(),
/// )
/// ```
class ArcaneLoginCard extends StatefulComponent {
  /// Authentication methods to display
  final List<AuthMethod> methods;

  /// Header component (logo, title, etc.)
  final Component? header;

  /// Route for signup link
  final String? signupRoute;

  /// Route for forgot password link
  final String? forgotPasswordRoute;

  /// Password validation policy
  final PasswordPolicy? passwordPolicy;

  /// Callback when login succeeds
  final void Function()? onSuccess;

  /// Max width of the card
  final String maxWidth;

  const ArcaneLoginCard({
    this.methods = const <AuthMethod>[
      AuthMethod.email,
      AuthMethod.github,
      AuthMethod.google,
    ],
    this.header,
    this.signupRoute,
    this.forgotPasswordRoute,
    this.passwordPolicy,
    this.onSuccess,
    this.maxWidth = '400px',
    super.key,
  });

  @override
  State<ArcaneLoginCard> createState() => _ArcaneLoginCardState();
}

class _ArcaneLoginCardState extends State<ArcaneLoginCard> {
  String _email = '';
  String _password = '';
  bool _loading = false;
  String? _error;

  bool get _hasEmailMethod => component.methods.contains(AuthMethod.email);
  bool get _hasGithubMethod => component.methods.contains(AuthMethod.github);
  bool get _hasGoogleMethod => component.methods.contains(AuthMethod.google);
  bool get _hasAppleMethod => component.methods.contains(AuthMethod.apple);
  bool get _hasSocialMethods =>
      _hasGithubMethod || _hasGoogleMethod || _hasAppleMethod;

  Future<void> _handleEmailSubmit() async {
    if (_email.isEmpty || _password.isEmpty) {
      setState(() => _error = 'Please enter your email and password.');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await context.signInWithEmail(_email, _password);
      component.onSuccess?.call();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        width: Size.full,
        maxWidthCustom: component.maxWidth,
        padding: PaddingPreset.xl,
        background: Background.surface,
        border: BorderPreset.standard,
        borderRadius: Radius.lg,
        shadow: Shadow.lg,
      ),
      children: <Component>[
        // Header
        if (component.header != null) ...<Component>[
          component.header!,
          div(
            styles: const Styles(raw: {'height': '1.5rem'}),
            [],
          ),
        ],

        // Title
        const ArcaneDiv(
          styles: ArcaneStyleData(
            margin: MarginPreset.bottomXs,
            fontSize: FontSize.xl,
            fontWeight: FontWeight.w600,
            textColor: TextColor.primary,
            textAlign: TextAlign.center,
          ),
          children: [Component.text('Welcome back')],
        ),

        const ArcaneDiv(
          styles: ArcaneStyleData(
            margin: MarginPreset.bottomLg,
            fontSize: FontSize.sm,
            textColor: TextColor.mutedForeground,
            textAlign: TextAlign.center,
          ),
          children: [Component.text('Sign in to your account')],
        ),

        // Error message
        if (_error != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              padding: PaddingPreset.md,
              margin: MarginPreset.bottomMd,
              backgroundCustom: 'hsl(var(--destructive) / 0.1)',
              borderCustom: '1px solid hsl(var(--destructive) / 0.3)',
              borderRadius: Radius.md,
              textColor: TextColor.error,
              fontSize: FontSize.sm,
            ),
            children: <Component>[Component.text(_error!)],
          ),

        // Social sign-in buttons
        if (_hasSocialMethods) ...<Component>[
          ArcaneDiv(
            styles: const ArcaneStyleData(
              display: Display.flex,
              flexDirection: FlexDirection.column,
              gap: Gap.sm,
            ),
            children: <Component>[
              if (_hasGithubMethod)
                GithubSignInButton(
                  fullWidth: true,
                  disabled: _loading,
                ),
              if (_hasGoogleMethod)
                GoogleSignInButton(
                  fullWidth: true,
                  disabled: _loading,
                ),
              if (_hasAppleMethod)
                AppleSignInButton(
                  fullWidth: true,
                  disabled: _loading,
                ),
            ],
          ),
        ],

        // Divider
        if (_hasSocialMethods && _hasEmailMethod)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              display: Display.flex,
              alignItems: AlignItems.center,
              gap: Gap.md,
              margin: MarginPreset.verticalLg,
            ),
            children: <Component>[
              div(
                styles: const Styles(raw: {
                  'flex': '1',
                  'height': '1px',
                  'background-color': 'var(--border)',
                }),
                [],
              ),
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  fontSize: FontSize.xs,
                  textColor: TextColor.mutedForeground,
                  textTransform: TextTransform.uppercase,
                  letterSpacing: LetterSpacing.wide,
                ),
                children: [Component.text('or continue with email')],
              ),
              div(
                styles: const Styles(raw: {
                  'flex': '1',
                  'height': '1px',
                  'background-color': 'var(--border)',
                }),
                [],
              ),
            ],
          ),

        // Email/password form
        if (_hasEmailMethod)
          form(
            events: {
              'submit': (event) {
                event.preventDefault();
                _handleEmailSubmit();
              },
            },
            <Component>[
              // Email field
              ArcaneDiv(
                styles: const ArcaneStyleData(margin: MarginPreset.bottomMd),
                children: <Component>[
                  const label(
                    styles: Styles(raw: <String, String>{
                      'display': 'block',
                      'margin-bottom': '0.25rem',
                      'font-size': '0.875rem',
                      'font-weight': '500',
                      'color': 'var(--foreground)',
                    }),
                    <Component>[Component.text('Email')],
                  ),
                  input(
                    attributes: <String, String>{
                      'type': 'email',
                      'placeholder': 'you@example.com',
                      'autocomplete': 'email',
                      'required': 'true',
                    },
                    styles: const Styles(raw: <String, String>{
                      'width': '100%',
                      'padding': '0.5rem 1rem',
                      'font-size': '0.875rem',
                      'background': 'var(--muted)',
                      'border': '1px solid var(--border)',
                      'border-radius': '0.375rem',
                      'color': 'var(--foreground)',
                      'outline': 'none',
                      'transition': 'all 150ms ease',
                      'box-sizing': 'border-box',
                    }),
                    events: {
                      'input': (event) {
                        final dynamic target = event.target;
                        if (target != null) {
                          setState(() => _email = (target as dynamic).value ?? '');
                        }
                      },
                    },
                  ),
                ],
              ),

              // Password field
              ArcaneDiv(
                styles: const ArcaneStyleData(margin: MarginPreset.bottomMd),
                children: <Component>[
                  ArcaneDiv(
                    styles: const ArcaneStyleData(
                      display: Display.flex,
                      justifyContent: JustifyContent.spaceBetween,
                      alignItems: AlignItems.center,
                      margin: MarginPreset.bottomXs,
                    ),
                    children: <Component>[
                      const label(
                        styles: Styles(raw: <String, String>{
                          'font-size': '0.875rem',
                          'font-weight': '500',
                          'color': 'var(--foreground)',
                        }),
                        <Component>[Component.text('Password')],
                      ),
                      if (component.forgotPasswordRoute != null)
                        a(
                          href: component.forgotPasswordRoute!,
                          styles: const Styles(raw: <String, String>{
                            'font-size': '0.75rem',
                            'color': 'var(--accent)',
                            'text-decoration': 'none',
                          }),
                          <Component>[const Component.text('Forgot password?')],
                        ),
                    ],
                  ),
                  input(
                    attributes: <String, String>{
                      'type': 'password',
                      'placeholder': 'Enter your password',
                      'autocomplete': 'current-password',
                      'required': 'true',
                    },
                    styles: const Styles(raw: <String, String>{
                      'width': '100%',
                      'padding': '0.5rem 1rem',
                      'font-size': '0.875rem',
                      'background': 'var(--muted)',
                      'border': '1px solid var(--border)',
                      'border-radius': '0.375rem',
                      'color': 'var(--foreground)',
                      'outline': 'none',
                      'transition': 'all 150ms ease',
                      'box-sizing': 'border-box',
                    }),
                    events: {
                      'input': (event) {
                        final dynamic target = event.target;
                        if (target != null) {
                          setState(() => _password = (target as dynamic).value ?? '');
                        }
                      },
                    },
                  ),
                ],
              ),

              // Submit button
              ArcaneButton(
                label: _loading ? 'Signing in...' : 'Sign in',
                fullWidth: true,
                disabled: _loading,
                loading: _loading,
                onPressed: _handleEmailSubmit,
              ),
            ],
          ),

        // Signup link
        if (component.signupRoute != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              margin: MarginPreset.topLg,
              textAlign: TextAlign.center,
              fontSize: FontSize.sm,
              textColor: TextColor.mutedForeground,
            ),
            children: <Component>[
              const Component.text("Don't have an account? "),
              a(
                href: component.signupRoute!,
                styles: const Styles(raw: <String, String>{
                  'color': 'var(--accent)',
                  'text-decoration': 'none',
                  'font-weight': '500',
                }),
                <Component>[const Component.text('Sign up')],
              ),
            ],
          ),
      ],
    );
  }
}
