import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/tag_input_props.dart'
    show TagInputStyleVariant, TagInputProps;

typedef TagInputStyle = TagInputStyleVariant;

/// Tag/chip input component for adding and removing tags.
class ArcaneTagInput extends StatefulComponent {
  final List<String> tags;
  final void Function(List<String>)? onTagsChanged;
  final String placeholder;
  final TagInputStyle style;
  final int? maxTags;
  final bool allowDuplicates;
  final bool disabled;
  final String? label;
  final String? helperText;
  final String? errorText;
  final Component Function(String tag, VoidCallback onRemove)? tagBuilder;

  const ArcaneTagInput({
    required this.tags,
    this.onTagsChanged,
    this.placeholder = 'Add tag...',
    this.style = TagInputStyle.outline,
    this.maxTags,
    this.allowDuplicates = false,
    this.disabled = false,
    this.label,
    this.helperText,
    this.errorText,
    this.tagBuilder,
    super.key,
  });

  @override
  State<ArcaneTagInput> createState() => _ArcaneTagInputState();
}

class _ArcaneTagInputState extends State<ArcaneTagInput> {
  String _inputValue = '';
  bool _isFocused = false;

  void _addTag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isEmpty) return;
    if (!component.allowDuplicates && component.tags.contains(trimmed)) return;
    if (component.maxTags != null && component.tags.length >= component.maxTags!) return;

    final newTags = [...component.tags, trimmed];
    component.onTagsChanged?.call(newTags);
    _inputValue = '';
  }

  void _removeTag(int index) {
    final newTags = [...component.tags]..removeAt(index);
    component.onTagsChanged?.call(newTags);
  }

  void _handleKeyDown(String key) {
    if (key == 'Enter' || key == ',') {
      _addTag(_inputValue);
    } else if (key == 'Backspace' && _inputValue.isEmpty && component.tags.isNotEmpty) {
      _removeTag(component.tags.length - 1);
    }
  }

  TagInputStyleVariant get _propsStyle => switch (component.style) {
        TagInputStyle.outline => TagInputStyleVariant.outline,
        TagInputStyle.filled => TagInputStyleVariant.filled,
        TagInputStyle.ghost => TagInputStyleVariant.ghost,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.tagInput(TagInputProps(
      tags: component.tags,
      onTagsChanged: component.onTagsChanged,
      placeholder: component.placeholder,
      style: _propsStyle,
      maxTags: component.maxTags,
      allowDuplicates: component.allowDuplicates,
      disabled: component.disabled,
      label: component.label,
      helperText: component.helperText,
      errorText: component.errorText,
      inputValue: _inputValue,
      isFocused: _isFocused,
      onInputChange: (value) => setState(() => _inputValue = value),
      onKeyDown: _handleKeyDown,
      onRemoveTag: _removeTag,
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      tagBuilder: component.tagBuilder,
    ));
  }
}
