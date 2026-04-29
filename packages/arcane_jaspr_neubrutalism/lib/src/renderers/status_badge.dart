import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/status_badge_props.dart';

class NeubrutalismStatusBadge extends StatelessComponent {
  final StatusBadgeProps props;

  const NeubrutalismStatusBadge(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final BadgePosition? position = props.position;
    final bool isPositioned = position != null;

    final bool isPromoBadge =
        props.variant == BadgeVariant.popular ||
        props.variant == BadgeVariant.recommended ||
        props.variant == BadgeVariant.isNew;

    if (isPromoBadge) {
      return _buildPromoBadge(position);
    }

    final bool isSolidBadge =
        props.variant == BadgeVariant.primary ||
        props.variant == BadgeVariant.secondary ||
        props.variant == BadgeVariant.successSolid ||
        props.variant == BadgeVariant.warningSolid ||
        props.variant == BadgeVariant.errorSolid ||
        props.variant == BadgeVariant.infoSolid ||
        props.variant == BadgeVariant.outline;

    if (isSolidBadge || isPositioned) {
      return _buildCardBadge(position);
    }

    return _buildStatusBadge();
  }

  Component _buildPromoBadge(BadgePosition? position) {
    final bool isPositioned = position != null;
    final String color = _getPromoColor();
    final String indicatorSize = _getIndicatorSize();
    final String padding = _getStatusPadding();
    final String fontSize = _getStatusFontSize();

    final String effectiveBackground =
        props.background ?? 'var(--nb-paper, var(--card))';
    final String effectiveBorder =
        props.borderColor ?? 'var(--nb-line, #000)';
    final String effectiveLabelColor =
        props.labelColor ?? 'var(--foreground)';

    final Map<String, String> containerStyles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4375rem',
      'padding': padding,
      'background': effectiveBackground,
      'border': 'var(--nb-border-thin, 2px) solid $effectiveBorder',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'box-shadow':
          'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
    };

    if (isPositioned) {
      containerStyles['position'] = 'absolute';
      if (position.top != null) containerStyles['top'] = position.top!;
      if (position.right != null) containerStyles['right'] = position.right!;
      if (position.bottom != null) {
        containerStyles['bottom'] = position.bottom!;
      }
      if (position.left != null) containerStyles['left'] = position.left!;
      containerStyles['z-index'] = '1';
    }

    return dom.div(
      classes:
          'neubrutalism-status-badge neubrutalism-promo-badge neubrutalism-badge-${props.variant.name}',
      attributes: <String, String>{
        'data-variant': props.variant.name,
        'data-size': props.size.name,
      },
      styles: dom.Styles(raw: containerStyles),
      <Component>[
        dom.span(
          classes: 'neubrutalism-status-indicator',
          styles: dom.Styles(
            raw: <String, String>{
              'width': indicatorSize,
              'height': indicatorSize,
              'border-radius': '9999px',
              'background': color,
              'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
              'flex-shrink': '0',
            },
          ),
          const <Component>[],
        ),
        dom.span(
          classes: 'neubrutalism-status-label',
          styles: dom.Styles(
            raw: <String, String>{
              'font-family': 'var(--font-heading)',
              'font-size': fontSize,
              'font-weight': '800',
              'color': effectiveLabelColor,
              'white-space': 'nowrap',
              'letter-spacing': '0.02em',
            },
          ),
          <Component>[Component.text(props.label)],
        ),
      ],
    );
  }

  Component _buildCardBadge(BadgePosition? position) {
    final bool isPositioned = position != null;
    final String padding = _getCardPadding();
    final String fontSize = _getCardFontSize();

    final (String bgColor, String fgColor) = _getCardColors();

    final Map<String, String> styles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.375rem',
      'font-family': 'var(--font-heading)',
      'font-size': fontSize,
      'font-weight': '800',
      'line-height': '1',
      'white-space': 'nowrap',
      'padding': padding,
      'letter-spacing': '0.04em',
      'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'box-shadow':
          'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
      'transition':
          'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease)',
    };

    if (isPositioned) {
      styles['position'] = 'absolute';
      if (position.top != null) styles['top'] = position.top!;
      if (position.right != null) styles['right'] = position.right!;
      if (position.bottom != null) styles['bottom'] = position.bottom!;
      if (position.left != null) styles['left'] = position.left!;
      styles['z-index'] = '1';
    }

    if (props.background != null) {
      styles['background-color'] = props.background!;
    } else {
      styles['background-color'] = bgColor;
    }
    styles['color'] = fgColor;

    final Component? iconToShow =
        props.icon ??
        (props.showDefaultIcon ? ArcaneIcon.star(size: IconSize.xs) : null);

    return dom.span(
      classes: 'neubrutalism-badge neubrutalism-badge-${props.variant.name}',
      attributes: <String, String>{
        'data-variant': props.variant.name,
        'data-size': props.size.name,
      },
      styles: dom.Styles(raw: styles),
      <Component>[
        if (iconToShow != null) iconToShow,
        Component.text(props.label),
      ],
    );
  }

  Component _buildStatusBadge() {
    final String color = _getStatusColor();
    final String indicatorSize = _getIndicatorSize();
    final String padding = _getStatusPadding();
    final String fontSize = _getStatusFontSize();

    final String effectiveBackground =
        props.background ?? 'var(--nb-paper, var(--card))';
    final String effectiveBorder =
        props.borderColor ?? 'var(--nb-line, #000)';
    final String effectiveLabelColor =
        props.labelColor ?? 'var(--foreground)';

    return dom.div(
      classes:
          'neubrutalism-status-badge neubrutalism-status-${props.status.name}',
      attributes: <String, String>{
        'data-state': props.status.name,
        'data-size': props.size.name,
      },
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': '0.4375rem',
          'padding': padding,
          'background': effectiveBackground,
          'border': 'var(--nb-border-thin, 2px) solid $effectiveBorder',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow':
              'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
        },
      ),
      <Component>[
        if (props.icon != null)
          dom.span(
            classes: 'neubrutalism-status-indicator neubrutalism-status-icon',
            styles: dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'color': color,
                'font-size': indicatorSize,
              },
            ),
            <Component>[props.icon!],
          )
        else if (props.effectiveShowDot)
          dom.span(
            classes: 'neubrutalism-status-indicator',
            styles: dom.Styles(
              raw: <String, String>{
                'width': indicatorSize,
                'height': indicatorSize,
                'border-radius': '9999px',
                'background': color,
                'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                'flex-shrink': '0',
              },
            ),
            const <Component>[],
          ),
        dom.span(
          classes: 'neubrutalism-status-label',
          styles: dom.Styles(
            raw: <String, String>{
              'font-family': 'var(--font-heading)',
              'font-size': fontSize,
              'font-weight': '800',
              'color': effectiveLabelColor,
              'white-space': 'nowrap',
              'letter-spacing': '0.02em',
            },
          ),
          <Component>[Component.text(props.label)],
        ),
      ],
    );
  }

  String _getStatusColor() {
    if (props.accentColor != null) {
      return props.accentColor!;
    }
    return switch (props.status) {
      StatusType.success || StatusType.online => 'var(--success)',
      StatusType.warning || StatusType.away => 'var(--warning)',
      StatusType.error || StatusType.busy => 'var(--destructive)',
      StatusType.info => 'var(--info)',
      StatusType.offline => 'var(--muted-foreground)',
    };
  }

  String _getPromoColor() {
    if (props.accentColor != null) {
      return props.accentColor!;
    }
    return switch (props.variant) {
      BadgeVariant.popular => 'var(--nb-accent, var(--primary))',
      BadgeVariant.recommended => 'var(--nb-accent-hot, var(--primary))',
      BadgeVariant.isNew => 'var(--success)',
      _ => 'var(--nb-accent, var(--primary))',
    };
  }

  String _getIndicatorSize() {
    return switch (props.size) {
      ComponentSize.sm => '8px',
      ComponentSize.md => '8px',
      ComponentSize.lg => '10px',
    };
  }

  String _getStatusPadding() {
    return switch (props.size) {
      ComponentSize.sm => '0.25rem 0.625rem',
      ComponentSize.md => '0.375rem 0.75rem',
      ComponentSize.lg => '0.5rem 1rem',
    };
  }

  String _getStatusFontSize() {
    return switch (props.size) {
      ComponentSize.sm => '0.75rem',
      ComponentSize.md => '0.875rem',
      ComponentSize.lg => '1rem',
    };
  }

  (String bgColor, String fgColor) _getCardColors() {
    return switch (props.variant) {
      BadgeVariant.popular || BadgeVariant.primary => (
        'var(--nb-accent, var(--primary))',
        'var(--nb-on-accent, #000)',
      ),
      BadgeVariant.recommended => (
        'var(--nb-accent-hot, var(--primary))',
        'var(--nb-on-accent, #000)',
      ),
      BadgeVariant.isNew || BadgeVariant.successSolid => (
        'var(--success, #22c55e)',
        'var(--success-foreground, #000)',
      ),
      BadgeVariant.warningSolid => (
        'var(--warning, #f59e0b)',
        'var(--warning-foreground, #000)',
      ),
      BadgeVariant.errorSolid => (
        'var(--destructive)',
        'var(--destructive-foreground, #fff)',
      ),
      BadgeVariant.infoSolid => (
        'var(--info, #3b82f6)',
        'var(--info-foreground, #fff)',
      ),
      BadgeVariant.outline => (
        'transparent',
        'var(--foreground)',
      ),
      BadgeVariant.secondary => (
        'var(--nb-paper-soft, var(--card))',
        'var(--foreground)',
      ),
      BadgeVariant.status => (
        'var(--nb-paper-soft, var(--card))',
        'var(--foreground)',
      ),
    };
  }

  String _getCardPadding() {
    return switch (props.size) {
      ComponentSize.sm => '0.25rem 0.625rem',
      ComponentSize.md => '0.25rem 0.75rem',
      ComponentSize.lg => '0.375rem 1rem',
    };
  }

  String _getCardFontSize() {
    return switch (props.size) {
      ComponentSize.sm => 'var(--font-size-xs)',
      ComponentSize.md => 'var(--font-size-xs)',
      ComponentSize.lg => 'var(--font-size-sm)',
    };
  }
}
