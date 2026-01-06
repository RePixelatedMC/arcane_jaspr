import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

/// A settings section card with a title and content.
///
/// Use this for grouping related settings in a dashboard.
class ArcaneSettingsSection extends StatelessComponent {
  /// The section title
  final String title;

  /// Optional description below the title
  final String? description;

  /// The section content
  final List<Component> children;

  /// Whether this is a danger zone section (destructive actions)
  final bool danger;

  const ArcaneSettingsSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
    this.danger = false,
  });

  /// Creates a danger zone section (red border, destructive styling)
  const ArcaneSettingsSection.danger({
    super.key,
    required this.title,
    this.description,
    required this.children,
  }) : danger = true;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-settings-section ${danger ? 'danger' : ''}',
      styles: Styles(raw: {
        'background': danger ? 'hsl(var(--destructive) / 0.05)' : 'var(--card)',
        'border': danger
            ? '1px solid hsl(var(--destructive) / 0.2)'
            : '1px solid var(--border)',
        'border-radius': '0.5rem',
        'padding': '1.5rem',
        'margin-bottom': '1.5rem',
      }),
      [
        // Header
        div(
          classes: 'arcane-settings-section-header',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.5rem',
            'margin-bottom': '1.5rem',
            'padding-bottom': '1rem',
            'border-bottom': '1px solid ${danger ? 'hsl(var(--destructive) / 0.2)' : 'var(--border)'}',
          }),
          [
            h2(
              styles: Styles(raw: {
                'font-size': '1.125rem',
                'font-weight': '600',
                'color': danger ? 'var(--destructive)' : 'var(--foreground)',
                'margin': '0',
              }),
              [Component.text(title)],
            ),
          ],
        ),
        // Description
        if (description != null)
          p(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'margin': '0 0 1rem 0',
            }),
            [Component.text(description!)],
          ),
        // Content
        ...children,
      ],
    );
  }
}

/// A row displaying a label and value (for profile info, etc.)
class ArcaneSettingsInfoRow extends StatelessComponent {
  /// The label/name
  final String label;

  /// The value to display
  final String value;

  /// Whether to use monospace font for the value
  final bool monospace;

  const ArcaneSettingsInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.monospace = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-settings-info-row',
      styles: const Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '1rem 0',
        'border-bottom': '1px solid var(--border)',
      }),
      [
        span(
          styles: const Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--muted-foreground)',
          }),
          [Component.text(label)],
        ),
        span(
          styles: Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--foreground)',
            if (monospace) 'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
          }),
          [Component.text(value)],
        ),
      ],
    );
  }
}

/// A toggle switch row for settings (title, description, toggle)
class ArcaneSettingsToggleRow extends StatelessComponent {
  /// The toggle title
  final String title;

  /// Optional description
  final String? description;

  /// Whether the toggle is enabled
  final bool enabled;

  /// Callback when toggle changes
  final void Function(bool)? onChanged;

  /// Whether the toggle is disabled
  final bool disabled;

  const ArcaneSettingsToggleRow({
    super.key,
    required this.title,
    this.description,
    required this.enabled,
    this.onChanged,
    this.disabled = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-settings-toggle-row ${disabled ? 'disabled' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '1rem',
        'border-bottom': '1px solid var(--border)',
        if (disabled) 'opacity': '0.5',
      }),
      [
        // Labels
        div(
          styles: const Styles(raw: {
            'flex': '1',
          }),
          [
            div(
              styles: const Styles(raw: {
                'font-size': '0.875rem',
                'font-weight': '500',
                'color': 'var(--foreground)',
              }),
              [Component.text(title)],
            ),
            if (description != null)
              div(
                styles: const Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '2px',
                }),
                [Component.text(description!)],
              ),
          ],
        ),
        // Toggle
        button(
          classes: 'arcane-toggle ${enabled ? 'enabled' : ''}',
          attributes: {
            'type': 'button',
            'role': 'switch',
            'aria-checked': enabled.toString(),
            if (disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'width': '44px',
            'height': '24px',
            'background': enabled ? 'var(--accent)' : 'var(--muted)',
            'border-radius': '12px',
            'border': 'none',
            'cursor': disabled ? 'not-allowed' : 'pointer',
            'position': 'relative',
            'transition': 'all 150ms ease',
            'flex-shrink': '0',
          }),
          events: {
            if (!disabled && onChanged != null)
              'click': (e) => onChanged!(!enabled),
          },
          [
            div(
              classes: 'arcane-toggle-thumb',
              styles: Styles(raw: {
                'width': '20px',
                'height': '20px',
                'background': 'var(--accent-foreground)',
                'border-radius': '9999px',
                'position': 'absolute',
                'top': '2px',
                'left': enabled ? '22px' : '2px',
                'transition': 'all 150ms ease',
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }
}

/// A subsection header within a settings section
class ArcaneSettingsSubheader extends StatelessComponent {
  /// The subsection title
  final String title;

  /// Optional description
  final String? description;

  const ArcaneSettingsSubheader({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-settings-subheader',
      styles: const Styles(raw: {
        'margin-bottom': '1rem',
      }),
      [
        div(
          styles: Styles(raw: {
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--foreground)',
            'margin-bottom': description != null ? '0.25rem' : '0',
          }),
          [Component.text(title)],
        ),
        if (description != null)
          p(
            styles: const Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
              'margin': '0',
            }),
            [Component.text(description!)],
          ),
      ],
    );
  }
}

/// A note/info box within a settings section
class ArcaneSettingsNote extends StatelessComponent {
  /// The note text
  final String text;

  /// The note variant
  final ArcaneSettingsNoteVariant variant;

  const ArcaneSettingsNote({
    super.key,
    required this.text,
    this.variant = ArcaneSettingsNoteVariant.info,
  });

  const ArcaneSettingsNote.info({super.key, required this.text})
      : variant = ArcaneSettingsNoteVariant.info;

  const ArcaneSettingsNote.warning({super.key, required this.text})
      : variant = ArcaneSettingsNoteVariant.warning;

  const ArcaneSettingsNote.success({super.key, required this.text})
      : variant = ArcaneSettingsNoteVariant.success;

  @override
  Component build(BuildContext context) {
    final colors = _getColors();
    return div(
      classes: 'arcane-settings-note ${variant.name}',
      styles: Styles(raw: {
        'margin-top': '1rem',
        'padding': '1rem',
        'background': colors.background,
        'border-radius': '0.375rem',
      }),
      [
        p(
          styles: const Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--muted-foreground)',
            'margin': '0',
          }),
          [Component.text(text)],
        ),
      ],
    );
  }

  ({String background}) _getColors() {
    switch (variant) {
      case ArcaneSettingsNoteVariant.info:
        return (background: 'hsl(var(--accent) / 0.1)');
      case ArcaneSettingsNoteVariant.warning:
        return (background: 'hsl(38 92% 50% / 0.1)');
      case ArcaneSettingsNoteVariant.success:
        return (background: 'hsl(142 76% 36% / 0.1)');
    }
  }
}

enum ArcaneSettingsNoteVariant { info, warning, success }
