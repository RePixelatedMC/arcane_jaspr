import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tile_props.dart';

/// Codex Tile renderer.
class CodexTile extends StatelessComponent {
  final TileProps props;

  const CodexTile(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isInteractive = props.onTap != null && !props.disabled;
    final String padding = props.padding ?? (props.dense ? '0.75rem 1rem' : '1rem 1.25rem');

    return dom.div(
      classes: 'codex-tile ${props.selected ? 'selected' : ''} ${props.disabled ? 'disabled' : ''} ${isInteractive ? 'interactive' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--arcane-space-4)',
        'padding': padding,
        'background-color': props.selected
            ? 'rgba(var(--codex-accent-rgb, 16, 185, 129), 0.1)'
            : 'transparent',
        'border-radius': 'var(--radius)',
        'cursor': isInteractive ? 'pointer' : 'default',
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all var(--arcane-transition)',
      }),
      events: isInteractive ? {'click': (_) => props.onTap!()} : null,
      [
        // Leading
        if (props.leading != null)
          dom.div(
            classes: 'codex-tile-leading',
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
            }),
            [props.leading!],
          ),

        // Content
        dom.div(
          classes: 'codex-tile-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--arcane-space-1)',
          }),
          [
            // Title
            if (props.titleWidget != null)
              props.titleWidget!
            else if (props.title != null)
              dom.div(
                classes: 'codex-tile-title',
                styles: dom.Styles(raw: {
                  'font-size': props.dense ? '0.875rem' : '0.9375rem',
                  'font-weight': 'var(--arcane-font-weight-medium)',
                  'color': props.selected ? 'var(--codex-accent, #10b981)' : 'var(--foreground)',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                }),
                [Component.text(props.title!)],
              ),

            // Subtitle
            if (props.subtitleWidget != null)
              props.subtitleWidget!
            else if (props.subtitle != null)
              dom.div(
                classes: 'codex-tile-subtitle',
                styles: dom.Styles(raw: {
                  'font-size': props.dense ? '0.75rem' : '0.8125rem',
                  'color': 'var(--muted-foreground)',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                }),
                [Component.text(props.subtitle!)],
              ),
          ],
        ),

        // Trailing
        if (props.trailing != null)
          dom.div(
            classes: 'codex-tile-trailing',
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
            }),
            [props.trailing!],
          ),
      ],
    );
  }
}

/// Codex NavTile renderer.
class CodexNavTile extends StatelessComponent {
  final NavTileProps props;

  const CodexNavTile(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isInteractive = props.onTap != null && !props.disabled;

    return dom.div(
      classes: 'codex-nav-tile ${props.selected ? 'selected' : ''} ${props.disabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.75rem',
        'padding': '0.75rem 1rem',
        'background-color': props.selected
            ? 'rgba(var(--codex-accent-rgb, 16, 185, 129), 0.1)'
            : 'transparent',
        'border-radius': 'var(--radius)',
        'cursor': isInteractive ? 'pointer' : 'default',
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all var(--arcane-transition)',
        if (props.selected) 'border-left': '3px solid var(--codex-accent, #10b981)',
      }),
      events: isInteractive ? {'click': (_) => props.onTap!()} : null,
      [
        // Icon
        if (props.icon != null)
          dom.div(
            classes: 'codex-nav-tile-icon',
            styles: dom.Styles(raw: {
              'color': props.selected ? 'var(--codex-accent, #10b981)' : 'var(--muted-foreground)',
              'flex-shrink': '0',
            }),
            [props.icon!],
          ),

        // Label
        dom.span(
          classes: 'codex-nav-tile-label',
          styles: dom.Styles(raw: {
            'flex': '1',
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': props.selected ? '500' : '400',
            'color': props.selected ? 'var(--codex-accent, #10b981)' : 'var(--foreground)',
          }),
          [Component.text(props.label)],
        ),

        // Badge
        if (props.badge != null)
          dom.span(
            classes: 'codex-nav-tile-badge',
            styles: const dom.Styles(raw: {
              'padding': '0.125rem 0.5rem',
              'font-size': 'var(--arcane-font-size-xs)',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'background-color': 'var(--codex-accent, #10b981)',
              'color': '#ffffff',
              'border-radius': 'var(--arcane-radius-full)',
            }),
            [Component.text(props.badge!)],
          ),
      ],
    );
  }
}
