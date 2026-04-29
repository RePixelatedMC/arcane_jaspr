import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/data_table_props.dart';

/// Neubrutalism DataTable renderer.
class NeubrutalismDataTable<T> extends StatelessComponent {
  final DataTableProps<T> props;

  const NeubrutalismDataTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (props.items.isEmpty) {
      return dom.div(
        classes: 'neubrutalism-data-table-empty',
        styles: const dom.Styles(
          raw: {
            'padding': '60px 30px',
            'text-align': 'center',
            'color': 'var(--muted-foreground)',
          },
        ),
        [Component.text(props.emptyMessage)],
      );
    }

    return dom.div(
      classes: 'neubrutalism-data-table-container',
      styles: const dom.Styles(
        raw: {
          'overflow-x': 'auto',
          'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'background': 'var(--nb-paper, var(--card))',
          'box-shadow':
              'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
        },
      ),
      [
        dom.table(
          classes: 'neubrutalism-data-table',
          styles: const dom.Styles(
            raw: {
              'width': '100%',
              'border-collapse': 'collapse',
              'font-size': 'var(--font-size-sm)',
              'font-variant-numeric': 'tabular-nums',
            },
          ),
          [
            // Header
            if (props.showHeader)
              dom.thead(
                classes: 'neubrutalism-data-table-header',
                styles: dom.Styles(
                  raw: {
                    'background': 'transparent',
                    'border-bottom':
                        'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                    if (props.stickyHeader) 'position': 'sticky',
                    if (props.stickyHeader) 'top': '0',
                    if (props.stickyHeader) 'z-index': '1',
                  },
                ),
                [
                  dom.tr([
                    if (props.selectable)
                      dom.th(
                        styles: const dom.Styles(
                          raw: {
                            'padding': '14px 20px',
                            'text-align': 'center',
                            'width': '56px',
                          },
                        ),
                        [
                          dom.input(
                            type: dom.InputType.checkbox,
                            attributes: {
                              if (props.selectedItems.length ==
                                  props.items.length)
                                'checked': 'true',
                            },
                            styles: const dom.Styles(
                              raw: {'accent-color': 'var(--nb-accent, var(--primary))'},
                            ),
                            events: {
                              if (props.onToggleSelectAll != null)
                                'change': (event) => props.onToggleSelectAll!(),
                            },
                          ),
                        ],
                      ),
                    for (final column in props.columns)
                      dom.th(
                        styles: dom.Styles(
                          raw: {
                            'padding': '14px 20px',
                            'text-align': column.align.css,
                            'font-family': 'var(--font-heading)',
                            'font-size': 'var(--font-size-xs)',
                            'font-weight': 'var(--font-weight-semibold)',
                            'letter-spacing': '0.12em',
                            'text-transform': 'uppercase',
                            'color': 'var(--muted-foreground)',
                            'white-space': 'nowrap',
                            if (column.width != null)
                              'width': '${column.width}px',
                          },
                        ),
                        [Component.text(column.header)],
                      ),
                  ]),
                ],
              ),

            // Body
            dom.tbody(classes: 'neubrutalism-data-table-body', [
              for (var i = 0; i < props.items.length; i++)
                _buildRow(i, props.items[i]),
            ]),
          ],
        ),
      ],
    );
  }

  Component _buildRow(int index, T item) {
    final bool isSelected = props.selectedItems.contains(item);
    final bool isClickable = props.onRowTap != null;

    return dom.tr(
      classes:
          'neubrutalism-data-table-row ${isSelected ? 'selected' : ''} ${isClickable ? 'clickable' : ''}',
      styles: dom.Styles(
        raw: {
          'background': isSelected
              ? 'var(--nb-accent, var(--primary))'
              : 'transparent',
          'color': isSelected ? 'var(--nb-ink, #000)' : 'var(--nb-ink, var(--foreground))',
          if (props.showDividers)
            'border-bottom':
                'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          if (isClickable) 'cursor': 'pointer',
          'transition': 'background-color 140ms ease',
        },
      ),
      events: isClickable ? {'click': (event) => props.onRowTap!(item)} : null,
      [
        if (props.selectable)
          dom.td(
            styles: const dom.Styles(
              raw: {'padding': '14px 20px', 'text-align': 'center'},
            ),
            [
              dom.input(
                type: dom.InputType.checkbox,
                attributes: {if (isSelected) 'checked': 'true'},
                styles: const dom.Styles(
                  raw: {'accent-color': 'var(--nb-accent, var(--primary))'},
                ),
                events: {
                  if (props.onToggleSelection != null)
                    'change': (event) {
                      event.stopPropagation();
                      props.onToggleSelection!(item);
                    },
                  'click': (event) => event.stopPropagation(),
                },
              ),
            ],
          ),
        for (final column in props.columns)
          dom.td(
            styles: dom.Styles(
              raw: {
                'padding': '14px 20px',
                'text-align': column.align.css,
                'color': 'var(--foreground)',
              },
            ),
            [column.builder(item)],
          ),
      ],
    );
  }
}
