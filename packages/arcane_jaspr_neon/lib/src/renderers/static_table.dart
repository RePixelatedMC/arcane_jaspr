import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/static_table_props.dart';

/// Neon Static Table renderer.
class NeonStaticTable extends StatelessComponent {
  final StaticTableProps props;

  const NeonStaticTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neon-static-table-container',
      styles: const dom.Styles(
        raw: {
          'overflow-x': 'auto',
          'border': '1px solid var(--neon-panel-border)',
          'clip-path': 'var(--neon-clip-md)',
          'background': 'var(--neon-panel-surface)',
          'box-shadow':
              'var(--neon-shadow-md), inset 0 1px 0 var(--neon-inset)',
        },
      ),
      [
        dom.table(
          classes: 'neon-static-table',
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
                    'background': 'var(--neon-panel-tint)',
                    'border-bottom':
                        '1px solid var(--neon-control-border-strong)',
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
                          ? 'color-mix(in srgb, var(--neon-accent) 4%, transparent)'
                          : 'transparent',
                      if (props.showDividers &&
                          rowIndex < props.rows.length - 1)
                        'border-bottom':
                            '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
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

/// Neon Key-Value Table renderer.
class NeonKeyValueTable extends StatelessComponent {
  final KeyValueTableProps props;

  const NeonKeyValueTable(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neon-kv-table',
      styles: const dom.Styles(
        raw: {
          'border': '1px solid var(--neon-panel-border)',
          'clip-path': 'var(--neon-clip-md)',
          'background': 'var(--neon-panel-surface)',
          'box-shadow':
              'var(--neon-shadow-md), inset 0 1px 0 var(--neon-inset)',
          'overflow': 'hidden',
        },
      ),
      [
        for (var i = 0; i < props.rows.length; i++)
          dom.div(
            classes: 'neon-kv-table-row',
            styles: dom.Styles(
              raw: {
                'display': 'flex',
                if (props.showDividers && i < props.rows.length - 1)
                  'border-bottom':
                      '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
              },
            ),
            [
              // Key
              dom.div(
                classes: 'neon-kv-table-key',
                styles: dom.Styles(
                  raw: {
                    'padding': '1rem 1.5rem',
                    'background': 'var(--neon-panel-tint)',
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
                        '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
                  },
                ),
                [Component.text(props.rows[i].key)],
              ),

              // Value
              dom.div(
                classes: 'neon-kv-table-value',
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
