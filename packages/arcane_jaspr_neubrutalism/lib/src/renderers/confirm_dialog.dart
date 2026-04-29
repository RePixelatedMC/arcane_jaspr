import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/props/confirm_dialog_props.dart';
import 'package:arcane_jaspr/core/props/dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// Neubrutalism Confirm Dialog renderer.
class NeubrutalismConfirmDialog extends StatelessComponent {
  final ConfirmDialogProps props;

  const NeubrutalismConfirmDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return NeubrutalismDialog(
      DialogProps(
        title: props.title,
        onClose: props.onCancel,
        maxWidth: 420,
        content: [
          dom.div(
            classes: 'neubrutalism-confirm-dialog-content',
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center',
                'text-align': 'center',
                'gap': '1.25rem',
              },
            ),
            [
              if (props.icon != null)
                dom.div(
                  classes: 'neubrutalism-confirm-dialog-icon',
                  styles: dom.Styles(
                    raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'width': '3rem',
                      'height': '3rem',
                      'font-size': '1.5rem',
                      'color': props.destructive
                          ? 'var(--destructive)'
                          : 'var(--nb-accent, var(--primary))',
                      'background': props.destructive
                          ? 'var(--destructive)'
                          : 'var(--nb-accent, var(--primary))',
                      'border':
                          'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                      'border-radius': 'var(--nb-radius-soft, 4px)',
                      'box-shadow':
                          'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
                    },
                  ),
                  [props.icon!],
                ),
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'color': 'var(--foreground)',
                    'font-size': '0.9375rem',
                    'line-height': '1.625',
                  },
                ),
                [Component.text(props.message)],
              ),
            ],
          ),
        ],
        actions: [
          NeubrutalismButton(
            ButtonProps(
              label: props.cancelText,
              variant: ButtonVariant.outline,
              onPressed: props.onCancel,
            ),
          ),
          props.destructive
              ? NeubrutalismButton(
                  ButtonProps(
                    label: props.confirmText,
                    variant: ButtonVariant.destructive,
                    onPressed: props.onConfirm,
                  ),
                )
              : NeubrutalismButton(
                  ButtonProps(
                    label: props.confirmText,
                    variant: ButtonVariant.primary,
                    onPressed: props.onConfirm,
                  ),
                ),
        ],
      ),
    );
  }
}

/// Neubrutalism Alert Dialog renderer.
class NeubrutalismAlertDialog extends StatelessComponent {
  final AlertDialogProps props;

  const NeubrutalismAlertDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return NeubrutalismDialog(
      DialogProps(
        title: props.title,
        onClose: props.onDismiss,
        maxWidth: 420,
        content: [
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center',
                'text-align': 'center',
                'gap': '1.25rem',
              },
            ),
            [
              if (props.icon != null)
                dom.div(
                  classes: 'neubrutalism-confirm-dialog-icon',
                  styles: const dom.Styles(
                    raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'width': '3rem',
                      'height': '3rem',
                      'font-size': '1.5rem',
                      'color': 'var(--nb-ink, #000)',
                      'background': 'var(--nb-accent, var(--primary))',
                      'border':
                          'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
                      'border-radius': '0',
                      'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
                    },
                  ),
                  [props.icon!],
                ),
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'color': 'var(--foreground)',
                    'font-size': '0.9375rem',
                    'line-height': '1.625',
                  },
                ),
                [Component.text(props.message)],
              ),
            ],
          ),
        ],
        actions: [
          NeubrutalismButton(
            ButtonProps(
              label: props.buttonText,
              variant: ButtonVariant.primary,
              onPressed: props.onDismiss,
            ),
          ),
        ],
      ),
    );
  }
}
