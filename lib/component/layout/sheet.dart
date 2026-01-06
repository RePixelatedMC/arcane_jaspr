import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';
import '../../core/props/dialog_props.dart' as props;
import 'sheet_types.dart';

export 'sheet_types.dart';

export '../../core/props/dialog_props.dart' show SheetSizeVariant, SheetProps;

/// A modal sheet that slides in from screen edges matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/sheet
///
/// Sheets are used for forms, filters, action menus, and other
/// content that requires user attention without navigating away.
/// ShadCN SheetOverlay: fixed inset-0 z-50 bg-black/80
/// ShadCN SheetContent: fixed z-50 gap-4 bg-background p-6 shadow-lg transition ease-in-out
///
/// ```dart
/// ArcaneSheet(
///   isOpen: showSheet,
///   onClose: () => setState(() => showSheet = false),
///   position: SheetPosition.bottom,
///   child: SheetContent(),
/// )
/// ```
class ArcaneSheet extends StatelessComponent {
  /// Whether the sheet is open
  final bool isOpen;

  /// Callback when sheet should close
  final VoidCallback? onClose;

  /// Sheet position (which edge it slides from)
  final SheetPosition position;

  /// Sheet size
  final SheetSize size;

  /// Sheet content
  final Component child;

  /// Optional title
  final String? title;

  /// Optional description below title
  final String? description;

  /// Optional header widget (overrides title/description)
  final Component? header;

  /// Optional footer content
  final Component? footer;

  /// Whether to show backdrop overlay
  final bool showBackdrop;

  /// Whether clicking backdrop closes sheet
  final bool closeOnBackdropClick;

  /// Whether to show close button
  final bool showCloseButton;

  /// Whether to show drag handle (for bottom/top sheets)
  final bool showDragHandle;

  /// Custom max width (for bottom sheets that shouldn't span full width)
  final String? maxWidth;

  const ArcaneSheet({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.position = SheetPosition.bottom,
    this.size = SheetSize.auto,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.showDragHandle = true,
    this.maxWidth,
    super.key,
  });

  /// Bottom sheet constructor
  const ArcaneSheet.bottom({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = SheetSize.auto,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = false,
    this.showDragHandle = true,
    this.maxWidth,
    super.key,
  }) : position = SheetPosition.bottom;

  /// Top sheet constructor
  const ArcaneSheet.top({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = SheetSize.auto,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.showDragHandle = false,
    this.maxWidth,
    super.key,
  }) : position = SheetPosition.top;

  /// Side sheet (end/right) constructor
  const ArcaneSheet.end({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = SheetSize.md,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.showDragHandle = false,
    this.maxWidth,
    super.key,
  }) : position = SheetPosition.end;

  props.SheetPosition get _propsPosition => switch (position) {
        SheetPosition.bottom => props.SheetPosition.bottom,
        SheetPosition.top => props.SheetPosition.top,
        SheetPosition.end => props.SheetPosition.right,
        SheetPosition.start => props.SheetPosition.left,
      };

  props.SheetSizeVariant get _propsSize => switch (size) {
        SheetSize.auto => props.SheetSizeVariant.auto,
        SheetSize.sm => props.SheetSizeVariant.sm,
        SheetSize.md => props.SheetSizeVariant.md,
        SheetSize.lg => props.SheetSizeVariant.lg,
        SheetSize.xl => props.SheetSizeVariant.xl,
        SheetSize.full => props.SheetSizeVariant.full,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.sheet(props.SheetProps(
      isOpen: isOpen,
      child: child,
      position: _propsPosition,
      size: _propsSize,
      onClose: onClose,
      showCloseButton: showCloseButton,
      title: title,
      description: description,
      header: header,
      footer: footer,
      showBackdrop: showBackdrop,
      closeOnBackdropClick: closeOnBackdropClick,
      showDragHandle: showDragHandle,
      maxWidth: maxWidth,
    ));
  }
}

/// Action sheet with a list of actions (mobile-style).
///
/// ```dart
/// ArcaneActionSheet(
///   isOpen: showActions,
///   onClose: () => setState(() => showActions = false),
///   actions: [
///     ActionSheetItem(
///       label: 'Share',
///       icon: '📤',
///       onTap: () => handleShare(),
///     ),
///     ActionSheetItem(
///       label: 'Delete',
///       icon: '🗑️',
///       destructive: true,
///       onTap: () => handleDelete(),
///     ),
///   ],
/// )
/// ```
class ArcaneActionSheet extends StatelessComponent {
  /// Whether the action sheet is open
  final bool isOpen;

  /// Callback when sheet should close
  final VoidCallback? onClose;

  /// Title text
  final String? title;

  /// Description text
  final String? message;

  /// List of actions
  final List<ActionSheetItem> actions;

  /// Whether to show cancel button
  final bool showCancel;

  /// Custom cancel label
  final String cancelLabel;

  const ArcaneActionSheet({
    required this.isOpen,
    required this.actions,
    this.onClose,
    this.title,
    this.message,
    this.showCancel = true,
    this.cancelLabel = 'Cancel',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneSheet.bottom(
      isOpen: isOpen,
      onClose: onClose,
      showCloseButton: false,
      showDragHandle: true,
      child: dom.div(
        styles: const dom.Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '4px',
        }),
        [
          // Title and message
          if (title != null || message != null)
            dom.div(
              styles: const dom.Styles(raw: {
                'text-align': 'center',
                'padding-bottom': '16px',
                'margin-bottom': '8px',
                'border-bottom': '1px solid var(--border)',
              }),
              [
                if (title != null)
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'font-size': '1rem',
                      'font-weight': '600',
                      'color': 'var(--foreground)',
                      'margin-bottom': '4px',
                    }),
                    [Component.text(title!)],
                  ),
                if (message != null)
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.875rem',
                      'color': 'var(--muted-foreground)',
                    }),
                    [Component.text(message!)],
                  ),
              ],
            ),

          // Actions
          for (final action in actions) _buildActionItem(action),

          // Cancel button
          if (showCancel) ...[
            dom.div(
              styles: const dom.Styles(raw: {
                'height': '8px',
              }),
              [],
            ),
            dom.button(
              styles: const dom.Styles(raw: {
                'width': '100%',
                'padding': '16px',
                'border': 'none',
                'background': 'var(--secondary)',
                'color': 'var(--foreground)',
                'font-size': '1rem',
                'font-weight': '500',
                'border-radius': '8px',
                'cursor': 'pointer',
                'transition': 'background 150ms ease',
              }),
              events: {'click': (_) => onClose?.call()},
              [Component.text(cancelLabel)],
            ),
          ],
        ],
      ),
    );
  }

  Component _buildActionItem(ActionSheetItem action) {
    return dom.button(
      classes: 'arcane-action-sheet-item ${action.destructive ? 'destructive' : ''}',
      styles: dom.Styles(raw: {
        'width': '100%',
        'display': 'flex',
        'align-items': 'center',
        'gap': '16px',
        'padding': '16px',
        'border': 'none',
        'background': 'transparent',
        'color': action.destructive ? 'var(--destructive)' : 'var(--foreground)',
        'font-size': '1rem',
        'border-radius': '6px',
        'cursor': action.disabled ? 'not-allowed' : 'pointer',
        'opacity': action.disabled ? '0.5' : '1',
        'transition': 'background 150ms ease',
      }),
      events: action.disabled
          ? null
          : {
              'click': (_) {
                action.onTap?.call();
                if (action.closeOnTap) onClose?.call();
              },
            },
      [
        if (action.icon != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': '1.125rem',
            }),
            [Component.text(action.icon!)],
          ),
        dom.span(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'text-align': 'left',
          }),
          [Component.text(action.label)],
        ),
        if (action.trailing != null) action.trailing!,
      ],
    );
  }
}

/// An action item for [ArcaneActionSheet].
class ActionSheetItem {
  /// Label text
  final String label;

  /// Optional icon (emoji or icon code)
  final String? icon;

  /// Whether this is a destructive action
  final bool destructive;

  /// Whether the action is disabled
  final bool disabled;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Whether to close sheet on tap
  final bool closeOnTap;

  /// Optional trailing widget
  final Component? trailing;

  const ActionSheetItem({
    required this.label,
    this.icon,
    this.destructive = false,
    this.disabled = false,
    this.onTap,
    this.closeOnTap = true,
    this.trailing,
  });
}