/// Single-value spacing scale for uniform padding/margin values.
///
/// Based on a 4px base unit, provides consistent spacing throughout the UI.
///
/// ## Spacing Scale
///
/// | Value     | Size  | Use Case                    |
/// |-----------|-------|------------------------------|
/// | `none`    | 0px   | No spacing                   |
/// | `xs`      | 4px   | Tight spacing, icons         |
/// | `sm`      | 8px   | Compact elements             |
/// | `md`      | 16px  | Standard spacing             |
/// | `lg`      | 24px  | Generous spacing             |
/// | `xl`      | 32px  | Section spacing              |
/// | `xxl`     | 48px  | Large sections               |
/// | `xxxl`    | 64px  | Major sections               |
/// | `huge`    | 96px  | Hero sections                |
/// | `massive` | 128px | Full-page hero               |
///
/// ## Example
///
/// ```dart
/// ArcaneStyleData(
///   padding: PaddingPreset.md,  // 16px all sides
///   gap: Gap.sm,                // 8px between items
/// )
/// ```
enum Spacing {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl,
  huge,
  massive;

  String get css => switch (this) {
        Spacing.none => '0',
        Spacing.xs => '4px',
        Spacing.sm => '8px',
        Spacing.md => '16px',
        Spacing.lg => '24px',
        Spacing.xl => '32px',
        Spacing.xxl => '48px',
        Spacing.xxxl => '64px',
        Spacing.huge => '96px',
        Spacing.massive => '120px',
      };

  double get value => switch (this) {
        Spacing.none => 0,
        Spacing.xs => 4,
        Spacing.sm => 8,
        Spacing.md => 16,
        Spacing.lg => 24,
        Spacing.xl => 32,
        Spacing.xxl => 48,
        Spacing.xxxl => 64,
        Spacing.huge => 96,
        Spacing.massive => 120,
      };
}

/// Compound padding presets for common UI patterns.
///
/// These presets combine vertical and horizontal padding values for
/// common use cases like buttons, cards, and sections.
///
/// ## Naming Convention
///
/// - **Single values** (`xs`, `sm`, `md`, `lg`, `xl`): Equal padding all sides
/// - **Compound values** (`smMd`, `mdLg`): `{vertical}{horizontal}` format
/// - **Directional** (`horizontalSm`, `verticalMd`, `topLg`): One direction only
/// - **Semantic** (`button*`, `card`, `section`): Use-case specific
///
/// ## Common Presets
///
/// ```dart
/// // Buttons
/// PaddingPreset.buttonSm  // 6px 12px  - Small button
/// PaddingPreset.buttonMd  // 10px 16px - Medium button
/// PaddingPreset.buttonLg  // 12px 24px - Large button
///
/// // Cards and sections
/// PaddingPreset.card      // 16px 32px
/// PaddingPreset.section   // 24px 48px
///
/// // Chips and badges
/// PaddingPreset.badge     // 2px 8px
/// PaddingPreset.chip      // 4px 12px
/// ```
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     padding: PaddingPreset.md,      // 16px all sides
///     // or
///     padding: PaddingPreset.smMd,    // 8px vertical, 16px horizontal
///     // or
///     padding: PaddingPreset.buttonMd, // Standard button padding
///   ),
///   children: [...],
/// )
/// ```
enum PaddingPreset {
  /// No padding
  none,

  /// 4px all sides
  xs,

  /// 8px all sides
  sm,

  /// 16px all sides
  md,

  /// 24px all sides
  lg,

  /// 32px all sides
  xl,

  /// 48px all sides
  xxl,

  /// 64px all sides
  xxxl,

  /// 4px vertical, 16px horizontal
  xsMd,

  /// 8px vertical, 16px horizontal
  smMd,

  /// 16px vertical, 24px horizontal
  mdLg,

  /// 24px vertical, 32px horizontal
  lgXl,

  /// 4px vertical, 8px horizontal (small buttons)
  xsSm,

  /// 6px vertical, 12px horizontal (button small)
  buttonSm,

  /// 10px vertical, 16px horizontal (button medium)
  buttonMd,

  /// 12px vertical, 24px horizontal (button large)
  buttonLg,

  /// 16px vertical, 32px horizontal (card)
  card,

  /// 24px vertical, 48px horizontal (section)
  section,

  /// 80px vertical, 24px horizontal (page section)
  sectionY,

  /// 120px vertical, 24px horizontal (hero section)
  heroY,

  /// 96px vertical only (carousel sections, no horizontal padding)
  hugeY,

  /// 8px horizontal only
  horizontalSm,

  /// 16px horizontal only
  horizontalMd,

  /// 24px horizontal only
  horizontalLg,

  /// 16px vertical only
  verticalMd,

  /// 24px vertical only
  verticalLg,

  /// 8px top padding only
  topSm,

  /// 16px top padding only
  topMd,

  /// 24px top padding only
  topLg,

  /// 8px vertical, 24px horizontal (small-large)
  smLg,

  /// 12px vertical, 32px horizontal (medium-xl)
  mdXl,

  /// 32px horizontal only
  horizontalXl,

  /// 16px bottom only
  bottomMd,

  /// 2px vertical, 8px horizontal (badge/tag)
  badge,

  /// 2px vertical, 6px horizontal (inline code)
  inlineCode,

  /// 4px vertical, 12px horizontal (chip)
  chip;

  String get css => switch (this) {
        PaddingPreset.none => '0',
        PaddingPreset.xs => '4px',
        PaddingPreset.sm => '8px',
        PaddingPreset.md => '16px',
        PaddingPreset.lg => '24px',
        PaddingPreset.xl => '32px',
        PaddingPreset.xxl => '48px',
        PaddingPreset.xxxl => '64px',
        PaddingPreset.xsMd => '4px 16px',
        PaddingPreset.smMd => '8px 16px',
        PaddingPreset.mdLg => '16px 24px',
        PaddingPreset.lgXl => '24px 32px',
        PaddingPreset.xsSm => '4px 8px',
        PaddingPreset.buttonSm => '6px 12px',
        PaddingPreset.buttonMd => '10px 16px',
        PaddingPreset.buttonLg => '12px 24px',
        PaddingPreset.card => '16px 32px',
        PaddingPreset.section => '24px 48px',
        PaddingPreset.sectionY => '80px 24px',
        PaddingPreset.heroY => '120px 24px',
        PaddingPreset.hugeY => '96px 0',
        PaddingPreset.horizontalSm => '0 8px',
        PaddingPreset.horizontalMd => '0 16px',
        PaddingPreset.horizontalLg => '0 24px',
        PaddingPreset.verticalMd => '16px 0',
        PaddingPreset.verticalLg => '24px 0',
        PaddingPreset.topSm => '8px 0 0 0',
        PaddingPreset.topMd => '16px 0 0 0',
        PaddingPreset.topLg => '24px 0 0 0',
        PaddingPreset.smLg => '8px 24px',
        PaddingPreset.mdXl => '16px 32px',
        PaddingPreset.horizontalXl => '0 32px',
        PaddingPreset.bottomMd => '0 0 16px 0',
        PaddingPreset.badge => '2px 8px',
        PaddingPreset.inlineCode => '2px 6px',
        PaddingPreset.chip => '4px 12px',
      };
}

/// Compound margin presets for common patterns
enum MarginPreset {
  /// No margin
  none,

  /// 4px all sides
  xs,

  /// 8px all sides
  sm,

  /// 16px all sides
  md,

  /// 24px all sides
  lg,

  /// 32px all sides
  xl,

  /// Auto horizontal (centering)
  autoX,

  /// Auto vertical
  autoY,

  /// Auto all (center both axes)
  auto,

  /// 8px top only
  topSm,

  /// 16px top only
  topMd,

  /// 24px top only
  topLg,

  /// 4px bottom only
  bottomXs,

  /// 8px bottom only
  bottomSm,

  /// 16px bottom only
  bottomMd,

  /// 24px bottom only
  bottomLg,

  /// 32px bottom only
  bottomXl,

  /// 48px bottom only
  bottomXxl,

  /// 64px bottom only
  bottomXxxl,

  /// 4px top only
  topXs,

  /// 32px top only
  topXl,

  /// 48px top only
  topXxl,

  /// 8px vertical
  verticalSm,

  /// 16px vertical
  verticalMd,

  /// 24px vertical
  verticalLg,

  /// 32px vertical
  verticalXl,

  /// 8px horizontal
  horizontalSm,

  /// 16px horizontal
  horizontalMd,

  /// 24px horizontal
  horizontalLg,

  /// 8px right only
  rightSm,

  /// 16px right only
  rightMd,

  /// 24px right only
  rightLg,

  /// 8px left only
  leftSm,

  /// 16px left only
  leftMd,

  /// 24px left only
  leftLg,

  /// Centered horizontally with 16px bottom margin
  centerBottomMd,

  /// Centered horizontally with 24px bottom margin
  centerBottomLg,

  /// Centered horizontally with 32px bottom margin
  centerBottomXl,

  /// Centered horizontally with 48px bottom margin
  centerBottomXxl;

  String get css => switch (this) {
        MarginPreset.none => '0',
        MarginPreset.xs => '4px',
        MarginPreset.sm => '8px',
        MarginPreset.md => '16px',
        MarginPreset.lg => '24px',
        MarginPreset.xl => '32px',
        MarginPreset.autoX => '0 auto',
        MarginPreset.autoY => 'auto 0',
        MarginPreset.auto => 'auto',
        MarginPreset.topXs => '4px 0 0 0',
        MarginPreset.topSm => '8px 0 0 0',
        MarginPreset.topMd => '16px 0 0 0',
        MarginPreset.topLg => '24px 0 0 0',
        MarginPreset.topXl => '32px 0 0 0',
        MarginPreset.topXxl => '48px 0 0 0',
        MarginPreset.bottomXs => '0 0 4px 0',
        MarginPreset.bottomSm => '0 0 8px 0',
        MarginPreset.bottomMd => '0 0 16px 0',
        MarginPreset.bottomLg => '0 0 24px 0',
        MarginPreset.bottomXl => '0 0 32px 0',
        MarginPreset.bottomXxl => '0 0 48px 0',
        MarginPreset.bottomXxxl => '0 0 64px 0',
        MarginPreset.verticalSm => '8px 0',
        MarginPreset.verticalMd => '16px 0',
        MarginPreset.verticalLg => '24px 0',
        MarginPreset.verticalXl => '32px 0',
        MarginPreset.horizontalSm => '0 8px',
        MarginPreset.horizontalMd => '0 16px',
        MarginPreset.horizontalLg => '0 24px',
        MarginPreset.rightSm => '0 8px 0 0',
        MarginPreset.rightMd => '0 16px 0 0',
        MarginPreset.rightLg => '0 24px 0 0',
        MarginPreset.leftSm => '0 0 0 8px',
        MarginPreset.leftMd => '0 0 0 16px',
        MarginPreset.leftLg => '0 0 0 24px',
        MarginPreset.centerBottomMd => '0 auto 16px auto',
        MarginPreset.centerBottomLg => '0 auto 24px auto',
        MarginPreset.centerBottomXl => '0 auto 32px auto',
        MarginPreset.centerBottomXxl => '0 auto 48px auto',
      };
}

/// Gap presets for flex and grid layouts.
///
/// Controls spacing between child elements in flex containers and grid cells.
///
/// ## Gap Scale
///
/// | Value  | Size | Typical Use                    |
/// |--------|------|--------------------------------|
/// | `none` | 0px  | No gap between items           |
/// | `xs`   | 4px  | Very tight spacing             |
/// | `sm`   | 8px  | Compact layouts, icon groups   |
/// | `md`   | 16px | Standard spacing               |
/// | `lg`   | 24px | Card grids, form sections      |
/// | `xl`   | 32px | Major sections                 |
/// | `xxl`  | 48px | Page sections                  |
/// | `xxxl` | 64px | Hero content                   |
///
/// ## Example
///
/// ```dart
/// // Flex container with gap
/// ArcaneRow(
///   gapSize: Gap.md,
///   children: [Button1(), Button2()],
/// )
///
/// // Grid with custom gaps
/// ArcaneStyleData(
///   display: Display.grid,
///   gridColumns: GridColumns.three,
///   gap: Gap.lg,        // Both row and column gap
///   rowGap: Gap.xl,     // Override row gap only
///   columnGap: Gap.md,  // Override column gap only
/// )
/// ```
enum Gap {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl;

  String get css => switch (this) {
        Gap.none => '0',
        Gap.xs => '4px',
        Gap.sm => '8px',
        Gap.md => '16px',
        Gap.lg => '24px',
        Gap.xl => '32px',
        Gap.xxl => '48px',
        Gap.xxxl => '64px',
      };

  double get value => switch (this) {
        Gap.none => 0,
        Gap.xs => 4,
        Gap.sm => 8,
        Gap.md => 16,
        Gap.lg => 24,
        Gap.xl => 32,
        Gap.xxl => 48,
        Gap.xxxl => 64,
      };
}
