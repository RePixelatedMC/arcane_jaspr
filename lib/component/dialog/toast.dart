import 'dart:async';

import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import 'toast_manager.dart';

export '../../core/props/toast_props.dart' show ToastVariant, ToastPosition, ToastAction;
export 'toast_manager.dart';

/// A toast notification component matching shadcn/ui Sonner.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/toast
///
/// Can be used standalone or with the global [toast] API.
///
/// ## Standalone Usage
/// ```dart
/// ArcaneToast(
///   message: 'Changes saved!',
///   variant: ToastVariant.success,
///   position: ToastPosition.bottomRight,
/// )
/// ```
///
/// ## Global API Usage
/// ```dart
/// // Add ArcaneToast.container() once at app root
/// toast.success('Saved!');
/// toast.error('Failed!');
/// toast.warning('Check input');
/// toast.info('New update');
/// toast.loading('Processing...');
/// ```
class ArcaneToast extends StatefulComponent {
  /// Toast message (required)
  final String message;

  /// Optional title displayed above message
  final String? title;

  /// Optional description displayed below message
  final String? description;

  /// Toast variant (info, success, warning, error, loading)
  final ToastVariant variant;

  /// Screen position
  final ToastPosition position;

  /// Auto-dismiss duration in milliseconds (0 = no auto-dismiss)
  final int duration;

  /// Whether the toast can be dismissed by clicking close
  final bool dismissible;

  /// Optional action button
  final ToastAction? action;

  /// Custom icon (overrides default variant icon)
  final Component? icon;

  /// Callback when toast is closed
  final void Function()? onClose;

  /// Unique ID for this toast (used by toast manager)
  final String? id;

  const ArcaneToast({
    required this.message,
    this.title,
    this.description,
    this.variant = ToastVariant.info,
    this.position = ToastPosition.bottomRight,
    this.duration = 4000,
    this.dismissible = true,
    this.action,
    this.icon,
    this.onClose,
    this.id,
    super.key,
  });

  /// Creates a toast container for the global toast API.
  /// Place this once at your app root.
  static Component container({
    ToastPosition position = ToastPosition.bottomRight,
    int maxVisible = 3,
    double gap = 12,
    double offset = 20,
    Key? key,
  }) {
    return _ToastContainer(
      position: position,
      maxVisible: maxVisible,
      gap: gap,
      offset: offset,
      key: key,
    );
  }

  @override
  State<ArcaneToast> createState() => _ArcaneToastState();
}

class _ArcaneToastState extends State<ArcaneToast> {
  bool _isExiting = false;
  bool _isHovered = false;
  Timer? _dismissTimer;
  Timer? _exitTimer;

  @override
  void initState() {
    super.initState();
    _scheduleDismissTimer();
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }

  void _cancelTimers() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _exitTimer?.cancel();
    _exitTimer = null;
  }

  void _scheduleDismissTimer() {
    _dismissTimer?.cancel();
    if (component.duration > 0 && !_isHovered) {
      _dismissTimer = Timer(
        Duration(milliseconds: component.duration),
        () {
          if (mounted && !_isHovered) {
            _startExitAnimation();
          }
        },
      );
    }
  }

  void _startExitAnimation() {
    if (_isExiting) return;
    setState(() => _isExiting = true);

    _exitTimer = Timer(
      const Duration(milliseconds: 200),
      () {
        if (mounted) {
          component.onClose?.call();
        }
      },
    );
  }

  void _onMouseEnter() {
    setState(() => _isHovered = true);
    _dismissTimer?.cancel();
    _dismissTimer = null;
  }

  void _onMouseLeave() {
    setState(() => _isHovered = false);
    _scheduleDismissTimer();
  }

  void _onDismissClick() {
    _startExitAnimation();
  }

  @override
  Component build(BuildContext context) {
    // Delegate rendering to the current stylesheet's toast renderer
    return context.renderers.toast(ToastProps(
      message: component.message,
      title: component.title,
      description: component.description,
      variant: component.variant,
      position: component.position,
      duration: component.duration,
      dismissible: component.dismissible,
      action: component.action,
      icon: component.icon,
      id: component.id,
      isExiting: _isExiting,
      isHovered: _isHovered,
      onMouseEnter: _onMouseEnter,
      onMouseLeave: _onMouseLeave,
      onDismiss: _onDismissClick,
    ));
  }
}

// =============================================================================
// Toast Container (renders active toasts)
// =============================================================================

/// Toast container component - renders all active toasts
class _ToastContainer extends StatefulComponent {
  final ToastPosition position;
  final int maxVisible;
  final double gap;
  final double offset;

  const _ToastContainer({
    this.position = ToastPosition.bottomRight,
    this.maxVisible = 3,
    this.gap = 12,
    this.offset = 20,
    super.key,
  });

  @override
  State<_ToastContainer> createState() => _ToastContainerState();
}

class _ToastContainerState extends State<_ToastContainer> {
  @override
  void initState() {
    super.initState();
    ToastManager.instance.setDefaultPosition(component.position);
    ToastManager.instance.addListener(_onToastsChanged);
  }

  @override
  void dispose() {
    ToastManager.instance.removeListener(_onToastsChanged);
    super.dispose();
  }

  void _onToastsChanged() {
    setState(() {});
  }

  @override
  Component build(BuildContext context) {
    final toasts = ToastManager.instance.toasts.take(component.maxVisible);

    // Build ToastProps from ToastData
    final toastPropsList = toasts.map((data) => ToastProps(
      message: data.message,
      title: data.title,
      description: data.description,
      variant: data.variant,
      position: data.position,
      duration: data.duration,
      dismissible: data.dismissible,
      action: data.action,
      icon: data.icon,
      id: data.id,
    )).toList();

    // We still render individual ArcaneToast components for state management
    // The container just positions them
    return context.renderers.toastContainer(ToastContainerProps(
      position: component.position,
      maxVisible: component.maxVisible,
      gap: component.gap,
      offset: component.offset,
      toasts: toastPropsList,
    ));
  }
}

/// Short alias for ArcaneToast
typedef AToast = ArcaneToast;
