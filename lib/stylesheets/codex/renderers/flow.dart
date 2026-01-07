import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/flow_props.dart';
import '../../../core/props/gutter_props.dart';
import '../../../util/arcane.dart';

/// Codex Row renderer.
class CodexRow extends StatelessComponent {
  final RowProps props;

  const CodexRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-row',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'row',
        'align-items': _crossAlign(props.crossAxisAlignment),
        'justify-content': _mainAlign(props.mainAxisAlignment),
        if (props.mainAxisSize == MainAxisSize.min) 'width': 'fit-content',
        if (props.gap > 0) 'gap': '${props.gap}px',
      }),
      props.children,
    );
  }
}

/// Codex Column renderer.
class CodexColumn extends StatelessComponent {
  final ColumnProps props;

  const CodexColumn(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-column',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': _crossAlign(props.crossAxisAlignment),
        'justify-content': _mainAlign(props.mainAxisAlignment),
        if (props.mainAxisSize == MainAxisSize.min) 'height': 'fit-content',
        if (props.gap > 0) 'gap': '${props.gap}px',
      }),
      props.children,
    );
  }
}

/// Codex Center renderer.
class CodexCenter extends StatelessComponent {
  final CenterProps props;

  const CodexCenter(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-center',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '100%',
        'height': '100%',
      }),
      [props.child],
    );
  }
}

/// Codex Spacer renderer.
class CodexSpacer extends StatelessComponent {
  final SpacerProps props;

  const CodexSpacer(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-spacer',
      styles: dom.Styles(raw: {
        'flex': '${props.flex}',
      }),
      [],
    );
  }
}

/// Codex Expanded renderer.
class CodexExpanded extends StatelessComponent {
  final ExpandedProps props;

  const CodexExpanded(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-expanded',
      styles: dom.Styles(raw: {
        'flex': '${props.flex}',
        'min-width': '0',
        'min-height': '0',
      }),
      [props.child],
    );
  }
}

/// Codex SizedBox renderer.
class CodexSizedBox extends StatelessComponent {
  final SizedBoxProps props;

  const CodexSizedBox(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-sized-box',
      styles: dom.Styles(raw: {
        if (props.width != null) 'width': '${props.width}px',
        if (props.height != null) 'height': '${props.height}px',
        'flex-shrink': '0',
      }),
      props.child != null ? [props.child!] : [],
    );
  }
}

/// Codex Flow (wrap) renderer.
class CodexFlow extends StatelessComponent {
  final FlowProps props;

  const CodexFlow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-flow',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'flex-direction': props.reverse ? 'row-reverse' : 'row',
        'align-items': _crossAlign(props.crossAxisAlignment),
        'justify-content': _mainAlign(props.mainAxisAlignment),
        'align-content': _wrapAlign(props.wrapAlignment),
        'gap': '${props.rowGap ?? props.gap}px ${props.columnGap ?? props.gap}px',
      }),
      props.children,
    );
  }
}

/// Codex Gap renderer.
class CodexGap extends StatelessComponent {
  final GapProps props;

  const CodexGap(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-gap',
      styles: dom.Styles(raw: {
        if (props.horizontal) 'width': '${props.size}px' else 'height': '${props.size}px',
        'flex-shrink': '0',
      }),
      [],
    );
  }
}

/// Codex PaddingWrapper renderer.
class CodexPaddingWrapper extends StatelessComponent {
  final PaddingWrapperProps props;

  const CodexPaddingWrapper(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-padding-wrapper',
      styles: dom.Styles(raw: {
        'padding': '${props.padding.top}px ${props.padding.right}px ${props.padding.bottom}px ${props.padding.left}px',
      }),
      [props.child],
    );
  }
}

// Helper functions
String _mainAlign(MainAxisAlignment alignment) {
  return switch (alignment) {
    MainAxisAlignment.start => 'flex-start',
    MainAxisAlignment.end => 'flex-end',
    MainAxisAlignment.center => 'center',
    MainAxisAlignment.spaceBetween => 'space-between',
    MainAxisAlignment.spaceAround => 'space-around',
    MainAxisAlignment.spaceEvenly => 'space-evenly',
  };
}

String _crossAlign(CrossAxisAlignment alignment) {
  return switch (alignment) {
    CrossAxisAlignment.start => 'flex-start',
    CrossAxisAlignment.end => 'flex-end',
    CrossAxisAlignment.center => 'center',
    CrossAxisAlignment.stretch => 'stretch',
    CrossAxisAlignment.baseline => 'baseline',
  };
}

String _wrapAlign(WrapAlignment alignment) {
  return switch (alignment) {
    WrapAlignment.start => 'flex-start',
    WrapAlignment.end => 'flex-end',
    WrapAlignment.center => 'center',
    WrapAlignment.spaceBetween => 'space-between',
    WrapAlignment.spaceAround => 'space-around',
    WrapAlignment.spaceEvenly => 'space-evenly',
  };
}
