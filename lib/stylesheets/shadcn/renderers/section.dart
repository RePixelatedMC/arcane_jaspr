import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/section_props.dart';

/// ShadCN Section renderer.
class ShadcnSection extends StatelessComponent {
  final SectionProps props;

  const ShadcnSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveGap = props.gap ?? '0.75rem';

    final Component? headerWidget = props.headerComponent ??
        (props.header != null
            ? dom.div(
                classes: 'arcane-section-header',
                styles: dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--muted-foreground)',
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'margin-bottom': effectiveGap,
                }),
                [Component.text(props.header!)],
              )
            : null);

    final Component? dividerWidget = props.showDivider && headerWidget != null
        ? dom.div(
            classes: 'arcane-section-divider',
            styles: dom.Styles(raw: {
              'height': '1px',
              'background-color': 'var(--border)',
              'margin-bottom': effectiveGap,
            }),
            [],
          )
        : null;

    final Component content = dom.div(
      classes: 'arcane-section-content',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': effectiveGap,
      }),
      props.children,
    );

    final List<Component> sectionChildren = <Component>[
      if (headerWidget != null) headerWidget,
      if (dividerWidget != null) dividerWidget,
      content,
    ];

    if (props.card) {
      return dom.div(
        classes: 'arcane-section arcane-section-card',
        styles: dom.Styles(raw: {
          'padding': props.padding ?? '1rem',
          'background-color': 'var(--card)',
          'border-radius': 'var(--radius)',
          'border': '1px solid var(--border)',
        }),
        sectionChildren,
      );
    }

    return dom.div(
      classes: 'arcane-section',
      styles: dom.Styles(raw: {
        'padding': props.padding ?? '1rem',
      }),
      sectionChildren,
    );
  }
}
