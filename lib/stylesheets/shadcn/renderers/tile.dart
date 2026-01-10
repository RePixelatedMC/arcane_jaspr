import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tile_props.dart';

/// ShadCN Tile renderer.
class ShadcnTile extends StatelessComponent {
  final TileProps props;

  const ShadcnTile(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectivePadding = props.padding ?? (props.dense ? '0.5rem 1rem' : '0.75rem 1rem');

    return dom.div(
      classes: 'arcane-tile ${props.selected ? "selected" : ""} ${props.disabled ? "disabled" : ""} ${props.onTap != null ? "clickable" : ""}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        'padding': effectivePadding,
        'background-color': props.selected ? 'color-mix(in srgb, var(--accent) 10%, transparent)' : 'transparent',
        'cursor': props.disabled ? 'not-allowed' : (props.onTap != null ? 'pointer' : 'default'),
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all var(--arcane-transition)',
        'border-radius': 'var(--radius)',
      }),
      events: props.onTap != null && !props.disabled
          ? {'click': (event) => props.onTap!()}
          : null,
      [
        // Leading
        if (props.leading != null)
          dom.div(
            classes: 'arcane-tile-leading',
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': props.selected ? 'var(--accent)' : 'var(--muted-foreground)',
            }),
            [props.leading!],
          ),

        // Content
        dom.div(
          classes: 'arcane-tile-content',
          styles: dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': props.dense ? '2px' : '0.25rem',
          }),
          [
            // Title
            if (props.titleWidget != null)
              props.titleWidget!
            else if (props.title != null)
              dom.span(
                classes: 'arcane-tile-title',
                styles: dom.Styles(raw: {
                  'font-size': props.dense ? '0.875rem' : '1rem',
                  'font-weight': 'var(--font-weight-medium)',
                  'color': props.selected ? 'var(--accent)' : 'var(--foreground)',
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [Component.text(props.title!)],
              ),

            // Subtitle
            if (props.subtitleWidget != null)
              props.subtitleWidget!
            else if (props.subtitle != null)
              dom.span(
                classes: 'arcane-tile-subtitle',
                styles: dom.Styles(raw: {
                  'font-size': props.dense ? '0.75rem' : '0.875rem',
                  'color': props.selected ? 'var(--accent)' : 'var(--muted-foreground)',
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [Component.text(props.subtitle!)],
              ),
          ],
        ),

        // Trailing
        if (props.trailing != null)
          dom.div(
            classes: 'arcane-tile-trailing',
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'display': 'flex',
              'align-items': 'center',
              'color': props.selected ? 'var(--accent)' : 'var(--muted-foreground)',
            }),
            [props.trailing!],
          ),
      ],
    );
  }
}

/// ShadCN NavTile renderer.
class ShadcnNavTile extends StatelessComponent {
  final NavTileProps props;

  const ShadcnNavTile(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.button(
      classes: 'arcane-nav-tile ${props.selected ? "selected" : ""} ${props.disabled ? "disabled" : ""}',
      attributes: {
        'type': 'button',
        if (props.disabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        'width': '100%',
        'padding': '0.5rem 1rem',
        'background-color': props.selected ? 'color-mix(in srgb, var(--accent) 10%, transparent)' : 'transparent',
        'color': props.selected ? 'var(--accent)' : 'var(--foreground)',
        'border-radius': 'var(--radius)',
        'border': 'none',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all var(--arcane-transition)',
        'text-align': 'left',
        'font-size': 'var(--font-size-base)',
        'font-weight': props.selected ? '600' : '500',
      }),
      events: {
        'click': (event) {
          if (!props.disabled && props.onTap != null) {
            props.onTap!();
          }
        },
      },
      [
        if (props.icon != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            }),
            [props.icon!],
          ),
        dom.span(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'overflow': 'hidden',
            'text-overflow': 'ellipsis',
            'white-space': 'nowrap',
          }),
          [Component.text(props.label)],
        ),
        if (props.badge != null)
          dom.span(
            classes: 'arcane-nav-tile-badge',
            styles: const dom.Styles(raw: {
              'background-color': 'var(--primary)',
              'color': 'var(--primary-foreground)',
              'font-size': 'var(--font-size-xs)',
              'padding': '2px 6px',
              'border-radius': 'var(--arcane-radius-full)',
              'font-weight': 'var(--font-weight-medium)',
            }),
            [Component.text(props.badge!)],
          ),
      ],
    );
  }
}
