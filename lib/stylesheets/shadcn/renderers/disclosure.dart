import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/disclosure_props.dart';

/// ShadCN Disclosure renderer.
///
/// Uses native HTML details/summary elements for static site compatibility.
/// Similar to ShadCN Collapsible but using native browser behavior.
class ShadcnDisclosure extends StatelessComponent {
  final DisclosureProps props;

  const ShadcnDisclosure(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (
      String containerBg,
      String containerBorder,
      String summaryBg,
      String contentBorder,
    ) = switch (props.variant) {
      DisclosureVariant.default_ => (
          'transparent',
          'none',
          'var(--muted)',
          '1px solid var(--border)',
        ),
      DisclosureVariant.minimal => (
          'transparent',
          'none',
          'transparent',
          'none',
        ),
      DisclosureVariant.bordered => (
          'transparent',
          '1px solid var(--border)',
          'transparent',
          '1px solid var(--border)',
        ),
      DisclosureVariant.filled => (
          'var(--card)',
          '1px solid var(--border)',
          'var(--muted)',
          '1px solid var(--border)',
        ),
    };

    final allClasses = [
      'arcane-disclosure',
      'arcane-disclosure-${props.variant.name}',
      if (props.classes != null) props.classes,
    ].join(' ');

    // Use Component.element for details/summary which aren't in dom.*
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
          classes: 'arcane-disclosure-summary',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': '1rem',
            'padding': '0.5rem 1rem',
            'background-color': summaryBg,
            'cursor': 'pointer',
            'transition': 'all 150ms ease',
            'list-style': 'none',
            '-webkit-user-select': 'none',
            'user-select': 'none',
          }),
          children: [
            dom.span(
              classes: 'arcane-disclosure-summary-content',
              styles: const dom.Styles(raw: {
                'flex': '1',
                'min-width': '0',
              }),
              [props.summary],
            ),
            if (props.showChevron)
              const dom.span(
                classes: 'arcane-disclosure-chevron',
                styles: dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'font-size': '0.875rem',
                  'transition': 'transform 150ms ease',
                }),
                [Component.text('\u25BC')],
              ),
          ],
        ),
        // Content
        dom.div(
          classes: 'arcane-disclosure-content',
          styles: dom.Styles(raw: {
            'padding': '1rem',
            'border-top': contentBorder,
          }),
          [props.child],
        ),
      ],
    );
  }
}

/// ShadCN Disclosure Group renderer.
class ShadcnDisclosureGroup extends StatelessComponent {
  final DisclosureGroupProps props;

  const ShadcnDisclosureGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-disclosure-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': props.gap,
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          ShadcnDisclosure(DisclosureProps(
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