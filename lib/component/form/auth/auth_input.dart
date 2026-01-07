import 'package:arcane_jaspr/arcane_jaspr.dart';

enum AuthInputType { text, email, password }

/// Styled input field for authentication forms.
class AuthInput extends StatelessComponent {
  final String labelText;
  final String? placeholder;
  final String? hint;
  final String? error;
  final AuthInputType type;
  final String? value;
  final void Function(String)? onInput;
  final bool disabled;
  final bool autofocus;
  final String? name;

  const AuthInput({
    super.key,
    required String label,
    this.placeholder,
    this.hint,
    this.error,
    this.type = AuthInputType.text,
    this.value,
    this.onInput,
    this.disabled = false,
    this.autofocus = false,
    this.name,
  }) : labelText = label;

  @override
  Component build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final inputId = name ?? labelText.toLowerCase().replaceAll(' ', '-');

    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomMd,
      ),
      children: [
        label(
          [Component.text(labelText)],
          htmlFor: inputId,
          styles: const Styles(raw: {
            'display': 'block',
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--foreground)',
            'margin-bottom': '0.25rem',
          }),
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.relative,
          ),
          children: [
            input(
              id: inputId,
              name: name ?? inputId,
              type: _getInputType(),
              value: value,
              disabled: disabled,
              attributes: {
                if (placeholder != null) 'placeholder': placeholder!,
                if (autofocus) 'autofocus': '',
              },
              events: {
                'input': (event) {
                  if (onInput != null) {
                  }
                },
              },
              styles: Styles(raw: {
                'width': '100%',
                'padding': '12px 16px',
                'font-size': '0.875rem',
                'font-family': 'inherit',
                'color': 'var(--foreground)',
                'background': 'var(--card)',
                'border': hasError
                    ? '1px solid var(--destructive)'
                    : '1px solid var(--border)',
                'border-radius': '0.375rem',
                'outline': 'none',
                'transition': 'border-color 0.2s ease, box-shadow 0.2s ease',
                'box-sizing': 'border-box',
              }),
            ),
          ],
        ),
        if (hint != null || hasError)
          ArcaneDiv(
            styles: ArcaneStyleData(
              fontSize: FontSize.xs,
              margin: MarginPreset.topXs,
              textColor: hasError ? TextColor.error : TextColor.muted,
            ),
            children: [Component.text(hasError ? error! : hint!)],
          ),
      ],
    );
  }

  InputType _getInputType() {
    switch (type) {
      case AuthInputType.email:
        return InputType.email;
      case AuthInputType.password:
        return InputType.password;
      case AuthInputType.text:
        return InputType.text;
    }
  }
}
