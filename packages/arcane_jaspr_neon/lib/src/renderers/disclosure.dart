import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/disclosure_props.dart';

/// Neon Disclosure renderer.
class NeonDisclosure extends StatelessComponent {
  final DisclosureProps props;

  const NeonDisclosure(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (
      String containerBg,
      String containerBorder,
      String summaryBg,
      String contentBorder,
      String contentPadding,
      String? containerClip,
    ) = switch (props.variant) {
      DisclosureVariant.default_ => (
        'transparent',
        'none',
        'var(--neon-panel-tint)',
        '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
        '1.25rem',
        null,
      ),
      DisclosureVariant.minimal => (
        'transparent',
        'none',
        'transparent',
        'none',
        '0.25rem 0 0 0',
        null,
      ),
      DisclosureVariant.bordered => (
        'transparent',
        '1px solid var(--neon-panel-border)',
        'transparent',
        '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
        '1.25rem',
        'var(--neon-clip-md)',
      ),
      DisclosureVariant.filled => (
        'var(--neon-panel-surface)',
        '1px solid var(--neon-panel-border)',
        'var(--neon-panel-tint)',
        '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
        '1.25rem',
        'var(--neon-clip-md)',
      ),
    };

    final allClasses = [
      'neon-disclosure',
      'neon-disclosure-${props.variant.name}',
      if (props.classes != null) props.classes,
    ].join(' ');

    return Component.element(
      tag: 'details',
      classes: allClasses,
      attributes: {if (props.open) 'open': ''},
      styles: dom.Styles(
        raw: {
          'background': containerBg,
          'border': containerBorder,
          if (containerClip != null) 'clip-path': containerClip,
          'overflow': 'hidden',
        },
      ),
      children: [
        // Summary (clickable header)
        Component.element(
          tag: 'summary',
          classes: 'neon-disclosure-summary',
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'gap': 'var(--space-4)',
              'padding': '0.75rem 1.25rem',
              'background': summaryBg,
              'font-family': 'var(--font-heading)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.04em',
              'cursor': 'pointer',
              'transition': 'background 140ms ease',
              'list-style': 'none',
              '-webkit-user-select': 'none',
              'user-select': 'none',
            },
          ),
          children: [
            dom.span(
              classes: 'neon-disclosure-summary-content',
              styles: const dom.Styles(raw: {'flex': '1', 'min-width': '0'}),
              [props.summary],
            ),
            if (props.showChevron)
              const dom.span(
                classes: 'neon-disclosure-chevron',
                styles: dom.Styles(
                  raw: {
                    'color': 'var(--neon-accent)',
                    'font-size': '0.625rem',
                    'transition': 'transform 200ms ease',
                  },
                ),
                [Component.text('\u25BC')],
              ),
          ],
        ),
        // Content
        dom.div(
          classes:
              'neon-disclosure-content${props.showTreeLines ? ' arcane-tree-lines' : ''}',
          styles: dom.Styles(
            raw: {
              'padding': contentPadding,
              'border-top': contentBorder,
              if (props.showTreeLines) ...{
                'padding-left': '1.5rem',
                'position': 'relative',
              },
            },
          ),
          [props.child],
        ),
      ],
    );
  }
}

/// Neon Disclosure Group renderer.
class NeonDisclosureGroup extends StatelessComponent {
  final DisclosureGroupProps props;

  const NeonDisclosureGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neon-disclosure-group',
      styles: dom.Styles(
        raw: {'display': 'flex', 'flex-direction': 'column', 'gap': props.gap},
      ),
      [
        for (var i = 0; i < props.items.length; i++)
          NeonDisclosure(
            DisclosureProps(
              summary: props.items[i].summary,
              child: props.items[i].content,
              open: i == props.initialOpenIndex,
              variant: props.variant,
              showChevron: props.items[i].showChevron,
            ),
          ),
      ],
    );
  }
}
