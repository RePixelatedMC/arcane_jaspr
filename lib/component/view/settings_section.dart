import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/settings_section_props.dart';

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
    return context.renderers.settingsSection(SettingsSectionProps(
      title: title,
      description: description,
      children: children,
      danger: danger,
    ));
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
    return context.renderers.settingsInfoRow(SettingsInfoRowProps(
      label: label,
      value: value,
      monospace: monospace,
    ));
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
    return context.renderers.settingsToggleRow(SettingsToggleRowProps(
      title: title,
      description: description,
      enabled: enabled,
      onChanged: onChanged,
      disabled: disabled,
    ));
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
    return context.renderers.settingsSubheader(SettingsSubheaderProps(
      title: title,
      description: description,
    ));
  }
}

/// A note/info box within a settings section
class ArcaneSettingsNote extends StatelessComponent {
  /// The note text
  final String text;

  /// The note variant
  final SettingsNoteVariant variant;

  const ArcaneSettingsNote({
    super.key,
    required this.text,
    this.variant = SettingsNoteVariant.info,
  });

  const ArcaneSettingsNote.info({super.key, required this.text})
      : variant = SettingsNoteVariant.info;

  const ArcaneSettingsNote.warning({super.key, required this.text})
      : variant = SettingsNoteVariant.warning;

  const ArcaneSettingsNote.success({super.key, required this.text})
      : variant = SettingsNoteVariant.success;

  @override
  Component build(BuildContext context) {
    return context.renderers.settingsNote(SettingsNoteProps(
      text: text,
      variant: variant,
    ));
  }
}
