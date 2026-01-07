import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_panel_props.dart';

/// Renders a Codex button panel component.
Component renderCodexButtonPanel(ButtonPanelProps props) {
  final String effectivePadding = props.padding?.padding ?? '10px 0';

  return dom.div(
    classes: 'codex-button-panel',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'justify-content': props.mainAxisAlignment.css,
      'align-items': 'center',
      'gap': '${props.gap}px',
      'padding': effectivePadding,
    }),
    props.children,
  );
}

/// Renders a Codex toolbar component.
Component renderCodexToolbar(ToolbarProps props) {
  final String effectivePadding = props.padding?.padding ?? '6px 10px';

  return dom.div(
    classes: 'codex-toolbar',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'row',
      'justify-content': props.mainAxisAlignment.css,
      'align-items': props.crossAxisAlignment.css,
      'gap': '${props.gap}px',
      'padding': effectivePadding,
    }),
    props.children,
  );
}

/// Renders a Codex button group component.
Component renderCodexButtonGroup(ButtonGroupProps props) {
  return dom.div(
    classes: 'codex-button-group',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': props.vertical ? 'column' : 'row',
      if (props.gap > 0) 'gap': '${props.gap}px',
    }),
    props.children,
  );
}
