import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for style reference section
class StyleDemos {
  // ============================================================
  // LAYOUT DEMOS
  // ============================================================

  /// Display & Layout demos
  static List<Component> display() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Display.flex', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.flex,
                  gap: Gap.sm,
                  padding: PaddingPreset.md,
                  background: Background.surface,
                  borderRadius: Radius.md,
                ),
                children: [
                  _colorBox('1'),
                  _colorBox('2'),
                  _colorBox('3'),
                ],
              ),
            ]),
            _buildStyleDemo('Display.grid (3 columns)', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.grid,
                  raw: {'grid-template-columns': 'repeat(3, 1fr)'},
                  gap: Gap.sm,
                  padding: PaddingPreset.md,
                  background: Background.surface,
                  borderRadius: Radius.md,
                ),
                children: [
                  for (int i = 1; i <= 6; i++) _colorBox('$i'),
                ],
              ),
            ]),
            _buildStyleDemo('FlexDirection comparison', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  ArcaneColumn(
                    gapSize: Gap.xs,
                    children: [
                      ArcaneText('row', size: FontSize.xs, color: TextColor.muted),
                      ArcaneDiv(
                        styles: const ArcaneStyleData(
                          display: Display.flex,
                          flexDirection: FlexDirection.row,
                          gap: Gap.xs,
                          padding: PaddingPreset.sm,
                          background: Background.surface,
                          borderRadius: Radius.sm,
                        ),
                        children: [_smallBox(), _smallBox(), _smallBox()],
                      ),
                    ],
                  ),
                  ArcaneColumn(
                    gapSize: Gap.xs,
                    children: [
                      ArcaneText('column', size: FontSize.xs, color: TextColor.muted),
                      ArcaneDiv(
                        styles: const ArcaneStyleData(
                          display: Display.flex,
                          flexDirection: FlexDirection.column,
                          gap: Gap.xs,
                          padding: PaddingPreset.sm,
                          background: Background.surface,
                          borderRadius: Radius.sm,
                        ),
                        children: [_smallBox(), _smallBox(), _smallBox()],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Spacing demos - gap, padding, margin
  static List<Component> spacing() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Gap sizes', [
              ArcaneColumn(
                gapSize: Gap.md,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final gap in [
                    ('Gap.xs', Gap.xs),
                    ('Gap.sm', Gap.sm),
                    ('Gap.md', Gap.md),
                    ('Gap.lg', Gap.lg),
                    ('Gap.xl', Gap.xl),
                  ])
                    ArcaneRow(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '80px'),
                          children: [ArcaneText(gap.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            display: Display.flex,
                            gap: gap.$2,
                            padding: PaddingPreset.sm,
                            background: Background.surface,
                            borderRadius: Radius.sm,
                          ),
                          children: [_smallBox(), _smallBox(), _smallBox()],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Padding presets', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final preset in [
                    ('sm', PaddingPreset.sm),
                    ('md', PaddingPreset.md),
                    ('lg', PaddingPreset.lg),
                    ('xl', PaddingPreset.xl),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneText(preset.$1, size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            padding: preset.$2,
                            background: Background.surface,
                            borderRadius: Radius.sm,
                            border: BorderPreset.standard,
                          ),
                          children: [
                            ArcaneDiv(
                              styles: const ArcaneStyleData(
                                widthCustom: '40px',
                                heightCustom: '20px',
                                background: Background.accent,
                                borderRadius: Radius.xs,
                              ),
                              children: [],
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Typography demos
  static List<Component> typography() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Font sizes', [
              ArcaneColumn(
                gapSize: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArcaneText('FontSize.xs - Extra small text', size: FontSize.xs),
                  ArcaneText('FontSize.sm - Small text', size: FontSize.sm),
                  ArcaneText('FontSize.base - Base text', size: FontSize.base),
                  ArcaneText('FontSize.lg - Large text', size: FontSize.lg),
                  ArcaneText('FontSize.xl - Extra large text', size: FontSize.xl),
                  ArcaneText('FontSize.xl2 - 2XL text', size: FontSize.xl2),
                  ArcaneText('FontSize.xl3 - 3XL text', size: FontSize.xl3),
                ],
              ),
            ]),
            _buildStyleDemo('Font weights', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  ArcaneText('Normal', weight: FontWeight.normal),
                  ArcaneText('Medium', weight: FontWeight.w500),
                  ArcaneText('Semibold', weight: FontWeight.w600),
                  ArcaneText('Bold', weight: FontWeight.bold),
                ],
              ),
            ]),
            _buildStyleDemo('Text colors', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  ArcaneText('Primary', color: TextColor.primary),
                  ArcaneText('Muted', color: TextColor.muted),
                  ArcaneText('Accent', color: TextColor.accent),
                  ArcaneText('Success', color: TextColor.success),
                  ArcaneText('Warning', color: TextColor.warning),
                  ArcaneText('Error', color: TextColor.error),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Color demos
  static List<Component> colors() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Background colors', [
              ArcaneRow(
                gapSize: Gap.sm,
                children: [
                  for (final bg in [
                    ('surface', Background.surface),
                    ('surfaceVariant', Background.surfaceVariant),
                    ('accent', Background.accent),
                    ('success', Background.success),
                    ('warning', Background.warning),
                    ('error', Background.error),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '60px',
                            heightCustom: '40px',
                            background: bg.$2,
                            borderRadius: Radius.sm,
                            border: BorderPreset.subtle,
                          ),
                          children: [],
                        ),
                        ArcaneText(bg.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Text color swatches', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.md,
                  background: Background.surface,
                  borderRadius: Radius.md,
                ),
                children: [
                  ArcaneRow(
                    gapSize: Gap.lg,
                    children: [
                      _textSwatch('primary', TextColor.primary),
                      _textSwatch('muted', TextColor.muted),
                      _textSwatch('accent', TextColor.accent),
                      _textSwatch('success', TextColor.success),
                      _textSwatch('error', TextColor.error),
                    ],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Border demos
  static List<Component> borders() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Border presets', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final border in [
                    ('standard', BorderPreset.standard),
                    ('subtle', BorderPreset.subtle),
                    ('accent', BorderPreset.accent),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '80px',
                            heightCustom: '50px',
                            background: Background.surface,
                            borderRadius: Radius.md,
                            border: border.$2,
                          ),
                          children: [],
                        ),
                        ArcaneText(border.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Border radius', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final radius in [
                    ('xs', Radius.xs),
                    ('sm', Radius.sm),
                    ('md', Radius.md),
                    ('lg', Radius.lg),
                    ('xl', Radius.xl),
                    ('full', Radius.full),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            background: Background.accent,
                            borderRadius: radius.$2,
                          ),
                          children: [],
                        ),
                        ArcaneText(radius.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Effects demos (shadows, transitions)
  static List<Component> effects() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Shadow presets', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  for (final shadow in [
                    ('xs', Shadow.xs),
                    ('sm', Shadow.sm),
                    ('md', Shadow.md),
                    ('lg', Shadow.lg),
                    ('xl', Shadow.xl),
                    ('card', Shadow.card),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '60px',
                            heightCustom: '40px',
                            background: Background.surface,
                            borderRadius: Radius.md,
                            shadow: shadow.$2,
                          ),
                          children: [],
                        ),
                        ArcaneText(shadow.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Glow shadows', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  for (final glow in [
                    ('accent', Shadow.glowAccent),
                    ('success', Shadow.glowSuccess),
                    ('cyan', Shadow.glowCyan),
                    ('purple', Shadow.glowPurple),
                    ('pink', Shadow.glowPink),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            background: Background.surface,
                            borderRadius: Radius.md,
                            shadow: glow.$2,
                          ),
                          children: [],
                        ),
                        ArcaneText(glow.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Opacity levels', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final opacity in [
                    ('100%', Opacity.full),
                    ('75%', Opacity.muted),
                    ('50%', Opacity.half),
                    ('25%', Opacity.light),
                    ('10%', Opacity.faint),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            background: Background.accent,
                            borderRadius: Radius.md,
                            opacity: opacity.$2,
                          ),
                          children: [],
                        ),
                        ArcaneText(opacity.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Transition presets', [
              ArcaneColumn(
                gapSize: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final transition in [
                    ('fast (150ms)', Transition.fast),
                    ('normal (200ms)', Transition.normal),
                    ('slow (300ms)', Transition.slow),
                    ('bounce', Transition.bounce),
                  ])
                    ArcaneRow(
                      gapSize: Gap.md,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '120px'),
                          children: [ArcaneText(transition.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '100px',
                            heightCustom: '30px',
                            background: Background.accent,
                            borderRadius: Radius.sm,
                            transition: transition.$2,
                            cursor: Cursor.pointer,
                          ),
                          children: const [ArcaneText('Hover me', size: FontSize.xs, color: TextColor.onPrimary)],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // MARGIN DEMOS
  // ============================================================

  /// Margin presets
  static List<Component> margins() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Single value margins', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final margin in [
                    ('none', MarginPreset.none),
                    ('xs', MarginPreset.xs),
                    ('sm', MarginPreset.sm),
                    ('md', MarginPreset.md),
                    ('lg', MarginPreset.lg),
                    ('xl', MarginPreset.xl),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            background: Background.surfaceVariant,
                            borderRadius: Radius.sm,
                          ),
                          children: [
                            ArcaneDiv(
                              styles: ArcaneStyleData(
                                widthCustom: '40px',
                                heightCustom: '30px',
                                background: Background.accent,
                                borderRadius: Radius.xs,
                                margin: margin.$2,
                              ),
                              children: [],
                            ),
                          ],
                        ),
                        ArcaneText(margin.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Auto margins (centering)', [
              ArcaneColumn(
                gapSize: Gap.sm,
                children: [
                  for (final margin in [
                    ('autoX (horizontal center)', MarginPreset.autoX),
                    ('auto (all sides)', MarginPreset.auto),
                  ])
                    ArcaneDiv(
                      styles: const ArcaneStyleData(
                        widthCustom: '300px',
                        background: Background.surfaceVariant,
                        borderRadius: Radius.sm,
                        padding: PaddingPreset.sm,
                      ),
                      children: [
                        ArcaneText(margin.$1, size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '80px',
                            heightCustom: '30px',
                            background: Background.accent,
                            borderRadius: Radius.xs,
                            margin: margin.$2,
                          ),
                          children: [],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Directional margins', [
              ArcaneColumn(
                gapSize: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final margin in [
                    ('bottomMd', MarginPreset.bottomMd),
                    ('topMd', MarginPreset.topMd),
                    ('rightMd', MarginPreset.rightMd),
                    ('leftMd', MarginPreset.leftMd),
                  ])
                    ArcaneRow(
                      gapSize: Gap.md,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '80px'),
                          children: [ArcaneText(margin.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            background: Background.surfaceVariant,
                            borderRadius: Radius.sm,
                          ),
                          children: [
                            ArcaneDiv(
                              styles: ArcaneStyleData(
                                widthCustom: '40px',
                                heightCustom: '25px',
                                background: Background.accent,
                                borderRadius: Radius.xs,
                                margin: margin.$2,
                              ),
                              children: [],
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // PADDING PRESETS (COMPOUND)
  // ============================================================

  /// Compound padding presets
  static List<Component> paddingCompound() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Button padding presets', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final padding in [
                    ('buttonSm', PaddingPreset.buttonSm),
                    ('buttonMd', PaddingPreset.buttonMd),
                    ('buttonLg', PaddingPreset.buttonLg),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            padding: padding.$2,
                            background: Background.accent,
                            borderRadius: Radius.md,
                          ),
                          children: const [ArcaneText('Button', size: FontSize.sm, color: TextColor.onPrimary)],
                        ),
                        ArcaneText(padding.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Compound padding (vertical x horizontal)', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final padding in [
                    ('xsSm (4x8)', PaddingPreset.xsSm),
                    ('smMd (8x16)', PaddingPreset.smMd),
                    ('mdLg (16x24)', PaddingPreset.mdLg),
                    ('lgXl (24x32)', PaddingPreset.lgXl),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            padding: padding.$2,
                            background: Background.surface,
                            borderRadius: Radius.md,
                            border: BorderPreset.standard,
                          ),
                          children: [
                            ArcaneDiv(
                              styles: const ArcaneStyleData(
                                widthCustom: '30px',
                                heightCustom: '20px',
                                background: Background.accent,
                                borderRadius: Radius.xs,
                              ),
                              children: [],
                            ),
                          ],
                        ),
                        ArcaneText(padding.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Section padding', [
              ArcaneColumn(
                gapSize: Gap.sm,
                children: [
                  for (final padding in [
                    ('section (24x48)', PaddingPreset.section),
                    ('sectionY (80x24)', PaddingPreset.sectionY),
                    ('heroY (120x24)', PaddingPreset.heroY),
                  ])
                    ArcaneDiv(
                      styles: ArcaneStyleData(
                        padding: padding.$2,
                        background: Background.surfaceVariant,
                        borderRadius: Radius.md,
                        textAlign: TextAlign.center,
                      ),
                      children: [ArcaneText(padding.$1, size: FontSize.xs, color: TextColor.muted)],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // GRID DEMOS
  // ============================================================

  /// Grid column presets
  static List<Component> gridColumns() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Fixed column counts', [
              ArcaneColumn(
                gapSize: Gap.md,
                children: [
                  for (final cols in [
                    ('two', GridColumns.two),
                    ('three', GridColumns.three),
                    ('four', GridColumns.four),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneText('GridColumns.${cols.$1}', size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            display: Display.grid,
                            gridColumns: cols.$2,
                            gap: Gap.sm,
                            padding: PaddingPreset.sm,
                            background: Background.surface,
                            borderRadius: Radius.md,
                          ),
                          children: [
                            for (int i = 0; i < (cols.$2 == GridColumns.two ? 4 : cols.$2 == GridColumns.three ? 6 : 8); i++)
                              _smallBox(),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Auto-fit responsive grids', [
              ArcaneColumn(
                gapSize: Gap.md,
                children: [
                  for (final cols in [
                    ('autoFitSm (min 200px)', GridColumns.autoFitSm),
                    ('autoFitMd (min 280px)', GridColumns.autoFitMd),
                    ('autoFitLg (min 320px)', GridColumns.autoFitLg),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneText(cols.$1, size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            display: Display.grid,
                            gridColumns: cols.$2,
                            gap: Gap.sm,
                            padding: PaddingPreset.sm,
                            background: Background.surface,
                            borderRadius: Radius.md,
                          ),
                          children: [
                            for (int i = 0; i < 4; i++) _colorBox('${i + 1}'),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Layout presets', [
              ArcaneColumn(
                gapSize: Gap.md,
                children: [
                  for (final cols in [
                    ('sidebar (280px + 1fr)', GridColumns.sidebar),
                    ('mainSidebar (1fr + 300px)', GridColumns.mainSidebar),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneText(cols.$1, size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            display: Display.grid,
                            gridColumns: cols.$2,
                            gap: Gap.sm,
                            padding: PaddingPreset.sm,
                            background: Background.surface,
                            borderRadius: Radius.md,
                            heightCustom: '60px',
                          ),
                          children: [
                            ArcaneDiv(
                              styles: const ArcaneStyleData(background: Background.accent, borderRadius: Radius.sm),
                              children: [],
                            ),
                            ArcaneDiv(
                              styles: const ArcaneStyleData(background: Background.surfaceVariant, borderRadius: Radius.sm),
                              children: [],
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // POSITION DEMOS
  // ============================================================

  /// Position presets
  static List<Component> position() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Position values', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  for (final pos in [
                    ('relative', Position.relative),
                    ('absolute', Position.absolute),
                    ('fixed', Position.fixed),
                    ('sticky', Position.sticky),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            widthCustom: '80px',
                            heightCustom: '60px',
                            background: Background.surfaceVariant,
                            borderRadius: Radius.md,
                            position: Position.relative,
                          ),
                          children: [
                            ArcaneDiv(
                              styles: ArcaneStyleData(
                                position: pos.$2 == Position.fixed || pos.$2 == Position.sticky
                                    ? Position.relative
                                    : pos.$2,
                                top: pos.$2 == Position.absolute ? '5px' : null,
                                left: pos.$2 == Position.absolute ? '5px' : null,
                                widthCustom: '30px',
                                heightCustom: '30px',
                                background: Background.accent,
                                borderRadius: Radius.xs,
                              ),
                              children: [],
                            ),
                          ],
                        ),
                        ArcaneText(pos.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('ZIndex layers', [
              ArcaneColumn(
                gapSize: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final z in [
                    ('base (0)', ZIndex.base),
                    ('dropdown (1000)', ZIndex.dropdown),
                    ('modal (1050)', ZIndex.modal),
                    ('tooltip (1070)', ZIndex.tooltip),
                    ('toast (1080)', ZIndex.toast),
                  ])
                    ArcaneRow(
                      gapSize: Gap.md,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '140px'),
                          children: [ArcaneText(z.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '60px',
                            heightCustom: '25px',
                            background: Background.accent,
                            borderRadius: Radius.sm,
                            zIndex: z.$2,
                          ),
                          children: [],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // MAX WIDTH DEMOS
  // ============================================================

  /// MaxWidth presets
  static List<Component> maxWidths() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('MaxWidth presets', [
              ArcaneColumn(
                gapSize: Gap.sm,
                children: [
                  for (final mw in [
                    ('card (400px)', MaxWidth.card),
                    ('form (480px)', MaxWidth.form),
                    ('narrowText (560px)', MaxWidth.narrowText),
                    ('text (680px)', MaxWidth.text),
                    ('narrow (800px)', MaxWidth.narrow),
                    ('content (1024px)', MaxWidth.content),
                    ('container (1280px)', MaxWidth.container),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneText(mw.$1, size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            maxWidth: mw.$2,
                            heightCustom: '25px',
                            background: Background.accent,
                            borderRadius: Radius.sm,
                          ),
                          children: [],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // TYPOGRAPHY EXTENDED DEMOS
  // ============================================================

  /// Line height demos
  static List<Component> lineHeights() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Line height presets', [
              ArcaneColumn(
                gapSize: Gap.md,
                children: [
                  for (final lh in [
                    ('tight (1.1)', LineHeight.tight),
                    ('snug (1.25)', LineHeight.snug),
                    ('normal (1.5)', LineHeight.normal),
                    ('relaxed (1.625)', LineHeight.relaxed),
                    ('loose (2)', LineHeight.loose),
                  ])
                    ArcaneRow(
                      gapSize: Gap.md,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '120px'),
                          children: [ArcaneText(lh.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            maxWidth: MaxWidth.card,
                            lineHeight: lh.$2,
                            padding: PaddingPreset.sm,
                            background: Background.surface,
                            borderRadius: Radius.sm,
                          ),
                          children: const [
                            ArcaneText(
                              'This is sample text that demonstrates line height. Notice how the spacing between lines changes.',
                              size: FontSize.sm,
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Letter spacing demos
  static List<Component> letterSpacings() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Letter spacing presets', [
              ArcaneColumn(
                gapSize: Gap.sm,
                children: [
                  for (final ls in [
                    ('tighter (-0.05em)', LetterSpacing.tighter),
                    ('tight (-0.025em)', LetterSpacing.tight),
                    ('normal (0)', LetterSpacing.normal),
                    ('wide (0.025em)', LetterSpacing.wide),
                    ('wider (0.05em)', LetterSpacing.wider),
                    ('widest (0.2em)', LetterSpacing.widest),
                  ])
                    ArcaneRow(
                      gapSize: Gap.md,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '140px'),
                          children: [ArcaneText(ls.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: ArcaneStyleData(letterSpacing: ls.$2),
                          children: const [ArcaneText('LETTER SPACING', size: FontSize.sm, weight: FontWeight.w600)],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Text transform demos
  static List<Component> textTransforms() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Text transform presets', [
              ArcaneColumn(
                gapSize: Gap.sm,
                children: [
                  for (final tt in [
                    ('none', TextTransform.none),
                    ('uppercase', TextTransform.uppercase),
                    ('lowercase', TextTransform.lowercase),
                    ('capitalize', TextTransform.capitalize),
                  ])
                    ArcaneRow(
                      gapSize: Gap.md,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '100px'),
                          children: [ArcaneText(tt.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: ArcaneStyleData(textTransform: tt.$2),
                          children: const [ArcaneText('Sample Text Here', size: FontSize.sm)],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // NEON & GAME COLORS
  // ============================================================

  /// Neon color demos
  static List<Component> neonColors() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('ArcaneColor neon palette', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final neon in [
                    ('neonPink', ArcaneColor.neonPink),
                    ('neonCyan', ArcaneColor.neonCyan),
                    ('neonPurple', ArcaneColor.neonPurple),
                    ('neonGreen', ArcaneColor.neonGreen),
                    ('neonOrange', ArcaneColor.neonOrange),
                    ('neonBlue', ArcaneColor.neonBlue),
                    ('neonRed', ArcaneColor.neonRed),
                    ('neonYellow', ArcaneColor.neonYellow),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            backgroundCustom: neon.$2.css,
                            borderRadius: Radius.md,
                          ),
                          children: [],
                        ),
                        ArcaneText(neon.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Extended neon palette', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final neon in [
                    ('neonLime', ArcaneColor.neonLime),
                    ('neonMagenta', ArcaneColor.neonMagenta),
                    ('neonTeal', ArcaneColor.neonTeal),
                    ('neonIndigo', ArcaneColor.neonIndigo),
                    ('neonAmber', ArcaneColor.neonAmber),
                    ('neonRose', ArcaneColor.neonRose),
                    ('neonSky', ArcaneColor.neonSky),
                    ('neonViolet', ArcaneColor.neonViolet),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            backgroundCustom: neon.$2.css,
                            borderRadius: Radius.md,
                          ),
                          children: [],
                        ),
                        ArcaneText(neon.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Neon text colors', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  ArcaneDiv(
                    styles: ArcaneStyleData(colorCustom: ArcaneColor.neonPink.css),
                    children: const [ArcaneText('Pink', size: FontSize.lg, weight: FontWeight.bold)],
                  ),
                  ArcaneDiv(
                    styles: ArcaneStyleData(colorCustom: ArcaneColor.neonCyan.css),
                    children: const [ArcaneText('Cyan', size: FontSize.lg, weight: FontWeight.bold)],
                  ),
                  ArcaneDiv(
                    styles: ArcaneStyleData(colorCustom: ArcaneColor.neonPurple.css),
                    children: const [ArcaneText('Purple', size: FontSize.lg, weight: FontWeight.bold)],
                  ),
                  ArcaneDiv(
                    styles: ArcaneStyleData(colorCustom: ArcaneColor.neonGreen.css),
                    children: const [ArcaneText('Green', size: FontSize.lg, weight: FontWeight.bold)],
                  ),
                  ArcaneDiv(
                    styles: ArcaneStyleData(colorCustom: ArcaneColor.neonBlue.css),
                    children: const [ArcaneText('Blue', size: FontSize.lg, weight: FontWeight.bold)],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Game color demos
  static List<Component> gameColors() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('ArcaneColor game palette', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final game in [
                    ('gameMinecraft', ArcaneColor.gameMinecraft),
                    ('gameRust', ArcaneColor.gameRust),
                    ('gameArk', ArcaneColor.gameArk),
                    ('gameValheim', ArcaneColor.gameValheim),
                    ('gameCs2', ArcaneColor.gameCs2),
                    ('gameTerraria', ArcaneColor.gameTerraria),
                    ('gameHytale', ArcaneColor.gameHytale),
                    ('gamePalworld', ArcaneColor.gamePalworld),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            backgroundCustom: game.$2.css,
                            borderRadius: Radius.md,
                          ),
                          children: [],
                        ),
                        ArcaneText(game.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('ArcaneColor brand palette', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final brand in [
                    ('brandDiscord', ArcaneColor.brandDiscord),
                    ('brandTwitch', ArcaneColor.brandTwitch),
                    ('brandYoutube', ArcaneColor.brandYoutube),
                    ('brandGithub', ArcaneColor.brandGithub),
                    ('brandSteam', ArcaneColor.brandSteam),
                    ('brandPatreon', ArcaneColor.brandPatreon),
                    ('brandSpotify', ArcaneColor.brandSpotify),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            backgroundCustom: brand.$2.css,
                            borderRadius: Radius.md,
                          ),
                          children: [],
                        ),
                        ArcaneText(brand.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // TRANSFORM & ANIMATION DEMOS
  // ============================================================

  /// Transform presets
  static List<Component> transforms() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Transform presets', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  for (final t in [
                    ('hoverLift', Transform.hoverLift),
                    ('hoverScale', Transform.hoverScale),
                    ('rotate90', Transform.rotate90),
                    ('rotate180', Transform.rotate180),
                    ('flipX', Transform.flipX),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            background: Background.accent,
                            borderRadius: Radius.md,
                            transform: t.$2,
                            display: Display.flex,
                            alignItems: AlignItems.center,
                            justifyContent: JustifyContent.center,
                          ),
                          children: [ArcaneIcon.arrowUp(size: IconSize.sm, color: TextColor.onPrimary)],
                        ),
                        ArcaneText(t.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// BackdropFilter demos
  static List<Component> backdropFilters() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('BackdropFilter presets', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  for (final bf in [
                    ('none', BackdropFilter.none),
                    ('blurLight (8px)', BackdropFilter.blurLight),
                    ('blur (16px)', BackdropFilter.blur),
                    ('blurStrong (24px)', BackdropFilter.blurStrong),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(
                            widthCustom: '80px',
                            heightCustom: '60px',
                            position: Position.relative,
                            backgroundCustom: 'linear-gradient(45deg, var(--primary), var(--destructive))',
                            borderRadius: Radius.md,
                            overflow: Overflow.hidden,
                          ),
                          children: [
                            ArcaneDiv(
                              styles: ArcaneStyleData(
                                position: Position.absolute,
                                inset: '10px',
                                backdropFilter: bf.$2,
                                background: Background.glassTint,
                                borderRadius: Radius.sm,
                              ),
                              children: [],
                            ),
                          ],
                        ),
                        ArcaneText(bf.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // CURSOR DEMOS
  // ============================================================

  /// Cursor presets
  static List<Component> cursors() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Cursor presets', [
              ArcaneRow(
                gapSize: Gap.sm,
                children: [
                  for (final c in [
                    ('pointer', Cursor.pointer),
                    ('text', Cursor.text),
                    ('move', Cursor.move),
                    ('grab', Cursor.grab),
                    ('notAllowed', Cursor.notAllowed),
                    ('wait', Cursor.wait),
                    ('help', Cursor.help),
                  ])
                    ArcaneDiv(
                      styles: ArcaneStyleData(
                        padding: PaddingPreset.smMd,
                        background: Background.surface,
                        borderRadius: Radius.md,
                        border: BorderPreset.subtle,
                        cursor: c.$2,
                      ),
                      children: [ArcaneText(c.$1, size: FontSize.xs, color: TextColor.muted)],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // ============================================================
  // FLEXBOX ALIGNMENT DEMOS
  // ============================================================

  /// Flex alignment demos
  static List<Component> flexAlignment() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('JustifyContent values', [
              ArcaneColumn(
                gapSize: Gap.sm,
                children: [
                  for (final jc in [
                    ('flexStart', JustifyContent.flexStart),
                    ('center', JustifyContent.center),
                    ('flexEnd', JustifyContent.flexEnd),
                    ('spaceBetween', JustifyContent.spaceBetween),
                    ('spaceAround', JustifyContent.spaceAround),
                    ('spaceEvenly', JustifyContent.spaceEvenly),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneText(jc.$1, size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            display: Display.flex,
                            justifyContent: jc.$2,
                            padding: PaddingPreset.sm,
                            background: Background.surface,
                            borderRadius: Radius.sm,
                            widthCustom: '300px',
                          ),
                          children: [_smallBox(), _smallBox(), _smallBox()],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('AlignItems values', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final ai in [
                    ('flexStart', AlignItems.flexStart),
                    ('center', AlignItems.center),
                    ('flexEnd', AlignItems.flexEnd),
                    ('stretch', AlignItems.stretch),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneText(ai.$1, size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            display: Display.flex,
                            alignItems: ai.$2,
                            heightCustom: '80px',
                            padding: PaddingPreset.sm,
                            background: Background.surface,
                            borderRadius: Radius.sm,
                            gap: Gap.xs,
                          ),
                          children: [
                            ArcaneDiv(
                              styles: ArcaneStyleData(
                                widthCustom: '24px',
                                heightCustom: ai.$2 == AlignItems.stretch ? null : '24px',
                                background: Background.accent,
                                borderRadius: Radius.xs,
                              ),
                              children: [],
                            ),
                            ArcaneDiv(
                              styles: ArcaneStyleData(
                                widthCustom: '24px',
                                heightCustom: ai.$2 == AlignItems.stretch ? null : '36px',
                                background: Background.accent,
                                borderRadius: Radius.xs,
                              ),
                              children: [],
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // Helper methods
  static Component _buildStyleDemo(String title, List<Component> children) {
    return ArcaneColumn(
      gapSize: Gap.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneText(title, weight: FontWeight.w600, size: FontSize.sm),
        ...children,
      ],
    );
  }

  static Component _colorBox(String label) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '50px',
        heightCustom: '50px',
        background: Background.accent,
        borderRadius: Radius.sm,
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
      ),
      children: [ArcaneText(label, color: TextColor.primary, weight: FontWeight.w600)],
    );
  }

  static Component _smallBox() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '24px',
        heightCustom: '24px',
        background: Background.accent,
        borderRadius: Radius.xs,
      ),
      children: [],
    );
  }

  static Component _textSwatch(String name, TextColor color) {
    return ArcaneColumn(
      gapSize: Gap.xs,
      children: [
        ArcaneText('Aa', size: FontSize.xl, weight: FontWeight.bold, color: color),
        ArcaneText(name, size: FontSize.xs, color: TextColor.muted),
      ],
    );
  }
}
