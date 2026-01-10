import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/section_header_props.dart';

/// Renders a Codex section header with label, heading, and description.
Component renderSectionHeader(SectionHeaderProps props) {
  final textAlign = _getTextAlign(props.align);
  final effectiveDescriptionMaxWidth = props.descriptionMaxWidth ?? '680px';
  final effectiveMarginBottom = props.marginBottom ?? '4rem';

  return dom.div(
    styles: dom.Styles(raw: {
      'text-align': textAlign,
      'margin-bottom': effectiveMarginBottom,
    }),
    [
      // Label
      if (props.label != null)
        dom.span(
          styles: dom.Styles(raw: {
            'display': 'inline-block',
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-medium)',
            'color': props.labelColor ?? 'var(--primary)',
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
            'margin-bottom': '1.25rem',
          }),
          [Component.text(props.label!)],
        ),
      // Heading
      dom.h2(
        styles: dom.Styles(raw: {
          'font-family': 'ui-sans-serif, system-ui, sans-serif',
          'font-size': '2.5rem',
          'font-weight': 'var(--font-weight-bold)',
          'color': props.headingColor ?? 'var(--foreground)',
          'margin': '0 0 1.25rem 0',
          'line-height': '1.2',
        }),
        [Component.text(props.heading)],
      ),
      // Description
      if (props.description != null)
        dom.p(
          styles: dom.Styles(raw: {
            'font-size': 'var(--font-size-xl)',
            'color': props.descriptionColor ?? 'var(--muted-foreground)',
            'max-width': effectiveDescriptionMaxWidth,
            'margin':
                props.align == SectionHeaderAlign.center ? '0 auto' : '0',
            'line-height': '1.6',
          }),
          [Component.text(props.description!)],
        ),
    ],
  );
}

String _getTextAlign(SectionHeaderAlign align) {
  switch (align) {
    case SectionHeaderAlign.left:
      return 'left';
    case SectionHeaderAlign.center:
      return 'center';
    case SectionHeaderAlign.right:
      return 'right';
  }
}
