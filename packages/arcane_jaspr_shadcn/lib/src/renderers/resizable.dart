import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/resizable_props.dart';

/// Renders a resizable panel group component.
Component renderResizable(ResizableProps props) {
  final isHorizontal = props.direction == ResizeDirection.horizontal;

  return dom.div(
    classes: 'arcane-resizable ${isHorizontal ? 'horizontal' : 'vertical'}',
    attributes: {
      'data-resizable': 'true',
      'data-direction': isHorizontal ? 'horizontal' : 'vertical',
    },
    styles: dom.Styles(
      raw: {
        'display': 'flex',
        'flex-direction': isHorizontal ? 'row' : 'column',
        'width': '100%',
        'height': '100%',
        'overflow': 'hidden',
      },
    ),
    [
      for (var i = 0; i < props.panels.length; i++) ...[
        _buildPanel(props.panels[i], isHorizontal, i),
        if (i < props.panels.length - 1)
          _buildHandle(isHorizontal, i, props.showGrip),
      ],
    ],
  );
}

Component _buildPanel(ResizablePanelData panel, bool isHorizontal, int index) {
  final flexBasis = panel.defaultSize != null
      ? '${panel.defaultSize}%'
      : 'auto';

  return dom.div(
    classes: 'arcane-resizable-panel ${panel.collapsible ? 'collapsible' : ''}',
    attributes: {
      'data-panel-index': '$index',
      if (panel.minSize != null) 'data-min-size': '${panel.minSize}',
      if (panel.maxSize != null) 'data-max-size': '${panel.maxSize}',
      if (panel.collapsible) 'data-collapsible': 'true',
    },
    styles: dom.Styles(
      raw: {
        'flex': panel.defaultSize != null ? '0 0 $flexBasis' : '1 1 auto',
        'min-width': isHorizontal
            ? (panel.minSize != null ? '${panel.minSize}%' : '0')
            : 'auto',
        'min-height': !isHorizontal
            ? (panel.minSize != null ? '${panel.minSize}%' : '0')
            : 'auto',
        'max-width': isHorizontal
            ? (panel.maxSize != null ? '${panel.maxSize}%' : 'none')
            : 'auto',
        'max-height': !isHorizontal
            ? (panel.maxSize != null ? '${panel.maxSize}%' : 'none')
            : 'auto',
        'overflow': 'auto',
      },
    ),
    [panel.child],
  );
}

Component _buildHandle(bool isHorizontal, int index, bool showGrip) {
  return dom.div(
    classes: 'arcane-resizable-handle',
    attributes: {
      'data-handle-index': '$index',
      'role': 'separator',
      'aria-orientation': isHorizontal ? 'vertical' : 'horizontal',
      'aria-valuenow': '50',
      'tabindex': '0',
    },
    styles: dom.Styles(
      raw: {
        'position': 'relative',
        'flex': '0 0 1px',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'background-color': 'var(--border)',
        'cursor': isHorizontal ? 'col-resize' : 'row-resize',
        'outline': 'none',
        'transition': 'background-color var(--transition)',
        'z-index': '10',
      },
    ),
    [
      if (showGrip)
        dom.div(
          classes: 'arcane-resizable-grip',
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'z-index': '10',
              'border-radius': 'var(--radius-xs)',
              'border': '1px solid var(--border)',
              'background-color': 'var(--border)',
              'width': isHorizontal ? '12px' : '16px',
              'height': isHorizontal ? '16px' : '12px',
            },
          ),
          [
            dom.div(
              styles: dom.Styles(
                raw: {
                  'display': 'flex',
                  'flex-direction': isHorizontal ? 'column' : 'row',
                  'gap': '1px',
                },
              ),
              [
                for (var i = 0; i < 3; i++)
                  const dom.div(
                    styles: dom.Styles(
                      raw: {
                        'width': '2px',
                        'height': '2px',
                        'border-radius': '50%',
                        'background-color': 'var(--muted-foreground)',
                      },
                    ),
                    [],
                  ),
              ],
            ),
          ],
        ),
    ],
  );
}
