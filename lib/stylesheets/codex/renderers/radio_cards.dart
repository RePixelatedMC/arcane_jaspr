import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/radio_cards_props.dart';

/// Codex Radio Cards renderer.
class CodexRadioCards<T> extends StatefulComponent {
  final RadioCardsProps<T> props;

  const CodexRadioCards(this.props, {super.key});

  @override
  State<CodexRadioCards<T>> createState() => _CodexRadioCardsState<T>();
}

class _CodexRadioCardsState<T> extends State<CodexRadioCards<T>> {
  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-radio-cards',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-wrap': component.props.wrap ? 'wrap' : 'nowrap',
        'gap': '${component.props.gap}px',
      }),
      [
        for (final item in component.props.items)
          _buildCard(context, item),
      ],
    );
  }

  Component _buildCard(BuildContext context, RadioCardItemData<T> item) {
    final bool isSelected = component.props.value == item.value;
    final bool isDisabled = item.disabled;

    return dom.button(
      classes: 'codex-radio-card ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'flex-start',
        'padding': '1.25rem',
        'border-radius': 'var(--radius)',
        'border': isSelected
            ? '2px solid var(--codex-accent)'
            : '2px solid var(--border)',
        'background-color':
            isSelected ? 'rgba(var(--codex-accent-rgb), 0.1)' : 'var(--card)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'text-align': 'left',
        if (isSelected) 'box-shadow': '0 0 20px rgba(var(--codex-accent-rgb), 0.15)',
        if (component.props.cardWidth != null) 'width': '${component.props.cardWidth}px',
        'flex': component.props.cardWidth == null ? '1' : 'none',
        'min-width': '0',
      }),
      events: {
        'click': (event) {
          if (!isDisabled && component.props.onChanged != null) {
            component.props.onChanged!(item.value);
          }
        },
      },
      [
        if (item.icon != null)
          dom.div(
            styles: dom.Styles(raw: {
              'margin-bottom': '0.75rem',
              'color': isSelected ? 'var(--codex-accent)' : 'var(--muted-foreground)',
            }),
            [item.icon!],
          ),
        if (item.title != null)
          dom.div(
            classes: 'codex-radio-card-title',
            styles: dom.Styles(raw: {
              'font-weight': '600',
              'color': isSelected ? 'var(--codex-accent)' : 'var(--foreground)',
              'margin-bottom': item.subtitle != null ? '0.5rem' : '0',
            }),
            [Component.text(item.title!)],
          ),
        if (item.subtitle != null)
          dom.div(
            classes: 'codex-radio-card-subtitle',
            styles: dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': isSelected ? 'var(--codex-accent)' : 'var(--muted-foreground)',
            }),
            [Component.text(item.subtitle!)],
          ),
        if (item.child != null) item.child!,
      ],
    );
  }
}

/// Renders a Codex selectable chip group component.
Component renderSelectableChipGroup(SelectableChipGroupProps props) {
  return dom.div(
    classes: 'codex-chip-group',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'flex-wrap': props.wrap ? 'wrap' : 'nowrap',
      'gap': '${props.gap}px',
    }),
    props.children,
  );
}

/// Renders a Codex chip component.
Component renderArcaneChip(ArcaneChipProps props) {
  return dom.button(
    classes: 'codex-chip ${props.selected ? 'selected' : ''} ${props.disabled ? 'disabled' : ''}',
    styles: dom.Styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '8px',
      'padding': '8px 14px',
      'border-radius': '9999px',
      'font-size': '0.875rem',
      'border': props.selected
          ? '1px solid var(--codex-accent)'
          : '1px solid var(--border)',
      'background-color': props.selected
          ? 'rgba(var(--codex-accent-rgb), 0.1)'
          : 'var(--card)',
      'color': props.selected ? 'var(--codex-accent)' : 'var(--foreground)',
      'cursor': props.disabled ? 'not-allowed' : 'pointer',
      'opacity': props.disabled ? '0.5' : '1',
      'transition': 'all 150ms ease',
      if (props.selected) 'box-shadow': '0 0 15px rgba(var(--codex-accent-rgb), 0.15)',
    }),
    events: {
      'click': (event) {
        if (!props.disabled && props.onTap != null) {
          props.onTap!();
        }
      },
    },
    [
      if (props.avatar != null) props.avatar!,
      Component.text(props.label),
      if (props.deleteIcon != null && props.onDeleted != null)
        dom.button(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'margin-left': '0.5rem',
            'color': 'inherit',
            'opacity': '0.7',
            'background': 'none',
            'border': 'none',
            'padding': '0',
            'cursor': 'pointer',
          }),
          events: {
            'click': (event) {
              event.stopPropagation();
              props.onDeleted!();
            },
          },
          [props.deleteIcon!],
        ),
    ],
  );
}
