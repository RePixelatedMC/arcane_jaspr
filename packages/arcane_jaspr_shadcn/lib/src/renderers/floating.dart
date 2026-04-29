import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/floating_props.dart';

/// ShadCN Floating renderer.
///
/// Unified component for tooltip, popover, and hovercard patterns.
/// Handles text tooltips with CSS :hover, and rich content with state management.
///
/// Reference: https://ui.shadcn.com/docs/components/tooltip
/// Reference: https://ui.shadcn.com/docs/components/popover
/// Reference: https://ui.shadcn.com/docs/components/hover-card
class ShadcnFloating extends StatelessComponent {
  final FloatingProps props;

  const ShadcnFloating(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Simple text tooltip uses CSS :hover (no JS needed)
    if (props.isTextTooltip && props.triggerType == FloatingTrigger.hover) {
      return _buildCssTooltip();
    }

    // Rich content uses state-based rendering
    return _buildStatefulFloating();
  }

  /// Builds a CSS-only tooltip for simple text hints.
  Component _buildCssTooltip() {
    return dom.div(
      classes: 'arcane-floating-trigger',
      attributes: {
        'data-tooltip': props.textContent ?? '',
        'data-tooltip-position': props.position.name,
      },
      styles: const dom.Styles(
        raw: {'position': 'relative', 'display': 'inline-flex'},
      ),
      [
        props.trigger,
        // Tooltip content (CSS-controlled visibility)
        dom.div(
          classes: 'arcane-floating arcane-floating-tooltip',
          attributes: {'role': 'tooltip'},
          styles: dom.Styles(
            raw: {
              'position': 'absolute',
              'z-index': '50',
              'padding': '6px 12px',
              'max-width': '${props.maxWidth ?? 250}px',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'line-height': '1.4',
              'color': 'var(--popover-foreground)',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius-sm)',
              'box-shadow': 'var(--shadow-md)',
              'overflow': 'hidden',
              'white-space': 'nowrap',
              'pointer-events': 'none',
              'opacity': '0',
              'visibility': 'hidden',
              'transition':
                  'opacity var(--transition), visibility var(--transition), transform var(--transition)',
              ..._getPositionStyles(props.position),
            },
          ),
          [Component.text(props.textContent ?? '')],
        ),
      ],
    );
  }

  /// Builds a state-controlled floating panel for rich content.
  Component _buildStatefulFloating() {
    final bool isOpen = props.isOpen ?? false;
    final bool useHoverEvents = props.triggerType == FloatingTrigger.hover;
    final bool useClickEvents = props.triggerType == FloatingTrigger.click;
    final String surfaceId = props.id ?? _autoId();
    final String anchorId = '$surfaceId-trigger';
    final String surfaceKind = useHoverEvents ? 'hovercard' : 'popover';

    final String triggerAction = useClickEvents
        ? 'surface.toggle:$surfaceId'
        : 'surface.hoverOpen:$surfaceId';

    final Map<String, String> triggerWrapperAttrs = <String, String>{
      'data-arcane-anchor-id': anchorId,
      if (useClickEvents) 'data-arcane-action': triggerAction,
      if (useHoverEvents) ...<String, String>{
        'data-arcane-mouseenter': 'surface.hoverOpen:$surfaceId',
        'data-arcane-mouseleave': 'surface.hoverClose:$surfaceId',
      },
      if (useHoverEvents && props.openDelay > 0)
        'data-arcane-hover-open-delay': props.openDelay.toString(),
      if (useHoverEvents && props.closeDelay > 0)
        'data-arcane-hover-close-delay': props.closeDelay.toString(),
    };

    return dom.div(
      classes: 'arcane-floating-container',
      styles: const dom.Styles(
        raw: {'position': 'relative', 'display': 'inline-block'},
      ),
      events: <String, EventCallback>{
        if (useHoverEvents)
          'mouseenter': (_) => props.onMouseEnter?.call(),
        if (useHoverEvents)
          'mouseleave': (_) => props.onMouseLeave?.call(),
      },
      [
        dom.div(
          attributes: triggerWrapperAttrs,
          styles: const dom.Styles(raw: {'display': 'inline-block'}),
          events: <String, EventCallback>{
            if (useClickEvents) 'click': (_) => props.onToggle?.call(),
          },
          [props.trigger],
        ),

        _buildFloatingContent(
          surfaceId: surfaceId,
          anchorId: anchorId,
          surfaceKind: surfaceKind,
          initiallyOpen: isOpen,
        ),
      ],
    );
  }

  Component _buildFloatingContent({
    required String surfaceId,
    required String anchorId,
    required String surfaceKind,
    required bool initiallyOpen,
  }) {
    final (positionProp, positionValue, alignment) =
        _getPositionStylesForPanel();
    final bool hasRichContent = props.content != null;
    final double? maxWidth = props.maxWidth;

    final Map<String, String> surfAttrs = surfaceAttrs(
      surface: surfaceKind,
      id: surfaceId,
      initiallyOpen: initiallyOpen,
      dismissible: props.closeOnOutsideClick,
      escapeCloses: props.closeOnEscape,
      focusTrap: false,
      scrimCloses: false,
      restoreFocus: true,
      anchorId: anchorId,
      anchorPlacement: props.position.name,
      anchorOffset: props.offset.toString(),
    );

    return dom.div(
      classes: 'arcane-floating-content',
      attributes: <String, String>{
        'role': surfaceKind == 'hovercard' ? 'tooltip' : 'dialog',
        ...surfAttrs,
      },
      styles: dom.Styles(
        raw: {
          'position': 'absolute',
          positionProp: positionValue,
          ...alignment,
          'z-index': '50',
          if (maxWidth != null) 'max-width': '${maxWidth}px',
          if (hasRichContent) 'min-width': '180px',
          'background-color': 'var(--popover)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-sm)',
          'box-shadow': 'var(--shadow-md)',
          'padding': hasRichContent ? '16px' : '6px 12px',
          'color': 'var(--popover-foreground)',
          'outline': 'none',
        },
      ),
      [
        // Arrow (optional)
        if (props.showArrow) _buildArrow(),

        // Content
        if (props.content != null)
          props.content!
        else if (props.textContent != null)
          Component.text(props.textContent!),
      ],
    );
  }

  Component _buildArrow() {
    return dom.div(
      classes: 'arcane-floating-arrow',
      styles: dom.Styles(
        raw: {
          'position': 'absolute',
          'width': '12px',
          'height': '12px',
          'background-color': 'var(--popover)',
          'border-left': '1px solid var(--border)',
          'border-top': '1px solid var(--border)',
          ..._getArrowStyles(),
        },
      ),
      [],
    );
  }

  Map<String, String> _getPositionStyles(FloatingPosition position) {
    return switch (position) {
      FloatingPosition.top => {
        'bottom': '100%',
        'left': '50%',
        'transform': 'translateX(-50%) translateY(-4px)',
        'margin-bottom': '8px',
      },
      FloatingPosition.bottom => {
        'top': '100%',
        'left': '50%',
        'transform': 'translateX(-50%) translateY(4px)',
        'margin-top': '8px',
      },
      FloatingPosition.left => {
        'right': '100%',
        'top': '50%',
        'transform': 'translateY(-50%) translateX(-4px)',
        'margin-right': '8px',
      },
      FloatingPosition.right => {
        'left': '100%',
        'top': '50%',
        'transform': 'translateY(-50%) translateX(4px)',
        'margin-left': '8px',
      },
      FloatingPosition.topStart => {
        'bottom': '100%',
        'left': '0',
        'margin-bottom': '8px',
      },
      FloatingPosition.topEnd => {
        'bottom': '100%',
        'right': '0',
        'margin-bottom': '8px',
      },
      FloatingPosition.bottomStart => {
        'top': '100%',
        'left': '0',
        'margin-top': '8px',
      },
      FloatingPosition.bottomEnd => {
        'top': '100%',
        'right': '0',
        'margin-top': '8px',
      },
    };
  }

  (String, String, Map<String, String>) _getPositionStylesForPanel() {
    final String offsetPx = '${props.offset}px';

    return switch (props.position) {
      FloatingPosition.top => (
        'bottom',
        'calc(100% + $offsetPx)',
        {'left': '50%', 'transform': 'translateX(-50%)'},
      ),
      FloatingPosition.bottom => (
        'top',
        'calc(100% + $offsetPx)',
        {'left': '50%', 'transform': 'translateX(-50%)'},
      ),
      FloatingPosition.left => (
        'right',
        'calc(100% + $offsetPx)',
        {'top': '50%', 'transform': 'translateY(-50%)'},
      ),
      FloatingPosition.right => (
        'left',
        'calc(100% + $offsetPx)',
        {'top': '50%', 'transform': 'translateY(-50%)'},
      ),
      FloatingPosition.topStart => (
        'bottom',
        'calc(100% + $offsetPx)',
        {'left': '0'},
      ),
      FloatingPosition.topEnd => (
        'bottom',
        'calc(100% + $offsetPx)',
        {'right': '0'},
      ),
      FloatingPosition.bottomStart => (
        'top',
        'calc(100% + $offsetPx)',
        {'left': '0'},
      ),
      FloatingPosition.bottomEnd => (
        'top',
        'calc(100% + $offsetPx)',
        {'right': '0'},
      ),
    };
  }

  Map<String, String> _getArrowStyles() {
    return switch (props.position) {
      FloatingPosition.top ||
      FloatingPosition.topStart ||
      FloatingPosition.topEnd => {
        'bottom': '-6px',
        'left': '50%',
        'transform': 'translateX(-50%) rotate(225deg)',
      },
      FloatingPosition.bottom ||
      FloatingPosition.bottomStart ||
      FloatingPosition.bottomEnd => {
        'top': '-6px',
        'left': '50%',
        'transform': 'translateX(-50%) rotate(45deg)',
      },
      FloatingPosition.left => {
        'right': '-6px',
        'top': '50%',
        'transform': 'translateY(-50%) rotate(135deg)',
      },
      FloatingPosition.right => {
        'left': '-6px',
        'top': '50%',
        'transform': 'translateY(-50%) rotate(-45deg)',
      },
    };
  }

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'arcane-floating-$_autoCounter';
  }
}
