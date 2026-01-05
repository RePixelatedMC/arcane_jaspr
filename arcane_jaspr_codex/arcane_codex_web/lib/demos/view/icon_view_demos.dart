import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Icon and SVG view demos
class IconViewDemos {
  static List<Component> icon() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Size comparison
            ArcaneText('Icon Sizes', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.xs),
                    ArcaneText('xs', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.sm),
                    ArcaneText('sm', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.md),
                    ArcaneText('md', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.lg),
                    ArcaneText('lg', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.xl),
                    ArcaneText('xl', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneIcon.star(size: IconSize.xl2),
                    ArcaneText('xl2', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
              ],
            ),

            // Navigation icons
            ArcaneText('Navigation', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.home(),
                ArcaneIcon.search(),
                ArcaneIcon.settings(),
                ArcaneIcon.menu(),
                ArcaneIcon.close(),
                ArcaneIcon.chevronDown(),
                ArcaneIcon.chevronRight(),
                ArcaneIcon.arrowLeft(),
                ArcaneIcon.externalLink(),
              ],
            ),

            // Actions
            ArcaneText('Actions', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.edit(),
                ArcaneIcon.copy(),
                ArcaneIcon.trash(),
                ArcaneIcon.save(),
                ArcaneIcon.download(),
                ArcaneIcon.upload(),
                ArcaneIcon.refresh(),
                ArcaneIcon.plus(),
                ArcaneIcon.check(),
              ],
            ),

            // Files & Folders
            ArcaneText('Files & Folders', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.file(),
                ArcaneIcon.fileText(),
                ArcaneIcon.folder(),
                ArcaneIcon.folderOpen(),
                ArcaneIcon.code(),
                ArcaneIcon.terminal(),
                ArcaneIcon.database(),
              ],
            ),

            // Communication
            ArcaneText('Communication', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.bell(),
                ArcaneIcon.mail(),
                ArcaneIcon.message(),
                ArcaneIcon.send(),
                ArcaneIcon.info(),
                ArcaneIcon.warning(),
                ArcaneIcon.help(),
              ],
            ),

            // Social & Feedback
            ArcaneText('Social & Feedback', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.heart(),
                ArcaneIcon.star(),
                ArcaneIcon.thumbsUp(),
                ArcaneIcon.thumbsDown(),
                ArcaneIcon.share(),
                ArcaneIcon.bookmark(),
              ],
            ),

            // Theme & Display
            ArcaneText('Theme & Display', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.sun(),
                ArcaneIcon.moon(),
                ArcaneIcon.eye(),
                ArcaneIcon.eyeOff(),
                ArcaneIcon.monitor(),
                ArcaneIcon.smartphone(),
              ],
            ),

            // Security
            ArcaneText('Security', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.lock(),
                ArcaneIcon.unlock(),
                ArcaneIcon.key(),
                ArcaneIcon.shield(),
                ArcaneIcon.shieldCheck(),
              ],
            ),

            // Semantic Aliases (intuitive names)
            ArcaneText('Semantic Aliases', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.home(), // -> house()
                ArcaneIcon.close(), // -> x()
                ArcaneIcon.edit(), // -> pencil()
                ArcaneIcon.delete(), // -> trash2()
                ArcaneIcon.success(), // -> circleCheck()
                ArcaneIcon.error(), // -> circleX()
                ArcaneIcon.loading(), // -> loaderCircle()
                ArcaneIcon.grid(), // -> grid3x3()
              ],
            ),

            // Status icons
            ArcaneText('Status', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.success(),
                ArcaneIcon.error(),
                ArcaneIcon.warning(),
                ArcaneIcon.info(),
                ArcaneIcon.help(),
                ArcaneIcon.loading(),
              ],
            ),

            // Misc
            ArcaneText('Misc', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneIcon.moreHorizontal(),
                ArcaneIcon.moreVertical(),
                ArcaneIcon.filter(),
                ArcaneIcon.sort(),
                ArcaneIcon.zap(),
                ArcaneIcon.sparkles(),
                ArcaneIcon.rocket(),
                ArcaneIcon.flame(),
              ],
            ),

            // Total count
            ArcaneText('1,666 icons available!',
              size: FontSize.sm,
              color: TextColor.muted,
            ),
          ],
        ),
      ];

  static List<Component> svg() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic SVG usage
            ArcaneRow(
              gapSize: Gap.lg,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneSvg(
                      viewBox: '0 0 24 24',
                      size: SvgSize.xl,
                      children: [
                        ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                      ],
                    ),
                    ArcaneText('Circle', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneSvg(
                      viewBox: '0 0 24 24',
                      size: SvgSize.xl,
                      children: [
                        ArcaneSvgRect(x: '2', y: '2', width: '20', height: '20', rx: '4'),
                      ],
                    ),
                    ArcaneText('Square', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
                ArcaneColumn(
                  gapSize: Gap.xs,
                  children: [
                    ArcaneSvg(
                      viewBox: '0 0 24 24',
                      size: SvgSize.xl,
                      children: [
                        ArcaneSvgPolygon(points: '12,2 22,22 2,22'),
                      ],
                    ),
                    ArcaneText('Triangle', size: FontSize.xs, color: TextColor.muted),
                  ],
                ),
              ],
            ),
            // Colored SVGs
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneSvg(
                  viewBox: '0 0 24 24',
                  size: SvgSize.lg,
                  fill: 'var(--arcane-success)',
                  children: [
                    ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                  ],
                ),
                ArcaneSvg(
                  viewBox: '0 0 24 24',
                  size: SvgSize.lg,
                  fill: 'var(--arcane-warning)',
                  children: [
                    ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                  ],
                ),
                ArcaneSvg(
                  viewBox: '0 0 24 24',
                  size: SvgSize.lg,
                  fill: 'var(--arcane-error)',
                  children: [
                    ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                  ],
                ),
                ArcaneSvg(
                  viewBox: '0 0 24 24',
                  size: SvgSize.lg,
                  fill: 'var(--arcane-accent)',
                  children: [
                    ArcaneSvgCircle(cx: '12', cy: '12', r: '10'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}
