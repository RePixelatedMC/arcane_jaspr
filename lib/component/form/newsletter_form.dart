import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// A newsletter signup form (Supabase-style)
class ArcaneNewsletterForm extends StatefulComponent {
  /// Placeholder text
  final String placeholder;

  /// Submit button text
  final String buttonText;

  /// Success message
  final String successMessage;

  /// Submit callback
  final void Function(String email)? onSubmit;

  /// Whether to show inline (horizontal) layout
  final bool inline;

  /// Whether the form is compact
  final bool compact;

  const ArcaneNewsletterForm({
    this.placeholder = 'Enter your email',
    this.buttonText = 'Subscribe',
    this.successMessage = 'Thanks for subscribing!',
    this.onSubmit,
    this.inline = true,
    this.compact = false,
    super.key,
  });

  @override
  State<ArcaneNewsletterForm> createState() => _NewsletterFormState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-newsletter-input:focus').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 0 0 2px hsl(var(--accent) / 0.1)',
    }),
    css('.arcane-newsletter-button:hover').styles(raw: {
      'filter': 'brightness(1.1)',
    }),
  ];
}

class _NewsletterFormState extends State<ArcaneNewsletterForm> {
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

    component.onSubmit?.call(_email);
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return div(
        classes: 'arcane-newsletter-success',
        styles: const Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': '0.5rem',
          'padding': '1rem 1.5rem',
          'background-color': 'hsl(142 76% 36% / 0.1)',
          'border': '1px solid hsl(142 76% 36%)',
          'border-radius': '0.375rem',
          'color': 'hsl(142 76% 36%)',
          'font-size': '0.875rem',
        }),
        [
          span([text('✓')]),
          span([text(component.successMessage)]),
        ],
      );
    }

    final String inputHeight = component.compact ? '36px' : '44px';
    final String inputPadding = component.compact ? '0.5rem 1rem' : '10px 14px';
    final String buttonPadding = component.compact ? '0.5rem 1.5rem' : '10px 20px';

    if (component.inline) {
      return div(
        classes: 'arcane-newsletter-form',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.5rem',
        }),
        [
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'gap': '0.5rem',
            }),
            [
              input(
                type: InputType.email,
                classes: 'arcane-newsletter-input',
                attributes: {
                  'placeholder': component.placeholder,
                },
                styles: Styles(raw: {
                  'flex': '1',
                  'height': inputHeight,
                  'padding': inputPadding,
                  'font-size': '0.875rem',
                  'background-color': 'var(--card)',
                  'border': '1px solid ${_error != null ? 'var(--destructive)' : 'var(--border)'}',
                  'border-radius': '0.375rem',
                  'color': 'var(--foreground)',
                  'outline': 'none',
                  'transition': 'all 150ms ease',
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
              button(
                [text(component.buttonText)],
                classes: 'arcane-newsletter-button',
                attributes: {'type': 'button'},
                styles: Styles(raw: {
                  'height': inputHeight,
                  'padding': buttonPadding,
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'color': 'var(--accent-foreground)',
                  'background-color': 'var(--accent)',
                  'border': 'none',
                  'border-radius': '0.375rem',
                  'cursor': 'pointer',
                  'white-space': 'nowrap',
                  'transition': 'all 150ms ease',
                }),
                events: {
                  'click': (e) => _handleSubmit(),
                },
              ),
            ],
          ),
          if (_error != null)
            span(
              [text(_error!)],
              styles: const Styles(raw: {
                'font-size': '0.75rem',
                'color': 'var(--destructive)',
              }),
            ),
        ],
      );
    }

    // Stacked layout
    return div(
      classes: 'arcane-newsletter-form stacked',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1rem',
      }),
      [
        input(
          type: InputType.email,
          classes: 'arcane-newsletter-input',
          attributes: {
            'placeholder': component.placeholder,
          },
          styles: Styles(raw: {
            'width': '100%',
            'height': inputHeight,
            'padding': inputPadding,
            'font-size': '0.875rem',
            'background-color': 'var(--card)',
            'border': '1px solid ${_error != null ? 'var(--destructive)' : 'var(--border)'}',
            'border-radius': '0.375rem',
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
          span(
            [text(_error!)],
            styles: const Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--destructive)',
              'margin-top': '-0.25rem',
            }),
          ),
        button(
          [text(component.buttonText)],
          classes: 'arcane-newsletter-button',
          attributes: {'type': 'button'},
          styles: Styles(raw: {
            'width': '100%',
            'height': inputHeight,
            'padding': buttonPadding,
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--accent-foreground)',
            'background-color': 'var(--accent)',
            'border': 'none',
            'border-radius': '0.375rem',
            'cursor': 'pointer',
            'transition': 'all 150ms ease',
          }),
          events: {
            'click': (e) => _handleSubmit(),
          },
        ),
      ],
    );
  }
}

/// A waitlist form with additional fields
class ArcaneWaitlistForm extends StatefulComponent {
  /// Form title
  final String? title;

  /// Form description
  final String? description;

  /// Submit button text
  final String buttonText;

  /// Success message
  final String successMessage;

  /// Submit callback
  final void Function(String email, String? name)? onSubmit;

  /// Whether to collect name
  final bool collectName;

  const ArcaneWaitlistForm({
    this.title,
    this.description,
    this.buttonText = 'Join Waitlist',
    this.successMessage = "You're on the list! We'll be in touch.",
    this.onSubmit,
    this.collectName = true,
    super.key,
  });

  @override
  State<ArcaneWaitlistForm> createState() => _WaitlistFormState();
}

class _WaitlistFormState extends State<ArcaneWaitlistForm> {
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

    component.onSubmit?.call(_email, component.collectName ? _name : null);
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return div(
        classes: 'arcane-waitlist-success',
        styles: const Styles(raw: {
          'padding': '2rem',
          'text-align': 'center',
          'background-color': 'var(--card)',
          'border': '1px solid hsl(142 76% 36%)',
          'border-radius': '0.375rem',
        }),
        [
          div(
            [text('!')],
            styles: const Styles(raw: {
              'font-size': '2rem',
              'margin-bottom': '1rem',
            }),
          ),
          div(
            [text(component.successMessage)],
            styles: const Styles(raw: {
              'font-size': '1rem',
              'color': 'var(--foreground)',
            }),
          ),
        ],
      );
    }

    return div(
      classes: 'arcane-waitlist-form',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1.5rem',
        'padding': '2rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': '0.375rem',
      }),
      [
        if (component.title != null)
          div(
            [text(component.title!)],
            styles: const Styles(raw: {
              'font-size': '1.125rem',
              'font-weight': '600',
              'color': 'var(--foreground)',
            }),
          ),
        if (component.description != null)
          div(
            [text(component.description!)],
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'line-height': '1.625',
            }),
          ),
        if (component.collectName)
          input(
            type: InputType.text,
            attributes: {'placeholder': 'Your name'},
            styles: const Styles(raw: {
              'width': '100%',
              'height': '44px',
              'padding': '10px 14px',
              'font-size': '0.875rem',
              'background-color': 'var(--muted)',
              'border': '1px solid var(--border)',
              'border-radius': '0.375rem',
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
        input(
          type: InputType.email,
          attributes: {'placeholder': 'your@email.com'},
          styles: Styles(raw: {
            'width': '100%',
            'height': '44px',
            'padding': '10px 14px',
            'font-size': '0.875rem',
            'background-color': 'var(--muted)',
            'border': '1px solid ${_error != null ? 'var(--destructive)' : 'var(--border)'}',
            'border-radius': '0.375rem',
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
          span(
            [text(_error!)],
            styles: const Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--destructive)',
            }),
          ),
        button(
          [text(component.buttonText)],
          attributes: {'type': 'button'},
          styles: const Styles(raw: {
            'width': '100%',
            'height': '44px',
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': 'var(--accent-foreground)',
            'background-color': 'var(--accent)',
            'border': 'none',
            'border-radius': '0.375rem',
            'cursor': 'pointer',
            'transition': 'all 150ms ease',
          }),
          events: {
            'click': (e) => _handleSubmit(),
          },
        ),
      ],
    );
  }
}
