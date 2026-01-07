import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/field_wrapper_props.dart';

/// Codex Form renderer.
class CodexForm extends StatelessComponent {
  final FormProps props;

  const CodexForm(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.form(
      classes: 'codex-form',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${props.spacing}px',
      }),
      events: props.onSubmit != null
          ? {
              'submit': (event) {
                event.preventDefault();
                props.onSubmit!();
              }
            }
          : null,
      [
        // Form fields
        ...props.children,

        // Action buttons
        if (props.showActions)
          dom.div(
            classes: 'codex-form-actions',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'gap': '0.75rem',
              'margin-top': '0.5rem',
              'justify-content': 'flex-end',
            }),
            [
              if (props.onCancel != null)
                dom.button(
                  classes: 'codex-form-cancel-btn',
                  styles: const dom.Styles(raw: {
                    'padding': '0.75rem 1.25rem',
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': 'var(--foreground)',
                    'background-color': 'transparent',
                    'border': '1px solid var(--border)',
                    'border-radius': 'var(--radius)',
                    'cursor': 'pointer',
                    'transition': 'all 150ms ease',
                  }),
                  events: {'click': (_) => props.onCancel!()},
                  [Component.text(props.cancelText ?? 'Cancel')],
                ),
              dom.button(
                type: dom.ButtonType.submit,
                classes: 'codex-form-submit-btn',
                styles: const dom.Styles(raw: {
                  'padding': '0.75rem 1.25rem',
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'color': '#ffffff',
                  'background-color': 'var(--codex-accent)',
                  'border': 'none',
                  'border-radius': 'var(--radius)',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                  'box-shadow': '0 0 20px rgba(var(--codex-accent-rgb), 0.3)',
                }),
                [Component.text(props.submitText ?? 'Submit')],
              ),
            ],
          ),
      ],
    );
  }
}
