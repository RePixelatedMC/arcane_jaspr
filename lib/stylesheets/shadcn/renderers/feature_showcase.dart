import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/renderers.dart';
import '../../../component/card/flexi_cards.dart';

/// ShadCN Feature Showcase renderer.
class ShadcnFeatureShowcase extends StatelessComponent {
  final FeatureShowcaseProps props;

  const ShadcnFeatureShowcase(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.section(
      classes: 'arcane-feature-showcase',
      styles: dom.Styles(raw: {
        'padding': '3rem 1.5rem',
        if (props.background != null) 'background': props.background!,
      }),
      [
        dom.div(
          classes: 'arcane-feature-showcase-container',
          styles: const dom.Styles(raw: {
            'max-width': '1200px',
            'margin': '0 auto',
          }),
          [
            // Header
            dom.div(
              classes: 'arcane-feature-showcase-header',
              styles: dom.Styles(raw: {
                if (props.centerHeader) 'text-align': 'center',
                'margin-bottom': '3rem',
              }),
              [
                // Title
                dom.h2(
                  classes: 'arcane-feature-showcase-title',
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-2xl)',
                    'font-weight': 'var(--arcane-font-weight-bold)',
                    'color': 'var(--foreground)',
                    'margin': '0 0 1rem 0',
                  }),
                  [Component.text(props.title)],
                ),

                // Subtitle
                if (props.subtitle != null)
                  dom.p(
                    classes: 'arcane-feature-showcase-subtitle',
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--arcane-font-size-lg)',
                      'color': 'var(--muted-foreground)',
                      'margin': '0',
                      'max-width': '600px',
                      if (props.centerHeader) 'margin-left': 'auto',
                      if (props.centerHeader) 'margin-right': 'auto',
                    }),
                    [Component.text(props.subtitle!)],
                  ),
              ],
            ),

            // FlexiCards
            ArcaneFlexiCards(
              expandedFlex: props.expandedFlex,
              collapsedFlex: props.collapsedFlex,
              gap: props.gap,
              minCardWidth: props.minCardWidth,
              expandLongTextOnHover: props.expandOnHover,
              items: props.items
                  .map((item) => FlexiCardItem(
                        icon: item.icon,
                        shortText: item.title,
                        longText: item.description,
                        header: item.header,
                        footer: item.footer,
                        onTap: item.onTap,
                        href: item.href,
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
