import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/data_table_props.dart';

/// Codex DataTable renderer.
class CodexDataTable<T> extends StatelessComponent {
  final DataTableProps<T> props;

  const CodexDataTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (props.items.isEmpty) {
      return dom.div(
        classes: 'codex-data-table-empty',
        styles: const dom.Styles(raw: {
          'padding': '60px 30px',
          'text-align': 'center',
          'color': 'var(--muted-foreground)',
        }),
        [Component.text(props.emptyMessage)],
      );
    }

    return dom.div(
      classes: 'codex-data-table-container',
      styles: const dom.Styles(raw: {
        'overflow-x': 'auto',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
      }),
      [
        dom.table(
          classes: 'codex-data-table',
          styles: const dom.Styles(raw: {
            'width': '100%',
            'border-collapse': 'collapse',
            'font-size': 'var(--font-size-sm)',
          }),
          [
            // Header
            if (props.showHeader)
              dom.thead(
                classes: 'codex-data-table-header',
                styles: dom.Styles(raw: {
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
                          'padding': '16px 20px',
                          'text-align': 'center',
                          'width': '56px',
                        }),
                        [
                          dom.input(
                            type: dom.InputType.checkbox,
                            attributes: {
                              if (props.selectedItems.length == props.items.length)
                                'checked': 'true',
                            },
                            styles: const dom.Styles(raw: {
                              'accent-color': 'var(--primary)',
                            }),
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
                          'padding': '16px 20px',
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
              classes: 'codex-data-table-body',
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
          'codex-data-table-row ${isSelected ? 'selected' : ''} ${isClickable ? 'clickable' : ''}',
      styles: dom.Styles(raw: {
        'background-color':
            isSelected ? 'rgba(var(--primary-rgb), 0.1)' : 'var(--background)',
        if (props.showDividers) 'border-bottom': '1px solid var(--border)',
        if (isClickable) 'cursor': 'pointer',
        'transition': 'background-color var(--arcane-transition)',
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
              'padding': '16px 20px',
              'text-align': 'center',
            }),
            [
              dom.input(
                type: dom.InputType.checkbox,
                attributes: {
                  if (isSelected) 'checked': 'true',
                },
                styles: const dom.Styles(raw: {
                  'accent-color': 'var(--primary)',
                }),
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
              'padding': '16px 20px',
              'text-align': column.align.css,
              'color': 'var(--foreground)',
            }),
            [column.builder(item)],
          ),
      ],
    );
  }
}
