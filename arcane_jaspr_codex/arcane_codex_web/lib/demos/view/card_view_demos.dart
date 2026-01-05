import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Card and surface view demos (feature card, surface card, author card, code window, check list)
class CardViewDemos {
  static List<Component> featureCard() => [
        ArcaneFeatureCard(
          title: 'Feature',
          description: 'Feature description text',
          icon: ArcaneText('*'),
        ),
      ];

  static List<Component> authorCard() => [
        ArcaneRow(
          gapSize: Gap.xl,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ArcaneAuthorCard.sm(
              name: 'Jane Doe',
              role: 'Developer',
              initials: 'JD',
            ),
            ArcaneAuthorCard(
              name: 'John Smith',
              role: 'Software Engineer',
              initials: 'JS',
            ),
            ArcaneAuthorCard.lg(
              name: 'Alice Johnson',
              role: 'CEO & Founder',
              initials: 'AJ',
            ),
          ],
        ),
      ];

  static List<Component> codeWindow() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '400px'),
          children: [
            ArcaneCodeWindow(
              title: 'main.dart',
              code: '''void main() {
  print('Hello, World!');
}''',
            ),
          ],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '400px',
            margin: MarginPreset.topMd,
          ),
          children: [
            ArcaneCodeWindow.terminal(
              title: 'Terminal',
              code: '\$ dart run\nHello, World!\n\$ ',
            ),
          ],
        ),
      ];

  static List<Component> checkList() => [
        ArcaneRow(
          gapSize: Gap.xxl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Brand Icons', weight: FontWeight.bold),
                ArcaneCheckList.brand(
                  items: [
                    'Shared models',
                    'Type-safe API calls',
                    'Hot reload',
                  ],
                ),
              ],
            ),
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Success Icons', weight: FontWeight.bold),
                ArcaneCheckList.success(
                  items: [
                    'All tests passing',
                    'Build successful',
                    'Deployed to prod',
                  ],
                ),
              ],
            ),
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Feature Rows', weight: FontWeight.bold),
                ArcaneFeatureRow(feature: 'Unlimited API calls', included: true),
                ArcaneFeatureRow(feature: 'Priority support', included: true),
                ArcaneFeatureRow(feature: 'Custom domain', included: false),
              ],
            ),
          ],
        ),
      ];

  static List<Component> surfaceCard() => [
        ArcaneRow(
          gapSize: Gap.lg,
          children: [
            ArcaneSurfaceCard(
              effect: SurfaceEffect.none,
              child: ArcaneText('Plain'),
            ),
            ArcaneSurfaceCard.blur(
              child: ArcaneText('Blur'),
            ),
            ArcaneSurfaceCard.frosted(
              child: ArcaneText('Frosted'),
            ),
            ArcaneSurfaceCard.glass(
              child: ArcaneText('Glass'),
            ),
            ArcaneSurfaceCard.gradient(
              child: ArcaneText('Gradient'),
            ),
          ],
        ),
      ];

  static List<Component> flexiCards() => [
        ArcaneColumn(
          gapSize: Gap.xl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Basic Flexi Cards', weight: FontWeight.w600),
            ArcaneDiv(
              styles: const ArcaneStyleData(widthCustom: '100%'),
              children: [
                ArcaneFlexiCards(
                  items: [
                    ArcaneFlexiCardItem(
                      icon: ArcaneIcon.server(),
                      shortText: 'Fast Servers',
                      longText: 'Enterprise-grade hardware with NVMe SSDs for blazing fast performance.',
                    ),
                    ArcaneFlexiCardItem(
                      icon: ArcaneIcon.shield(),
                      shortText: 'DDoS Protection',
                      longText: 'Multi-layer protection against attacks with real-time mitigation.',
                    ),
                    ArcaneFlexiCardItem(
                      icon: ArcaneIcon.zap(),
                      shortText: 'Low Latency',
                      longText: 'Optimized routing for minimal ping and maximum responsiveness.',
                    ),
                  ],
                ),
              ],
            ),
            ArcaneText('With Locked Dimensions', weight: FontWeight.w600),
            ArcaneDiv(
              styles: const ArcaneStyleData(widthCustom: '100%'),
              children: [
                ArcaneFlexiCards(
                  items: [
                    ArcaneFlexiCardItem(
                      icon: ArcaneIcon.code(),
                      shortText: 'Development',
                      longText: 'Full-featured development environment with hot reload.',
                    ),
                    ArcaneFlexiCardItem(
                      icon: ArcaneIcon.rocket(),
                      shortText: 'Deployment',
                      longText: 'One-click deployment to production with zero downtime.',
                    ),
                    ArcaneFlexiCardItem(
                      icon: ArcaneIcon.sparkles(),
                      shortText: 'Analytics',
                      longText: 'Real-time analytics and monitoring for your applications.',
                    ),
                  ],
                  heightPreLock: '180px',
                  heightPostLock: '240px',
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> slotCounter() => [
        ArcaneColumn(
          gapSize: Gap.xl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Latency Counters', weight: FontWeight.w600),
            ArcaneSlotCounterRow(
              counters: [
                ArcaneSlotCounter.latency(
                  label: 'NYC',
                  minLatency: 5,
                  maxLatency: 45,
                ),
                ArcaneSlotCounter.latency(
                  label: 'LON',
                  minLatency: 15,
                  maxLatency: 80,
                ),
                ArcaneSlotCounter.latency(
                  label: 'TOK',
                  minLatency: 30,
                  maxLatency: 120,
                ),
              ],
            ),
            ArcaneText('Percentage Counter', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.lg,
              children: [
                ArcaneSlotCounterCard(
                  background: Background.surface,
                  border: BorderPreset.subtle,
                  counter: ArcaneSlotCounter.percentage(
                    label: 'Uptime',
                    minValue: 99,
                    maxValue: 100,
                    valueColor: TextColor.success,
                  ),
                ),
              ],
            ),
            ArcaneText('Currency Counter', weight: FontWeight.w600),
            ArcaneSlotCounter.currency(
              label: 'Revenue',
              minValue: 1000,
              maxValue: 9999,
              valueFontSize: FontSize.xl2,
            ),
            ArcaneText('Custom Counter', weight: FontWeight.w600),
            ArcaneSlotCounter(
              minValue: 100,
              maxValue: 999,
              prefix: '<',
              suffix: 'ms',
              label: 'Response Time',
              valueFontSize: FontSize.lg,
              valueColor: TextColor.accent,
              minDigits: 3,
            ),
          ],
        ),
      ];
}
