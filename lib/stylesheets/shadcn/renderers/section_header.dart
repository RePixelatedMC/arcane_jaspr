import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/section_header_props.dart';

/// Renders a section header with label, heading, and description.
Component renderSectionHeader(SectionHeaderProps props) {
  final textAlign = _getTextAlign(props.align);
  final effectiveDescriptionMaxWidth = props.descriptionMaxWidth ?? '640px';
  final effectiveMarginBottom = props.marginBottom ?? '3rem';

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
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': props.labelColor ?? 'var(--accent)',
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
            'margin-bottom': '1rem',
          }),
          [Component.text(props.label!)],
        ),
      // Heading
      dom.h2(
        styles: dom.Styles(raw: {
          'font-family': 'ui-sans-serif, system-ui, sans-serif',
          'font-size': 'var(--arcane-font-size-4xl)',
          'font-weight': 'var(--arcane-font-weight-bold)',
          'color': props.headingColor ?? 'var(--foreground)',
          'margin': '0 0 1rem 0',
          'line-height': '1.2',
        }),
        [Component.text(props.heading)],
      ),
      // Description
      if (props.description != null)
        dom.p(
          styles: dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-lg)',
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
