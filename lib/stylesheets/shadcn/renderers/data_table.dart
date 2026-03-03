import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/data_table_props.dart';

/// ShadCN DataTable renderer.
///
/// Outputs data table HTML matching the ShadCN/ui design language.
/// Reference: https://ui.shadcn.com/docs/components/data-table
class ShadcnDataTable<T> extends StatelessComponent {
  final DataTableProps<T> props;

  const ShadcnDataTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (props.items.isEmpty) {
      return dom.div(
        classes: 'arcane-data-table-empty',
        styles: const dom.Styles(raw: {
          'padding': '48px 24px',
          'text-align': 'center',
          'color': 'var(--muted-foreground)',
        }),
        [Component.text(props.emptyMessage)],
      );
    }

    return dom.div(
      classes: 'arcane-data-table-container',
      styles: const dom.Styles(raw: {
        'overflow-x': 'auto',
        // ShadCN: rounded-md border
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-md)',
      }),
      [
        dom.table(
          classes: 'arcane-data-table',
          styles: const dom.Styles(raw: {
            'width': '100%',
            'border-collapse': 'collapse',
            // ShadCN: text-sm
            'font-size': 'var(--font-size-sm)',
          }),
          [
            // Header
            if (props.showHeader)
              dom.thead(
                classes: 'arcane-data-table-header',
                styles: dom.Styles(raw: {
                  // ShadCN: [&_tr]:border-b
                  'background-color': 'var(--muted)',
                  if (props.stickyHeader) 'position': 'sticky',
                  if (props.stickyHeader) 'top': '0',
                  if (props.stickyHeader) 'z-index': '1',
                }),
                [
                  dom.tr([
                    if (props.selectable)
                      dom.th(
                        styles: const dom.Styles(raw: {
                          // ShadCN: h-12 px-4
                          'padding': '12px 16px',
                          'text-align': 'center',
                          'width': '48px',
                        }),
                        [
                          dom.input(
                            type: dom.InputType.checkbox,
                            attributes: {
                              if (props.selectedItems.length == props.items.length)
                                'checked': 'true',
                            },
                            events: {
                              if (props.onToggleSelectAll != null)
                                'change': (event) => props.onToggleSelectAll!(),
                            },
                          ),
                        ],
                      ),
                    for (final column in props.columns)
                      dom.th(
                        styles: dom.Styles(raw: {
                          // ShadCN: h-12 px-4 text-left align-middle font-medium text-muted-foreground
                          'padding': '12px 16px',
                          'text-align': column.align.css,
                          'font-weight': 'var(--font-weight-medium)',
                          'color': 'var(--muted-foreground)',
                          'white-space': 'nowrap',
                          if (column.width != null)
                            'width': '${column.width}px',
                        }),
                        [Component.text(column.header)],
                      ),
                  ]),
                ],
              ),

            // Body
            dom.tbody(
              classes: 'arcane-data-table-body',
              styles: const dom.Styles(raw: {
                // ShadCN: [&_tr:last-child]:border-0
              }),
              [
                for (var i = 0; i < props.items.length; i++)
                  _buildRow(i, props.items[i]),
              ],
            ),
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
          'arcane-data-table-row ${isSelected ? 'selected' : ''} ${isClickable ? 'clickable' : ''}',
      styles: dom.Styles(raw: {
        // ShadCN: border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted
        'background-color':
            isSelected ? 'var(--muted)' : 'var(--background)',
        if (props.showDividers) 'border-bottom': '1px solid var(--border)',
        if (isClickable) 'cursor': 'pointer',
        'transition': 'background-color var(--transition)',
      }),
      events: isClickable
          ? {
              'click': (event) => props.onRowTap!(item),
            }
          : null,
      [
        if (props.selectable)
          dom.td(
            styles: const dom.Styles(raw: {
              // ShadCN: p-4
              'padding': '12px 16px',
              'text-align': 'center',
            }),
            [
              dom.input(
                type: dom.InputType.checkbox,
                attributes: {
                  if (isSelected) 'checked': 'true',
                },
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
            styles: dom.Styles(raw: {
              // ShadCN: p-4 align-middle
              'padding': '12px 16px',
              'text-align': column.align.css,
              'color': 'var(--foreground)',
            }),
            [column.builder(item)],
          ),
      ],
    );
  }
}
