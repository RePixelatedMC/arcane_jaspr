import 'dart:async';

import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/hovercard_props.dart'
    show HovercardPositionVariant, HovercardProps;

/// Hovercard position relative to the trigger element
enum HovercardPosition {
  /// Above the trigger, centered
  top,

  /// Below the trigger, centered
  bottom,

  /// To the left of the trigger
  left,

  /// To the right of the trigger
  right,

  /// Above and aligned to the start (left in LTR)
  topStart,

  /// Above and aligned to the end (right in LTR)
  topEnd,

  /// Below and aligned to the start
  bottomStart,

  /// Below and aligned to the end
  bottomEnd,
}

/// A floating card that appears on hover with rich, interactive content.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/hover-card
///
/// Unlike tooltips, hovercards can contain interactive elements like buttons
/// and links. The card stays open while the user hovers over either the
/// trigger or the card itself.
///
/// ```dart
/// ArcaneHovercard(
///   trigger: ArcaneAvatar(name: 'John Doe'),
///   content: UserProfileCard(user: user),
///   position: HovercardPosition.bottom,
///   openDelay: 200,
///   closeDelay: 300,
/// )
/// ```
class ArcaneHovercard extends StatefulComponent {
  /// The element that triggers the hovercard on hover
  final Component trigger;

  /// The content displayed inside the hovercard
  final Component content;

  /// Position of the hovercard relative to the trigger
  final HovercardPosition position;

  /// Whether to show an arrow pointing to the trigger
  final bool showArrow;

  /// Delay in milliseconds before showing the hovercard
  final int openDelay;

  /// Delay in milliseconds before hiding the hovercard
  final int closeDelay;

  /// Distance in pixels between the trigger and the hovercard
  final int offset;

  /// External control of the open state (optional)
  final bool? isOpen;

  /// Callback when the open state changes
  final void Function(bool isOpen)? onOpenChange;

  const ArcaneHovercard({
    required this.trigger,
    required this.content,
    this.position = HovercardPosition.top,
    this.showArrow = true,
    this.openDelay = 200,
    this.closeDelay = 300,
    this.offset = 8,
    this.isOpen,
    this.onOpenChange,
    super.key,
  });

  @override
  State<ArcaneHovercard> createState() => _ArcaneHovercardState();
}

class _ArcaneHovercardState extends State<ArcaneHovercard> {
  bool _internalIsOpen = false;
  Timer? _openTimer;
  Timer? _closeTimer;

  bool get _isOpen => component.isOpen ?? _internalIsOpen;

  void _cancelTimers() {
    _openTimer?.cancel();
    _openTimer = null;
    _closeTimer?.cancel();
    _closeTimer = null;
  }

  void _startOpenTimer() {
    _cancelTimers();
    if (component.openDelay <= 0) {
      _open();
    } else {
      _openTimer = Timer(Duration(milliseconds: component.openDelay), _open);
    }
  }

  void _startCloseTimer() {
    _cancelTimers();
    if (component.closeDelay <= 0) {
      _close();
    } else {
      _closeTimer = Timer(Duration(milliseconds: component.closeDelay), _close);
    }
  }

  void _open() {
    if (!_isOpen) {
      if (component.isOpen == null) {
        setState(() => _internalIsOpen = true);
      }
      component.onOpenChange?.call(true);
    }
  }

  void _close() {
    if (_isOpen) {
      if (component.isOpen == null) {
        setState(() => _internalIsOpen = false);
      }
      component.onOpenChange?.call(false);
    }
  }

  void _handleMouseEnter() {
    _cancelTimers();
    _startOpenTimer();
  }

  void _handleMouseLeave() {
    _cancelTimers();
    _startCloseTimer();
  }

  HovercardPositionVariant get _propsPosition => switch (component.position) {
        HovercardPosition.top => HovercardPositionVariant.top,
        HovercardPosition.bottom => HovercardPositionVariant.bottom,
        HovercardPosition.left => HovercardPositionVariant.left,
        HovercardPosition.right => HovercardPositionVariant.right,
        HovercardPosition.topStart => HovercardPositionVariant.topStart,
        HovercardPosition.topEnd => HovercardPositionVariant.topEnd,
        HovercardPosition.bottomStart => HovercardPositionVariant.bottomStart,
        HovercardPosition.bottomEnd => HovercardPositionVariant.bottomEnd,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.hovercard(HovercardProps(
      trigger: component.trigger,
      content: component.content,
      position: _propsPosition,
      showArrow: component.showArrow,
      offset: component.offset,
      isOpen: _isOpen,
      onMouseEnter: _handleMouseEnter,
      onMouseLeave: _handleMouseLeave,
    ));
  }
}
