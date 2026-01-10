import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/radio_cards_props.dart';

/// Renders a radio cards component.
class ShadcnRadioCards<T> extends StatefulComponent {
  final RadioCardsProps<T> props;

  const ShadcnRadioCards(this.props, {super.key});

  @override
  State<ShadcnRadioCards<T>> createState() => _ShadcnRadioCardsState<T>();
}

class _ShadcnRadioCardsState<T> extends State<ShadcnRadioCards<T>> {
  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-radio-cards',
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
      classes: 'arcane-radio-card ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'flex-start',
        'padding': '1rem',
        'border-radius': 'var(--arcane-radius-sm)',
        'border': isSelected
            ? '2px solid var(--accent)'
            : '2px solid var(--border)',
        'background-color':
            isSelected ? 'color-mix(in srgb, var(--accent) 10%, transparent)' : 'var(--card)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all var(--arcane-transition)',
        'text-align': 'left',
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
              'margin-bottom': '0.5rem',
              'color': isSelected ? 'var(--accent)' : 'var(--muted-foreground)',
            }),
            [item.icon!],
          ),
        if (item.title != null)
          dom.div(
            classes: 'arcane-radio-card-title',
            styles: dom.Styles(raw: {
              'font-weight': 'var(--font-weight-semibold)',
              'color': isSelected ? 'var(--accent)' : 'var(--foreground)',
              'margin-bottom': item.subtitle != null ? '0.25rem' : '0',
            }),
            [Component.text(item.title!)],
          ),
        if (item.subtitle != null)
          dom.div(
            classes: 'arcane-radio-card-subtitle',
            styles: dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': isSelected ? 'var(--accent)' : 'var(--muted-foreground)',
            }),
            [Component.text(item.subtitle!)],
          ),
        if (item.child != null) item.child!,
      ],
    );
  }
}

/// Renders a selectable chip group component.
Component renderSelectableChipGroup(SelectableChipGroupProps props) {
  return dom.div(
    classes: 'arcane-chip-group',
    styles: dom.Styles(raw: {
      'display': 'flex',
      'flex-wrap': props.wrap ? 'wrap' : 'nowrap',
      'gap': '${props.gap}px',
    }),
    props.children,
  );
}

/// Renders a chip component.
Component renderArcaneChip(ArcaneChipProps props) {
  return dom.button(
    classes: 'arcane-chip ${props.selected ? 'selected' : ''} ${props.disabled ? 'disabled' : ''}',
    styles: dom.Styles(raw: {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '6px',
      'padding': '6px 12px',
      'border-radius': 'var(--arcane-radius-full)',
      'font-size': 'var(--font-size-sm)',
      'border': props.selected
          ? '1px solid var(--accent)'
          : '1px solid var(--border)',
      'background-color': props.selected
          ? 'color-mix(in srgb, var(--accent) 10%, transparent)'
          : 'var(--card)',
      'color': props.selected ? 'var(--accent)' : 'var(--foreground)',
      'cursor': props.disabled ? 'not-allowed' : 'pointer',
      'opacity': props.disabled ? '0.5' : '1',
      'transition': 'all var(--arcane-transition)',
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
            'margin-left': '0.25rem',
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
