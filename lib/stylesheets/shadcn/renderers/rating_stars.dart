import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/rating_stars_props.dart';

/// ShadCN Rating Stars renderer.
class ShadcnRatingStars extends StatelessComponent {
  final RatingStarsProps props;

  const ShadcnRatingStars(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final filledColor = props.filledColor ?? 'var(--warning)'; // Gold/amber
    final emptyColor = props.emptyColor ?? 'var(--muted)';

    return dom.div(
      classes: 'arcane-rating-stars',
      attributes: {
        'role': 'img',
        'aria-label': 'Rating: ${props.rating.toStringAsFixed(1)} out of ${props.totalStars} stars',
      },
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.125rem',
      }),
      [
        for (var i = 0; i < props.totalStars; i++) _buildStar(i, filledColor, emptyColor),
        if (props.showValue)
          dom.span(
            styles: const dom.Styles(raw: {
              'margin-left': '0.5rem',
              'color': 'var(--foreground)',
              'font-weight': 'var(--font-weight-medium)',
              'font-size': 'var(--font-size-sm)',
            }),
            [Component.text(props.rating.toStringAsFixed(1))],
          ),
      ],
    );
  }

  Component _buildStar(int index, String filledColor, String emptyColor) {
    final double fill = props.rating - index;
    String color;
    double opacity = 1.0;

    if (fill >= 1) {
      color = filledColor;
    } else if (fill > 0) {
      // Partial fill - show filled star with opacity based on fill
      color = filledColor;
      opacity = fill.clamp(0.3, 1.0);
    } else {
      color = emptyColor;
    }

    return dom.span(
      styles: dom.Styles(raw: {
        'font-size': props.size,
        'color': color,
        'line-height': '1',
        if (opacity < 1.0) 'opacity': opacity.toString(),
        'transition': 'color var(--arcane-transition)',
      }),
      [const Component.text('\u2605')], // Filled star character
    );
  }
}