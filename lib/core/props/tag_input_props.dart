import 'package:jaspr/jaspr.dart';

/// Tag input style variants
enum TagInputStyleVariant {
  /// Default style with border
  outline,

  /// Filled background style
  filled,

  /// Ghost/minimal style
  ghost,
}

/// Properties for tag input components.
class TagInputProps {
  /// Current list of tags
  final List<String> tags;

  /// Callback when tags change
  final void Function(List<String>)? onTagsChanged;

  /// Placeholder text
  final String placeholder;

  /// Style variant
  final TagInputStyleVariant style;

  /// Maximum number of tags allowed (null = unlimited)
  final int? maxTags;

  /// Whether duplicate tags are allowed
  final bool allowDuplicates;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Helper text
  final String? helperText;

  /// Error message
  final String? errorText;

  /// Current input value (for controlled input)
  final String inputValue;

  /// Whether the input is currently focused
  final bool isFocused;

  /// Callback when input value changes
  final void Function(String)? onInputChange;

  /// Callback when a key is pressed
  final void Function(String)? onKeyDown;

  /// Callback to remove a tag by index
  final void Function(int)? onRemoveTag;

  /// Callback when focus changes
  final void Function(bool)? onFocusChange;

  /// Custom tag builder
  final Component Function(String tag, VoidCallback onRemove)? tagBuilder;

  const TagInputProps({
    required this.tags,
    this.onTagsChanged,
    this.placeholder = 'Add tag...',
    this.style = TagInputStyleVariant.outline,
    this.maxTags,
    this.allowDuplicates = false,
    this.disabled = false,
    this.label,
    this.helperText,
    this.errorText,
    this.inputValue = '',
    this.isFocused = false,
    this.onInputChange,
    this.onKeyDown,
    this.onRemoveTag,
    this.onFocusChange,
    this.tagBuilder,
  });

  /// Create a copy with modified properties
  TagInputProps copyWith({
    List<String>? tags,
    void Function(List<String>)? onTagsChanged,
    String? placeholder,
    TagInputStyleVariant? style,
    int? maxTags,
    bool? allowDuplicates,
    bool? disabled,
    String? label,
    String? helperText,
    String? errorText,
    String? inputValue,
    bool? isFocused,
    void Function(String)? onInputChange,
    void Function(String)? onKeyDown,
    void Function(int)? onRemoveTag,
    void Function(bool)? onFocusChange,
    Component Function(String tag, VoidCallback onRemove)? tagBuilder,
  }) {
    return TagInputProps(
      tags: tags ?? this.tags,
      onTagsChanged: onTagsChanged ?? this.onTagsChanged,
      placeholder: placeholder ?? this.placeholder,
      style: style ?? this.style,
      maxTags: maxTags ?? this.maxTags,
      allowDuplicates: allowDuplicates ?? this.allowDuplicates,
      disabled: disabled ?? this.disabled,
      label: label ?? this.label,
      helperText: helperText ?? this.helperText,
      errorText: errorText ?? this.errorText,
      inputValue: inputValue ?? this.inputValue,
      isFocused: isFocused ?? this.isFocused,
      onInputChange: onInputChange ?? this.onInputChange,
      onKeyDown: onKeyDown ?? this.onKeyDown,
      onRemoveTag: onRemoveTag ?? this.onRemoveTag,
      onFocusChange: onFocusChange ?? this.onFocusChange,
      tagBuilder: tagBuilder ?? this.tagBuilder,
    );
  }
}
