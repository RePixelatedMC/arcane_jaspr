import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

/// A group of selectable cards where only one can be selected at a time.
class ArcaneRadioCards<T> extends StatefulComponent {
  /// The items to display
  final List<ArcaneRadioCardItem<T>> items;

  /// The currently selected value
  final T? value;

  /// Callback when selection changes
  final void Function(T value)? onChanged;

  /// Gap between cards
  final double gap;

  /// Whether to wrap cards
  final bool wrap;

  /// Card width (null for auto)
  final double? cardWidth;

  const ArcaneRadioCards({
    required this.items,
    this.value,
    this.onChanged,
    this.gap = 12,
    this.wrap = true,
    this.cardWidth,
    super.key,
  });

  @override
  State<ArcaneRadioCards<T>> createState() => _ArcaneRadioCardsState<T>();
}

class _ArcaneRadioCardsState<T> extends State<ArcaneRadioCards<T>> {
  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-radio-cards',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-wrap': component.wrap ? 'wrap' : 'nowrap',
        'gap': '${component.gap}px',
      }),
      [
        for (final item in component.items)
          _buildCard(context, item),
      ],
    );
  }

  Component _buildCard(BuildContext context, ArcaneRadioCardItem<T> item) {
    final bool isSelected = component.value == item.value;
    final bool isDisabled = item.disabled;

    return button(
      classes: 'arcane-radio-card ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'flex-start',
        'padding': '1rem',
        'border-radius': '0.375rem',
        'border': isSelected
            ? '2px solid var(--accent)'
            : '2px solid var(--border)',
        'background-color':
            isSelected ? 'hsl(var(--accent) / 0.1)' : 'var(--card)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'text-align': 'left',
        if (component.cardWidth != null) 'width': '${component.cardWidth}px',
        'flex': component.cardWidth == null ? '1' : 'none',
        'min-width': '0',
      }),
      events: {
        'click': (event) {
          if (!isDisabled && component.onChanged != null) {
            component.onChanged!(item.value);
          }
        },
      },
      [
        if (item.icon != null)
          div(
            styles: Styles(raw: {
              'margin-bottom': '0.5rem',
              'color': isSelected ? 'var(--accent)' : 'var(--muted-foreground)',
            }),
            [item.icon!],
          ),
        if (item.title != null)
          div(
            classes: 'arcane-radio-card-title',
            styles: Styles(raw: {
              'font-weight': '600',
              'color': isSelected ? 'var(--accent)' : 'var(--foreground)',
              'margin-bottom': item.subtitle != null ? '0.25rem' : '0',
            }),
            [Component.text(item.title!)],
          ),
        if (item.subtitle != null)
          div(
            classes: 'arcane-radio-card-subtitle',
            styles: Styles(raw: {
              'font-size': '0.875rem',
              'color': isSelected ? 'var(--accent)' : 'var(--muted-foreground)',
            }),
            [Component.text(item.subtitle!)],
          ),
        if (item.child != null) item.child!,
      ],
    );
  }
}

/// An item for ArcaneRadioCards
class ArcaneRadioCardItem<T> {
  final T value;
  final String? title;
  final String? subtitle;
  final Component? icon;
  final Component? child;
  final bool disabled;

  const ArcaneRadioCardItem({
    required this.value,
    this.title,
    this.subtitle,
    this.icon,
    this.child,
    this.disabled = false,
  });
}

/// A group of selectable chips where multiple can be selected
class ArcaneChipGroup extends StatelessComponent {
  final List<Component> children;
  final double gap;
  final bool wrap;

  const ArcaneChipGroup({
    required this.children,
    this.gap = 8,
    this.wrap = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-chip-group',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-wrap': wrap ? 'wrap' : 'nowrap',
        'gap': '${gap}px',
      }),
      children,
    );
  }
}

/// A single chip component
class ArcaneChip extends StatelessComponent {
  final String label;
  final Component? avatar;
  final Component? deleteIcon;
  final void Function()? onDeleted;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;

  const ArcaneChip({
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-chip ${selected ? 'selected' : ''} ${disabled ? 'disabled' : ''}',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '6px',
        'padding': '6px 12px',
        'border-radius': '9999px',
        'font-size': '0.875rem',
        'border': selected
            ? '1px solid var(--accent)'
            : '1px solid var(--border)',
        'background-color': selected
            ? 'hsl(var(--accent) / 0.1)'
            : 'var(--card)',
        'color': selected ? 'var(--accent)' : 'var(--foreground)',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
      }),
      events: {
        'click': (event) {
          if (!disabled && onTap != null) {
            onTap!();
          }
        },
      },
      [
        if (avatar != null) avatar!,
        Component.text(label),
        if (deleteIcon != null && onDeleted != null)
          button(
            styles: const Styles(raw: {
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
                onDeleted!();
              },
            },
            [deleteIcon!],
          ),
      ],
    );
  }
}
