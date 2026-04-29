import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/field_wrapper_props.dart';

/// Neubrutalism Form renderer.
class NeubrutalismForm extends StatelessComponent {
  final FormProps props;

  const NeubrutalismForm(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.form(
      classes: 'neubrutalism-form',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '${props.spacing}px',
        },
      ),
      events: props.onSubmit != null
          ? {
              'submit': (event) {
                event.preventDefault();
                props.onSubmit!();
              },
            }
          : null,
      [
        // Form fields
        ...props.children,

        // Action buttons
        if (props.showActions)
          dom.div(
            classes: 'neubrutalism-form-actions',
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'gap': '0.75rem',
                'margin-top': '0.5rem',
                'justify-content': 'flex-end',
              },
            ),
            [
              if (props.onCancel != null)
                dom.button(
                  classes: 'neubrutalism-form-cancel-btn neubrutalism-button',
                  attributes: {
                    'type': 'button',
                    'data-variant': 'outline',
                  },
                  styles: const dom.Styles(
                    raw: {
                      'padding': '0.7rem 1.4rem',
                      'font-family': 'var(--font-heading)',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'letter-spacing': '0.06em',
                      'text-transform': 'uppercase',
                      'color': 'var(--foreground)',
                      'background': 'var(--nb-paper, var(--card))',
                      'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                      'cursor': 'pointer',
                                            'transition':
                          'background 200ms ease, border-color 200ms ease, color 200ms ease',
                    },
                  ),
                  events: {'click': (_) => props.onCancel!()},
                  [Component.text(props.cancelText ?? 'Cancel')],
                ),
              dom.button(
                type: dom.ButtonType.submit,
                classes: 'neubrutalism-form-submit-btn neubrutalism-button',
                attributes: {'data-variant': 'primary'},
                styles: const dom.Styles(
                  raw: {
                    'padding': '0.7rem 1.4rem',
                    'font-family': 'var(--font-heading)',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'letter-spacing': '0.06em',
                    'text-transform': 'uppercase',
                    'color': 'var(--nb-ink, #000)',
                    'background': 'var(--nb-accent, var(--primary))',
                    'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                    'cursor': 'pointer',
                    'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
                    'transition':
                        'background 200ms ease, box-shadow 200ms ease, transform 200ms ease',
                  },
                ),
                [Component.text(props.submitText ?? 'Submit')],
              ),
            ],
          ),
      ],
    );
  }
}
