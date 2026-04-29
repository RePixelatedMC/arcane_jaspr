import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/floating_props.dart';

/// Neubrutalism Floating renderer.
///
/// Unified component for tooltip, popover, and hovercard patterns.
/// Implements the Neubrutalism design language with subtle glow effects.
class NeubrutalismFloating extends StatelessComponent {
  final FloatingProps props;

  const NeubrutalismFloating(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Simple text tooltip uses CSS :hover (no JS needed)
    if (props.isTextTooltip && props.triggerType == FloatingTrigger.hover) {
      return _buildCssTooltip();
    }

    // Rich content uses state-based rendering
    return _buildStatefulFloating();
  }

  Component _buildCssTooltip() {
    return dom.div(
      classes: 'neubrutalism-floating-trigger',
      attributes: {
        'data-tooltip': props.textContent ?? '',
        'data-tooltip-position': props.position.name,
      },
      styles: const dom.Styles(
        raw: {'position': 'relative', 'display': 'inline-flex'},
      ),
      [
        props.trigger,
        dom.div(
          classes:
              'neubrutalism-floating neubrutalism-floating-tooltip neubrutalism-tooltip',
          attributes: {'role': 'tooltip'},
          styles: dom.Styles(
            raw: {
              'position': 'absolute',
              'z-index': '50',
              'padding': '6px 10px',
              'max-width': '${props.maxWidth ?? 250}px',
              'font-family': 'var(--font-body)',
              'font-size': 'var(--arcane-font-size-sm)',
              'font-weight': '600',
              'line-height': '1.4',
              'background': 'var(--nb-ink, #000)',
              'color': 'var(--nb-paper, #fff)',
              'border':
                  'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
              'border-radius': '0',
              'box-shadow':
                  'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
              'overflow': 'hidden',
              'white-space': 'nowrap',
              'pointer-events': 'none',
              'opacity': '0',
              'visibility': 'hidden',
              'transition':
                  'opacity 0.15s ease, visibility 0.15s ease, transform 0.15s ease',
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

    final Map<String, String> triggerWrapperAttrs = <String, String>{
      'data-arcane-anchor-id': anchorId,
      if (useClickEvents) 'data-arcane-action': 'surface.toggle:$surfaceId',
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
      classes: 'neubrutalism-floating-container',
      styles: const dom.Styles(
        raw: {'position': 'relative', 'display': 'inline-block'},
      ),
      events: <String, EventCallback>{
        if (useHoverEvents) 'mouseenter': (_) => props.onMouseEnter?.call(),
        if (useHoverEvents) 'mouseleave': (_) => props.onMouseLeave?.call(),
      },
      [
        // Trigger wrapper
        dom.div(
          attributes: triggerWrapperAttrs,
          styles: const dom.Styles(raw: {'display': 'inline-block'}),
          events: <String, EventCallback>{
            if (useClickEvents) 'click': (_) => props.onToggle?.call(),
          },
          [props.trigger],
        ),

        // Floating content
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
      classes: hasRichContent
          ? 'neubrutalism-floating-content neubrutalism-popover'
          : 'neubrutalism-floating-content neubrutalism-tooltip',
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
          if (hasRichContent) 'min-width': '220px',
          'padding': hasRichContent ? '14px 16px' : '6px 10px',
          'background': hasRichContent
              ? 'var(--nb-paper, var(--card))'
              : 'var(--nb-ink, #000)',
          'color': hasRichContent
              ? 'var(--nb-ink, var(--popover-foreground))'
              : 'var(--nb-paper, #fff)',
          'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
          'border-radius': '0',
          'box-shadow': hasRichContent
              ? 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))'
              : 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
          'outline': 'none',
        },
      ),
      [
        if (props.showArrow) _buildArrow(),
        if (props.content != null)
          props.content!
        else if (props.textContent != null)
          Component.text(props.textContent!),
      ],
    );
  }

  Component _buildArrow() {
    return dom.div(
      classes: 'neubrutalism-floating-arrow',
      styles: dom.Styles(
        raw: {
          'position': 'absolute',
          'width': '10px',
          'height': '10px',
          'background': 'transparent',
          'border-left':
              'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'border-top': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
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
    return 'neubrutalism-floating-$_autoCounter';
  }
}
