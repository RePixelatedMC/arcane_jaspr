import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/bar_props.dart';

/// ShadCN Bar renderer.
class ShadcnBar extends StatelessComponent {
  final BarProps props;

  const ShadcnBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveHeight = props.height ?? 56.0;
    final effectivePadding = props.padding ?? '0 1rem';

    // Build title section
    final Component? titleWidget = props.title ??
        (props.titleText != null
            ? dom.span(
                classes: 'arcane-bar-title',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-lg)',
                  'font-weight': 'var(--arcane-font-weight-semibold)',
                  'color': 'var(--foreground)',
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [Component.text(props.titleText!)],
              )
            : null);

    final Component? subtitleWidget = props.subtitle ??
        (props.subtitleText != null
            ? dom.span(
                classes: 'arcane-bar-subtitle',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [Component.text(props.subtitleText!)],
              )
            : null);

    // Show back button?
    final showBack = props.backButton == BarBackButtonMode.always ||
        (props.backButton == BarBackButtonMode.auto && props.onBack != null);

    return dom.header(
      classes: 'arcane-bar ${props.transparent ? 'transparent' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--arcane-space-4)',
        'height': '${effectiveHeight}px',
        'padding': effectivePadding,
        'background-color': props.transparent ? 'transparent' : 'var(--card)',
        if (!props.transparent) 'border-bottom': '1px solid var(--border)',
        'flex-shrink': '0',
      }),
      [
        // Leading section
        if (showBack || (props.leading != null && props.leading!.isNotEmpty))
          dom.div(
            classes: 'arcane-bar-leading',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--arcane-space-2)',
            }),
            [
              if (showBack) _buildBackButton(),
              ...?props.leading,
            ],
          ),

        // Title section
        dom.div(
          classes: 'arcane-bar-content',
          styles: dom.Styles(raw: {
            'flex': '1',
            'display': 'flex',
            'flex-direction': 'column',
            'justify-content': 'center',
            'min-width': '0',
            if (props.centerTitle) 'align-items': 'center',
          }),
          [
            if (titleWidget != null) titleWidget,
            if (subtitleWidget != null) subtitleWidget,
          ],
        ),

        // Trailing section
        if (props.trailing != null && props.trailing!.isNotEmpty)
          dom.div(
            classes: 'arcane-bar-trailing',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--arcane-space-2)',
            }),
            props.trailing!,
          ),
      ],
    );
  }

  Component _buildBackButton() {
    return dom.button(
      classes: 'arcane-bar-back',
      attributes: {'type': 'button', 'aria-label': 'Go back'},
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '36px',
        'height': '36px',
        'border-radius': 'var(--arcane-radius-full)',
        'background': 'transparent',
        'border': 'none',
        'color': 'var(--foreground)',
        'cursor': 'pointer',
        'transition': 'background-color var(--arcane-transition)',
      }),
      events: {
        'click': (event) {
          if (props.onBack != null) {
            props.onBack!();
          }
        },
      },
      [
        const dom.span(
          styles: dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-xl)',
          }),
          [Component.text('\u2190')], // Left arrow
        ),
      ],
    );
  }
}

/// ShadCN Dialog Bar renderer.
class ShadcnDialogBar extends StatelessComponent {
  final DialogBarProps props;

  const ShadcnDialogBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-dialog-bar',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'padding': '1.5rem',
        'border-bottom': '1px solid var(--border)',
      }),
      [
        if (props.title != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-lg)',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.title!)],
          )
        else
          const dom.div([]),
        if (props.onClose != null)
          dom.button(
            attributes: {'type': 'button', 'aria-label': 'Close'},
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '32px',
              'height': '32px',
              'border-radius': 'var(--arcane-radius-full)',
              'background': 'transparent',
              'border': 'none',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'transition': 'all var(--arcane-transition)',
              'font-size': 'var(--arcane-font-size-xl)',
            }),
            events: {
              'click': (event) => props.onClose!(),
            },
            [const Component.text('\u00D7')], // Multiplication sign (x)
          ),
      ],
    );
  }
}