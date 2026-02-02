import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/feature_card_props.dart';

/// ShadCN Feature Card renderer.
class ShadcnFeatureCard extends StatelessComponent {
  final FeatureCardProps props;

  const ShadcnFeatureCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isClickable = props.href != null || props.onTap != null;
    final bool hasAccent = props.accentColor != null;
    final String accent = props.accentColor ?? 'var(--accent)';

    final List<Component> content = [
      // Top gradient border (when accent color is set)
      if (hasAccent)
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'top': '0',
            'left': '0',
            'right': '0',
            'height': '2px',
            'background': 'linear-gradient(90deg, $accent, ${accent}66)',
            'border-radius': 'var(--arcane-radius-lg) var(--arcane-radius-lg) 0 0',
          }),
          [],
        ),

      // Icon row (with title if accent style)
      if (hasAccent && props.icon != null)
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': 'var(--space-3)',
            'margin-bottom': 'var(--space-3)',
          }),
          [
            dom.div(
              classes: 'arcane-feature-card-icon',
              styles: dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '40px',
                'height': '40px',
                'border-radius': 'var(--arcane-radius-sm)',
                'background-color': 'color-mix(in srgb, $accent 10%, transparent)',
                'border': '1px solid color-mix(in srgb, $accent 20%, transparent)',
                'color': accent,
                'flex-shrink': '0',
              }),
              [props.icon!],
            ),
            dom.div(
              classes: 'arcane-feature-card-title',
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-lg)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.title)],
            ),
          ],
        )
      else if (props.icon != null)
        // Icon (standard style)
        dom.div(
          classes: 'arcane-feature-card-icon',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '48px',
            'height': '48px',
            'border-radius': 'var(--arcane-radius-sm)',
            'background-color': 'color-mix(in srgb, var(--accent) 10%, transparent)',
            'color': 'var(--accent)',
            'flex-shrink': '0',
            if (!props.horizontal) 'margin-bottom': '1.5rem',
          }),
          [props.icon!],
        ),

      // Content
      if (!hasAccent)
        dom.div(
          classes: 'arcane-feature-card-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
          }),
          [
            // Title with optional arrow
            dom.div(
              classes: 'arcane-feature-card-title',
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': 'var(--space-2)',
                'font-size': 'var(--font-size-lg)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--foreground)',
                'margin-bottom': '0.5rem',
              }),
              [
                Component.text(props.title),
                if (props.showArrow && isClickable)
                  const dom.span(
                    classes: 'arcane-feature-card-arrow',
                    styles: dom.Styles(raw: {
                      'transition': 'all var(--arcane-transition)',
                    }),
                    [Component.text('\u2192')],
                  ),
              ],
            ),

            // Description
            dom.p(
              classes: 'arcane-feature-card-description',
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-base)',
                'line-height': '1.7',
                'color': 'var(--muted-foreground)',
                'margin': '0',
              }),
              [Component.text(props.description)],
            ),
          ],
        )
      else
        // Description only (accent style)
        dom.p(
          classes: 'arcane-feature-card-description',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'line-height': '1.6',
            'color': 'var(--muted-foreground)',
            'margin': '0',
            'flex': '1',
          }),
          [Component.text(props.description)],
        ),

      // CTA button (when showCta is true)
      if (props.showCta && isClickable)
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'gap': 'var(--space-2)',
            'padding': 'var(--space-2) var(--space-3)',
            'margin-top': 'var(--space-4)',
            'background-color': hasAccent ? accent : 'var(--accent)',
            'border-radius': 'var(--arcane-radius-sm)',
            'color': 'var(--accent-foreground)',
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-medium)',
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

    final Map<String, String> cardStyles = {
      'display': 'flex',
      'flex-direction': props.horizontal ? 'row' : 'column',
      'gap': props.horizontal ? '1.5rem' : '0',
      'padding': '2rem',
      'background-color': 'var(--card)',
      'border': '1px solid var(--border)',
      'border-radius': 'var(--arcane-radius-lg)',
      'transition': 'all var(--arcane-transition-slow)',
      'position': 'relative',
      'overflow': 'hidden',
      if (hasAccent) 'min-height': '200px',
      if (isClickable) 'cursor': 'pointer',
    };

    if (props.href != null) {
      return dom.a(
        classes: 'arcane-feature-card ${hasAccent ? 'accented' : ''}',
        href: props.href!,
        target: props.isExternal ? dom.Target.blank : null,
        styles: dom.Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        content,
      );
    }

    if (props.onTap != null) {
      return dom.button(
        classes: 'arcane-feature-card ${hasAccent ? 'accented' : ''}',
        type: dom.ButtonType.button,
        styles: dom.Styles(raw: {
          ...cardStyles,
          'text-align': 'left',
          'border': '1px solid var(--border)',
        }),
        events: {'click': (e) => props.onTap!()},
        content,
      );
    }

    return dom.div(
      classes: 'arcane-feature-card ${hasAccent ? 'accented' : ''}',
      styles: dom.Styles(raw: cardStyles),
      content,
    );
  }
}

/// ShadCN Icon Card renderer.
class ShadcnIconCard extends StatelessComponent {
  final IconCardProps props;

  const ShadcnIconCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isClickable = props.href != null || props.onTap != null;

    final List<Component> content = [
      dom.div(
        classes: 'arcane-icon-card-icon',
        styles: const dom.Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '40px',
          'height': '40px',
          'border-radius': 'var(--arcane-radius-sm)',
          'background-color': 'var(--muted)',
          'color': 'var(--accent)',
          'margin-bottom': '1rem',
        }),
        [props.icon],
      ),
      dom.span(
        classes: 'arcane-icon-card-title',
        styles: const dom.Styles(raw: {
          'font-size': 'var(--font-size-base)',
          'font-weight': 'var(--font-weight-medium)',
          'color': 'var(--foreground)',
        }),
        [Component.text(props.title)],
      ),
      if (props.subtitle != null)
        dom.span(
          classes: 'arcane-icon-card-subtitle',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--muted-foreground)',
            'margin-top': '0.25rem',
          }),
          [Component.text(props.subtitle!)],
        ),
    ];

    final Map<String, String> cardStyles = {
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'center',
      'text-align': 'center',
      'padding': '1.5rem',
      'background-color': 'var(--card)',
      'border': '1px solid var(--border)',
      'border-radius': 'var(--arcane-radius-sm)',
      'transition': 'all var(--arcane-transition-slow)',
      if (isClickable) 'cursor': 'pointer',
    };

    if (props.href != null) {
      return dom.a(
        classes: 'arcane-icon-card',
        href: props.href!,
        styles: dom.Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        content,
      );
    }

    if (props.onTap != null) {
      return dom.button(
        classes: 'arcane-icon-card',
        type: dom.ButtonType.button,
        styles: dom.Styles(raw: {
          ...cardStyles,
          'border': '1px solid var(--border)',
        }),
        events: {'click': (e) => props.onTap!()},
        content,
      );
    }

    return dom.div(
      classes: 'arcane-icon-card',
      styles: dom.Styles(raw: cardStyles),
      content,
    );
  }
}