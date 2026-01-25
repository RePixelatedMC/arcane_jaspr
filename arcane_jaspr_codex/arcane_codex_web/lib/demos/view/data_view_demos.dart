import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Data and feedback view demos (progress, data table, alert, toast, callout, meter)
class DataViewDemos {
  static List<Component> progressBar() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [ArcaneProgressBar(value: 0.3)],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [ArcaneProgressBar(value: 0.7)],
        ),
      ];

  static List<Component> dataTable() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '300px',
            background: Background.surface,
            borderRadius: Radius.md,
            overflow: Overflow.hidden,
          ),
          children: [
            ArcaneStaticTable(
              headers: const ['Name', 'Value'],
              rows: [
                [ArcaneText('Item 1'), ArcaneText('100')],
                [ArcaneText('Item 2'), ArcaneText('200')],
              ],
            ),
          ],
        ),
      ];

  static List<Component> toast() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
            raw: {'border-left': '4px solid var(--arcane-accent)'},
          ),
          children: [
            ArcaneRow(
              gapSize: Gap.sm,
              children: [
                ArcaneIcon.check(size: IconSize.sm),
                ArcaneText('Toast notification'),
              ],
            ),
          ],
        ),
      ];

  static List<Component> callout() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneCallout(
              title: 'Note',
              content: 'This is an important callout message.',
              variant: CalloutVariant.info,
            ),
          ],
        ),
      ];

  static List<Component> meter() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneMeter(
              value: 0.65,
              label: 'Storage',
              showValue: true,
            ),
          ],
        ),
      ];

  static List<Component> alert() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneAlert.success(
              title: 'Success',
              message: 'Your changes have been saved.',
            ),
          ],
        ),
      ];

  static List<Component> statDisplay() => [
        ArcaneStatRow(
          stats: [
            ArcaneStatDisplay(value: '99.9%', label: 'Uptime SLA'),
            ArcaneStatDisplay(value: '10K+', label: 'Active Servers'),
            ArcaneStatDisplay(value: '<60s', label: 'Deploy Time'),
          ],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(margin: MarginPreset.topLg),
          children: [
            ArcaneRow(
              gapSize: Gap.xl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ArcaneStatDisplay.accent(
                  value: '5M+',
                  label: 'Downloads',
                ),
                ArcaneStatDisplay.accent(
                  value: '150+',
                  label: 'Contributors',
                  layout: StatDisplayLayout.horizontal,
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> tracker() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Contribution Grid', weight: FontWeight.w600),
            ArcaneTracker(
              data: List.generate(90, (idx) => TrackerData(
                level: idx % 5 == 0 ? TrackerLevel.fine
                    : idx % 7 == 0 ? TrackerLevel.warning
                    : idx % 11 == 0 ? TrackerLevel.critical
                    : TrackerLevel.unknown,
                tooltip: 'Day ${idx + 1}',
              )),
              showLegend: true,
            ),
            ArcaneText('Uptime Tracker', weight: FontWeight.w600),
            ArcaneDiv(
              styles: const ArcaneStyleData(widthCustom: '300px'),
              children: [
                ArcaneUptimeTracker(
                  days: List.generate(30, (idx) => UptimeDay(
                    date: DateTime.now().subtract(Duration(days: idx)),
                    uptime: 99.0 + (idx % 10) / 10,
                  )),
                ),
              ],
            ),
          ],
        ),
      ];
}
