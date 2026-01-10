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

import 'mutable_text_types.dart';

export 'mutable_text_types.dart';

/// A text component that can be clicked to edit inline.
class ArcaneMutableText extends StatefulComponent {
  final String value;
  final String? placeholder;
  final void Function(String value)? onSave;
  final void Function()? onCancel;
  final void Function(String value)? onChange;
  final MutableTextTrigger trigger;
  final MutableTextInputType inputType;
  final MutableTextStyle displayStyle;
  final bool disabled;
  final bool required;
  final String? Function(String value)? validator;
  final int maxLength;
  final int minLength;
  final int multilineRows;
  final bool saveOnBlur;
  final bool showCharCount;
  final Map<String, String>? textStyles;
  final String? label;
  final String? helperText;
  final bool startEditing;
  final Component? prefix;
  final Component? suffix;
  final bool selectAllOnEdit;

  const ArcaneMutableText({
    required this.value,
    this.placeholder,
    this.onSave,
    this.onCancel,
    this.onChange,
    this.trigger = MutableTextTrigger.click,
    this.inputType = MutableTextInputType.text,
    this.displayStyle = MutableTextStyle.subtle,
    this.disabled = false,
    this.required = false,
    this.validator,
    this.maxLength = 0,
    this.minLength = 0,
    this.multilineRows = 3,
    this.saveOnBlur = true,
    this.showCharCount = false,
    this.textStyles,
    this.label,
    this.helperText,
    this.startEditing = false,
    this.prefix,
    this.suffix,
    this.selectAllOnEdit = false,
    super.key,
  });

  @override
  State<ArcaneMutableText> createState() => _ArcaneMutableTextState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-mutable-text-input:focus').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 0 0 2px color-mix(in srgb, var(--accent) 20%, transparent)',
    }),
  ];
}

class _ArcaneMutableTextState extends State<ArcaneMutableText> {
  late bool _isEditing;
  late String _editValue;
  String? _error;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _isEditing =
        component.startEditing || component.trigger == MutableTextTrigger.always;
    _editValue = component.value;
  }

  void _startEditing() {
    if (component.disabled) return;
    setState(() {
      _isEditing = true;
      _editValue = component.value;
      _error = null;
    });
  }

  void _save() {
    if (component.required && _editValue.isEmpty) {
      setState(() => _error = 'This field is required');
      return;
    }
    if (component.minLength > 0 && _editValue.length < component.minLength) {
      setState(() => _error = 'Minimum ${component.minLength} characters');
      return;
    }
    if (component.validator != null) {
      final validationError = component.validator!(_editValue);
      if (validationError != null) {
        setState(() => _error = validationError);
        return;
      }
    }

    setState(() {
      _isEditing = component.trigger == MutableTextTrigger.always;
      _error = null;
    });
    component.onSave?.call(_editValue);
  }

  void _cancel() {
    setState(() {
      _isEditing = component.trigger == MutableTextTrigger.always;
      _editValue = component.value;
      _error = null;
    });
    component.onCancel?.call();
  }

  void _handleKeyDown(dynamic event) {
    final key = event.key as String;
    if (key == 'Enter' && component.inputType != MutableTextInputType.multiline) {
      event.preventDefault();
      _save();
    } else if (key == 'Escape') {
      event.preventDefault();
      _cancel();
    }
  }

  @override
  Component build(BuildContext context) {
    final hasError = _error != null;
    final isEmpty = component.value.isEmpty;
    final showPlaceholder = isEmpty && component.placeholder != null;

    final Map<String, String> baseTextStyles = {
      'font-size': '1rem',
      'color': 'var(--foreground)',
      'line-height': '1.5',
      ...?component.textStyles,
    };

    return div(
      classes: 'arcane-mutable-text',
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
        'width': '100%',
      }),
      [
        if (component.label != null)
          Component.element(
            tag: 'label',
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
            }),
            children: [
              Component.text(component.label!),
              if (component.required)
                const span(
                  [Component.text(' *')],
                  styles: Styles(raw: {
                    'color': 'var(--destructive)',
                  }),
                ),
            ],
          ),

        if (_isEditing) ...[
          _buildEditMode(baseTextStyles, hasError),
        ] else ...[
          _buildDisplayMode(baseTextStyles, showPlaceholder),
        ],

        if (_error != null)
          span(
            [Component.text(_error!)],
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--destructive)',
            }),
          )
        else if (component.helperText != null)
          span(
            [Component.text(component.helperText!)],
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
            }),
          ),
      ],
    );
  }

  Component _buildEditMode(Map<String, String> baseTextStyles, bool hasError) {
    final isMultiline = component.inputType == MutableTextInputType.multiline;

    return div(
      classes: 'arcane-mutable-text-edit',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
      }),
      [
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'gap': '0.25rem',
          }),
          [
            if (component.prefix != null)
              span(
                [component.prefix!],
                styles: const Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'padding': '0.25rem 0',
                }),
              ),

            if (isMultiline)
              Component.element(
                tag: 'textarea',
                classes: 'arcane-mutable-text-input',
                attributes: {
                  'rows': component.multilineRows.toString(),
                  if (component.maxLength > 0)
                    'maxlength': component.maxLength.toString(),
                  if (component.placeholder != null)
                    'placeholder': component.placeholder!,
                  'autofocus': 'true',
                },
                styles: Styles(raw: {
                  ...baseTextStyles,
                  'flex': '1',
                  'min-width': '0',
                  'padding': '0.25rem 0.5rem',
                  'background': 'var(--input)',
                  'border': hasError
                      ? '1px solid var(--destructive)'
                      : '1px solid var(--border)',
                  'border-radius': '0.375rem',
                  'outline': 'none',
                  'resize': 'vertical',
                  'font-family': 'inherit',
                }),
                events: {
                  'input': (e) {
                    final target = e.target as dynamic;
                    setState(() => _editValue = target.value as String);
                    component.onChange?.call(_editValue);
                  },
                  'keydown': _handleKeyDown,
                  'blur': (e) {
                    if (component.saveOnBlur) _save();
                  },
                },
                children: [Component.text(_editValue)],
              )
            else
              input(
                type: _getInputType(),
                classes: 'arcane-mutable-text-input',
                attributes: {
                  'value': _editValue,
                  if (component.maxLength > 0)
                    'maxlength': component.maxLength.toString(),
                  if (component.placeholder != null)
                    'placeholder': component.placeholder!,
                  'autofocus': 'true',
                },
                styles: Styles(raw: {
                  ...baseTextStyles,
                  'flex': '1',
                  'min-width': '0',
                  'padding': '0.25rem 0.5rem',
                  'background': 'var(--input)',
                  'border': hasError
                      ? '1px solid var(--destructive)'
                      : '1px solid var(--border)',
                  'border-radius': '0.375rem',
                  'outline': 'none',
                }),
                events: {
                  'input': (e) {
                    final target = e.target as dynamic;
                    setState(() => _editValue = target.value as String);
                    component.onChange?.call(_editValue);
                  },
                  'keydown': _handleKeyDown,
                  'blur': (e) {
                    if (component.saveOnBlur) _save();
                  },
                },
              ),

            if (component.suffix != null)
              span(
                [component.suffix!],
                styles: const Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'padding': '0.25rem 0',
                }),
              ),

            if (isMultiline || !component.saveOnBlur) ...[
              button(
                attributes: {'type': 'button', 'aria-label': 'Save'},
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'background': 'var(--accent)',
                  'color': 'var(--accent-foreground)',
                  'border': 'none',
                  'border-radius': '0.125rem',
                  'cursor': 'pointer',
                  'font-size': '14px',
                }),
                events: {'click': (e) => _save()},
                [const Component.text('OK')],
              ),
              button(
                attributes: {'type': 'button', 'aria-label': 'Cancel'},
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'background': 'var(--muted)',
                  'color': 'var(--muted-foreground)',
                  'border': 'none',
                  'border-radius': '0.125rem',
                  'cursor': 'pointer',
                  'font-size': '14px',
                }),
                events: {'click': (e) => _cancel()},
                [const Component.text('X')],
              ),
            ],
          ],
        ),

        if (component.showCharCount && component.maxLength > 0)
          span(
            [Component.text('${_editValue.length}/${component.maxLength}')],
            styles: Styles(raw: {
              'font-size': '0.75rem',
              'color': _editValue.length >= component.maxLength
                  ? 'var(--destructive)'
                  : 'var(--muted-foreground)',
              'text-align': 'right',
            }),
          ),
      ],
    );
  }

  Component _buildDisplayMode(
      Map<String, String> baseTextStyles, bool showPlaceholder) {
    final Map<String, String> styleVariant = switch (component.displayStyle) {
      MutableTextStyle.inline => {},
      MutableTextStyle.subtle => {
          'padding': '0.25rem 0.5rem',
          'border-radius': '0.125rem',
          'margin': '-0.25rem -0.5rem',
        },
      MutableTextStyle.underline => {
          'border-bottom': '1px solid var(--border)',
          'padding-bottom': '2px',
        },
      MutableTextStyle.dashed => {
          'border-bottom': '1px dashed var(--muted-foreground)',
          'padding-bottom': '2px',
        },
      MutableTextStyle.input => {
          'padding': '0.25rem 0.5rem',
          'border': '1px solid var(--border)',
          'border-radius': '0.375rem',
          'background': 'transparent',
        },
    };

    final Map<String, String> hoverStyles = switch (component.displayStyle) {
      MutableTextStyle.subtle when _isHovered && !component.disabled => {
          'background': 'var(--muted)',
        },
      MutableTextStyle.input when _isHovered && !component.disabled => {
          'border-color': 'var(--accent)',
        },
      _ => {},
    };

    final events = <String, void Function(dynamic)>{};
    if (!component.disabled) {
      events['mouseenter'] = (e) => setState(() => _isHovered = true);
      events['mouseleave'] = (e) => setState(() => _isHovered = false);

      switch (component.trigger) {
        case MutableTextTrigger.click:
        case MutableTextTrigger.hover:
          events['click'] = (e) => _startEditing();
        case MutableTextTrigger.doubleClick:
          events['dblclick'] = (e) => _startEditing();
        case MutableTextTrigger.always:
          break;
      }
    }

    return div(
      classes: 'arcane-mutable-text-display',
      attributes: {
        'role': 'button',
        'tabindex': component.disabled ? '-1' : '0',
        if (!component.disabled) 'aria-label': 'Click to edit',
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.25rem',
        ...baseTextStyles,
        ...styleVariant,
        ...hoverStyles,
        'cursor': component.disabled ? 'default' : 'pointer',
        'transition': 'all 150ms ease',
        if (component.disabled) 'opacity': '0.5',
      }),
      events: {
        ...events,
        if (!component.disabled)
          'keydown': (e) {
            final key = (e as dynamic).key as String;
            if (key == 'Enter' || key == ' ') {
              e.preventDefault();
              _startEditing();
            }
          },
      },
      [
        if (component.prefix != null) component.prefix!,

        span(
          [
            Component.text(showPlaceholder ? component.placeholder! : component.value),
          ],
          styles: Styles(raw: {
            if (showPlaceholder) 'color': 'var(--muted-foreground)',
            if (showPlaceholder) 'font-style': 'italic',
          }),
        ),

        if (component.suffix != null) component.suffix!,

        if (_isHovered &&
            !component.disabled &&
            component.trigger == MutableTextTrigger.hover)
          const span(
            [Component.text('[edit]')],
            styles: Styles(raw: {
              'color': 'var(--muted-foreground)',
              'font-size': '14px',
              'margin-left': '0.25rem',
            }),
          ),
      ],
    );
  }

  InputType _getInputType() {
    return switch (component.inputType) {
      MutableTextInputType.text => InputType.text,
      MutableTextInputType.multiline => InputType.text,
      MutableTextInputType.number => InputType.number,
      MutableTextInputType.email => InputType.email,
      MutableTextInputType.url => InputType.url,
    };
  }
}

/// Convenience constructors for common mutable text patterns.
extension ArcaneMutableTextFactories on ArcaneMutableText {
  static ArcaneMutableText heading({
    required String value,
    void Function(String)? onSave,
    String? placeholder,
  }) {
    return ArcaneMutableText(
      value: value,
      onSave: onSave,
      placeholder: placeholder,
      displayStyle: MutableTextStyle.inline,
      textStyles: const {
        'font-size': '1.5rem',
        'font-weight': '700',
      },
    );
  }

  static ArcaneMutableText paragraph({
    required String value,
    void Function(String)? onSave,
    String? placeholder,
  }) {
    return ArcaneMutableText(
      value: value,
      onSave: onSave,
      placeholder: placeholder,
      inputType: MutableTextInputType.multiline,
      displayStyle: MutableTextStyle.subtle,
    );
  }

  static ArcaneMutableText label({
    required String value,
    void Function(String)? onSave,
    String? placeholder,
  }) {
    return ArcaneMutableText(
      value: value,
      onSave: onSave,
      placeholder: placeholder,
      displayStyle: MutableTextStyle.dashed,
      textStyles: const {
        'font-size': '0.875rem',
        'color': 'var(--muted-foreground)',
      },
    );
  }
}
