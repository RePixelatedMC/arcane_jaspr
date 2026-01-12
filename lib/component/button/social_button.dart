import 'package:arcane_jaspr/arcane_jaspr.dart';

export 'social_provider.dart';
export 'social_icons.dart';

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

  @override
  Component build(BuildContext context) {
    final bool isDisabled = disabled || loading;

    final SocialProviderConfig? config =
        provider != null ? SocialProviderConfig.forProvider(provider!) : null;

    final String effectiveBg =
        backgroundColor ?? config?.backgroundColor ?? 'transparent';
    final String effectiveFg =
        foregroundColor ?? config?.foregroundColor ?? 'var(--foreground)';
    final String effectiveBorder =
        borderColor ?? config?.borderColor ?? 'var(--border)';
    final String effectiveHoverBg =
        hoverBackgroundColor ?? config?.hoverBackgroundColor ?? 'var(--muted)';

    final String effectiveLabel = label ?? config?.defaultLabel ?? 'Sign in';
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
