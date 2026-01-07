import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/settings_section_props.dart';

/// A settings section card with a title and content.
class ArcaneSettingsSection extends StatelessComponent {
  final String title;
  final String? description;
  final List<Component> children;
  final bool danger;

  const ArcaneSettingsSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
    this.danger = false,
  });

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

/// A row displaying a label and value.
class ArcaneSettingsInfoRow extends StatelessComponent {
  final String label;
  final String value;
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

/// A toggle switch row for settings.
class ArcaneSettingsToggleRow extends StatelessComponent {
  final String title;
  final String? description;
  final bool enabled;
  final void Function(bool)? onChanged;
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

/// A subsection header within a settings section.
class ArcaneSettingsSubheader extends StatelessComponent {
  final String title;
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

/// A note/info box within a settings section.
class ArcaneSettingsNote extends StatelessComponent {
  final String text;
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
