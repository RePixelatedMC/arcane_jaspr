import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/static_table_props.dart';

/// ShadCN Static Table renderer.
class ShadcnStaticTable extends StatelessComponent {
  final StaticTableProps props;

  const ShadcnStaticTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-static-table-container',
      styles: const dom.Styles(raw: {
        'overflow-x': 'auto',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
      }),
      [
        dom.table(
          classes: 'arcane-static-table',
          styles: const dom.Styles(raw: {
            'width': '100%',
            'border-collapse': 'collapse',
            'font-size': 'var(--arcane-font-size-sm)',
          }),
          [
            // Header
            if (props.showHeader)
              dom.thead(
                styles: dom.Styles(raw: {
                  'background-color': 'var(--muted)',
                  if (props.stickyHeader) 'position': 'sticky',
                  if (props.stickyHeader) 'top': '0',
                  if (props.stickyHeader) 'z-index': '1',
                }),
                [
                  dom.tr([
                    for (var i = 0; i < props.headers.length; i++)
                      dom.th(
                        styles: dom.Styles(raw: {
                          'padding': '1rem 1.5rem',
                          'text-align':
                              (props.alignments != null && i < props.alignments!.length)
                                  ? props.alignments![i].css
                                  : 'left',
                          'font-weight': 'var(--arcane-font-weight-semibold)',
                          'color': 'var(--foreground)',
                          'white-space': 'nowrap',
                        }),
                        [Component.text(props.headers[i])],
                      ),
                  ]),
                ],
              ),

            // Body
            dom.tbody([
              for (var rowIndex = 0; rowIndex < props.rows.length; rowIndex++)
                dom.tr(
                  styles: dom.Styles(raw: {
                    'background-color': props.striped && rowIndex.isOdd
                        ? 'var(--muted)'
                        : 'var(--card)',
                    if (props.showDividers && rowIndex < props.rows.length - 1)
                      'border-bottom': '1px solid var(--border)',
                  }),
                  [
                    for (var colIndex = 0;
                        colIndex < props.rows[rowIndex].length;
                        colIndex++)
                      dom.td(
                        styles: dom.Styles(raw: {
                          'padding': '1rem 1.5rem',
                          'text-align': (props.alignments != null &&
                                  colIndex < props.alignments!.length)
                              ? props.alignments![colIndex].css
                              : 'left',
                          'color': 'var(--foreground)',
                        }),
                        [props.rows[rowIndex][colIndex]],
                      ),
                  ],
                ),
            ]),
          ],
        ),
      ],
    );
  }
}

/// ShadCN Key-Value Table renderer.
class ShadcnKeyValueTable extends StatelessComponent {
  final KeyValueTableProps props;

  const ShadcnKeyValueTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-kv-table',
      styles: const dom.Styles(raw: {
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'overflow': 'hidden',
      }),
      [
        for (var i = 0; i < props.rows.length; i++)
          dom.div(
            classes: 'arcane-kv-table-row',
            styles: dom.Styles(raw: {
              'display': 'flex',
              if (props.showDividers && i < props.rows.length - 1)
                'border-bottom': '1px solid var(--border)',
            }),
            [
              // Key
              dom.div(
                classes: 'arcane-kv-table-key',
                styles: dom.Styles(raw: {
                  'padding': '1rem 1.5rem',
                  'background-color': 'var(--muted)',
                  'font-weight': 'var(--arcane-font-weight-medium)',
                  'color': 'var(--foreground)',
                  'font-size': 'var(--arcane-font-size-sm)',
                  if (props.keyWidth != null) 'width': '${props.keyWidth}px',
                  if (props.keyWidth != null) 'flex-shrink': '0',
                  if (props.keyWidth == null) 'flex': '0 0 30%',
                  'border-right': '1px solid var(--border)',
                }),
                [Component.text(props.rows[i].key)],
              ),

              // Value
              dom.div(
                classes: 'arcane-kv-table-value',
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'padding': '1rem 1.5rem',
                  'background-color': 'var(--card)',
                  'color': 'var(--foreground)',
                  'font-size': 'var(--arcane-font-size-sm)',
                }),
                [props.rows[i].value],
              ),
            ],
          ),
      ],
    );
  }
}
