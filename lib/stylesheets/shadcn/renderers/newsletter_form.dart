import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/newsletter_form_props.dart';

/// ShadCN Newsletter Form renderer (stateful).
class ShadcnNewsletterForm extends StatefulComponent {
  final NewsletterFormProps props;

  const ShadcnNewsletterForm(this.props, {super.key});

  @override
  State<ShadcnNewsletterForm> createState() => _ShadcnNewsletterFormState();
}

class _ShadcnNewsletterFormState extends State<ShadcnNewsletterForm> {
  String _email = '';
  bool _submitted = false;
  String? _error;

  void _handleSubmit() {
    if (_email.isEmpty) {
      setState(() => _error = 'Please enter your email');
      return;
    }

    if (!_email.contains('@')) {
      setState(() => _error = 'Please enter a valid email');
      return;
    }

    setState(() {
      _error = null;
      _submitted = true;
    });

    component.props.onSubmit?.call(_email);
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return dom.div(
        classes: 'arcane-newsletter-success',
        styles: const dom.Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--arcane-space-2)',
          'padding': '1rem 1.5rem',
          'background-color': 'color-mix(in srgb, var(--success) 10%, transparent)',
          'border': '1px solid var(--success)',
          'border-radius': 'var(--radius)',
          'color': 'var(--success)',
          'font-size': 'var(--arcane-font-size-sm)',
        }),
        [
          const dom.span([Component.text('\u2713')]),
          dom.span([Component.text(component.props.successMessage)]),
        ],
      );
    }

    final String inputHeight = component.props.compact ? '36px' : '44px';
    final String inputPadding =
        component.props.compact ? '0.5rem 1rem' : '10px 14px';
    final String buttonPadding =
        component.props.compact ? '0.5rem 1.5rem' : '10px 20px';

    if (component.props.inline) {
      return dom.div(
        classes: 'arcane-newsletter-form',
        styles: const dom.Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--arcane-space-2)',
        }),
        [
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'gap': 'var(--arcane-space-2)',
            }),
            [
              dom.input(
                type: dom.InputType.email,
                classes: 'arcane-newsletter-input',
                attributes: {
                  'placeholder': component.props.placeholder,
                },
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'height': inputHeight,
                  'padding': inputPadding,
                  'font-size': 'var(--arcane-font-size-sm)',
                  'background-color': 'var(--card)',
                  'border':
                      '1px solid ${_error != null ? 'var(--destructive)' : 'var(--border)'}',
                  'border-radius': 'var(--radius)',
                  'color': 'var(--foreground)',
                  'outline': 'none',
                  'transition': 'all var(--arcane-transition)',
                }),
                events: {
                  'input': (e) {
                    final dynamic target = e.target;
                    setState(() {
                      _email = target.value as String;
                      _error = null;
                    });
                  },
                  'keypress': (e) {
                    final dynamic keyEvent = e;
                    if (keyEvent.key == 'Enter') {
                      _handleSubmit();
                    }
                  },
                },
              ),
              dom.button(
                [Component.text(component.props.buttonText)],
                classes: 'arcane-newsletter-button',
                attributes: const {'type': 'button'},
                styles: dom.Styles(raw: {
                  'height': inputHeight,
                  'padding': buttonPadding,
                  'font-size': 'var(--arcane-font-size-sm)',
                  'font-weight': 'var(--arcane-font-weight-medium)',
                  'color': 'var(--accent-foreground)',
                  'background-color': 'var(--accent)',
                  'border': 'none',
                  'border-radius': 'var(--radius)',
                  'cursor': 'pointer',
                  'white-space': 'nowrap',
                  'transition': 'all var(--arcane-transition)',
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
                'font-size': 'var(--arcane-font-size-xs)',
                'color': 'var(--destructive)',
              }),
            ),
        ],
      );
    }

    // Stacked layout
    return dom.div(
      classes: 'arcane-newsletter-form stacked',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--arcane-space-4)',
      }),
      [
        dom.input(
          type: dom.InputType.email,
          classes: 'arcane-newsletter-input',
          attributes: {
            'placeholder': component.props.placeholder,
          },
          styles: dom.Styles(raw: {
            'width': '100%',
            'height': inputHeight,
            'padding': inputPadding,
            'font-size': 'var(--arcane-font-size-sm)',
            'background-color': 'var(--card)',
            'border':
                '1px solid ${_error != null ? 'var(--destructive)' : 'var(--border)'}',
            'border-radius': 'var(--radius)',
            'color': 'var(--foreground)',
            'outline': 'none',
          }),
          events: {
            'input': (e) {
              final dynamic target = e.target;
              setState(() {
                _email = target.value as String;
                _error = null;
              });
            },
          },
        ),
        if (_error != null)
          dom.span(
            [Component.text(_error!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'color': 'var(--destructive)',
              'margin-top': '-0.25rem',
            }),
          ),
        dom.button(
          [Component.text(component.props.buttonText)],
          classes: 'arcane-newsletter-button',
          attributes: const {'type': 'button'},
          styles: dom.Styles(raw: {
            'width': '100%',
            'height': inputHeight,
            'padding': buttonPadding,
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': 'var(--accent-foreground)',
            'background-color': 'var(--accent)',
            'border': 'none',
            'border-radius': 'var(--radius)',
            'cursor': 'pointer',
            'transition': 'all var(--arcane-transition)',
          }),
          events: {
            'click': (e) => _handleSubmit(),
          },
        ),
      ],
    );
  }
}

/// ShadCN Waitlist Form renderer (stateful).
class ShadcnWaitlistForm extends StatefulComponent {
  final WaitlistFormProps props;

  const ShadcnWaitlistForm(this.props, {super.key});

  @override
  State<ShadcnWaitlistForm> createState() => _ShadcnWaitlistFormState();
}

class _ShadcnWaitlistFormState extends State<ShadcnWaitlistForm> {
  String _email = '';
  String _name = '';
  bool _submitted = false;
  String? _error;

  void _handleSubmit() {
    if (_email.isEmpty || !_email.contains('@')) {
      setState(() => _error = 'Please enter a valid email');
      return;
    }

    setState(() {
      _error = null;
      _submitted = true;
    });

    component.props.onSubmit
        ?.call(_email, component.props.collectName ? _name : null);
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return dom.div(
        classes: 'arcane-waitlist-success',
        styles: const dom.Styles(raw: {
          'padding': '2rem',
          'text-align': 'center',
          'background-color': 'var(--card)',
          'border': '1px solid var(--success)',
          'border-radius': 'var(--radius)',
        }),
        [
          const dom.div(
            [Component.text('\u2713')],
            styles: dom.Styles(raw: {
              'font-size': '2rem',
              'margin-bottom': '1rem',
              'color': 'var(--success)',
            }),
          ),
          dom.div(
            [Component.text(component.props.successMessage)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-base)',
              'color': 'var(--foreground)',
            }),
          ),
        ],
      );
    }

    return dom.div(
      classes: 'arcane-waitlist-form',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--arcane-space-6)',
        'padding': '2rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
      }),
      [
        if (component.props.title != null)
          dom.div(
            [Component.text(component.props.title!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-lg)',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'color': 'var(--foreground)',
            }),
          ),
        if (component.props.description != null)
          dom.div(
            [Component.text(component.props.description!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--muted-foreground)',
              'line-height': '1.625',
            }),
          ),
        if (component.props.collectName)
          dom.input(
            type: dom.InputType.text,
            attributes: const {'placeholder': 'Your name'},
            styles: const dom.Styles(raw: {
              'width': '100%',
              'height': '44px',
              'padding': '10px 14px',
              'font-size': 'var(--arcane-font-size-sm)',
              'background-color': 'var(--muted)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'color': 'var(--foreground)',
              'outline': 'none',
            }),
            events: {
              'input': (e) {
                final dynamic target = e.target;
                setState(() => _name = target.value as String);
              },
            },
          ),
        dom.input(
          type: dom.InputType.email,
          attributes: const {'placeholder': 'your@email.com'},
          styles: dom.Styles(raw: {
            'width': '100%',
            'height': '44px',
            'padding': '10px 14px',
            'font-size': 'var(--arcane-font-size-sm)',
            'background-color': 'var(--muted)',
            'border':
                '1px solid ${_error != null ? 'var(--destructive)' : 'var(--border)'}',
            'border-radius': 'var(--radius)',
            'color': 'var(--foreground)',
            'outline': 'none',
          }),
          events: {
            'input': (e) {
              final dynamic target = e.target;
              setState(() {
                _email = target.value as String;
                _error = null;
              });
            },
          },
        ),
        if (_error != null)
          dom.span(
            [Component.text(_error!)],
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'color': 'var(--destructive)',
            }),
          ),
        dom.button(
          [Component.text(component.props.buttonText)],
          attributes: const {'type': 'button'},
          styles: const dom.Styles(raw: {
            'width': '100%',
            'height': '44px',
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': 'var(--accent-foreground)',
            'background-color': 'var(--accent)',
            'border': 'none',
            'border-radius': 'var(--radius)',
            'cursor': 'pointer',
            'transition': 'all var(--arcane-transition)',
          }),
          events: {
            'click': (e) => _handleSubmit(),
          },
        ),
      ],
    );
  }
}