import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../core/props/expander_props.dart';
import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

/// An expandable/collapsible component.
class ArcaneExpander extends StatelessComponent {
  /// Header content (always visible)
  final Component header;

  /// Expandable content
  final Component child;

  /// Whether initially expanded
  final bool initiallyExpanded;

  /// Callback when expansion changes
  final void Function(bool expanded)? onExpansionChanged;

  /// Custom leading icon
  final Component? leading;

  /// Whether to show the expansion icon
  final bool showIcon;

  /// Custom padding for the content
  final EdgeInsets? contentPadding;

  /// Whether to maintain child state when collapsed
  final bool maintainState;

  const ArcaneExpander({
    required this.header,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.leading,
    this.showIcon = true,
    this.contentPadding,
    this.maintainState = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.expander(ExpanderProps(
      header: header,
      child: child,
      initiallyExpanded: initiallyExpanded,
      onExpansionChanged: onExpansionChanged,
      leading: leading,
      showIcon: showIcon,
      contentPadding: contentPadding,
      maintainState: maintainState,
    ));
  }
}

/// An accordion component (multiple expanders where only one can be open)
class ArcaneAccordion extends StatefulComponent {
  final List<ArcaneAccordionItem> items;
  final int? initialOpenIndex;
  final bool allowMultiple;
  final double gap;

  const ArcaneAccordion({
    required this.items,
    this.initialOpenIndex,
    this.allowMultiple = false,
    this.gap = 0,
    super.key,
  });

  @override
  State<ArcaneAccordion> createState() => _AccordionState();
}

class _AccordionState extends State<ArcaneAccordion> {
  late Set<int> _expandedIndices;

  @override
  void initState() {
    super.initState();
    _expandedIndices =
        component.initialOpenIndex != null ? {component.initialOpenIndex!} : {};
  }

  void _toggleItem(int index) {
    setState(() {
      if (component.allowMultiple) {
        if (_expandedIndices.contains(index)) {
          _expandedIndices.remove(index);
        } else {
          _expandedIndices.add(index);
        }
      } else {
        if (_expandedIndices.contains(index)) {
          _expandedIndices.clear();
        } else {
          _expandedIndices = {index};
        }
      }
    });
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-accordion',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${component.gap}px',
      }),
      [
        for (var i = 0; i < component.items.length; i++)
          _buildItem(context, i, component.items[i]),
      ],
    );
  }

  Component _buildItem(
      BuildContext context, int index, ArcaneAccordionItem item) {
    final bool isExpanded = _expandedIndices.contains(index);

    return div(
      classes: 'arcane-accordion-item ${isExpanded ? 'expanded' : ''}',
      styles: const Styles(raw: {
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'overflow': 'hidden',
      }),
      [
        button(
          classes: 'arcane-accordion-header',
          attributes: {
            'type': 'button',
            'aria-expanded': '$isExpanded',
          },
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '1rem',
            'width': '100%',
            'padding': '1rem 1.5rem',
            'background-color': 'var(--card)',
            'border': 'none',
            'cursor': 'pointer',
            'transition': 'all 150ms ease',
            'text-align': 'left',
          }),
          events: {
            'click': (event) => _toggleItem(index),
          },
          [
            if (item.icon != null) item.icon!,
            span(
              styles: const Styles(raw: {
                'flex': '1',
                'font-weight': '500',
                'color': 'var(--foreground)',
              }),
              [text(item.title)],
            ),
            span(
              styles: Styles(raw: {
                'color': 'var(--muted-foreground)',
                'transition': 'transform 150ms ease',
                'transform': isExpanded ? 'rotate(180deg)' : 'rotate(0)',
              }),
              [text('\u25BC')],
            ),
          ],
        ),
        if (isExpanded)
          div(
            classes: 'arcane-accordion-content',
            styles: const Styles(raw: {
              'padding': '1.5rem',
              'background-color': 'var(--card)',
              'border-top': '1px solid var(--border)',
            }),
            [item.content],
          ),
      ],
    );
  }
}

/// An accordion item
class ArcaneAccordionItem {
  final String title;
  final Component content;
  final Component? icon;

  const ArcaneAccordionItem({
    required this.title,
    required this.content,
    this.icon,
  });
}
