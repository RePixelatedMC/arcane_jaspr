import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/status_badge_props.dart';

/// Neon Status Badge renderer.
///
/// Unified renderer for both status indicators and card overlay badges.
/// Supports:
/// - Status badges: pill-shaped with dot/icon and optional emphasis
/// - Card overlay badges: positioned absolutely with solid backgrounds
/// - All size variants (sm, md, lg)
class NeonStatusBadge extends StatelessComponent {
  final StatusBadgeProps props;

  const NeonStatusBadge(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final BadgePosition? position = props.position;
    final bool isPositioned = position != null;

    // Popular, recommended, isNew use status badge style (rounded pill with dot)
    final bool isPromoBadge =
        props.variant == BadgeVariant.popular ||
        props.variant == BadgeVariant.recommended ||
        props.variant == BadgeVariant.isNew;

    if (isPromoBadge) {
      return _buildPromoBadge(position);
    }

    // Solid color badges (no dot, solid background)
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

    // Default: status badge (inline, with dot)
    return _buildStatusBadge();
  }

  /// Builds a promo badge (popular/recommended/new) with status badge styling.
  /// Uses rounded pill with dot indicator and transparent color-mix background.
  Component _buildPromoBadge(BadgePosition? position) {
    final bool isPositioned = position != null;
    final String color = _getPromoColor();
    final String indicatorSize = _getIndicatorSize();
    final String padding = _getStatusPadding();
    final String fontSize = _getStatusFontSize();

    final String effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 8%, transparent)';
    final String effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 22%, transparent)';
    final String effectiveLabelColor = props.labelColor ?? color;

    final Map<String, String> containerStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.4375rem',
      'padding': padding,
      'background': effectiveBackground,
      'border': '1px solid $effectiveBorder',
    };

    if (isPositioned) {
      containerStyles['position'] = 'absolute';
      if (position.top != null) containerStyles['top'] = position.top!;
      if (position.right != null) containerStyles['right'] = position.right!;
      if (position.bottom != null) containerStyles['bottom'] = position.bottom!;
      if (position.left != null) containerStyles['left'] = position.left!;
      containerStyles['z-index'] = '1';
    }

    return dom.div(
      classes:
          'neon-status-badge neon-promo-badge neon-badge-${props.variant.name}',
      attributes: {
        'data-variant': props.variant.name,
        'data-size': props.size.name,
      },
      styles: dom.Styles(raw: containerStyles),
      [
        dom.span(
          classes: 'neon-status-indicator',
          styles: dom.Styles(
            raw: {
              'width': indicatorSize,
              'height': indicatorSize,
              'border-radius': '50%',
              'background': color,
              'flex-shrink': '0',
              'box-shadow':
                  '0 0 8px color-mix(in srgb, $color 45%, transparent)',
            },
          ),
          [],
        ),
        dom.span(
          classes: 'neon-status-label',
          styles: dom.Styles(
            raw: {
              'font-size': fontSize,
              'font-weight': '600',
              'color': effectiveLabelColor,
              'white-space': 'nowrap',
            },
          ),
          [Component.text(props.label)],
        ),
      ],
    );
  }

  Component _buildCardBadge(BadgePosition? position) {
    final bool isPositioned = position != null;
    final String padding = _getCardPadding();
    final String fontSize = _getCardFontSize();

    final (
      String bgColor,
      String fgColor,
      String? shadowColor,
      String? borderStyle,
    ) = _getCardColors();

    final Map<String, String> styles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.375rem',
      'font-size': fontSize,
      'font-weight': 'var(--font-weight-semibold)',
      'line-height': '1',
      'white-space': 'nowrap',
      'transition': 'all var(--transition)',
      'padding': padding,
      'letter-spacing': '0.04em',
    };

    if (isPositioned) {
      styles['position'] = 'absolute';
      if (position.top != null) styles['top'] = position.top!;
      if (position.right != null) styles['right'] = position.right!;
      if (position.bottom != null) styles['bottom'] = position.bottom!;
      if (position.left != null) styles['left'] = position.left!;
      styles['z-index'] = '1';
    }

    if (props.gradient != null) {
      styles['background'] = props.gradient!;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
      if (shadowColor != null) styles['box-shadow'] = shadowColor;
    } else if (props.background != null) {
      styles['background-color'] = props.background!;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
    } else {
      styles['background-color'] = bgColor;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
      if (shadowColor != null) styles['box-shadow'] = shadowColor;
    }

    final Component? iconToShow =
        props.icon ??
        (props.showDefaultIcon ? ArcaneIcon.star(size: IconSize.xs) : null);

    return dom.span(
      classes: 'neon-badge neon-badge-${props.variant.name}',
      attributes: {
        'data-variant': props.variant.name,
        'data-size': props.size.name,
      },
      styles: dom.Styles(raw: styles),
      [if (iconToShow != null) iconToShow, Component.text(props.label)],
    );
  }

  Component _buildStatusBadge() {
    final String color = _getStatusColor();
    final String indicatorSize = _getIndicatorSize();
    final String padding = _getStatusPadding();
    final String fontSize = _getStatusFontSize();

    final String effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 6%, transparent)';
    final String effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 20%, transparent)';
    final String effectiveLabelColor = props.labelColor ?? color;

    return dom.div(
      classes: 'neon-status-badge neon-status-${props.status.name}',
      attributes: {
        'data-state': props.status.name,
        'data-size': props.size.name,
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': '0.4375rem',
          'padding': padding,
          'background': effectiveBackground,
          'border': '1px solid $effectiveBorder',
        },
      ),
      [
        if (props.icon != null)
          dom.span(
            classes: 'neon-status-indicator neon-status-icon',
            styles: dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'color': color,
                'font-size': indicatorSize,
              },
            ),
            [props.icon!],
          )
        else if (props.effectiveShowDot)
          dom.span(
            classes: 'neon-status-indicator',
            styles: dom.Styles(
              raw: {
                'width': indicatorSize,
                'height': indicatorSize,
                'border-radius': '50%',
                'background': color,
                'flex-shrink': '0',
                if (props.showGlow)
                  'box-shadow':
                      '0 0 8px color-mix(in srgb, $color 45%, transparent)',
              },
            ),
            [],
          ),
        dom.span(
          classes: 'neon-status-label',
          styles: dom.Styles(
            raw: {
              'font-size': fontSize,
              'font-weight': '600',
              'color': effectiveLabelColor,
              'white-space': 'nowrap',
            },
          ),
          [Component.text(props.label)],
        ),
      ],
    );
  }

  // ===========================================================================
  // Status Badge Helpers
  // ===========================================================================

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

  /// Gets the color for promo badges (popular, recommended, isNew).
  String _getPromoColor() {
    if (props.accentColor != null) {
      return props.accentColor!;
    }
    return switch (props.variant) {
      BadgeVariant.popular => 'var(--neon-accent)',
      BadgeVariant.recommended => 'var(--neon-accent)',
      BadgeVariant.isNew => 'var(--success)',
      _ => 'var(--neon-accent)',
    };
  }

  String _getIndicatorSize() {
    return switch (props.size) {
      ComponentSize.sm => '6px',
      ComponentSize.md => '6px',
      ComponentSize.lg => '8px',
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

  // ===========================================================================
  // Card Badge Helpers
  // ===========================================================================

  (String bgColor, String fgColor, String? shadow, String? border)
  _getCardColors() {
    return switch (props.variant) {
      BadgeVariant.popular || BadgeVariant.primary => (
        'var(--neon-accent)',
        'var(--neon-on-accent)',
        '0 4px 14px color-mix(in srgb, var(--neon-accent) 26%, transparent)',
        '1px solid color-mix(in srgb, var(--neon-accent) 60%, #12151C)',
      ),
      BadgeVariant.recommended => (
        'var(--neon-accent)',
        'var(--neon-on-accent)',
        '0 4px 14px color-mix(in srgb, var(--neon-accent) 26%, transparent)',
        '1px solid color-mix(in srgb, var(--neon-accent) 60%, #12151C)',
      ),
      BadgeVariant.isNew || BadgeVariant.successSolid => (
        'var(--success, #22c55e)',
        'var(--success-foreground, #ffffff)',
        '0 4px 14px color-mix(in srgb, var(--success) 24%, transparent)',
        '1px solid color-mix(in srgb, var(--success) 55%, #12151C)',
      ),
      BadgeVariant.warningSolid => (
        'var(--warning, #f59e0b)',
        'var(--warning-foreground, #0b0b0b)',
        '0 4px 14px color-mix(in srgb, var(--warning) 24%, transparent)',
        '1px solid color-mix(in srgb, var(--warning) 58%, #12151C)',
      ),
      BadgeVariant.errorSolid => (
        'var(--destructive)',
        'var(--destructive-foreground)',
        '0 4px 14px color-mix(in srgb, var(--destructive) 24%, transparent)',
        '1px solid color-mix(in srgb, var(--destructive) 55%, #12151C)',
      ),
      BadgeVariant.infoSolid => (
        'var(--info, #3b82f6)',
        'var(--info-foreground, #ffffff)',
        '0 4px 14px color-mix(in srgb, var(--info) 24%, transparent)',
        '1px solid color-mix(in srgb, var(--info) 58%, #12151C)',
      ),
      BadgeVariant.outline => (
        'transparent',
        'var(--foreground)',
        null,
        '1px solid var(--neon-control-border)',
      ),
      BadgeVariant.secondary => (
        'color-mix(in srgb, var(--neon-accent-cool) 6%, var(--neon-surface-2))',
        'var(--secondary-foreground)',
        null,
        '1px solid color-mix(in srgb, var(--neon-accent-cool) 18%, var(--neon-control-border))',
      ),
      BadgeVariant.status => (
        'color-mix(in srgb, var(--neon-accent-cool) 6%, var(--neon-surface-2))',
        'var(--secondary-foreground)',
        null,
        '1px solid color-mix(in srgb, var(--neon-accent-cool) 18%, var(--neon-control-border))',
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
