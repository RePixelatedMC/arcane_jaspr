import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/alert_props.dart';

class NeubrutalismAlert extends StatelessComponent {
  final AlertProps props;

  const NeubrutalismAlert(this.props, {super.key});

  String get _defaultIcon => switch (props.color) {
    ColorVariant.info => '\u2139',
    ColorVariant.success => '\u2713',
    ColorVariant.warning => '\u26A0',
    ColorVariant.destructive => '\u2715',
    ColorVariant.primary => '\u2139',
    ColorVariant.secondary => '\u2139',
  };

  String get _accentColor => switch (props.color) {
    ColorVariant.info => 'var(--info, #3b82f6)',
    ColorVariant.success => 'var(--success, #22c55e)',
    ColorVariant.warning => 'var(--warning, #facc15)',
    ColorVariant.destructive => 'var(--destructive)',
    ColorVariant.primary => 'var(--nb-accent, var(--primary))',
    ColorVariant.secondary => 'var(--nb-accent-cool, var(--secondary))',
  };

  @override
  Component build(BuildContext context) {
    String accent = _accentColor;
    bool isSolid = props.style == AlertStyle.solid;

    Map<String, String> containerStyles = switch (props.style) {
      AlertStyle.solid => <String, String>{
        'background-color': accent,
        'color': 'var(--nb-ink, #000)',
        'border': 'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
      AlertStyle.subtle => <String, String>{
        'background-color': 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
      AlertStyle.outline => <String, String>{
        'background-color': 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow': 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
      },
      AlertStyle.accent => <String, String>{
        'background-color': 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
        'border-left':
            'calc(var(--nb-border-thick, 4px) * 2) solid $accent',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
    };

    return dom.div(
      classes: 'neubrutalism-alert',
      attributes: <String, String>{
        'role': 'alert',
        'data-variant': props.color.name,
        'data-style': props.style.name,
      },
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'width': '100%',
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': '0.75rem',
          'padding': '1rem 1.125rem',
          ...containerStyles,
        },
      ),
      <Component>[
        if (props.showIcon)
          dom.div(
            classes: 'neubrutalism-alert-icon',
            styles: dom.Styles(
              raw: <String, String>{
                'flex-shrink': '0',
                'width': '1.5rem',
                'height': '1.5rem',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background-color':
                    isSolid ? 'var(--nb-paper, #fff)' : accent,
                'color':
                    isSolid ? accent : 'var(--nb-ink, #000)',
                'border':
                    'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'font-size': '0.875rem',
                'font-weight': '900',
                'margin-top': '1px',
              },
            ),
            <Component>[props.icon ?? Component.text(_defaultIcon)],
          ),
        dom.div(
          classes: 'neubrutalism-alert-content',
          styles: const dom.Styles(
            raw: <String, String>{'flex': '1', 'min-width': '0'},
          ),
          <Component>[
            if (props.title != null)
              dom.div(
                classes: 'neubrutalism-alert-title',
                styles: dom.Styles(
                  raw: <String, String>{
                    'font-family': 'var(--font-heading)',
                    'font-weight': '900',
                    'line-height': '1.1',
                    'letter-spacing': '-0.01em',
                    'color':
                        isSolid ? 'var(--nb-ink, #000)' : 'var(--foreground)',
                    if (props.message != null || props.child != null)
                      'margin-bottom': '0.25rem',
                  },
                ),
                <Component>[Component.text(props.title!)],
              ),
            if (props.message != null)
              dom.div(
                classes: 'neubrutalism-alert-description',
                styles: dom.Styles(
                  raw: <String, String>{
                    'font-size': 'var(--font-size-sm)',
                    'line-height': '1.5',
                    'font-weight': '500',
                    'color': isSolid
                        ? 'var(--nb-ink, #000)'
                        : 'var(--foreground)',
                  },
                ),
                <Component>[Component.text(props.message!)],
              ),
            if (props.child != null) props.child!,
            if (props.action != null)
              dom.div(
                styles: const dom.Styles(
                  raw: <String, String>{'margin-top': '0.75rem'},
                ),
                <Component>[props.action!],
              ),
          ],
        ),
        if (props.dismissible)
          dom.button(
            type: dom.ButtonType.button,
            classes: 'neubrutalism-alert-dismiss',
            attributes: const <String, String>{'aria-label': 'Dismiss'},
            styles: dom.Styles(
              raw: <String, String>{
                'position': 'absolute',
                'right': '0.5rem',
                'top': '0.5rem',
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '1.5rem',
                'height': '1.5rem',
                'padding': '0',
                'border':
                    'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                'background-color': 'var(--nb-paper, #fff)',
                'color': 'var(--nb-ink, #000)',
                'cursor': 'pointer',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'font-size': '0.875rem',
                'font-weight': '900',
                'line-height': '1',
              },
            ),
            events: <String, EventCallback>{
              'click': (_) => props.onDismiss?.call(),
            },
            <Component>[const Component.text('\u00D7')],
          ),
      ],
    );
  }
}
