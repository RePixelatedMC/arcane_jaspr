import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/flow_props.dart';
import '../../../util/arcane.dart';

/// Renders a flow layout component.
Component renderFlow(FlowProps props) {
  return dom.div(
    classes: 'arcane-flow',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'flex-direction': props.reverse ? 'row-reverse' : 'row',
      'justify-content': props.mainAxisAlignment.css,
      'align-items': props.crossAxisAlignment.css,
      'align-content': props.wrapAlignment.css,
      'gap': '${props.rowGap ?? props.gap}px ${props.columnGap ?? props.gap}px',
    }),
    props.children,
  );
}

/// Renders a row layout component.
Component renderRow(RowProps props) {
  return dom.div(
    classes: 'arcane-row',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'row',
      'justify-content': props.mainAxisAlignment.css,
      'align-items': props.crossAxisAlignment.css,
      if (props.mainAxisSize == MainAxisSize.max) 'width': '100%',
      if (props.gap > 0) 'gap': '${props.gap}px',
    }),
    props.children,
  );
}

/// Renders a column layout component.
Component renderColumn(ColumnProps props) {
  return dom.div(
    classes: 'arcane-column',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': props.mainAxisAlignment.css,
      'align-items': props.crossAxisAlignment.css,
      if (props.mainAxisSize == MainAxisSize.max) 'height': '100%',
      if (props.gap > 0) 'gap': '${props.gap}px',
    }),
    props.children,
  );
}

/// Renders a center alignment component.
Component renderCenter(CenterProps props) {
  return dom.div(
    classes: 'arcane-center',
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'justify-content': 'center',
      'align-items': 'center',
      'width': '100%',
      'height': '100%',
    }),
    [props.child],
  );
}

/// Renders a spacer component.
Component renderSpacer(SpacerProps props) {
  return dom.div(
    classes: 'arcane-spacer',
    styles: dom.Styles(raw: {
      'flex': '${props.flex}',
    }),
    [],
  );
}

/// Renders an expanded component.
Component renderExpanded(ExpandedProps props) {
  return dom.div(
    classes: 'arcane-expanded',
    styles: dom.Styles(raw: {
      'flex': '${props.flex}',
      'min-width': '0',
      'min-height': '0',
    }),
    [props.child],
  );
}

/// Renders a sized box component.
Component renderSizedBox(SizedBoxProps props) {
  final bool isExpand = props.width == double.infinity || props.height == double.infinity;

  return dom.div(
    classes: 'arcane-sized-box',
    styles: dom.Styles(raw: {
      if (props.width != null && !isExpand) 'width': '${props.width}px',
      if (props.height != null && !isExpand) 'height': '${props.height}px',
      if (props.width == double.infinity) 'width': '100%',
      if (props.height == double.infinity) 'height': '100%',
      'flex-shrink': '0',
    }),
    props.child != null ? [props.child!] : [],
  );
}

/// Renders a padding wrapper component.
Component renderPaddingWrapper(PaddingWrapperProps props) {
  return dom.div(
    classes: 'arcane-padding',
    styles: dom.Styles(raw: {
      'padding': props.padding.padding,
    }),
    [props.child],
  );
}
