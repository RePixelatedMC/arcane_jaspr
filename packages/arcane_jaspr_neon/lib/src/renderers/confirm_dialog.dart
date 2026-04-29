import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/props/confirm_dialog_props.dart';
import 'package:arcane_jaspr/core/props/dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// Neon Confirm Dialog renderer.
class NeonConfirmDialog extends StatelessComponent {
  final ConfirmDialogProps props;

  const NeonConfirmDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return NeonDialog(
      DialogProps(
        title: props.title,
        onClose: props.onCancel,
        maxWidth: 420,
        content: [
          dom.div(
            classes: 'neon-confirm-dialog-content',
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
                  classes: 'neon-confirm-dialog-icon',
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
                          : 'var(--neon-accent)',
                      'background':
                          'color-mix(in srgb, ${props.destructive ? 'var(--destructive)' : 'var(--neon-accent)'} 8%, transparent)',
                      'border':
                          '1px solid color-mix(in srgb, ${props.destructive ? 'var(--destructive)' : 'var(--neon-accent)'} 32%, transparent)',
                      'border-radius': 'var(--neon-radius-control)',
                      'clip-path': 'var(--neon-clip-xs)',
                      'box-shadow':
                          '0 0 18px color-mix(in srgb, ${props.destructive ? 'var(--destructive)' : 'var(--neon-accent)'} 22%, transparent)',
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
          NeonButton(
            ButtonProps(
              label: props.cancelText,
              variant: ButtonVariant.outline,
              onPressed: props.onCancel,
            ),
          ),
          props.destructive
              ? NeonButton(
                  ButtonProps(
                    label: props.confirmText,
                    variant: ButtonVariant.destructive,
                    onPressed: props.onConfirm,
                  ),
                )
              : NeonButton(
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

/// Neon Alert Dialog renderer.
class NeonAlertDialog extends StatelessComponent {
  final AlertDialogProps props;

  const NeonAlertDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return NeonDialog(
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
                  classes: 'neon-confirm-dialog-icon',
                  styles: const dom.Styles(
                    raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'width': '3rem',
                      'height': '3rem',
                      'font-size': '1.5rem',
                      'color': 'var(--neon-accent)',
                      'background':
                          'color-mix(in srgb, var(--neon-accent) 8%, transparent)',
                      'border':
                          '1px solid color-mix(in srgb, var(--neon-accent) 32%, transparent)',
                      'border-radius': 'var(--neon-radius-control)',
                      'clip-path': 'var(--neon-clip-xs)',
                      'box-shadow':
                          '0 0 18px color-mix(in srgb, var(--neon-accent) 22%, transparent)',
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
          NeonButton(
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
