import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/animated_counter_props.dart';

/// ShadCN Animated Counter renderer.
class ShadcnAnimatedCounter extends StatelessComponent {
  final AnimatedCounterProps props;

  const ShadcnAnimatedCounter(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final hasGradient = props.gradientStart != null && props.gradientEnd != null;

    return dom.div(
      classes: 'arcane-animated-counter',
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
              'margin-top': '0.5rem',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }
}

/// ShadCN Counter Row renderer.
class ShadcnCounterRow extends StatelessComponent {
  final CounterRowProps props;

  const ShadcnCounterRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-counter-row',
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

/// ShadCN Metric Display renderer.
class ShadcnMetricDisplay extends StatelessComponent {
  final MetricDisplayProps props;

  const ShadcnMetricDisplay(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-metric-display',
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
              'color': 'var(--primary)',
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
