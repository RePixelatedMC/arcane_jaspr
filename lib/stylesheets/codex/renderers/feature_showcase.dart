import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/renderers.dart';
import '../../../component/card/flexi_cards.dart';

/// Codex Feature Showcase renderer.
class CodexFeatureShowcase extends StatelessComponent {
  final FeatureShowcaseProps props;

  const CodexFeatureShowcase(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.section(
      classes: 'codex-feature-showcase',
      styles: dom.Styles(raw: {
        'padding': '4rem 2rem',
        if (props.background != null) 'background': props.background!,
      }),
      [
        dom.div(
          classes: 'codex-feature-showcase-container',
          styles: const dom.Styles(raw: {
            'max-width': '1200px',
            'margin': '0 auto',
          }),
          [
            // Header
            dom.div(
              classes: 'codex-feature-showcase-header',
              styles: dom.Styles(raw: {
                if (props.centerHeader) 'text-align': 'center',
                'margin-bottom': '4rem',
              }),
              [
                // Title
                dom.h2(
                  classes: 'codex-feature-showcase-title',
                  styles: const dom.Styles(raw: {
                    'font-size': '1.75rem',
                    'font-weight': '700',
                    'color': 'var(--foreground)',
                    'margin': '0 0 1.25rem 0',
                  }),
                  [Component.text(props.title)],
                ),

                // Subtitle
                if (props.subtitle != null)
                  dom.p(
                    classes: 'codex-feature-showcase-subtitle',
                    styles: dom.Styles(raw: {
                      'font-size': '1.25rem',
                      'color': 'var(--muted-foreground)',
                      'margin': '0',
                      'max-width': '640px',
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
