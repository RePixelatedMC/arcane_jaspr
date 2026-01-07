import 'package:arcane_jaspr/arcane_jaspr.dart';

enum AuthButtonVariant { primary, secondary, ghost }

/// Styled button for authentication forms with loading state.
class AuthButton extends StatelessComponent {
  final String label;
  final void Function()? onPressed;
  final AuthButtonVariant variant;
  final bool loading;
  final bool fullWidth;
  final bool disabled;
  final String type;

  const AuthButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AuthButtonVariant.primary,
    this.loading = false,
    this.fullWidth = true,
    this.disabled = false,
    this.type = 'button',
  });

  @override
  Component build(BuildContext context) {
    final isDisabled = disabled || loading;

    return button(
      type: type == 'submit' ? ButtonType.submit : ButtonType.button,
      disabled: isDisabled,
      events: {
        'click': (event) {
          if (!isDisabled && onPressed != null) {
            onPressed!();
          }
        },
      },
      styles: Styles(raw: _getStyles()),
      [
        if (loading) _buildSpinner(),
        span(
          styles: Styles(raw: {
            'opacity': loading ? '0' : '1',
          }),
          [Component.text(label)],
        ),
      ],
    );
  }

  Map<String, String> _getStyles() {
    final baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': '0.25rem',
      'padding': '12px 24px',
      'font-size': '0.875rem',
      'font-weight': '600',
      'font-family': 'inherit',
      'border-radius': '0.375rem',
      'cursor': disabled || loading ? 'not-allowed' : 'pointer',
      'transition': 'all 150ms ease',
      'position': 'relative',
      'width': fullWidth ? '100%' : 'auto',
      'opacity': disabled ? '0.5' : '1',
    };

    switch (variant) {
      case AuthButtonVariant.primary:
        return {
          ...baseStyles,
          'background': 'linear-gradient(135deg, var(--accent) 0%, var(--info) 100%)',
          'color': 'var(--accent-foreground)',
          'border': 'none',
          'box-shadow': '0 0 20px hsl(var(--accent) / 0.3)',
        };

      case AuthButtonVariant.secondary:
        return {
          ...baseStyles,
          'background': 'transparent',
          'color': 'var(--foreground)',
          'border': '1px solid var(--border)',
        };

      case AuthButtonVariant.ghost:
        return {
          ...baseStyles,
          'background': 'transparent',
          'color': 'var(--muted-foreground)',
          'border': 'none',
          'padding': '8px 16px',
        };
    }
  }

  Component _buildSpinner() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.absolute,
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
      ),
      children: [
        div(
          styles: Styles(raw: {
            'width': '18px',
            'height': '18px',
            'border': '2px solid transparent',
            'border-top-color': variant == AuthButtonVariant.primary
                ? 'var(--accent-foreground)'
                : 'var(--accent)',
            'border-radius': '9999px',
            'animation': 'spin 0.8s linear infinite',
          }),
          [],
        ),
      ],
    );
  }
}
