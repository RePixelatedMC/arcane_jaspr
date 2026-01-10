import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/expander_props.dart';
import '../../../util/arcane.dart';

/// ShadCN Expander renderer.
///
/// A stateful expand/collapse component. Requires client-side hydration
/// for interactivity. For static sites, use Disclosure instead.
class ShadcnExpander extends StatefulComponent {
  final ExpanderProps props;

  const ShadcnExpander(this.props, {super.key});

  @override
  State<ShadcnExpander> createState() => _ShadcnExpanderState();
}

class _ShadcnExpanderState extends State<ShadcnExpander> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = component.props.initiallyExpanded;
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    component.props.onExpansionChanged?.call(_isExpanded);
  }

  @override
  Component build(BuildContext context) {
    final EdgeInsets contentPadding =
        component.props.contentPadding ?? const EdgeInsets.all(16);

    return dom.div(
      classes: 'arcane-expander ${_isExpanded ? 'expanded' : ''}',
      styles: const dom.Styles(raw: {
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'overflow': 'hidden',
      }),
      [
        // Header (clickable)
        dom.button(
          classes: 'arcane-expander-header',
          attributes: {
            'type': 'button',
            'aria-expanded': '$_isExpanded',
          },
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': 'var(--arcane-space-4)',
            'width': '100%',
            'padding': '1rem 1.5rem',
            'background-color': 'var(--card)',
            'border': 'none',
            'cursor': 'pointer',
            'transition': 'all var(--arcane-transition)',
            'text-align': 'left',
          }),
          events: {
            'click': (event) => _toggleExpansion(),
          },
          [
            if (component.props.leading != null) component.props.leading!,
            dom.div(
              styles: const dom.Styles(raw: {
                'flex': '1',
                'min-width': '0',
              }),
              [component.props.header],
            ),
            if (component.props.showIcon)
              dom.span(
                classes: 'arcane-expander-icon',
                styles: dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'transition': 'transform var(--arcane-transition)',
                  'transform': _isExpanded ? 'rotate(180deg)' : 'rotate(0)',
                }),
                [const Component.text('\u25BC')],
              ),
          ],
        ),

        // Content
        if (_isExpanded || component.props.maintainState)
          dom.div(
            classes: 'arcane-expander-content',
            styles: dom.Styles(raw: {
              'padding': contentPadding.padding,
              'background-color': 'var(--card)',
              'border-top': '1px solid var(--border)',
              if (!_isExpanded) 'display': 'none',
            }),
            [component.props.child],
          ),
      ],
    );
  }
}