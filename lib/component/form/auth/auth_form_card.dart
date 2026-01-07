import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Container card for authentication form content.
class AuthFormCard extends StatelessComponent {
  final String title;
  final String? subtitle;
  final Component child;
  final Component? footer;

  const AuthFormCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.footer,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        width: Size.full,
      ),
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            margin: MarginPreset.bottomXl,
            textAlign: TextAlign.center,
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xl2,
                fontWeight: FontWeight.bold,
                textColor: TextColor.primary,
                margin: MarginPreset.bottomXs,
                letterSpacing: LetterSpacing.tight,
              ),
              children: [Component.text(title)],
            ),
            if (subtitle != null)
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  fontSize: FontSize.sm,
                  textColor: TextColor.mutedForeground,
                  lineHeight: LineHeight.normal,
                ),
                children: [Component.text(subtitle!)],
              ),
          ],
        ),
        child,
        if (footer != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              margin: MarginPreset.topLg,
              textAlign: TextAlign.center,
            ),
            children: [footer!],
          ),
      ],
    );
  }
}
