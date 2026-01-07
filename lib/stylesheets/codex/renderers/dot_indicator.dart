import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/dot_indicator_props.dart';

/// Codex DotIndicator renderer.
class CodexDotIndicator extends StatelessComponent {
  final DotIndicatorProps props;

  const CodexDotIndicator(this.props, {super.key});

  String _getDotSize() {
    switch (props.size) {
      case DotIndicatorSize.sm:
        return '6px';
      case DotIndicatorSize.md:
        return '8px';
      case DotIndicatorSize.lg:
        return '10px';
    }
  }

  @override
  Component build(BuildContext context) {
    final dotSize = _getDotSize();

    return dom.div(
      classes: 'codex-dot-indicator',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': props.spacing ?? '8px',
      }),
      [
        for (int i = 0; i < props.length; i++)
          dom.button(
            classes: 'codex-dot ${i == props.index ? 'active' : ''}',
            styles: dom.Styles(raw: {
              'width': dotSize,
              'height': dotSize,
              'border-radius': '50%',
              'border': 'none',
              'padding': '0',
              'background-color': i == props.index
                  ? (props.activeColor ?? 'var(--codex-accent)')
                  : (props.inactiveColor ?? 'var(--muted-foreground)'),
              'opacity': i == props.index ? '1' : '0.4',
              'transition': 'all 200ms ease',
              'cursor': props.interactive ? 'pointer' : 'default',
            }),
            events: props.onChanged != null && props.interactive
                ? {'click': (_) => props.onChanged!(i)}
                : null,
            [],
          ),
      ],
    );
  }
}

/// Codex StepIndicator renderer.
class CodexStepIndicator extends StatelessComponent {
  final StepIndicatorProps props;

  const CodexStepIndicator(this.props, {super.key});

  String _getStepSize() {
    switch (props.size) {
      case StepIndicatorSize.sm:
        return '24px';
      case StepIndicatorSize.md:
        return '32px';
      case StepIndicatorSize.lg:
        return '40px';
    }
  }

  @override
  Component build(BuildContext context) {
    final stepSize = _getStepSize();
    final totalSteps = props.steps.length;

    return dom.div(
      classes: 'codex-step-indicator',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '8px',
      }),
      [
        for (int i = 0; i < totalSteps; i++) ...[
          // Step dot/number
          dom.div(
            classes: 'codex-step ${_getStepClass(i)}',
            styles: dom.Styles(raw: {
              'width': stepSize,
              'height': stepSize,
              'min-width': stepSize,
              'border-radius': '50%',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'font-size': '0.75rem',
              'font-weight': '600',
              'background-color': _getBackgroundColor(i),
              'color': _getTextColor(i),
              'border': i == props.currentStep
                  ? '2px solid var(--codex-accent)'
                  : '1px solid var(--border)',
              'transition': 'all 200ms ease',
              'cursor': props.allowStepNavigation && i < props.currentStep
                  ? 'pointer'
                  : 'default',
            }),
            events: props.onStepTap != null && props.allowStepNavigation && i <= props.currentStep
                ? {'click': (_) => props.onStepTap!(i)}
                : null,
            [
              if (i < props.currentStep)
                ArcaneIcon.check(size: IconSize.sm)
              else
                Component.text('${i + 1}'),
            ],
          ),

          // Connector line
          if (i < totalSteps - 1)
            dom.div(
              classes: 'codex-step-connector',
              styles: dom.Styles(raw: {
                'flex': '1',
                'height': '2px',
                'background-color': i < props.currentStep
                    ? 'var(--codex-accent)'
                    : 'var(--border)',
                'transition': 'background-color 200ms ease',
              }),
              [],
            ),
        ],
      ],
    );
  }

  String _getStepClass(int index) {
    if (index < props.currentStep) return 'completed';
    if (index == props.currentStep) return 'current';
    return 'upcoming';
  }

  String _getBackgroundColor(int index) {
    if (index < props.currentStep) return 'var(--codex-accent)';
    if (index == props.currentStep) return 'rgba(var(--codex-accent-rgb), 0.1)';
    return 'var(--background)';
  }

  String _getTextColor(int index) {
    if (index < props.currentStep) return '#ffffff';
    if (index == props.currentStep) return 'var(--codex-accent)';
    return 'var(--muted-foreground)';
  }
}
