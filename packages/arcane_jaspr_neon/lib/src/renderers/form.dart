import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/field_wrapper_props.dart';

/// Neon Form renderer.
class NeonForm extends StatelessComponent {
  final FormProps props;

  const NeonForm(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.form(
      classes: 'neon-form',
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
            classes: 'neon-form-actions',
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
                  classes: 'neon-form-cancel-btn neon-button',
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
                      'background': 'var(--neon-surface-1)',
                      'border': '1px solid var(--neon-control-border)',
                      'clip-path': 'var(--neon-clip-sm)',
                      'cursor': 'pointer',
                      'box-shadow': 'inset 0 1px 0 var(--neon-inset)',
                      'transition':
                          'background 200ms ease, border-color 200ms ease, color 200ms ease',
                    },
                  ),
                  events: {'click': (_) => props.onCancel!()},
                  [Component.text(props.cancelText ?? 'Cancel')],
                ),
              dom.button(
                type: dom.ButtonType.submit,
                classes: 'neon-form-submit-btn neon-button',
                attributes: {'data-variant': 'primary'},
                styles: const dom.Styles(
                  raw: {
                    'padding': '0.7rem 1.4rem',
                    'font-family': 'var(--font-heading)',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'letter-spacing': '0.06em',
                    'text-transform': 'uppercase',
                    'color': 'var(--neon-on-accent)',
                    'background':
                        'linear-gradient(180deg, color-mix(in srgb, var(--neon-accent) 82%, var(--neon-surface-0)), var(--neon-accent))',
                    'border': '1px solid var(--neon-control-border-strong)',
                    'clip-path': 'var(--neon-clip-sm)',
                    'cursor': 'pointer',
                    'box-shadow':
                        '0 0 22px color-mix(in srgb, var(--neon-accent) 28%, transparent), inset 0 1px 0 var(--neon-inset)',
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
