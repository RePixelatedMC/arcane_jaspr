import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/carpet_props.dart';

/// Renders a carpet/background container.
Component renderCarpet(CarpetProps props) {
  final String effectiveRadius = props.radius != null ? '${props.radius}px' : '0.375rem';
  final String effectivePadding = props.padding?.padding ?? '16px';

  return dom.div(
    classes: 'arcane-carpet',
    styles: dom.Styles(raw: {
      'background-color': props.color ?? 'var(--muted)',
      'border-radius': effectiveRadius,
      'padding': effectivePadding,
      if (props.border) 'border': '1px solid var(--border)',
    }),
    [props.child],
  );
}

/// Renders a surface component with elevation.
Component renderSurface(SurfaceProps props) {
  final String effectiveRadius = props.radius != null ? '${props.radius}px' : '0.375rem';

  // Generate shadow based on elevation
  String boxShadow;
  switch (props.elevation) {
    case 0:
      boxShadow = 'none';
      break;
    case 1:
      boxShadow = '0 1px 2px 0 hsl(0 0% 0% / 0.05)';
      break;
    case 2:
      boxShadow = '0 1px 3px 0 hsl(0 0% 0% / 0.1), 0 1px 2px -1px hsl(0 0% 0% / 0.1)';
      break;
    case 3:
      boxShadow = '0 4px 6px -1px hsl(0 0% 0% / 0.1), 0 2px 4px -2px hsl(0 0% 0% / 0.1)';
      break;
    case 4:
      boxShadow = '0 10px 15px -3px hsl(0 0% 0% / 0.1), 0 4px 6px -4px hsl(0 0% 0% / 0.1)';
      break;
    default:
      boxShadow = '0 20px 25px -5px hsl(0 0% 0% / 0.1), 0 8px 10px -6px hsl(0 0% 0% / 0.1)';
  }

  return dom.div(
    classes: 'arcane-surface',
    styles: dom.Styles(raw: {
      'background-color': props.color ?? 'var(--card)',
      'border-radius': effectiveRadius,
      if (props.padding != null) 'padding': props.padding!.padding,
      if (props.border) 'border': '1px solid var(--border)',
      'box-shadow': boxShadow,
    }),
    [props.child],
  );
}

/// Renders a divider component.
Component renderArcaneDivider(ArcaneDividerProps props) {
  if (props.vertical) {
    return dom.div(
      classes: 'arcane-divider-vertical',
      styles: dom.Styles(raw: {
        'width': '${props.thickness ?? 1}px',
        'background-color': props.color ?? 'var(--border)',
        'align-self': 'stretch',
        if (props.indent != null) 'margin-top': '${props.indent}px',
        if (props.endIndent != null) 'margin-bottom': '${props.endIndent}px',
      }),
      [],
    );
  } else {
    return dom.div(
      classes: 'arcane-divider',
      styles: dom.Styles(raw: {
        'height': '${props.thickness ?? 1}px',
        'background-color': props.color ?? 'var(--border)',
        'width': '100%',
        if (props.indent != null) 'margin-left': '${props.indent}px',
        if (props.endIndent != null) 'margin-right': '${props.endIndent}px',
      }),
      [],
    );
  }
}
