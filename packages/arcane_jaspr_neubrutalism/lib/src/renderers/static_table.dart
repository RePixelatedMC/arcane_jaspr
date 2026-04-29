import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/static_table_props.dart';

/// Neubrutalism Static Table renderer.
class NeubrutalismStaticTable extends StatelessComponent {
  final StaticTableProps props;

  const NeubrutalismStaticTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-static-table-container',
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
          classes: 'neubrutalism-static-table',
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
                    for (var i = 0; i < props.headers.length; i++)
                      dom.th(
                        styles: dom.Styles(
                          raw: {
                            'padding': '1rem 1.5rem',
                            'text-align':
                                (props.alignments != null &&
                                    i < props.alignments!.length)
                                ? props.alignments![i].css
                                : 'left',
                            'font-family': 'var(--font-heading)',
                            'font-size': 'var(--font-size-xs)',
                            'font-weight': 'var(--font-weight-semibold)',
                            'letter-spacing': '0.12em',
                            'text-transform': 'uppercase',
                            'color': 'var(--muted-foreground)',
                            'white-space': 'nowrap',
                          },
                        ),
                        [Component.text(props.headers[i])],
                      ),
                  ]),
                ],
              ),

            // Body
            dom.tbody([
              for (var rowIndex = 0; rowIndex < props.rows.length; rowIndex++)
                dom.tr(
                  styles: dom.Styles(
                    raw: {
                      'background': props.striped && rowIndex.isOdd
                          ? 'var(--nb-paper-soft, var(--card))'
                          : 'transparent',
                      if (props.showDividers &&
                          rowIndex < props.rows.length - 1)
                        'border-bottom':
                            'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                    },
                  ),
                  [
                    for (
                      var colIndex = 0;
                      colIndex < props.rows[rowIndex].length;
                      colIndex++
                    )
                      dom.td(
                        styles: dom.Styles(
                          raw: {
                            'padding': '1rem 1.5rem',
                            'text-align':
                                (props.alignments != null &&
                                    colIndex < props.alignments!.length)
                                ? props.alignments![colIndex].css
                                : 'left',
                            'color': 'var(--foreground)',
                          },
                        ),
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

/// Neubrutalism Key-Value Table renderer.
class NeubrutalismKeyValueTable extends StatelessComponent {
  final KeyValueTableProps props;

  const NeubrutalismKeyValueTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-kv-table',
      styles: const dom.Styles(
        raw: {
          'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'background': 'var(--nb-paper, var(--card))',
          'box-shadow':
              'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
          'overflow': 'hidden',
        },
      ),
      [
        for (var i = 0; i < props.rows.length; i++)
          dom.div(
            classes: 'neubrutalism-kv-table-row',
            styles: dom.Styles(
              raw: {
                'display': 'flex',
                if (props.showDividers && i < props.rows.length - 1)
                  'border-bottom':
                      'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
              },
            ),
            [
              // Key
              dom.div(
                classes: 'neubrutalism-kv-table-key',
                styles: dom.Styles(
                  raw: {
                    'padding': '1rem 1.5rem',
                    'background': 'transparent',
                    'font-family': 'var(--font-heading)',
                    'font-size': 'var(--font-size-xs)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'letter-spacing': '0.08em',
                    'text-transform': 'uppercase',
                    'color': 'var(--muted-foreground)',
                    if (props.keyWidth != null) 'width': '${props.keyWidth}px',
                    if (props.keyWidth != null) 'flex-shrink': '0',
                    if (props.keyWidth == null) 'flex': '0 0 30%',
                    'border-right':
                        'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                  },
                ),
                [Component.text(props.rows[i].key)],
              ),

              // Value
              dom.div(
                classes: 'neubrutalism-kv-table-value',
                styles: const dom.Styles(
                  raw: {
                    'flex': '1',
                    'padding': '1rem 1.5rem',
                    'background': 'transparent',
                    'color': 'var(--foreground)',
                    'font-size': 'var(--font-size-sm)',
                  },
                ),
                [props.rows[i].value],
              ),
            ],
          ),
      ],
    );
  }
}
