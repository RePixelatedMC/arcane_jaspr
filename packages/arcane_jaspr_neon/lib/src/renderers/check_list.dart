import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/check_list_props.dart';

/// Neon CheckItem renderer.
class NeonCheckItem extends StatelessComponent {
  final CheckItemProps props;

  const NeonCheckItem(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String iconSymbol = switch (props.icon) {
      CheckStyle.check => '[check]',
      CheckStyle.bullet => '-',
      CheckStyle.arrow => '->',
      CheckStyle.plus => '+',
      CheckStyle.star => '*',
    };

    return dom.div(
      classes: 'neon-check-item',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': props.gap ?? '0.75rem',
        },
      ),
      [
        dom.span(
          classes: 'neon-check-item-icon',
          styles: dom.Styles(
            raw: {
              'color': props.iconColor ?? 'var(--neon-accent)',
              'font-size': props.fontSize ?? '0.9375rem',
              'flex-shrink': '0',
            },
          ),
          [Component.text(iconSymbol)],
        ),
        dom.span(
          classes: 'neon-check-item-text',
          styles: dom.Styles(
            raw: {
              'color': props.textColor ?? 'var(--foreground)',
              'font-size': props.fontSize ?? '0.9375rem',
              'line-height': '1.5',
            },
          ),
          [Component.text(props.text)],
        ),
      ],
    );
  }
}

/// Neon CheckList renderer.
class NeonCheckList extends StatelessComponent {
  final CheckListProps props;

  const NeonCheckList(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.ul(
      classes: 'neon-check-list',
      styles: dom.Styles(
        raw: {
          'list-style': 'none',
          'padding': '0',
          'margin': '0',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': props.listGap ?? '0.75rem',
          if (props.alignItems != null) 'align-items': props.alignItems!,
        },
      ),
      [
        for (final item in props.items)
          dom.li([
            NeonCheckItem(
              CheckItemProps(
                text: item,
                icon: props.icon,
                iconColor: props.iconColor,
                textColor: props.textColor,
                fontSize: props.fontSize,
                gap: props.itemGap,
              ),
            ),
          ]),
      ],
    );
  }
}

/// Neon FeatureRow renderer.
///
/// Displays a feature with check/x indicator for included/excluded states.
/// Supports circular icon containers, strikethrough, and tooltips.
class NeonFeatureRow extends StatelessComponent {
  final FeatureRowProps props;

  const NeonFeatureRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String iconColor = props.included
        ? (props.includedColor ?? 'var(--neon-accent)')
        : (props.excludedColor ?? 'var(--muted-foreground)');

    final String iconSize = props.iconSize ?? '18px';
    final bool showCircular = props.circularIcon;
    final bool showStrikethrough = props.strikethrough && !props.included;

    // Icon component - check for included, x for excluded
    final Component iconWidget = props.included
        ? const dom.span(
            styles: dom.Styles(
              raw: {'font-size': '0.625rem', 'font-weight': '600'},
            ),
            [Component.text('\u2713')], // Check mark
          )
        : const dom.span(
            styles: dom.Styles(
              raw: {'font-size': '0.625rem', 'font-weight': '600'},
            ),
            [Component.text('\u2715')], // X mark
          );

    // Build icon container - circular or inline
    final Component iconContainer = showCircular
        ? dom.div(
            classes: 'neon-feature-row-icon',
            styles: dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': iconSize,
                'height': iconSize,
                'border-radius': '50%',
                'flex-shrink': '0',
                'background-color': props.included
                    ? 'color-mix(in srgb, var(--neon-accent) 18%, transparent)'
                    : 'color-mix(in srgb, var(--foreground) 8%, transparent)',
                'color': iconColor,
              },
            ),
            [iconWidget],
          )
        : dom.span(
            classes: 'neon-feature-row-icon',
            styles: dom.Styles(
              raw: {
                'color': iconColor,
                'font-size': 'var(--font-size-sm)',
                'flex-shrink': '0',
              },
            ),
            [iconWidget],
          );

    // Build text styles with optional strikethrough
    final Map<String, String> textStyles = {
      'color': props.included ? 'var(--foreground)' : 'var(--muted-foreground)',
      'font-size': 'var(--font-size-sm)',
      if (showStrikethrough) 'text-decoration': 'line-through',
    };

    return dom.div(
      classes: 'neon-feature-row ${props.included ? 'included' : 'excluded'}',
      styles: const dom.Styles(
        raw: {'display': 'flex', 'align-items': 'center', 'gap': '0.5rem'},
      ),
      attributes: props.tooltip != null ? {'title': props.tooltip!} : null,
      [
        iconContainer,
        dom.span(
          classes: 'neon-feature-row-text',
          styles: dom.Styles(raw: textStyles),
          [Component.text(props.feature)],
        ),
      ],
    );
  }
}
