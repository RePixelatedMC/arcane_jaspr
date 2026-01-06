import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/check_list_props.dart';

String _getIconChar(CheckStyle icon) {
  return switch (icon) {
    CheckStyle.check => '\u2713',
    CheckStyle.bullet => '\u2022',
    CheckStyle.arrow => '\u2192',
    CheckStyle.plus => '+',
    CheckStyle.star => '\u2605',
  };
}

/// ShadCN Check Item renderer.
class ShadcnCheckItem extends StatelessComponent {
  final CheckItemProps props;

  const ShadcnCheckItem(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final iconColor = props.iconColor ?? 'var(--primary)';
    final textColor = props.textColor ?? 'var(--foreground)';
    final fontSize = props.fontSize ?? '0.875rem';
    final gap = props.gap ?? '0.5rem';

    return dom.div(
      classes: 'arcane-check-item',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': gap,
      }),
      [
        dom.span(
          styles: dom.Styles(raw: {
            'color': iconColor,
            'font-weight': '600',
            'flex-shrink': '0',
            'line-height': '1.5',
          }),
          [Component.text(_getIconChar(props.icon))],
        ),
        dom.span(
          styles: dom.Styles(raw: {
            'color': textColor,
            'font-size': fontSize,
            'line-height': '1.5',
          }),
          [Component.text(props.text)],
        ),
      ],
    );
  }
}

/// ShadCN Check List renderer.
class ShadcnCheckList extends StatelessComponent {
  final CheckListProps props;

  const ShadcnCheckList(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final listGap = props.listGap ?? '0.75rem';
    final alignItems = props.alignItems ?? 'flex-start';

    return dom.div(
      classes: 'arcane-check-list',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': listGap,
        'align-items': alignItems,
      }),
      [
        for (final item in props.items)
          ShadcnCheckItem(CheckItemProps(
            text: item,
            icon: props.icon,
            iconColor: props.iconColor,
            textColor: props.textColor,
            fontSize: props.fontSize,
            gap: props.itemGap,
          )),
      ],
    );
  }
}

/// ShadCN Feature Row renderer.
class ShadcnFeatureRow extends StatelessComponent {
  final FeatureRowProps props;

  const ShadcnFeatureRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final includedColor = props.includedColor ?? 'hsl(142 76% 36%)';
    final excludedColor = props.excludedColor ?? 'var(--muted-foreground)';
    final iconColor = props.included ? includedColor : excludedColor;

    return dom.div(
      classes: 'arcane-feature-row',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.5rem',
      }),
      [
        dom.span(
          styles: dom.Styles(raw: {
            'font-size': '0.875rem',
            'color': iconColor,
            'flex-shrink': '0',
          }),
          [Component.text(props.included ? '\u2713' : '\u2717')],
        ),
        dom.span(
          styles: dom.Styles(raw: {
            'font-size': '0.875rem',
            'color': props.included ? 'var(--foreground)' : 'var(--muted-foreground)',
          }),
          [Component.text(props.feature)],
        ),
      ],
    );
  }
}
