import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Visual effect view demos (fade edge, marquee)
class VisualViewDemos {
  static List<Component> fadeEdge() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.relative,
            widthCustom: '300px',
            heightCustom: '100px',
            background: Background.surface,
            borderRadius: Radius.md,
            overflow: Overflow.hidden,
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                padding: PaddingPreset.md,
              ),
              children: [
                ArcaneText('Content with fade edges on left and right.'),
              ],
            ),
            ArcaneFadeEdge.left(),
            ArcaneFadeEdge.right(),
          ],
        ),
      ];

  static List<Component> marquee() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '100%',
            overflow: Overflow.hidden,
          ),
          children: [
            ArcaneMarquee(
              duration: '20s',
              showFadeEdges: true,
              pauseOnHover: true,
              children: [
                for (final tech in ['React', 'Vue', 'Angular', 'Svelte', 'Next.js', 'Nuxt', 'Astro', 'Remix'])
                  ArcaneDiv(
                    styles: const ArcaneStyleData(
                      padding: PaddingPreset.md,
                      background: Background.surface,
                      borderRadius: Radius.md,
                      border: BorderPreset.subtle,
                    ),
                    children: [ArcaneText(tech)],
                  ),
              ],
            ),
          ],
        ),
      ];
}
