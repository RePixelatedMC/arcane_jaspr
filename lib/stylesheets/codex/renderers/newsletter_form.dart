import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/newsletter_form_props.dart';

/// Codex NewsletterForm renderer.
class CodexNewsletterForm extends StatefulComponent {
  final NewsletterFormProps props;

  const CodexNewsletterForm(this.props, {super.key});

  @override
  State<CodexNewsletterForm> createState() => _CodexNewsletterFormState();
}

class _CodexNewsletterFormState extends State<CodexNewsletterForm> {
  String _email = '';
  bool _submitted = false;

  void _handleSubmit() {
    if (_email.isNotEmpty && component.props.onSubmit != null) {
      component.props.onSubmit!(_email);
      setState(() => _submitted = true);
    }
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return dom.div(
        classes: 'codex-newsletter-success',
        styles: const dom.Styles(raw: {
          'padding': '1rem',
          'text-align': 'center',
          'color': 'var(--success)',
          'font-size': 'var(--arcane-font-size-sm)',
        }),
        [Component.text(component.props.successMessage)],
      );
    }

    final bool isInline = component.props.inline;
    final bool isCompact = component.props.compact;

    return dom.form(
      classes: 'codex-newsletter-form',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': isInline ? 'row' : 'column',
        'gap': isCompact ? '0.5rem' : '0.75rem',
      }),
      events: {
        'submit': (event) {
          event.preventDefault();
          _handleSubmit();
        }
      },
      [
        dom.input(
          type: dom.InputType.email,
          classes: 'codex-newsletter-input',
          styles: dom.Styles(raw: {
            'flex': isInline ? '1' : 'unset',
            'padding': isCompact ? '0.625rem 0.875rem' : '0.75rem 1rem',
            'font-size': 'var(--arcane-font-size-sm)',
            'color': 'var(--foreground)',
            'background-color': 'var(--input)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'outline': 'none',
            'transition': 'all var(--arcane-transition)',
          }),
          attributes: {'placeholder': component.props.placeholder},
          events: {
            'input': (event) {
              final target = event.target;
              if (target != null) {
                _email = (target as dynamic).value ?? '';
              }
            }
          },
        ),
        dom.button(
          type: dom.ButtonType.submit,
          classes: 'codex-newsletter-btn',
          styles: dom.Styles(raw: {
            'padding': isCompact ? '0.625rem 1rem' : '0.75rem 1.25rem',
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': '#ffffff',
            'background-color': 'var(--codex-accent)',
            'border': 'none',
            'border-radius': 'var(--radius)',
            'cursor': 'pointer',
            'transition': 'all var(--arcane-transition)',
            'white-space': 'nowrap',
          }),
          [Component.text(component.props.buttonText)],
        ),
      ],
    );
  }
}

/// Codex WaitlistForm renderer.
class CodexWaitlistForm extends StatefulComponent {
  final WaitlistFormProps props;

  const CodexWaitlistForm(this.props, {super.key});

  @override
  State<CodexWaitlistForm> createState() => _CodexWaitlistFormState();
}

class _CodexWaitlistFormState extends State<CodexWaitlistForm> {
  String _email = '';
  String _name = '';
  bool _submitted = false;

  void _handleSubmit() {
    if (_email.isNotEmpty && component.props.onSubmit != null) {
      component.props.onSubmit!(
        _email,
        component.props.collectName ? _name : null,
      );
      setState(() => _submitted = true);
    }
  }

  @override
  Component build(BuildContext context) {
    if (_submitted) {
      return dom.div(
        classes: 'codex-waitlist-success',
        styles: const dom.Styles(raw: {
          'padding': '2rem',
          'text-align': 'center',
        }),
        [
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-lg)',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'color': 'var(--foreground)',
              'margin-bottom': '0.5rem',
            }),
            [Component.text(component.props.successMessage)],
          ),
        ],
      );
    }

    return dom.form(
      classes: 'codex-waitlist-form',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--arcane-space-4)',
      }),
      events: {
        'submit': (event) {
          event.preventDefault();
          _handleSubmit();
        }
      },
      [
        // Title
        if (component.props.title != null)
          dom.h3(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xl)',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'color': 'var(--foreground)',
              'margin': '0',
            }),
            [Component.text(component.props.title!)],
          ),

        // Description
        if (component.props.description != null)
          dom.p(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin': '0',
            }),
            [Component.text(component.props.description!)],
          ),

        // Name input
        if (component.props.collectName)
          dom.input(
            type: dom.InputType.text,
            classes: 'codex-waitlist-name',
            styles: const dom.Styles(raw: {
              'padding': '0.75rem 1rem',
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--foreground)',
              'background-color': 'var(--input)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'outline': 'none',
              'transition': 'all var(--arcane-transition)',
            }),
            attributes: {'placeholder': 'Your name'},
            events: {
              'input': (event) {
                final target = event.target;
                if (target != null) {
                  _name = (target as dynamic).value ?? '';
                }
              }
            },
          ),

        // Email input
        dom.input(
          type: dom.InputType.email,
          classes: 'codex-waitlist-email',
          styles: const dom.Styles(raw: {
            'padding': '0.75rem 1rem',
            'font-size': 'var(--arcane-font-size-sm)',
            'color': 'var(--foreground)',
            'background-color': 'var(--input)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'outline': 'none',
            'transition': 'all var(--arcane-transition)',
          }),
          attributes: {'placeholder': 'Your email'},
          events: {
            'input': (event) {
              final target = event.target;
              if (target != null) {
                _email = (target as dynamic).value ?? '';
              }
            }
          },
        ),

        // Submit button
        dom.button(
          type: dom.ButtonType.submit,
          classes: 'codex-waitlist-btn',
          styles: const dom.Styles(raw: {
            'padding': '0.875rem 1.5rem',
            'font-size': '0.9375rem',
            'font-weight': 'var(--arcane-font-weight-semibold)',
            'color': '#ffffff',
            'background-color': 'var(--codex-accent)',
            'border': 'none',
            'border-radius': 'var(--radius)',
            'cursor': 'pointer',
            'transition': 'all var(--arcane-transition)',
            'box-shadow': '0 0 20px rgba(var(--codex-accent-rgb), 0.3)',
          }),
          [Component.text(component.props.buttonText)],
        ),
      ],
    );
  }
}
