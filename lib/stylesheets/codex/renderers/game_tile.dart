import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/game_tile_props.dart';

/// Codex GameTile renderer.
class CodexGameTile extends StatefulComponent {
  final GameTileProps props;

  const CodexGameTile(this.props, {super.key});

  @override
  State<CodexGameTile> createState() => _CodexGameTileState();
}

class _CodexGameTileState extends State<CodexGameTile> {
  bool _isHovered = false;

  @override
  Component build(BuildContext context) {
    final bool isSelected = component.props.selected;

    return dom.div(
      classes:
          'codex-game-tile ${isSelected ? 'selected' : ''} ${_isHovered ? 'hovered' : ''}',
      styles: dom.Styles(raw: {
        'width': '200px',
        'position': 'relative',
        'overflow': 'hidden',
        'border-radius': 'var(--radius)',
        'background-color': 'var(--card)',
        'border': isSelected
            ? '2px solid var(--codex-accent)'
            : '1px solid var(--border)',
        'cursor': 'pointer',
        'transition': 'all var(--arcane-transition-slow)',
        'padding': '1rem',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': '0.75rem',
        if (isSelected || _isHovered)
          'box-shadow': '0 0 20px rgba(var(--codex-accent-rgb), 0.2)',
        if (_isHovered) 'transform': 'scale(1.02)',
      }),
      events: {
        'mouseenter': (_) => setState(() => _isHovered = true),
        'mouseleave': (_) => setState(() => _isHovered = false),
        if (component.props.onTap != null)
          'click': (_) => component.props.onTap!(),
      },
      [
        // Icon/Image
        if (component.props.icon != null)
          component.props.icon!
        else if (component.props.iconUrl != null)
          dom.img(
            src: component.props.iconUrl!,
            alt: component.props.name,
            styles: const dom.Styles(raw: {
              'width': '64px',
              'height': '64px',
              'border-radius': 'var(--radius)',
              'object-fit': 'cover',
            }),
          )
        else
          dom.div(
            styles: const dom.Styles(raw: {
              'width': '64px',
              'height': '64px',
              'border-radius': 'var(--radius)',
              'background-color': 'var(--muted)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            }),
            [ArcaneIcon.gamepad(size: IconSize.lg)],
          ),

        // Title
        dom.h3(
          classes: 'codex-game-tile-title',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0',
            'text-align': 'center',
          }),
          [Component.text(component.props.name)],
        ),

        // Subtitle
        if (component.props.subtitle != null)
          dom.span(
            classes: 'codex-game-tile-subtitle',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'color': 'var(--muted-foreground)',
              'text-align': 'center',
            }),
            [Component.text(component.props.subtitle!)],
          ),

        // Badge
        if (component.props.badge != null)
          dom.span(
            classes: 'codex-game-tile-badge',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '0.5rem',
              'right': '0.5rem',
              'padding': '0.125rem 0.5rem',
              'font-size': '0.625rem',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'text-transform': 'uppercase',
              'color': 'var(--codex-accent)',
              'background-color': 'rgba(var(--codex-accent-rgb), 0.1)',
              'border-radius': 'var(--arcane-radius-full)',
            }),
            [Component.text(component.props.badge!)],
          ),

        // Popular indicator
        if (component.props.popular)
          dom.div(
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '0.5rem',
              'left': '0.5rem',
            }),
            [ArcaneIcon.star(size: IconSize.sm)],
          ),

        // Selection indicator
        if (isSelected)
          dom.div(
            classes: 'codex-game-tile-selected-indicator',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '0.5rem',
              'right': '0.5rem',
              'width': '20px',
              'height': '20px',
              'border-radius': '50%',
              'background-color': 'var(--codex-accent)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': '#ffffff',
            }),
            [ArcaneIcon.check(size: IconSize.xs)],
          ),
      ],
    );
  }
}

/// Codex GameSelector renderer.
class CodexGameSelector extends StatelessComponent {
  final GameSelectorProps props;

  const CodexGameSelector(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-game-selector',
      styles: dom.Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat(${props.columns}, 1fr)',
        'gap': '${props.gap}px',
      }),
      [
        // Title
        if (props.title != null)
          dom.h2(
            styles: const dom.Styles(raw: {
              'grid-column': '1 / -1',
              'font-size': 'var(--arcane-font-size-xl)',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'color': 'var(--foreground)',
              'margin': '0 0 0.5rem 0',
            }),
            [Component.text(props.title!)],
          ),

        // Description
        if (props.description != null)
          dom.p(
            styles: const dom.Styles(raw: {
              'grid-column': '1 / -1',
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin': '0 0 1rem 0',
            }),
            [Component.text(props.description!)],
          ),

        // Game tiles
        for (final game in props.games) CodexGameTile(game),
      ],
    );
  }
}

/// Codex GameCard renderer.
class CodexGameCard extends StatelessComponent {
  final GameCardProps props;

  const CodexGameCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-game-card',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'gap': 'var(--arcane-space-4)',
        'padding': '1rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
      }),
      events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
      [
        // Thumbnail
        if (props.icon != null)
          props.icon!
        else if (props.iconUrl != null)
          dom.div(
            classes: 'codex-game-card-thumbnail',
            styles: dom.Styles(raw: {
              'width': '80px',
              'height': '80px',
              'flex-shrink': '0',
              'border-radius': 'var(--radius)',
              'overflow': 'hidden',
              'background-image': 'url(${props.iconUrl})',
              'background-size': 'cover',
              'background-position': 'center',
            }),
            [],
          ),

        // Info
        dom.div(
          classes: 'codex-game-card-info',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--arcane-space-1)',
          }),
          [
            // Title
            dom.h3(
              classes: 'codex-game-card-title',
              styles: const dom.Styles(raw: {
                'font-size': 'var(--arcane-font-size-base)',
                'font-weight': 'var(--arcane-font-weight-semibold)',
                'color': 'var(--foreground)',
                'margin': '0',
              }),
              [Component.text(props.name)],
            ),

            // Description
            if (props.description != null)
              dom.p(
                classes: 'codex-game-card-description',
                styles: const dom.Styles(raw: {
                  'font-size': '0.8125rem',
                  'color': 'var(--muted-foreground)',
                  'margin': '0',
                  'line-height': '1.4',
                }),
                [Component.text(props.description!)],
              ),

            // Status
            if (props.status != null)
              dom.span(
                classes: 'codex-game-card-status',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-xs)',
                  'color': 'var(--codex-accent)',
                }),
                [Component.text(props.status!)],
              ),

            // Features
            if (props.features != null && props.features!.isNotEmpty)
              dom.div(
                classes: 'codex-game-card-features',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': 'var(--arcane-space-1)',
                  'margin-top': '0.5rem',
                }),
                [
                  for (final feature in props.features!)
                    dom.span(
                      classes: 'codex-game-card-feature',
                      styles: const dom.Styles(raw: {
                        'padding': '0.125rem 0.5rem',
                        'font-size': '0.6875rem',
                        'font-weight': 'var(--arcane-font-weight-medium)',
                        'color': 'var(--codex-accent)',
                        'background-color':
                            'rgba(var(--codex-accent-rgb), 0.1)',
                        'border-radius': 'var(--arcane-radius-full)',
                      }),
                      [Component.text(feature)],
                    ),
                ],
              ),

            // CTA
            if (props.ctaText != null)
              dom.button(
                classes: 'codex-game-card-cta',
                styles: const dom.Styles(raw: {
                  'margin-top': '0.5rem',
                  'padding': '0.5rem 1rem',
                  'font-size': 'var(--arcane-font-size-xs)',
                  'font-weight': 'var(--arcane-font-weight-semibold)',
                  'color': 'var(--primary-foreground)',
                  'background-color': 'var(--codex-accent)',
                  'border': 'none',
                  'border-radius': 'var(--radius)',
                  'cursor': 'pointer',
                }),
                [Component.text(props.ctaText!)],
              ),
          ],
        ),
      ],
    );
  }
}
