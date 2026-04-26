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
                  classes: 'neon-form-cancel-btn',
                  styles: const dom.Styles(
                    raw: {
                      'padding': '0.75rem 1.25rem',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'color': 'var(--foreground)',
                      'background-color': 'transparent',
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--radius)',
                      'cursor': 'pointer',
                      'transition': 'all var(--arcane-transition)',
                    },
                  ),
                  events: {'click': (_) => props.onCancel!()},
                  [Component.text(props.cancelText ?? 'Cancel')],
                ),
              dom.button(
                type: dom.ButtonType.submit,
                classes: 'neon-form-submit-btn',
                styles: const dom.Styles(
                  raw: {
                    'padding': '0.75rem 1.25rem',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': '#ffffff',
                    'background-color': 'var(--primary)',
                    'border': 'none',
                    'border-radius': 'var(--radius)',
                    'cursor': 'pointer',
                    'transition': 'all var(--arcane-transition)',
                    'box-shadow': '0 14px 20px rgba(var(--primary-rgb), 0.3)',
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
