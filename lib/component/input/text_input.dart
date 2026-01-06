import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

export '../../core/props/text_input_props.dart'
    show TextInputSize, TextInputVariant, TextInputType;

import '../../core/props/text_input_props.dart';
import '../../core/theme_provider.dart';

/// A styled text input component
///
/// ```dart
/// ArcaneTextInput(
///   placeholder: 'Enter text...',
///   onInput: (value) => print(value),
/// )
/// ```
class ArcaneTextInput extends StatelessComponent {
  /// Input placeholder
  final String? placeholder;

  /// Input type
  final dom.InputType type;

  /// Size variant
  final TextInputSize size;

  /// Whether input is disabled
  final bool disabled;

  /// Whether input is required
  final bool required;

  /// Whether input is read-only
  final bool readOnly;

  /// Input value
  final String? value;

  /// Input name (for forms)
  final String? name;

  /// Input ID
  final String? id;

  /// Prefix icon/text
  final Component? prefix;

  /// Suffix icon/text
  final Component? suffix;

  /// Error message
  final String? error;

  /// Helper text
  final String? helperText;

  /// Label text
  final String? label;

  /// Change callback
  final void Function(String)? _onChange;

  /// Focus callback
  final void Function()? onFocus;

  /// Blur callback
  final void Function()? onBlur;

  /// Submit callback
  final void Function(String)? onSubmit;

  /// Full width
  final bool fullWidth;

  /// Creates a text input.
  ///
  /// Use [onChange] or [onInput] for value change handling.
  const ArcaneTextInput({
    this.placeholder,
    this.type = dom.InputType.text,
    this.size = TextInputSize.md,
    this.disabled = false,
    this.required = false,
    this.readOnly = false,
    this.value,
    this.name,
    this.id,
    this.prefix,
    this.suffix,
    this.error,
    this.helperText,
    this.label,
    void Function(String)? onChange,
    void Function(String)? onInput,
    this.onFocus,
    this.onBlur,
    this.onSubmit,
    this.fullWidth = false,
    super.key,
  }) : _onChange = onChange ?? onInput;

  /// Map InputType to TextInputType
  TextInputType _mapInputType(dom.InputType t) {
    return switch (t) {
      dom.InputType.text => TextInputType.text,
      dom.InputType.email => TextInputType.email,
      dom.InputType.password => TextInputType.password,
      dom.InputType.number => TextInputType.number,
      dom.InputType.tel => TextInputType.tel,
      dom.InputType.url => TextInputType.url,
      dom.InputType.search => TextInputType.search,
      _ => TextInputType.text,
    };
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.textInput(TextInputProps(
      placeholder: placeholder,
      type: _mapInputType(type),
      value: value,
      name: name,
      id: id,
      size: size,
      disabled: disabled,
      required: required,
      readOnly: readOnly,
      fullWidth: fullWidth,
      label: label,
      helperText: helperText,
      error: error,
      prefix: prefix,
      suffix: suffix,
      onChanged: _onChange,
      onFocus: onFocus,
      onBlur: onBlur,
      onSubmit: onSubmit,
    ));
  }
}

/// Resize direction for textarea
enum TextAreaResize {
  /// No resizing allowed
  none,

  /// Vertical resizing only (default)
  vertical,

  /// Horizontal resizing only
  horizontal,

  /// Both directions
  both,
}

/// A textarea component
class ArcaneTextArea extends StatelessComponent {
  /// Placeholder text
  final String? placeholder;

  /// Number of rows
  final int rows;

  /// Number of columns (affects initial width)
  final int? cols;

  /// Whether disabled
  final bool disabled;

  /// Whether required
  final bool required;

  /// Resize direction (default: vertical)
  final TextAreaResize resize;

  /// Minimum width constraint (e.g., '200px', '50%')
  final String? minWidth;

  /// Maximum width constraint (e.g., '600px', '100%')
  final String? maxWidth;

  /// Minimum height constraint (e.g., '100px')
  final String? minHeight;

  /// Maximum height constraint (e.g., '400px')
  final String? maxHeight;

  /// Value
  final String? value;

  /// Name
  final String? name;

  /// ID
  final String? id;

  /// Label
  final String? label;

  /// Error
  final String? error;

  /// Helper text
  final String? helperText;

  /// Change callback
  final void Function(String)? _onChange;

  /// Full width
  final bool fullWidth;

  /// Creates a textarea.
  ///
  /// Use [onChange] or [onInput] for value change handling.
  const ArcaneTextArea({
    this.placeholder,
    this.rows = 4,
    this.cols,
    this.disabled = false,
    this.required = false,
    this.resize = TextAreaResize.vertical,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.value,
    this.name,
    this.id,
    this.label,
    this.error,
    this.helperText,
    void Function(String)? onChange,
    void Function(String)? onInput,
    this.fullWidth = true,
    super.key,
  }) : _onChange = onChange ?? onInput;

  @override
  Component build(BuildContext context) {
    final hasError = error != null;

    // Map resize enum to CSS value
    final resizeValue = switch (resize) {
      TextAreaResize.none => 'none',
      TextAreaResize.vertical => 'vertical',
      TextAreaResize.horizontal => 'horizontal',
      TextAreaResize.both => 'both',
    };

    final textareaElement = Component.element(
      tag: 'textarea',
      id: id,
      classes: 'arcane-textarea',
      attributes: {
        if (name != null) 'name': name!,
        if (placeholder != null) 'placeholder': placeholder!,
        'rows': rows.toString(),
        if (cols != null) 'cols': cols.toString(),
        if (disabled) 'disabled': 'true',
        if (required) 'required': 'true',
      },
      styles: dom.Styles(raw: {
        if (fullWidth) 'width': '100%',
        'padding': '0.5rem 1rem',
        'font-size': '1rem',
        'font-family': 'inherit',
        'line-height': '1.625',
        // Base styles using CSS variables
        'background-color': 'var(--background)',
        'border': hasError ? '1px solid var(--destructive)' : '1px solid var(--input)',
        'border-radius': '0.375rem',
        'color': 'var(--foreground)',
        'transition': 'color 150ms ease, border-color 150ms ease, box-shadow 150ms ease',
        'outline': 'none',
        'resize': resizeValue,
        if (minWidth != null) 'min-width': minWidth!,
        if (maxWidth != null) 'max-width': maxWidth!,
        if (minHeight != null) 'min-height': minHeight!,
        if (maxHeight != null) 'max-height': maxHeight!,
        if (disabled) 'opacity': '0.5',
        if (disabled) 'cursor': 'not-allowed',
      }),
      events: {
        if (_onChange != null)
          'input': (e) {
            final target = e.target as dynamic;
            _onChange(target.value as String);
          },
      },
      children: value != null ? [Component.text(value!)] : [],
    );

    if (label != null || error != null || helperText != null) {
      return dom.div(
        classes: 'arcane-textarea-wrapper',
        styles: dom.Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.25rem',
          if (fullWidth) 'width': '100%',
        }),
        [
          if (label != null)
            Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: const dom.Styles(raw: {
                'font-size': '1rem',
                'font-weight': '500',
                'color': 'var(--foreground)',
              }),
              children: [
                Component.text(label!),
                if (required)
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'color': 'var(--destructive)',
                      'margin-left': '0.25rem',
                    }),
                    [Component.text('*')],
                  ),
              ],
            ),
          textareaElement,
          if (error != null)
            dom.span(
              classes: 'arcane-textarea-error',
              styles: const dom.Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--destructive)',
              }),
              [Component.text(error!)],
            )
          else if (helperText != null)
            dom.span(
              classes: 'arcane-textarea-helper',
              styles: const dom.Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--muted-foreground)',
              }),
              [Component.text(helperText!)],
            ),
        ],
      );
    }

    return textareaElement;
  }
}

/// A select/dropdown input component
class ArcaneSelect extends StatelessComponent {
  /// Options list
  final List<ArcaneSelectOption> options;

  /// Selected value
  final String? value;

  /// Placeholder text
  final String? placeholder;

  /// Size variant
  final TextInputSize size;

  /// Whether disabled
  final bool disabled;

  /// Whether required
  final bool required;

  /// Name
  final String? name;

  /// ID
  final String? id;

  /// Label
  final String? label;

  /// Error
  final String? error;

  /// Change callback
  final void Function(String)? _onChange;

  /// Full width
  final bool fullWidth;

  /// Creates a select input.
  ///
  /// Use [onChange], [onInput], or [onSelect] for value change handling.
  const ArcaneSelect({
    required this.options,
    this.value,
    this.placeholder,
    this.size = TextInputSize.md,
    this.disabled = false,
    this.required = false,
    this.name,
    this.id,
    this.label,
    this.error,
    void Function(String)? onChange,
    void Function(String)? onInput,
    void Function(String)? onSelect,
    this.fullWidth = false,
    super.key,
  }) : _onChange = onChange ?? onInput ?? onSelect;

  @override
  Component build(BuildContext context) {
    final hasError = error != null;

    // Size styles
    final Map<String, String> sizeStyles = switch (size) {
      TextInputSize.sm => {
          'height': '36px',
          'padding': '0 12px',
          'font-size': '14px',
        },
      TextInputSize.md => {
          'height': '40px',
          'padding': '8px 12px',
          'font-size': '16px',
        },
      TextInputSize.lg => {
          'height': '44px',
          'padding': '0 16px',
          'font-size': '16px',
        },
    };

    final selectElement = Component.element(
      tag: 'select',
      id: id,
      classes: 'arcane-select',
      attributes: {
        if (name != null) 'name': name!,
        if (disabled) 'disabled': 'true',
        if (required) 'required': 'true',
      },
      styles: dom.Styles(raw: {
        ...sizeStyles,
        'padding-right': '36px',
        'font-family': 'inherit',
        // Base styles using CSS variables
        'background-color': 'var(--background)',
        'border': hasError ? '1px solid var(--destructive)' : '1px solid var(--input)',
        'border-radius': '0.375rem',
        'color': 'var(--foreground)',
        'transition': 'color 150ms ease, border-color 150ms ease, box-shadow 150ms ease',
        'cursor': 'pointer',
        'appearance': 'none',
        'background-image':
            'url("data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'12\' height=\'12\' viewBox=\'0 0 12 12\'%3E%3Cpath fill=\'%2371717A\' d=\'M2.5 4.5L6 8l3.5-3.5\'/%3E%3C/svg%3E")',
        'background-repeat': 'no-repeat',
        'background-position': 'right 12px center',
        if (fullWidth) 'width': '100%',
        if (disabled) 'opacity': '0.5',
        if (disabled) 'cursor': 'not-allowed',
      }),
      events: {
        if (_onChange != null)
          'change': (e) {
            final target = e.target as dynamic;
            _onChange(target.value as String);
          },
      },
      children: [
        if (placeholder != null)
          Component.element(
            tag: 'option',
            attributes: {'value': '', 'disabled': 'true', 'selected': 'true'},
            children: [Component.text(placeholder!)],
          ),
        for (final opt in options)
          Component.element(
            tag: 'option',
            attributes: {
              'value': opt.value,
              if (opt.disabled) 'disabled': 'true',
              if (value == opt.value) 'selected': 'true',
            },
            children: [Component.text(opt.label)],
          ),
      ],
    );

    if (label != null || error != null) {
      return dom.div(
        classes: 'arcane-select-wrapper',
        styles: dom.Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.25rem',
          if (fullWidth) 'width': '100%',
        }),
        [
          if (label != null)
            Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: const dom.Styles(raw: {
                'font-size': '1rem',
                'font-weight': '500',
                'color': 'var(--foreground)',
              }),
              children: [
                Component.text(label!),
                if (required)
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'color': 'var(--destructive)',
                      'margin-left': '0.25rem',
                    }),
                    [Component.text('*')],
                  ),
              ],
            ),
          selectElement,
          if (error != null)
            dom.span(
              classes: 'arcane-select-error',
              styles: const dom.Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--destructive)',
              }),
              [Component.text(error!)],
            ),
        ],
      );
    }

    return selectElement;
  }
}

/// Select option model
class ArcaneSelectOption {
  final String label;
  final String value;
  final bool disabled;

  const ArcaneSelectOption({
    required this.label,
    required this.value,
    this.disabled = false,
  });
}

typedef TextInput = ArcaneTextInput;
typedef TextArea = ArcaneTextArea;
typedef SelectInput = ArcaneSelect;