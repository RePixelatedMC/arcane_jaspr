import 'package:arcane_jaspr/arcane_jaspr.dart';

/// OAuth provider types for social sign-in buttons.
enum SocialProvider {
  google,
  github,
  apple,
  microsoft,
  discord,
  twitter,
  facebook,
  linkedin,
  slack,
  gitlab,
}

class _SocialProviderConfig {
  final String defaultLabel;
  final String backgroundColor;
  final String foregroundColor;
  final String borderColor;
  final String hoverBackgroundColor;
  final Component Function() buildIcon;

  const _SocialProviderConfig({
    required this.defaultLabel,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.hoverBackgroundColor,
    required this.buildIcon,
  });
}

/// Social sign-in button with branded styling for OAuth providers.
class SocialSignInButton extends StatelessComponent {
  final SocialProvider? provider;
  final String? label;
  final Component? icon;
  final void Function()? onPressed;
  final ButtonSize size;
  final bool disabled;
  final bool loading;
  final bool fullWidth;
  final String? backgroundColor;
  final String? foregroundColor;
  final String? borderColor;
  final String? hoverBackgroundColor;

  const SocialSignInButton({
    this.provider,
    this.label,
    this.icon,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.hoverBackgroundColor,
    super.key,
  });

  const factory SocialSignInButton.google({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _GoogleSignInButton;

  const factory SocialSignInButton.github({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _GithubSignInButton;

  const factory SocialSignInButton.apple({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _AppleSignInButton;

  const factory SocialSignInButton.microsoft({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _MicrosoftSignInButton;

  const factory SocialSignInButton.discord({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _DiscordSignInButton;

  const factory SocialSignInButton.twitter({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _TwitterSignInButton;

  const factory SocialSignInButton.facebook({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _FacebookSignInButton;

  const factory SocialSignInButton.linkedin({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _LinkedInSignInButton;

  const factory SocialSignInButton.slack({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _SlackSignInButton;

  const factory SocialSignInButton.gitlab({
    void Function()? onPressed,
    String? label,
    ButtonSize size,
    bool fullWidth,
    bool disabled,
    bool loading,
    Key? key,
  }) = _GitLabSignInButton;

  static _SocialProviderConfig _getConfig(SocialProvider provider) {
    return switch (provider) {
      SocialProvider.google => const _SocialProviderConfig(
          defaultLabel: 'Continue with Google',
          backgroundColor: '#ffffff',
          foregroundColor: '#1f1f1f',
          borderColor: '#dadce0',
          hoverBackgroundColor: '#f8f9fa',
          buildIcon: _buildGoogleIcon,
        ),
      SocialProvider.github => const _SocialProviderConfig(
          defaultLabel: 'Continue with GitHub',
          backgroundColor: '#24292e',
          foregroundColor: '#ffffff',
          borderColor: '#24292e',
          hoverBackgroundColor: '#2f363d',
          buildIcon: _buildGithubIcon,
        ),
      SocialProvider.apple => const _SocialProviderConfig(
          defaultLabel: 'Continue with Apple',
          backgroundColor: '#000000',
          foregroundColor: '#ffffff',
          borderColor: '#000000',
          hoverBackgroundColor: '#1a1a1a',
          buildIcon: _buildAppleIcon,
        ),
      SocialProvider.microsoft => const _SocialProviderConfig(
          defaultLabel: 'Continue with Microsoft',
          backgroundColor: '#2f2f2f',
          foregroundColor: '#ffffff',
          borderColor: '#2f2f2f',
          hoverBackgroundColor: '#3f3f3f',
          buildIcon: _buildMicrosoftIcon,
        ),
      SocialProvider.discord => const _SocialProviderConfig(
          defaultLabel: 'Continue with Discord',
          backgroundColor: '#5865F2',
          foregroundColor: '#ffffff',
          borderColor: '#5865F2',
          hoverBackgroundColor: '#4752c4',
          buildIcon: _buildDiscordIcon,
        ),
      SocialProvider.twitter => const _SocialProviderConfig(
          defaultLabel: 'Continue with X',
          backgroundColor: '#000000',
          foregroundColor: '#ffffff',
          borderColor: '#000000',
          hoverBackgroundColor: '#1a1a1a',
          buildIcon: _buildTwitterIcon,
        ),
      SocialProvider.facebook => const _SocialProviderConfig(
          defaultLabel: 'Continue with Facebook',
          backgroundColor: '#1877F2',
          foregroundColor: '#ffffff',
          borderColor: '#1877F2',
          hoverBackgroundColor: '#166fe5',
          buildIcon: _buildFacebookIcon,
        ),
      SocialProvider.linkedin => const _SocialProviderConfig(
          defaultLabel: 'Continue with LinkedIn',
          backgroundColor: '#0A66C2',
          foregroundColor: '#ffffff',
          borderColor: '#0A66C2',
          hoverBackgroundColor: '#004182',
          buildIcon: _buildLinkedInIcon,
        ),
      SocialProvider.slack => const _SocialProviderConfig(
          defaultLabel: 'Continue with Slack',
          backgroundColor: '#4A154B',
          foregroundColor: '#ffffff',
          borderColor: '#4A154B',
          hoverBackgroundColor: '#611f64',
          buildIcon: _buildSlackIcon,
        ),
      SocialProvider.gitlab => const _SocialProviderConfig(
          defaultLabel: 'Continue with GitLab',
          backgroundColor: '#FC6D26',
          foregroundColor: '#ffffff',
          borderColor: '#FC6D26',
          hoverBackgroundColor: '#e24329',
          buildIcon: _buildGitLabIcon,
        ),
    };
  }

  @override
  Component build(BuildContext context) {
    final bool isDisabled = disabled || loading;

    final _SocialProviderConfig? config =
        provider != null ? _getConfig(provider!) : null;

    final String effectiveBg =
        backgroundColor ?? config?.backgroundColor ?? 'transparent';
    final String effectiveFg =
        foregroundColor ?? config?.foregroundColor ?? 'var(--foreground)';
    final String effectiveBorder =
        borderColor ?? config?.borderColor ?? 'var(--border)';
    final String effectiveHoverBg =
        hoverBackgroundColor ?? config?.hoverBackgroundColor ?? 'var(--muted)';

    final String effectiveLabel =
        label ?? config?.defaultLabel ?? 'Sign in';
    final Component? effectiveIcon = icon ?? config?.buildIcon();

    final Map<String, String> sizeStyles = switch (size) {
      ButtonSize.small => <String, String>{
          'padding': '8px 12px',
          'font-size': '0.75rem',
          'gap': '0.25rem',
        },
      ButtonSize.medium => <String, String>{
          'padding': '10px 16px',
          'font-size': '0.875rem',
          'gap': '0.25rem',
        },
      ButtonSize.large => <String, String>{
          'padding': '12px 20px',
          'font-size': '1rem',
          'gap': '0.5rem',
        },
      ButtonSize.icon ||
      ButtonSize.iconSmall ||
      ButtonSize.iconLarge =>
        <String, String>{
          'padding': '10px',
          'font-size': '0.875rem',
          'gap': '0',
        },
    };

    return button(
      classes: 'social-signin-button',
      attributes: <String, String>{
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
      },
      styles: Styles(raw: <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        ...sizeStyles,
        'font-weight': '500',
        'font-family': 'inherit',
        'background': effectiveBg,
        'color': effectiveFg,
        'border': '1px solid $effectiveBorder',
        'border-radius': '0.375rem',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'white-space': 'nowrap',
        'user-select': 'none',
        if (fullWidth) 'width': '100%',
      }),
      events: {
        'click': (_) {
          if (!isDisabled && onPressed != null) {
            onPressed!();
          }
        },
        'mouseenter': (event) {
          if (!isDisabled) {
            final dynamic target = event.target;
            if (target != null) {
              (target as dynamic).style.background = effectiveHoverBg;
            }
          }
        },
        'mouseleave': (event) {
          final dynamic target = event.target;
          if (target != null) {
            (target as dynamic).style.background = effectiveBg;
          }
        },
      },
      <Component>[
        if (loading)
          _buildSpinner()
        else if (effectiveIcon != null)
          effectiveIcon,
        Component.text(effectiveLabel),
      ],
    );
  }

  Component _buildSpinner() {
    return const span(
      styles: Styles(raw: <String, String>{
        'display': 'inline-block',
        'width': '16px',
        'height': '16px',
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': '9999px',
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      <Component>[],
    );
  }

  static Component _buildGoogleIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'fill': '#4285F4',
            'd':
                'M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'fill': '#34A853',
            'd':
                'M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'fill': '#FBBC05',
            'd':
                'M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'fill': '#EA4335',
            'd':
                'M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z',
          },
        ),
      ],
    );
  }

  static Component _buildGithubIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z',
          },
        ),
      ],
    );
  }

  static Component _buildAppleIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z',
          },
        ),
      ],
    );
  }

  static Component _buildMicrosoftIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 21 21',
        'fill': 'none',
      },
      children: <Component>[
        Component.element(
          tag: 'rect',
          attributes: <String, String>{
            'x': '1',
            'y': '1',
            'width': '9',
            'height': '9',
            'fill': '#F25022',
          },
        ),
        Component.element(
          tag: 'rect',
          attributes: <String, String>{
            'x': '11',
            'y': '1',
            'width': '9',
            'height': '9',
            'fill': '#7FBA00',
          },
        ),
        Component.element(
          tag: 'rect',
          attributes: <String, String>{
            'x': '1',
            'y': '11',
            'width': '9',
            'height': '9',
            'fill': '#00A4EF',
          },
        ),
        Component.element(
          tag: 'rect',
          attributes: <String, String>{
            'x': '11',
            'y': '11',
            'width': '9',
            'height': '9',
            'fill': '#FFB900',
          },
        ),
      ],
    );
  }

  static Component _buildDiscordIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M20.317 4.37a19.791 19.791 0 0 0-4.885-1.515.074.074 0 0 0-.079.037c-.21.375-.444.864-.608 1.25a18.27 18.27 0 0 0-5.487 0 12.64 12.64 0 0 0-.617-1.25.077.077 0 0 0-.079-.037A19.736 19.736 0 0 0 3.677 4.37a.07.07 0 0 0-.032.027C.533 9.046-.32 13.58.099 18.057a.082.082 0 0 0 .031.057 19.9 19.9 0 0 0 5.993 3.03.078.078 0 0 0 .084-.028 14.09 14.09 0 0 0 1.226-1.994.076.076 0 0 0-.041-.106 13.107 13.107 0 0 1-1.872-.892.077.077 0 0 1-.008-.128 10.2 10.2 0 0 0 .372-.292.074.074 0 0 1 .077-.01c3.928 1.793 8.18 1.793 12.062 0a.074.074 0 0 1 .078.01c.12.098.246.198.373.292a.077.077 0 0 1-.006.127 12.299 12.299 0 0 1-1.873.892.077.077 0 0 0-.041.107c.36.698.772 1.362 1.225 1.993a.076.076 0 0 0 .084.028 19.839 19.839 0 0 0 6.002-3.03.077.077 0 0 0 .032-.054c.5-5.177-.838-9.674-3.549-13.66a.061.061 0 0 0-.031-.03zM8.02 15.33c-1.183 0-2.157-1.085-2.157-2.419 0-1.333.956-2.419 2.157-2.419 1.21 0 2.176 1.096 2.157 2.42 0 1.333-.956 2.418-2.157 2.418zm7.975 0c-1.183 0-2.157-1.085-2.157-2.419 0-1.333.955-2.419 2.157-2.419 1.21 0 2.176 1.096 2.157 2.42 0 1.333-.946 2.418-2.157 2.418z',
          },
        ),
      ],
    );
  }

  static Component _buildTwitterIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '16',
        'height': '16',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z',
          },
        ),
      ],
    );
  }

  static Component _buildFacebookIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z',
          },
        ),
      ],
    );
  }

  static Component _buildLinkedInIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z',
          },
        ),
      ],
    );
  }

  static Component _buildSlackIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
        'fill': 'none',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M5.042 15.165a2.528 2.528 0 0 1-2.52 2.523A2.528 2.528 0 0 1 0 15.165a2.527 2.527 0 0 1 2.522-2.52h2.52v2.52zM6.313 15.165a2.527 2.527 0 0 1 2.521-2.52 2.527 2.527 0 0 1 2.521 2.52v6.313A2.528 2.528 0 0 1 8.834 24a2.528 2.528 0 0 1-2.521-2.522v-6.313z',
            'fill': '#E01E5A',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M8.834 5.042a2.528 2.528 0 0 1-2.521-2.52A2.528 2.528 0 0 1 8.834 0a2.528 2.528 0 0 1 2.521 2.522v2.52H8.834zM8.834 6.313a2.528 2.528 0 0 1 2.521 2.521 2.528 2.528 0 0 1-2.521 2.521H2.522A2.528 2.528 0 0 1 0 8.834a2.528 2.528 0 0 1 2.522-2.521h6.312z',
            'fill': '#36C5F0',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M18.956 8.834a2.528 2.528 0 0 1 2.522-2.521A2.528 2.528 0 0 1 24 8.834a2.528 2.528 0 0 1-2.522 2.521h-2.522V8.834zM17.688 8.834a2.528 2.528 0 0 1-2.523 2.521 2.527 2.527 0 0 1-2.52-2.521V2.522A2.527 2.527 0 0 1 15.165 0a2.528 2.528 0 0 1 2.523 2.522v6.312z',
            'fill': '#2EB67D',
          },
        ),
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M15.165 18.956a2.528 2.528 0 0 1 2.523 2.522A2.528 2.528 0 0 1 15.165 24a2.527 2.527 0 0 1-2.52-2.522v-2.522h2.52zM15.165 17.688a2.527 2.527 0 0 1-2.52-2.523 2.526 2.526 0 0 1 2.52-2.52h6.313A2.527 2.527 0 0 1 24 15.165a2.528 2.528 0 0 1-2.522 2.523h-6.313z',
            'fill': '#ECB22E',
          },
        ),
      ],
    );
  }

  static Component _buildGitLabIcon() {
    return const Component.element(
      tag: 'svg',
      attributes: <String, String>{
        'width': '18',
        'height': '18',
        'viewBox': '0 0 24 24',
        'fill': 'currentColor',
      },
      children: <Component>[
        Component.element(
          tag: 'path',
          attributes: <String, String>{
            'd':
                'M4.845.904c-.435 0-.82.28-.955.692C2.639 5.449 1.246 9.728.07 13.335a1.437 1.437 0 00.522 1.607l11.071 8.045c.2.145.472.144.67-.004l11.073-8.04a1.436 1.436 0 00.522-1.61c-1.285-3.942-2.683-8.256-3.817-11.746a1.004 1.004 0 00-.957-.684.987.987 0 00-.949.69l-2.405 7.408H8.203l-2.41-7.408a.987.987 0 00-.942-.69h-.006z',
          },
        ),
      ],
    );
  }
}

class _GoogleSignInButton extends SocialSignInButton {
  const _GoogleSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.google);
}

class _GithubSignInButton extends SocialSignInButton {
  const _GithubSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.github);
}

class _AppleSignInButton extends SocialSignInButton {
  const _AppleSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.apple);
}

class _MicrosoftSignInButton extends SocialSignInButton {
  const _MicrosoftSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.microsoft);
}

class _DiscordSignInButton extends SocialSignInButton {
  const _DiscordSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.discord);
}

class _TwitterSignInButton extends SocialSignInButton {
  const _TwitterSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.twitter);
}

class _FacebookSignInButton extends SocialSignInButton {
  const _FacebookSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.facebook);
}

class _LinkedInSignInButton extends SocialSignInButton {
  const _LinkedInSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.linkedin);
}

class _SlackSignInButton extends SocialSignInButton {
  const _SlackSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.slack);
}

class _GitLabSignInButton extends SocialSignInButton {
  const _GitLabSignInButton({
    super.onPressed,
    super.label,
    super.size,
    super.fullWidth,
    super.disabled,
    super.loading,
    super.key,
  }) : super(provider: SocialProvider.gitlab);
}