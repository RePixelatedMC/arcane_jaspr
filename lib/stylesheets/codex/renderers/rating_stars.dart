import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/testimonial_card_props.dart';

/// Codex RatingStarsSimple renderer.
class CodexRatingStarsSimple extends StatelessComponent {
  final RatingStarsSimpleProps props;

  const CodexRatingStarsSimple(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-rating-stars',
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'gap': '0.125rem',
      }),
      [
        for (int i = 0; i < props.maxStars; i++)
          dom.span(
            classes:
                'codex-rating-star ${i < props.rating ? 'filled' : 'empty'}',
            styles: dom.Styles(raw: {
              'font-size': '${props.size}px',
              'color': i < props.rating
                  ? 'var(--codex-accent)'
                  : 'var(--muted-foreground)',
              if (props.interactive) 'cursor': 'pointer',
            }),
            events: props.interactive && props.onRatingChanged != null
                ? {'click': (_) => props.onRatingChanged!(i + 1)}
                : null,
            [Component.text(i < props.rating ? '*' : 'o')],
          ),
      ],
    );
  }
}
