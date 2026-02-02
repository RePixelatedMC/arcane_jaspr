import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/status_badge_props.dart';

/// ShadCN Status Badge renderer.
///
/// Unified renderer for both status indicators and card overlay badges.
/// Supports:
/// - Status badges: pill-shaped with dot/icon and optional pulse
/// - Card overlay badges: positioned absolutely with solid backgrounds
/// - All size variants (sm, md, lg)
class ShadcnStatusBadge extends StatelessComponent {
  final StatusBadgeProps props;

  const ShadcnStatusBadge(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final BadgePosition? position = props.position;
    final bool isPositioned = position != null;

    // Popular, recommended, isNew use status badge style (rounded pill with dot)
    final bool isPromoBadge = props.variant == BadgeVariant.popular ||
        props.variant == BadgeVariant.recommended ||
        props.variant == BadgeVariant.isNew;

    if (isPromoBadge) {
      return _buildPromoBadge(position);
    }

    // Solid color badges (no dot, solid background)
    final bool isSolidBadge = props.variant == BadgeVariant.primary ||
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

    // Use color-mix for transparent background like status badges
    final String effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 15%, transparent)';
    final String effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 35%, transparent)';
    final String effectiveLabelColor = props.labelColor ?? color;

    final Map<String, String> containerStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': 'var(--space-2)',
      'padding': padding,
      'background': effectiveBackground,
      'border': '1px solid $effectiveBorder',
      'border-radius': '9999px', // Pill shape
    };

    // Add positioning if needed
    if (isPositioned) {
      containerStyles['position'] = 'absolute';
      if (position.top != null) containerStyles['top'] = position.top!;
      if (position.right != null) containerStyles['right'] = position.right!;
      if (position.bottom != null) containerStyles['bottom'] = position.bottom!;
      if (position.left != null) containerStyles['left'] = position.left!;
      containerStyles['z-index'] = '1';
    }

    return dom.div(
      classes: 'shadcn-status-badge shadcn-promo-badge shadcn-badge-${props.variant.name}',
      styles: dom.Styles(raw: containerStyles),
      [
        // Dot indicator (always show for promo badges)
        dom.span(
          classes: 'shadcn-status-indicator',
          styles: dom.Styles(raw: {
            'width': indicatorSize,
            'height': indicatorSize,
            'border-radius': '50%',
            'background': color,
            'flex-shrink': '0',
            'box-shadow': '0 0 8px $color',
          }),
          [],
        ),
        // Label
        dom.span(
          classes: 'shadcn-status-label',
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'font-weight': '500',
            'color': effectiveLabelColor,
            'white-space': 'nowrap',
          }),
          [Component.text(props.label)],
        ),
      ],
    );
  }

  /// Builds a card overlay badge (solid background, positioned).
  Component _buildCardBadge(BadgePosition? position) {
    final bool isPositioned = position != null;
    final String padding = _getCardPadding();
    final String fontSize = _getCardFontSize();

    // Get colors based on variant
    final (String bgColor, String fgColor, String? glowColor, String? borderStyle) =
        _getCardColors();

    final Map<String, String> styles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.375rem',
      'border-radius': '9999px',
      'font-size': fontSize,
      'font-weight': '600',
      'line-height': '1',
      'white-space': 'nowrap',
      'transition': 'color 150ms, background-color 150ms, border-color 150ms',
      'padding': padding,
    };

    // Position styles for absolute positioning
    if (isPositioned) {
      styles['position'] = 'absolute';
      if (position.top != null) styles['top'] = position.top!;
      if (position.right != null) styles['right'] = position.right!;
      if (position.bottom != null) styles['bottom'] = position.bottom!;
      if (position.left != null) styles['left'] = position.left!;
      styles['z-index'] = '1';
    }

    // Background and colors
    if (props.gradient != null) {
      styles['background'] = props.gradient!;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
      if (glowColor != null) styles['box-shadow'] = glowColor;
    } else if (props.background != null) {
      styles['background-color'] = props.background!;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
    } else {
      styles['background-color'] = bgColor;
      styles['color'] = fgColor;
      styles['border'] = borderStyle ?? '1px solid transparent';
      if (glowColor != null) styles['box-shadow'] = glowColor;
    }

    // Determine icon to show
    final Component? iconToShow = props.icon ??
        (props.showDefaultIcon ? ArcaneIcon.star(size: IconSize.xs) : null);

    return dom.span(
      classes: 'shadcn-badge shadcn-badge-${props.variant.name}',
      styles: dom.Styles(raw: styles),
      [
        if (iconToShow != null) iconToShow,
        Component.text(props.label),
      ],
    );
  }

  /// Builds a status badge (pill with dot indicator).
  Component _buildStatusBadge() {
    final String color = _getStatusColor();
    final String indicatorSize = _getIndicatorSize();
    final String padding = _getStatusPadding();
    final String fontSize = _getStatusFontSize();

    // Use color-mix for consistent appearance
    final String effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 10%, transparent)';
    final String effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 25%, transparent)';
    final String effectiveLabelColor = props.labelColor ?? color;

    return dom.div(
      classes: 'shadcn-status-badge shadcn-status-${props.status.name}',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        'padding': padding,
        'background': effectiveBackground,
        'border': '1px solid $effectiveBorder',
        'border-radius': '9999px', // Pill shape
      }),
      [
        // Indicator (dot or custom icon)
        if (props.icon != null)
          dom.span(
            classes: 'shadcn-status-indicator shadcn-status-icon',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': color,
              'font-size': indicatorSize,
            }),
            [props.icon!],
          )
        else if (props.effectiveShowDot)
          dom.span(
            classes: 'shadcn-status-indicator',
            styles: dom.Styles(raw: {
              'width': indicatorSize,
              'height': indicatorSize,
              'border-radius': '50%',
              'background': color,
              'flex-shrink': '0',
              if (props.showGlow) 'box-shadow': '0 0 8px $color',
              if (props.showPulse)
                'animation': 'arcane-pulse 2s ease-in-out infinite',
            }),
            [],
          ),
        // Label
        dom.span(
          classes: 'shadcn-status-label',
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'font-weight': '500',
            'color': effectiveLabelColor,
            'white-space': 'nowrap',
          }),
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
      BadgeVariant.popular => 'var(--primary)',
      BadgeVariant.recommended => 'var(--primary)',
      BadgeVariant.isNew => 'var(--success)',
      _ => 'var(--primary)',
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
      ComponentSize.sm => '0.25rem 0.5rem',
      ComponentSize.md => '0.25rem 0.75rem',
      ComponentSize.lg => '0.375rem 1rem',
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

  (String bgColor, String fgColor, String? glow, String? border) _getCardColors() {
    return switch (props.variant) {
      BadgeVariant.popular || BadgeVariant.primary => (
          'var(--primary)',
          'var(--primary-foreground)',
          '0 0 15px color-mix(in srgb, var(--primary) 20%, transparent)',
          null,
        ),
      BadgeVariant.recommended => (
          'var(--primary)', // Gradient overrides this
          'var(--primary-foreground)',
          '0 0 15px color-mix(in srgb, var(--primary) 20%, transparent)',
          null,
        ),
      BadgeVariant.isNew || BadgeVariant.successSolid => (
          'var(--success, #22c55e)',
          'var(--success-foreground, #ffffff)',
          null,
          null,
        ),
      BadgeVariant.warningSolid => (
          'var(--warning, #f59e0b)',
          'var(--warning-foreground, #000000)',
          null,
          null,
        ),
      BadgeVariant.errorSolid => (
          'var(--destructive)',
          'var(--destructive-foreground)',
          null,
          null,
        ),
      BadgeVariant.infoSolid => (
          'var(--info, #3b82f6)',
          'var(--info-foreground, #ffffff)',
          null,
          null,
        ),
      BadgeVariant.outline => (
          'transparent',
          'var(--foreground)',
          null,
          '1px solid var(--border)',
        ),
      BadgeVariant.secondary => (
          'var(--secondary)',
          'var(--secondary-foreground)',
          null,
          null,
        ),
      BadgeVariant.status => (
          'var(--secondary)',
          'var(--secondary-foreground)',
          null,
          null,
        ),
    };
  }

  String _getCardPadding() {
    return switch (props.size) {
      ComponentSize.sm => '0.125rem 0.5rem',
      ComponentSize.md => '0.125rem 0.625rem',
      ComponentSize.lg => '0.25rem 0.75rem',
    };
  }

  String _getCardFontSize() {
    return switch (props.size) {
      ComponentSize.sm => '0.75rem',
      ComponentSize.md => '0.75rem',
      ComponentSize.lg => '0.875rem',
    };
  }
}
