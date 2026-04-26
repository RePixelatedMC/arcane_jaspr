import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

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
    final isOpen = props.isOpen ?? false;
    final useHoverEvents = props.triggerType == FloatingTrigger.hover;
    final useClickEvents = props.triggerType == FloatingTrigger.click;

    return dom.div(
      classes: 'arcane-floating-container',
      styles: const dom.Styles(
        raw: {'position': 'relative', 'display': 'inline-block'},
      ),
      events: useHoverEvents
          ? {
              'mouseenter': (_) => props.onMouseEnter?.call(),
              'mouseleave': (_) => props.onMouseLeave?.call(),
            }
          : null,
      [
        // Trigger wrapper
        if (useClickEvents)
          dom.div(
            styles: const dom.Styles(raw: {'display': 'inline-block'}),
            events: {'click': (_) => props.onToggle?.call()},
            [props.trigger],
          )
        else
          props.trigger,

        // Floating content
        if (isOpen) _buildFloatingContent(),
      ],
    );
  }

  Component _buildFloatingContent() {
    final (positionProp, positionValue, alignment) =
        _getPositionStylesForPanel();
    final hasRichContent = props.content != null;
    final maxWidth = props.maxWidth;

    return dom.div(
      classes: 'arcane-floating-content',
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
    final offsetPx = '${props.offset}px';

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
}
