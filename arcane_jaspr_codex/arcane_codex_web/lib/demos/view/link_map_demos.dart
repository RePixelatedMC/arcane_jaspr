import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Link and map view demos (arrow link, feature showcase, world map, USA map)
class LinkMapDemos {
  static List<Component> arrowLink() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Arrow Link Styles', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.xl,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneArrowLink(
                  label: 'Learn more',
                  href: '#',
                ),
                ArcaneArrowLink.muted(
                  label: 'View docs',
                  href: '#',
                ),
              ],
            ),
            ArcaneText('Arrow Positions', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.xl,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneArrowLink(
                  label: 'Next',
                  href: '#',
                ),
                ArcaneArrowLink(
                  label: 'Previous',
                  href: '#',
                  arrowBefore: true,
                ),
                ArcaneArrowLink(
                  label: 'No arrow',
                  href: '#',
                  showArrow: false,
                ),
              ],
            ),
            ArcaneText('Sizes', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.xl,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneArrowLink(
                  label: 'Extra small',
                  href: '#',
                  size: ArrowLinkSize.xs,
                ),
                ArcaneArrowLink(
                  label: 'Small',
                  href: '#',
                  size: ArrowLinkSize.sm,
                ),
                ArcaneArrowLink(
                  label: 'Medium',
                  href: '#',
                  size: ArrowLinkSize.md,
                ),
                ArcaneArrowLink(
                  label: 'Large',
                  href: '#',
                  size: ArrowLinkSize.lg,
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> featureShowcase() => [
        ArcaneFeatureShowcase(
          title: 'Why Choose Us?',
          subtitle: 'Hover over any card to learn more about our features.',
          items: [
            ArcaneFeatureShowcaseItem(
              icon: ArcaneIcon.server(size: IconSize.xl),
              title: 'Fast Servers',
              description:
                  'Enterprise-grade hardware with NVMe SSDs and DDR5 RAM for blazing fast performance.',
            ),
            ArcaneFeatureShowcaseItem(
              icon: ArcaneIcon.shield(size: IconSize.xl),
              title: 'DDoS Protection',
              description:
                  'Multi-layer protection against volumetric and application-layer attacks.',
            ),
            ArcaneFeatureShowcaseItem(
              icon: ArcaneIcon.zap(size: IconSize.xl),
              title: 'Low Latency',
              description:
                  'Optimized network routing for minimal ping and maximum responsiveness.',
            ),
            ArcaneFeatureShowcaseItem(
              icon: ArcaneIcon.globe(size: IconSize.xl),
              title: 'Global Network',
              description:
                  'Datacenters worldwide ensure low latency no matter where your users are.',
            ),
          ],
        ),
      ];

  static List<Component> worldMap() => [
        ArcaneColumn(
          gapSize: Gap.xl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('World Map - Debug Mode', weight: FontWeight.w600),
            ArcaneText(
              'Hover to see coordinates, click to copy lat/lng to clipboard.',
              color: TextColor.mutedForeground,
              size: FontSize.sm,
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                widthCustom: '100%',
                minHeight: '450px',
                borderRadius: Radius.lg,
                overflow: Overflow.hidden,
              ),
              children: [
                ArcaneWorldMap(
                  height: '400px',
                  debugMode: true,
                  locations: const [],
                ),
              ],
            ),
            const ArcaneDivider(),
            ArcaneText('USA Map - Debug Mode', weight: FontWeight.w600),
            ArcaneText(
              'Hover to see coordinates, click to copy lat/lng to clipboard.',
              color: TextColor.mutedForeground,
              size: FontSize.sm,
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                widthCustom: '100%',
                minHeight: '400px',
                borderRadius: Radius.lg,
                overflow: Overflow.hidden,
              ),
              children: [
                ArcaneUSAMap(
                  height: '350px',
                  debugMode: true,
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> usaMap() => [
        ArcaneColumn(
          gapSize: Gap.xl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('USA Map - Debug Mode', weight: FontWeight.w600),
            ArcaneText(
              'Hover to see coordinates, click to copy lat/lng to clipboard.',
              color: TextColor.mutedForeground,
              size: FontSize.sm,
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                widthCustom: '100%',
                minHeight: '400px',
                borderRadius: Radius.lg,
                overflow: Overflow.hidden,
              ),
              children: [
                ArcaneUSAMap(
                  height: '350px',
                  debugMode: true,
                ),
              ],
            ),
          ],
        ),
      ];
}
