import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/animated_counter_props.dart';

/// Codex Animated Counter renderer.
class CodexAnimatedCounter extends StatelessComponent {
  final AnimatedCounterProps props;

  const CodexAnimatedCounter(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final hasGradient = props.gradientStart != null && props.gradientEnd != null;

    return dom.div(
      classes: 'codex-animated-counter',
      styles: const dom.Styles(raw: {
        'text-align': 'center',
      }),
      [
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': props.fontSize,
            'font-weight': 'var(--arcane-font-weight-bold)',
            'color': hasGradient ? 'transparent' : (props.color ?? 'var(--foreground)'),
            if (hasGradient)
              'background': 'linear-gradient(135deg, ${props.gradientStart} 0%, ${props.gradientEnd} 100%)',
            if (hasGradient) '-webkit-background-clip': 'text',
            if (hasGradient) 'background-clip': 'text',
            'line-height': '1.1',
          }),
          [
            if (props.prefix != null)
              dom.span(
                styles: dom.Styles(raw: {'font-size': 'calc(${props.fontSize} * 0.6)'}),
                [Component.text(props.prefix!)],
              ),
            Component.text(props.value),
            if (props.suffix != null)
              dom.span(
                styles: dom.Styles(raw: {'font-size': 'calc(${props.fontSize} * 0.6)'}),
                [Component.text(props.suffix!)],
              ),
          ],
        ),
        if (props.label != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.75rem',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }
}

/// Codex Counter Row renderer.
class CodexCounterRow extends StatelessComponent {
  final CounterRowProps props;

  const CodexCounterRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-counter-row',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'center',
        'align-items': 'flex-start',
        'gap': props.gap,
        'flex-wrap': 'wrap',
      }),
      props.counters,
    );
  }
}

/// Codex Metric Display renderer.
class CodexMetricDisplay extends StatelessComponent {
  final MetricDisplayProps props;

  const CodexMetricDisplay(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-metric-display',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'text-align': 'center',
        'gap': 'var(--arcane-space-2)',
      }),
      [
        if (props.icon != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-2xl)',
              'color': 'var(--codex-accent)',
              'margin-bottom': '0.25rem',
            }),
            [Component.text(props.icon!)],
          ),
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': 'var(--arcane-space-2)',
          }),
          [
            dom.span(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--arcane-font-size-3xl)',
                'font-weight': 'var(--arcane-font-weight-bold)',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.value)],
            ),
            if (props.trend != null)
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-sm)',
                  'font-weight': 'var(--arcane-font-weight-medium)',
                  'color': props.trendPositive ? 'var(--success)' : 'var(--destructive)',
                }),
                [Component.text('${props.trendPositive ? '\u2191' : '\u2193'}${props.trend}')],
              ),
          ],
        ),
        dom.div(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-sm)',
            'color': 'var(--muted-foreground)',
          }),
          [Component.text(props.label)],
        ),
      ],
    );
  }
}
