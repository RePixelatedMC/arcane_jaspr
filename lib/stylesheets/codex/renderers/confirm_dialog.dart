import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';
import '../../../core/props/confirm_dialog_props.dart';
import '../../../core/props/dialog_props.dart';
import 'button.dart';
import 'dialog.dart';

/// Codex Confirm Dialog renderer.
class CodexConfirmDialog extends StatelessComponent {
  final ConfirmDialogProps props;

  const CodexConfirmDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return CodexDialog(
      DialogProps(
        title: props.title,
        onClose: props.onCancel,
        maxWidth: 420,
        content: [
          dom.div(
            classes: 'codex-confirm-dialog-content',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'text-align': 'center',
              'gap': '1.25rem',
            }),
            [
              if (props.icon != null)
                dom.div(
                  styles: dom.Styles(raw: {
                    'font-size': '3rem',
                    'color': props.destructive ? 'var(--destructive)' : 'var(--primary)',
                  }),
                  [props.icon!],
                ),
              dom.div(
                styles: const dom.Styles(raw: {
                  'color': 'var(--foreground)',
                  'font-size': '0.9375rem',
                  'line-height': '1.625',
                }),
                [Component.text(props.message)],
              ),
            ],
          ),
        ],
        actions: [
          CodexButton(ButtonProps(
            label: props.cancelText,
            variant: ButtonVariant.outline,
            onPressed: props.onCancel,
          )),
          props.destructive
              ? CodexButton(ButtonProps(
                  label: props.confirmText,
                  variant: ButtonVariant.destructive,
                  onPressed: props.onConfirm,
                ))
              : CodexButton(ButtonProps(
                  label: props.confirmText,
                  variant: ButtonVariant.primary,
                  onPressed: props.onConfirm,
                )),
        ],
      ),
    );
  }
}

/// Codex Alert Dialog renderer.
class CodexAlertDialog extends StatelessComponent {
  final AlertDialogProps props;

  const CodexAlertDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return CodexDialog(
      DialogProps(
        title: props.title,
        onClose: props.onDismiss,
        maxWidth: 420,
        content: [
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'text-align': 'center',
              'gap': '1.25rem',
            }),
            [
              if (props.icon != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '3rem',
                    'color': 'var(--primary)',
                  }),
                  [props.icon!],
                ),
              dom.div(
                styles: const dom.Styles(raw: {
                  'color': 'var(--foreground)',
                  'font-size': '0.9375rem',
                  'line-height': '1.625',
                }),
                [Component.text(props.message)],
              ),
            ],
          ),
        ],
        actions: [
          CodexButton(ButtonProps(
            label: props.buttonText,
            variant: ButtonVariant.primary,
            onPressed: props.onDismiss,
          )),
        ],
      ),
    );
  }
}
