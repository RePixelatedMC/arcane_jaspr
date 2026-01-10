const String _qnBorder = 'var(--qn-border, rgba(5, 150, 105, 0.25))';

/// Border presets combining width, style, and color
enum BorderPreset {
  none,
  subtle,
  standard,
  medium,
  light,
  accent,
  success,
  warning,
  error,
  info,
  focus,
  accentThick,
  dashedSubtle,
  dashedStandard,
  brand,
  brandThick,
  topSubtle,
  bottomSubtle;

  String get css => switch (this) {
        BorderPreset.none => 'none',
        BorderPreset.subtle => '1px solid var(--input)',
        BorderPreset.standard => '1px solid var(--border)',
        BorderPreset.medium => '1px solid color-mix(in srgb, var(--foreground) 10%, transparent)',
        BorderPreset.light => '1px solid color-mix(in srgb, var(--foreground) 15%, transparent)',
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

/// Border radius presets
enum Radius {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  full,
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

/// Border width presets
enum BorderWidth {
  none,
  hairline,
  thin,
  medium,
  thick,
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

/// Border style values
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
  none,
  focus,
  focusAccent,
  focusError,
  ring;

  String get css => switch (this) {
        OutlinePreset.none => 'none',
        OutlinePreset.focus => '2px solid var(--ring)',
        OutlinePreset.focusAccent => '2px solid var(--primary)',
        OutlinePreset.focusError => '2px solid var(--destructive)',
        OutlinePreset.ring => '2px solid var(--ring)',
      };
}
