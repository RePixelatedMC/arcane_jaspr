import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/feature_card_props.dart';

/// Codex Feature Card renderer.
///
/// Implements the Codex design language:
/// - Larger padding and icon size
/// - Accent-colored hover state
/// - Subtle glow on hover
/// - Optional accent color styling with gradient border
/// - Optional CTA button
class CodexFeatureCard extends StatelessComponent {
  final FeatureCardProps props;

  const CodexFeatureCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isInteractive = props.href != null || props.onTap != null;
    final bool hasAccent = props.accentColor != null;
    final String accent = props.accentColor ?? 'var(--primary)';

    final List<Component> cardChildren = [
      // Top gradient border (when accent color is set)
      if (hasAccent)
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'top': '0',
            'left': '0',
            'right': '0',
            'height': '3px',
            'background': 'linear-gradient(90deg, $accent, ${accent}66)',
            'border-radius': 'var(--radius-xl) var(--radius-xl) 0 0',
          }),
          [],
        ),

      // Main content
      dom.div(
        classes: 'codex-feature-card-inner',
        styles: dom.Styles(raw: {
          'display': 'flex',
          'flex-direction': props.horizontal ? 'row' : 'column',
          'gap': props.horizontal ? '1.25rem' : '1rem',
          'align-items': props.horizontal ? 'flex-start' : 'flex-start',
          if (props.showCta) 'flex': '1',
        }),
        [
          // Icon row (with title if accent style)
          if (hasAccent && props.icon != null)
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': 'var(--space-3)',
                'margin-bottom': 'var(--space-4)',
              }),
              [
                dom.div(
                  classes: 'codex-feature-card-icon',
                  styles: dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'width': '44px',
                    'height': '44px',
                    'border-radius': 'var(--radius-lg)',
                    'background-color': '${accent}15',
                    'border': '1px solid ${accent}30',
                    'color': accent,
                    'flex-shrink': '0',
                  }),
                  [props.icon!],
                ),
                dom.h3(
                  classes: 'codex-feature-card-title',
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-lg)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--foreground)',
                    'margin': '0',
                  }),
                  [Component.text(props.title)],
                ),
              ],
            )
          else ...[
            // Icon (standard style)
            if (props.icon != null)
              dom.div(
                classes: 'codex-feature-card-icon',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '56px',
                  'height': '56px',
                  'border-radius': 'var(--radius)',
                  'background-color': 'rgba(var(--primary-rgb), 0.1)',
                  'color': 'var(--primary)',
                  'flex-shrink': '0',
                }),
                [props.icon!],
              ),
          ],

          // Content (title + description for non-accent style)
          if (!hasAccent)
            dom.div(
              classes: 'codex-feature-card-content',
              styles: const dom.Styles(raw: {
                'flex': '1',
              }),
              [
                // Title row
                dom.div(
                  classes: 'codex-feature-card-title-row',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'gap': 'var(--space-2)',
                  }),
                  [
                    dom.h3(
                      classes: 'codex-feature-card-title',
                      styles: const dom.Styles(raw: {
                        'font-size': 'var(--font-size-lg)',
                        'font-weight': 'var(--font-weight-semibold)',
                        'color': 'var(--foreground)',
                        'margin': '0',
                      }),
                      [Component.text(props.title)],
                    ),
                    if (props.showArrow && isInteractive)
                      const dom.span(
                        classes: 'codex-feature-card-arrow',
                        styles: dom.Styles(raw: {
                          'font-size': 'var(--font-size-base)',
                          'color': 'var(--primary)',
                          'transition': 'transform var(--transition)',
                        }),
                        [Component.text('->')],
                      ),
                  ],
                ),

                // Description
                dom.p(
                  classes: 'codex-feature-card-description',
                  styles: const dom.Styles(raw: {
                    'font-size': '0.9375rem',
                    'color': 'var(--muted-foreground)',
                    'line-height': '1.6',
                    'margin': '0.5rem 0 0 0',
                  }),
                  [Component.text(props.description)],
                ),
              ],
            )
          else
            // Description only (accent style - title is in icon row)
            dom.p(
              classes: 'codex-feature-card-description',
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
                'line-height': '1.6',
                'margin': '0',
              }),
              [Component.text(props.description)],
            ),
        ],
      ),

      // CTA button (when showCta is true)
      if (props.showCta && isInteractive)
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'gap': 'var(--space-2)',
            'padding': 'var(--space-3) var(--space-4)',
            'margin-top': 'var(--space-4)',
            'background-color': hasAccent ? accent : 'var(--primary)',
            'border-radius': 'var(--radius-md)',
            'color': 'var(--foreground)',
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-semibold)',
            'transition': 'all var(--arcane-transition)',
          }),
          [
            Component.text(props.ctaText ??
                (props.isExternal ? 'View Docs' : 'Learn More')),
            props.isExternal
                ? ArcaneIcon.externalLink(size: IconSize.sm)
                : ArcaneIcon.arrowRight(size: IconSize.sm),
          ],
        ),
    ];

    if (props.href != null) {
      return dom.a(
        classes: 'codex-feature-card interactive ${hasAccent ? 'accented' : ''}',
        href: props.href!,
        target: props.isExternal ? dom.Target.blank : null,
        styles: _cardStyles(isInteractive, hasAccent),
        cardChildren,
      );
    }

    return dom.div(
      classes: 'codex-feature-card ${isInteractive ? 'interactive' : ''} ${hasAccent ? 'accented' : ''}',
      styles: _cardStyles(isInteractive, hasAccent),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      cardChildren,
    );
  }

  dom.Styles _cardStyles(bool isInteractive, bool hasAccent) {
    return dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'position': 'relative',
      'overflow': 'hidden',
      'padding': hasAccent ? '1.5rem 2rem 2rem' : '2rem',
      'background-color': 'var(--card)',
      'border': '1px solid color-mix(in srgb, var(--foreground) 8%, transparent)',
      'border-radius': 'var(--radius-xl)',
      if (hasAccent) 'min-height': '260px',
      if (isInteractive) 'cursor': 'pointer',
      'transition': 'all var(--arcane-transition)',
      'text-decoration': 'none',
    });
  }
}

/// Codex Icon Card renderer.
class CodexIconCard extends StatelessComponent {
  final IconCardProps props;

  const CodexIconCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isInteractive = props.href != null || props.onTap != null;

    final Component content = dom.div(
      classes: 'codex-icon-card-inner',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'text-align': 'center',
        'gap': 'var(--space-4)',
      }),
      [
        // Icon
        dom.div(
          classes: 'codex-icon-card-icon',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '64px', // Codex: larger
            'height': '64px',
            'border-radius': 'var(--radius-lg)',
            'background-color': 'rgba(var(--primary-rgb), 0.1)',
            'color': 'var(--primary)',
          }),
          [props.icon],
        ),

        // Title
        dom.h4(
          classes: 'codex-icon-card-title',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-base)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0',
          }),
          [Component.text(props.title)],
        ),

        // Subtitle
        if (props.subtitle != null)
          dom.p(
            classes: 'codex-icon-card-subtitle',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin': '0',
            }),
            [Component.text(props.subtitle!)],
          ),
      ],
    );

    if (props.href != null) {
      return dom.a(
        classes: 'codex-icon-card interactive',
        href: props.href!,
        styles: _cardStyles(isInteractive),
        [content],
      );
    }

    return dom.div(
      classes: 'codex-icon-card ${isInteractive ? 'interactive' : ''}',
      styles: _cardStyles(isInteractive),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      [content],
    );
  }

  dom.Styles _cardStyles(bool isInteractive) {
    return dom.Styles(raw: {
      'display': 'block',
      'padding': '2rem', // Codex: larger padding
      'background-color': 'var(--card)',
      'border': '1px solid var(--border)',
      'border-radius': 'var(--radius)',
      if (isInteractive) 'cursor': 'pointer',
      'transition': 'all var(--transition)',
      'text-decoration': 'none',
    });
  }
}