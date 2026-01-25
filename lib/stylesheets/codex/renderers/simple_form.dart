import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/simple_form_props.dart';

/// Codex SimpleForm renderer (stateful).
///
/// Implements the Codex Neon Cyberpunk design language with
/// glowing inputs and neon-styled buttons.
class CodexSimpleForm extends StatefulComponent {
  final SimpleFormProps props;

  const CodexSimpleForm(this.props, {super.key});

  @override
  State<CodexSimpleForm> createState() => _CodexSimpleFormState();
}

class _CodexSimpleFormState extends State<CodexSimpleForm> {
  final Map<String, String> _values = {};
  bool _submitted = false;
  String? _error;

  void _handleSubmit() {
    // Validate required fields
    for (final field in component.props.fields) {
      final String value = _values[field.name] ?? '';

      if (field.required && value.isEmpty) {
        setState(() => _error = '${field.label ?? field.name} is required');
        return;
      }

      if (field.type == SimpleFormFieldType.email && value.isNotEmpty) {
        if (!value.contains('@')) {
          setState(() => _error = 'Please enter a valid email');
          return;
        }
      }

      if (field.validator != null) {
        final String? validationError = field.validator!(value);
        if (validationError != null) {
          setState(() => _error = validationError);
          return;
        }
      }
    }

    setState(() {
      _error = null;
      _submitted = true;
    });

    component.props.onSubmit?.call(Map<String, String>.from(_values));
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return _buildSuccessState();
    }

    if (component.props.layout == SimpleFormLayout.inline &&
        component.props.fields.length == 1) {
      return _buildInlineForm();
    }

    return _buildStackedForm();
  }

  Component _buildSuccessState() {
    return dom.div(
      classes: 'codex-simple-form-success',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        'padding': '1rem 1.5rem',
        'background-color': 'color-mix(in srgb, var(--success) 10%, transparent)',
        'border': '1px solid var(--success)',
        'border-radius': 'var(--radius)',
        'color': 'var(--success)',
        'font-size': 'var(--font-size-sm)',
        'box-shadow': '0 0 15px rgba(var(--success-rgb), 0.2)',
      }),
      [
        const dom.span([Component.text('\u2713')]),
        dom.span([Component.text(component.props.successMessage)]),
      ],
    );
  }

  Component _buildInlineForm() {
    final SimpleFormField field = component.props.fields.first;
    final String inputHeight = component.props.compact ? '36px' : '44px';
    final String inputPadding =
        component.props.compact ? '0.5rem 1rem' : '10px 14px';
    final String buttonPadding =
        component.props.compact ? '0.5rem 1.5rem' : '10px 20px';

    return dom.div(
      classes: 'codex-simple-form inline',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-2)',
      }),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'gap': 'var(--space-2)',
          }),
          [
            _buildInput(field, inputHeight, inputPadding, flex: true),
            dom.button(
              [Component.text(component.props.submitLabel)],
              classes: 'codex-simple-form-button',
              attributes: const {'type': 'button'},
              styles: dom.Styles(raw: {
                'height': inputHeight,
                'padding': buttonPadding,
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'color': 'var(--primary-foreground)',
                'background': 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
                'border': 'none',
                'border-radius': 'var(--radius)',
                'cursor': 'pointer',
                'white-space': 'nowrap',
                'transition': 'all var(--arcane-transition)',
                'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.3)',
              }),
              events: {
                'click': (e) => _handleSubmit(),
              },
            ),
          ],
        ),
        if (_error != null)
          dom.span(
            [Component.text(_error!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--destructive)',
            }),
          ),
      ],
    );
  }

  Component _buildStackedForm() {
    final String inputHeight = component.props.compact ? '36px' : '44px';
    final String inputPadding =
        component.props.compact ? '0.5rem 1rem' : '10px 14px';

    final bool hasHeader =
        component.props.title != null || component.props.description != null;

    return dom.div(
      classes: 'codex-simple-form stacked',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-4)',
        if (hasHeader) 'padding': '2rem',
        if (hasHeader) 'background-color': 'var(--card)',
        if (hasHeader) 'border': '1px solid var(--border)',
        if (hasHeader) 'border-radius': 'var(--radius)',
        if (hasHeader) 'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.1)',
      }),
      [
        if (component.props.title != null)
          dom.div(
            [Component.text(component.props.title!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-lg)',
              'font-weight': 'var(--font-weight-semibold)',
              'color': 'var(--foreground)',
            }),
          ),
        if (component.props.description != null)
          dom.div(
            [Component.text(component.props.description!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'line-height': '1.625',
            }),
          ),
        for (final field in component.props.fields)
          _buildFieldWithLabel(field, inputHeight, inputPadding),
        if (_error != null)
          dom.span(
            [Component.text(_error!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--destructive)',
            }),
          ),
        dom.button(
          [Component.text(component.props.submitLabel)],
          classes: 'codex-simple-form-button',
          attributes: const {'type': 'button'},
          styles: const dom.Styles(raw: {
            'width': '100%',
            'height': '44px',
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-medium)',
            'color': 'var(--primary-foreground)',
            'background': 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
            'border': 'none',
            'border-radius': 'var(--radius)',
            'cursor': 'pointer',
            'transition': 'all var(--arcane-transition)',
            'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.3)',
          }),
          events: {
            'click': (e) => _handleSubmit(),
          },
        ),
      ],
    );
  }

  Component _buildFieldWithLabel(
    SimpleFormField field,
    String height,
    String padding,
  ) {
    return dom.div(
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-1)',
      }),
      [
        if (field.label != null)
          dom.label(
            [
              Component.text(field.label!),
              if (field.required)
                dom.span(
                  [Component.text(' *')],
                  styles: const dom.Styles(raw: {
                    'color': 'var(--destructive)',
                  }),
                ),
            ],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
            }),
          ),
        _buildInput(field, height, padding, flex: false),
        if (field.hint != null)
          dom.span(
            [Component.text(field.hint!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
            }),
          ),
      ],
    );
  }

  Component _buildInput(
    SimpleFormField field,
    String height,
    String padding, {
    required bool flex,
  }) {
    final Map<String, String> baseInputStyles = {
      if (flex) 'flex': '1',
      'width': '100%',
      'height': height,
      'padding': padding,
      'font-size': 'var(--font-size-sm)',
      'background-color': 'var(--muted)',
      'border': '1px solid var(--border)',
      'border-radius': 'var(--radius)',
      'color': 'var(--foreground)',
      'outline': 'none',
      'transition': 'all var(--arcane-transition)',
    };

    final Map<String, void Function(dynamic)> events = {
      'input': (e) {
        final dynamic target = e.target;
        setState(() {
          _values[field.name] = target.value as String;
          _error = null;
        });
      },
      'keypress': (e) {
        final dynamic keyEvent = e;
        if (keyEvent.key == 'Enter' &&
            field.type != SimpleFormFieldType.textarea) {
          _handleSubmit();
        }
      },
    };

    if (field.type == SimpleFormFieldType.textarea) {
      return dom.textarea(
        classes: 'codex-simple-form-input',
        attributes: {
          if (field.placeholder != null) 'placeholder': field.placeholder!,
          'rows': '4',
        },
        styles: dom.Styles(raw: {
          ...baseInputStyles,
          'height': 'auto',
          'min-height': '100px',
          'resize': 'vertical',
        }),
        events: events,
        [],
      );
    }

    final dom.InputType inputType = switch (field.type) {
      SimpleFormFieldType.email => dom.InputType.email,
      SimpleFormFieldType.password => dom.InputType.password,
      SimpleFormFieldType.phone => dom.InputType.tel,
      SimpleFormFieldType.url => dom.InputType.url,
      _ => dom.InputType.text,
    };

    return dom.input(
      type: inputType,
      classes: 'codex-simple-form-input',
      attributes: {
        if (field.placeholder != null) 'placeholder': field.placeholder!,
      },
      styles: dom.Styles(raw: baseInputStyles),
      events: events,
    );
  }
}
