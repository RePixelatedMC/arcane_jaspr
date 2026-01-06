import 'package:jaspr/jaspr.dart';

/// Props for the SettingsSection component.
class SettingsSectionProps {
  /// The section title
  final String title;

  /// Optional description below the title
  final String? description;

  /// The section content
  final List<Component> children;

  /// Whether this is a danger zone section (destructive actions)
  final bool danger;

  const SettingsSectionProps({
    required this.title,
    this.description,
    required this.children,
    this.danger = false,
  });
}

/// Props for the SettingsInfoRow component.
class SettingsInfoRowProps {
  /// The label/name
  final String label;

  /// The value to display
  final String value;

  /// Whether to use monospace font for the value
  final bool monospace;

  const SettingsInfoRowProps({
    required this.label,
    required this.value,
    this.monospace = false,
  });
}

/// Props for the SettingsToggleRow component.
class SettingsToggleRowProps {
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

  const SettingsToggleRowProps({
    required this.title,
    this.description,
    required this.enabled,
    this.onChanged,
    this.disabled = false,
  });
}

/// Props for the SettingsSubheader component.
class SettingsSubheaderProps {
  /// The subsection title
  final String title;

  /// Optional description
  final String? description;

  const SettingsSubheaderProps({
    required this.title,
    this.description,
  });
}

/// Variant for settings notes.
enum SettingsNoteVariant { info, warning, success }

/// Props for the SettingsNote component.
class SettingsNoteProps {
  /// The note text
  final String text;

  /// The note variant
  final SettingsNoteVariant variant;

  const SettingsNoteProps({
    required this.text,
    this.variant = SettingsNoteVariant.info,
  });
}
