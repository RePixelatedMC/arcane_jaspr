import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/disclosure_props.dart';

/// Codex Disclosure renderer.
class CodexDisclosure extends StatelessComponent {
  final DisclosureProps props;

  const CodexDisclosure(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (
      String containerBg,
      String containerBorder,
      String summaryBg,
      String contentBorder,
      String contentPadding,
    ) = switch (props.variant) {
      DisclosureVariant.default_ => (
          'transparent',
          'none',
          'var(--secondary)',
          '1px solid var(--border)',
          '1.25rem',
        ),
      DisclosureVariant.minimal => (
          'transparent',
          'none',
          'transparent',
          'none',
          '0.25rem 0 0 0', // Minimal top padding only
        ),
      DisclosureVariant.bordered => (
          'transparent',
          '1px solid var(--border)',
          'transparent',
          '1px solid var(--border)',
          '1.25rem',
        ),
      DisclosureVariant.filled => (
          'var(--card)',
          '1px solid var(--border)',
          'var(--secondary)',
          '1px solid var(--border)',
          '1.25rem',
        ),
    };

    final allClasses = [
      'codex-disclosure',
      'codex-disclosure-${props.variant.name}',
      if (props.classes != null) props.classes,
    ].join(' ');

    return Component.element(
      tag: 'details',
      classes: allClasses,
      attributes: {
        if (props.open) 'open': '',
      },
      styles: dom.Styles(raw: {
        'background-color': containerBg,
        'border': containerBorder,
        'border-radius': 'var(--radius)',
        'overflow': 'hidden',
      }),
      children: [
        // Summary (clickable header)
        Component.element(
          tag: 'summary',
          classes: 'codex-disclosure-summary',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': 'var(--arcane-space-4)',
            'padding': '0.75rem 1.25rem',
            'background-color': summaryBg,
            'cursor': 'pointer',
            'transition': 'all var(--arcane-transition)',
            'list-style': 'none',
            '-webkit-user-select': 'none',
            'user-select': 'none',
          }),
          children: [
            dom.span(
              classes: 'codex-disclosure-summary-content',
              styles: const dom.Styles(raw: {
                'flex': '1',
                'min-width': '0',
              }),
              [props.summary],
            ),
            if (props.showChevron)
              const dom.span(
                classes: 'codex-disclosure-chevron',
                styles: dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'font-size': 'var(--arcane-font-size-sm)',
                  'transition': 'transform var(--arcane-transition)',
                }),
                [Component.text('\u25BC')],
              ),
          ],
        ),
        // Content
        dom.div(
          classes: 'codex-disclosure-content${props.showTreeLines ? ' arcane-tree-lines' : ''}',
          styles: dom.Styles(raw: {
            'padding': contentPadding,
            'border-top': contentBorder,
            if (props.showTreeLines) ...{
              'padding-left': '1.5rem',
              'position': 'relative',
            },
          }),
          [props.child],
        ),
      ],
    );
  }
}

/// Codex Disclosure Group renderer.
class CodexDisclosureGroup extends StatelessComponent {
  final DisclosureGroupProps props;

  const CodexDisclosureGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-disclosure-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': props.gap,
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          CodexDisclosure(DisclosureProps(
            summary: props.items[i].summary,
            child: props.items[i].content,
            open: i == props.initialOpenIndex,
            variant: props.variant,
            showChevron: props.items[i].showChevron,
          )),
      ],
    );
  }
}
