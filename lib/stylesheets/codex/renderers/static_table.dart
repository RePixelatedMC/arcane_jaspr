import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/static_table_props.dart';

/// Codex Static Table renderer.
class CodexStaticTable extends StatelessComponent {
  final StaticTableProps props;

  const CodexStaticTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-static-table-container',
      styles: const dom.Styles(raw: {
        'overflow-x': 'auto',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
      }),
      [
        dom.table(
          classes: 'codex-static-table',
          styles: const dom.Styles(raw: {
            'width': '100%',
            'border-collapse': 'collapse',
            'font-size': '0.875rem',
          }),
          [
            // Header
            if (props.showHeader)
              dom.thead(
                styles: dom.Styles(raw: {
                  'background-color': 'var(--secondary)',
                  if (props.stickyHeader) 'position': 'sticky',
                  if (props.stickyHeader) 'top': '0',
                  if (props.stickyHeader) 'z-index': '1',
                }),
                [
                  dom.tr([
                    for (var i = 0; i < props.headers.length; i++)
                      dom.th(
                        styles: dom.Styles(raw: {
                          'padding': '1.25rem 1.75rem',
                          'text-align':
                              (props.alignments != null && i < props.alignments!.length)
                                  ? props.alignments![i].css
                                  : 'left',
                          'font-weight': '600',
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
                        ? 'var(--secondary)'
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
                          'padding': '1.25rem 1.75rem',
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

/// Codex Key-Value Table renderer.
class CodexKeyValueTable extends StatelessComponent {
  final KeyValueTableProps props;

  const CodexKeyValueTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-kv-table',
      styles: const dom.Styles(raw: {
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'overflow': 'hidden',
      }),
      [
        for (var i = 0; i < props.rows.length; i++)
          dom.div(
            classes: 'codex-kv-table-row',
            styles: dom.Styles(raw: {
              'display': 'flex',
              if (props.showDividers && i < props.rows.length - 1)
                'border-bottom': '1px solid var(--border)',
            }),
            [
              // Key
              dom.div(
                classes: 'codex-kv-table-key',
                styles: dom.Styles(raw: {
                  'padding': '1.25rem 1.75rem',
                  'background-color': 'var(--secondary)',
                  'font-weight': '500',
                  'color': 'var(--foreground)',
                  'font-size': '0.875rem',
                  if (props.keyWidth != null) 'width': '${props.keyWidth}px',
                  if (props.keyWidth != null) 'flex-shrink': '0',
                  if (props.keyWidth == null) 'flex': '0 0 30%',
                  'border-right': '1px solid var(--border)',
                }),
                [Component.text(props.rows[i].key)],
              ),

              // Value
              dom.div(
                classes: 'codex-kv-table-value',
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'padding': '1.25rem 1.75rem',
                  'background-color': 'var(--card)',
                  'color': 'var(--foreground)',
                  'font-size': '0.875rem',
                }),
                [props.rows[i].value],
              ),
            ],
          ),
      ],
    );
  }
}
