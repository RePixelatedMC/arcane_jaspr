// CSS variable references for QualityNode brand colors
const String _qnBorder = 'var(--qn-border, rgba(5, 150, 105, 0.25))';

/// Complete border presets combining width, style, and color.
///
/// These presets provide ready-to-use border configurations for common
/// UI patterns. Use for quick, consistent border styling.
///
/// ## Standard Borders
///
/// | Preset       | Description                    |
/// |--------------|--------------------------------|
/// | `none`       | No border                      |
/// | `subtle`     | 1px barely visible             |
/// | `standard`   | 1px default border             |
/// | `medium`     | 1px medium emphasis            |
/// | `accent`     | 1px accent color               |
///
/// ## Status Borders
///
/// | Preset    | Use Case                          |
/// |-----------|-----------------------------------|
/// | `success` | Success/confirmation states       |
/// | `warning` | Warning/caution states            |
/// | `error`   | Error/destructive states          |
/// | `info`    | Informational states              |
/// | `focus`   | Focus ring (2px)                  |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     border: BorderPreset.standard,    // All sides
///     borderLeft: BorderPreset.accent,  // Left only
///     borderBottom: BorderPreset.subtle, // Bottom only
///   ),
/// )
/// ```
enum BorderPreset {
  /// No border
  none,

  /// 1px solid subtle border
  subtle,

  /// 1px solid standard border
  standard,

  /// 1px solid medium border
  medium,

  /// 1px solid light border
  light,

  /// 1px solid accent border
  accent,

  /// 1px solid success border
  success,

  /// 1px solid warning border
  warning,

  /// 1px solid error border
  error,

  /// 1px solid info border
  info,

  /// 2px solid ring (focus state)
  focus,

  /// 2px solid accent
  accentThick,

  /// Dashed subtle border
  dashedSubtle,

  /// Dashed standard border
  dashedStandard,

  /// Brand colored border (theme-reactive)
  brand,

  /// 2px solid brand primary (for highlighted cards)
  brandThick,

  /// Top border only (subtle)
  topSubtle,

  /// Bottom border only (subtle)
  bottomSubtle;

  String get css => switch (this) {
        BorderPreset.none => 'none',
        BorderPreset.subtle => '1px solid var(--input)',
        BorderPreset.standard => '1px solid var(--border)',
        BorderPreset.medium => '1px solid hsl(var(--foreground) / 0.10)',
        BorderPreset.light => '1px solid hsl(var(--foreground) / 0.15)',
        BorderPreset.accent => '1px solid var(--primary)',
        BorderPreset.success => '1px solid var(--success)',
        BorderPreset.warning => '1px solid var(--warning)',
        BorderPreset.error => '1px solid var(--destructive)',
        BorderPreset.info => '1px solid var(--info)',
        BorderPreset.focus => '2px solid var(--ring)',
        BorderPreset.accentThick => '2px solid var(--primary)',
        BorderPreset.dashedSubtle => '1px dashed var(--input)',
        BorderPreset.dashedStandard => '1px dashed var(--border)',
        BorderPreset.brand => '1px solid $_qnBorder',
        BorderPreset.brandThick => '2px solid var(--primary)',
        BorderPreset.topSubtle => '1px solid var(--input)',
        BorderPreset.bottomSubtle => '1px solid var(--input)',
      };
}

/// Border radius presets for rounded corners.
///
/// These presets use CSS custom properties that can be themed.
///
/// ## Radius Scale
///
/// | Value   | Size   | Use Case                           |
/// |---------|--------|-------------------------------------|
/// | `none`  | 0      | Sharp corners                       |
/// | `xs`    | 4px    | Subtle rounding                     |
/// | `sm`    | 6px    | Buttons, inputs                     |
/// | `md`    | 8px    | Cards, dialogs                      |
/// | `lg`    | 12px   | Large cards, panels                 |
/// | `xl`    | 16px   | Hero sections                       |
/// | `full`  | 9999px | Pill shapes                         |
/// | `circle`| 50%    | Perfect circles (avatars)           |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     borderRadius: Radius.md,       // Standard card
///     // borderRadius: Radius.full,  // Pill button
///     // borderRadius: Radius.circle, // Avatar
///   ),
/// )
/// ```
enum Radius {
  /// No radius (0)
  none,

  /// Extra small (4px)
  xs,

  /// Small (6px theme-reactive)
  sm,

  /// Medium (8px theme-reactive)
  md,

  /// Large (12px theme-reactive)
  lg,

  /// Extra large (16px theme-reactive)
  xl,

  /// 2x Extra large (24px theme-reactive)
  xxl,

  /// Full/pill (9999px)
  full,

  /// Circle (50%)
  circle;

  String get css => switch (this) {
        Radius.none => '0',
        Radius.xs => 'var(--arcane-radius-xs, 4px)',
        Radius.sm => 'var(--arcane-radius-sm, 6px)',
        Radius.md => 'var(--arcane-radius-md, 8px)',
        Radius.lg => 'var(--arcane-radius-lg, 10px)',
        Radius.xl => 'var(--arcane-radius-xl, 14px)',
        Radius.xxl => 'var(--arcane-radius-2xl, 18px)',
        Radius.full => 'var(--arcane-radius-full, 9999px)',
        Radius.circle => '50%',
      };

  /// Static (non-CSS-variable) value for calculations
  String get staticCss => switch (this) {
        Radius.none => '0',
        Radius.xs => '4px',
        Radius.sm => '6px',
        Radius.md => '8px',
        Radius.lg => '12px',
        Radius.xl => '16px',
        Radius.xxl => '24px',
        Radius.full => '9999px',
        Radius.circle => '50%',
      };
}

/// Border width presets for controlling border thickness.
///
/// Use with directional border properties for fine-grained control.
///
/// ## Width Scale
///
/// | Value      | Size | Use Case                      |
/// |------------|------|-------------------------------|
/// | `none`     | 0    | Remove border                 |
/// | `hairline` | 1px  | Subtle dividers               |
/// | `thin`     | 1px  | Standard borders              |
/// | `medium`   | 2px  | Emphasized borders            |
/// | `thick`    | 3px  | Strong emphasis               |
/// | `heavy`    | 4px  | Maximum emphasis              |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     borderLeft: BorderPreset.accent,
///     borderLeftWidth: BorderWidth.thick,  // 3px accent left
///   ),
/// )
/// ```
enum BorderWidth {
  /// No border
  none,

  /// Hairline (1px)
  hairline,

  /// Thin (1px)
  thin,

  /// Medium (2px)
  medium,

  /// Thick (3px)
  thick,

  /// Heavy (4px)
  heavy;

  String get css => switch (this) {
        BorderWidth.none => '0',
        BorderWidth.hairline => '1px',
        BorderWidth.thin => '1px',
        BorderWidth.medium => '2px',
        BorderWidth.thick => '3px',
        BorderWidth.heavy => '4px',
      };
}

/// Border style
enum BorderStyle {
  none,
  solid,
  dashed,
  dotted,
  double_,
  groove,
  ridge,
  inset,
  outset;

  String get css => switch (this) {
        BorderStyle.none => 'none',
        BorderStyle.solid => 'solid',
        BorderStyle.dashed => 'dashed',
        BorderStyle.dotted => 'dotted',
        BorderStyle.double_ => 'double',
        BorderStyle.groove => 'groove',
        BorderStyle.ridge => 'ridge',
        BorderStyle.inset => 'inset',
        BorderStyle.outset => 'outset',
      };
}

/// Outline presets
enum OutlinePreset {
  /// No outline
  none,

  /// Standard focus outline
  focus,

  /// Accent focus outline
  focusAccent,

  /// Error focus outline
  focusError,

  /// Ring outline
  ring;

  String get css => switch (this) {
        OutlinePreset.none => 'none',
        OutlinePreset.focus => '2px solid var(--ring)',
        OutlinePreset.focusAccent => '2px solid var(--primary)',
        OutlinePreset.focusError => '2px solid var(--destructive)',
        OutlinePreset.ring => '2px solid var(--ring)',
      };
}
