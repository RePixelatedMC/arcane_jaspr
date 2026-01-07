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
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Debug Mode (hover to see coordinates, click to copy)',
                weight: FontWeight.w600),
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
            ArcaneText('Interactive World Map', weight: FontWeight.w600),
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
                  locations: [
                    ArcaneMapLocation(
                      id: 'nyc',
                      name: 'New York',
                      latitude: 40.7128,
                      longitude: -74.0060,
                      code: 'NYC',
                      region: 'North America',
                    ),
                    ArcaneMapLocation(
                      id: 'lon',
                      name: 'London',
                      latitude: 51.5074,
                      longitude: -0.1278,
                      code: 'LON',
                      region: 'Europe',
                    ),
                    ArcaneMapLocation(
                      id: 'tyo',
                      name: 'Tokyo',
                      latitude: 35.6762,
                      longitude: 139.6503,
                      code: 'TYO',
                      region: 'Asia Pacific',
                    ),
                    ArcaneMapLocation(
                      id: 'syd',
                      name: 'Sydney',
                      latitude: -33.8688,
                      longitude: 151.2093,
                      code: 'SYD',
                      region: 'Oceania',
                    ),
                    ArcaneMapLocation(
                      id: 'fra',
                      name: 'Frankfurt',
                      latitude: 50.1109,
                      longitude: 8.6821,
                      code: 'FRA',
                      region: 'Europe',
                    ),
                    ArcaneMapLocation(
                      id: 'sin',
                      name: 'Singapore',
                      latitude: 1.3521,
                      longitude: 103.8198,
                      code: 'SIN',
                      region: 'Asia Pacific',
                    ),
                  ],
                ),
              ],
            ),
            ArcaneText('Subtle Style', weight: FontWeight.w600),
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
                  style: ArcaneWorldMapStyle.subtle,
                  locations: [
                    ArcaneMapLocation(
                      id: 'sfo',
                      name: 'San Francisco',
                      latitude: 37.7749,
                      longitude: -122.4194,
                      code: 'SFO',
                      region: 'North America',
                    ),
                    ArcaneMapLocation(
                      id: 'ams',
                      name: 'Amsterdam',
                      latitude: 52.3676,
                      longitude: 4.9041,
                      code: 'AMS',
                      region: 'Europe',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> usaMap() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Debug Mode (hover to see coordinates, click to copy)',
                weight: FontWeight.w600),
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
            ArcaneText('Interactive USA Map', weight: FontWeight.w600),
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
                  locations: [
                    ArcaneUSAMapLocation(
                      id: 'nyc',
                      name: 'New York City',
                      latitude: 40.7128,
                      longitude: -74.0060,
                      code: 'NYC',
                      state: 'NY',
                    ),
                    ArcaneUSAMapLocation(
                      id: 'lax',
                      name: 'Los Angeles',
                      latitude: 34.0522,
                      longitude: -118.2437,
                      code: 'LAX',
                      state: 'CA',
                    ),
                    ArcaneUSAMapLocation(
                      id: 'chi',
                      name: 'Chicago',
                      latitude: 41.8781,
                      longitude: -87.6298,
                      code: 'ORD',
                      state: 'IL',
                    ),
                    ArcaneUSAMapLocation(
                      id: 'dal',
                      name: 'Dallas',
                      latitude: 32.7767,
                      longitude: -96.7970,
                      code: 'DFW',
                      state: 'TX',
                    ),
                    ArcaneUSAMapLocation(
                      id: 'mia',
                      name: 'Miami',
                      latitude: 25.7617,
                      longitude: -80.1918,
                      code: 'MIA',
                      state: 'FL',
                    ),
                    ArcaneUSAMapLocation(
                      id: 'sea',
                      name: 'Seattle',
                      latitude: 47.6062,
                      longitude: -122.3321,
                      code: 'SEA',
                      state: 'WA',
                    ),
                  ],
                ),
              ],
            ),
            ArcaneText('With Active States', weight: FontWeight.w600),
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
                  style: ArcaneUSAMapStyle.prominent,
                  activeStates: {'CA', 'TX', 'NY', 'FL'},
                  locations: [
                    ArcaneUSAMapLocation(
                      id: 'sfo',
                      name: 'San Francisco',
                      latitude: 37.7749,
                      longitude: -122.4194,
                      code: 'SFO',
                      state: 'CA',
                    ),
                    ArcaneUSAMapLocation(
                      id: 'aus',
                      name: 'Austin',
                      latitude: 30.2672,
                      longitude: -97.7431,
                      code: 'AUS',
                      state: 'TX',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}
