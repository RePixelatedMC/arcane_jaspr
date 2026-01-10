import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';
import '../../../core/props/confirm_dialog_props.dart';
import '../../../core/props/dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// ShadCN Confirm Dialog renderer.
class ShadcnConfirmDialog extends StatelessComponent {
  final ConfirmDialogProps props;

  const ShadcnConfirmDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return ShadcnDialog(
      DialogProps(
        title: props.title,
        onClose: props.onCancel,
        maxWidth: 400,
        content: [
          dom.div(
            classes: 'arcane-confirm-dialog-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'text-align': 'center',
              'gap': 'var(--arcane-space-4)',
            }),
            [
              if (props.icon != null)
                dom.div(
                  styles: dom.Styles(raw: {
                    'font-size': '3rem',
                    'color': props.destructive ? 'var(--destructive)' : 'var(--accent)',
                  }),
                  [props.icon!],
                ),
              dom.div(
                styles: const dom.Styles(raw: {
                  'color': 'var(--foreground)',
                  'font-size': 'var(--arcane-font-size-sm)',
                  'line-height': '1.625',
                }),
                [Component.text(props.message)],
              ),
            ],
          ),
        ],
        actions: [
          ShadcnButton(ButtonProps(
            label: props.cancelText,
            variant: ButtonVariant.outline,
            onPressed: props.onCancel,
          )),
          props.destructive
              ? ShadcnButton(ButtonProps(
                  label: props.confirmText,
                  variant: ButtonVariant.destructive,
                  onPressed: props.onConfirm,
                ))
              : ShadcnButton(ButtonProps(
                  label: props.confirmText,
                  variant: ButtonVariant.primary,
                  onPressed: props.onConfirm,
                )),
        ],
      ),
    );
  }
}

/// ShadCN Alert Dialog renderer.
class ShadcnAlertDialog extends StatelessComponent {
  final AlertDialogProps props;

  const ShadcnAlertDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return ShadcnDialog(
      DialogProps(
        title: props.title,
        onClose: props.onDismiss,
        maxWidth: 400,
        content: [
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'text-align': 'center',
              'gap': 'var(--arcane-space-4)',
            }),
            [
              if (props.icon != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '3rem',
                    'color': 'var(--accent)',
                  }),
                  [props.icon!],
                ),
              dom.div(
                styles: const dom.Styles(raw: {
                  'color': 'var(--foreground)',
                  'font-size': 'var(--arcane-font-size-sm)',
                  'line-height': '1.625',
                }),
                [Component.text(props.message)],
              ),
            ],
          ),
        ],
        actions: [
          ShadcnButton(ButtonProps(
            label: props.buttonText,
            variant: ButtonVariant.primary,
            onPressed: props.onDismiss,
          )),
        ],
      ),
    );
  }
}
