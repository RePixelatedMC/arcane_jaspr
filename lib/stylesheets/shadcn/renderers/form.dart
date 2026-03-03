import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/field_wrapper_props.dart';

/// ShadCN Form renderer (stateful for form handling).
class ShadcnForm extends StatefulComponent {
  final FormProps props;

  const ShadcnForm(this.props, {super.key});

  @override
  State<ShadcnForm> createState() => _ShadcnFormState();
}

class _ShadcnFormState extends State<ShadcnForm> {
  @override
  Component build(BuildContext context) {
    return dom.form(
      classes: 'arcane-form',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${component.props.spacing}px',
      }),
      events: {
        'submit': (event) {
          event.preventDefault();
          component.props.onSubmit?.call();
        },
      },
      [
        ...component.props.children,
        if (component.props.showActions)
          dom.div(
            classes: 'arcane-form-actions',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'flex-end',
              'gap': 'var(--space-2)',
              'margin-top': '1.5rem',
              'padding-top': '1.5rem',
              'border-top': '1px solid var(--border)',
            }),
            [
              if (component.props.onCancel != null)
                dom.button(
                  attributes: const {'type': 'button'},
                  styles: const dom.Styles(raw: {
                    'padding': '10px 20px',
                    'border': '1px solid var(--border)',
                    'border-radius': 'var(--radius)',
                    'background-color': 'transparent',
                    'color': 'var(--foreground)',
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'cursor': 'pointer',
                    'transition': 'all var(--transition)',
                  }),
                  events: {
                    'click': (_) => component.props.onCancel?.call(),
                  },
                  [Component.text(component.props.cancelText!)],
                ),
              dom.button(
                attributes: const {'type': 'submit'},
                styles: const dom.Styles(raw: {
                  'padding': '10px 20px',
                  'border': 'none',
                  'border-radius': 'var(--radius)',
                  'background-color': 'var(--accent)',
                  'color': 'var(--accent-foreground)',
                  'font-size': 'var(--font-size-sm)',
                  'font-weight': 'var(--font-weight-medium)',
                  'cursor': 'pointer',
                  'transition': 'all var(--transition)',
                }),
                [Component.text(component.props.submitText!)],
              ),
            ],
          ),
      ],
    );
  }
}
