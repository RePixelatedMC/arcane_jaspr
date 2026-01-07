import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Divider with centered text for authentication forms.
class AuthDivider extends StatelessComponent {
  final String text;

  const AuthDivider({
    super.key,
    this.text = 'or continue with',
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.md,
        margin: MarginPreset.verticalLg,
      ),
      children: [
        const div(
          styles: Styles(raw: {
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
            textTransform: TextTransform.lowercase,
            whiteSpace: WhiteSpace.nowrap,
          ),
          children: [Component.text(text)],
        ),
        const div(
          styles: Styles(raw: {
            'flex': '1',
            'height': '1px',
            'background-color': 'var(--border)',
          }),
          [],
        ),
      ],
    );
  }
}
