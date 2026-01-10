import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/dot_indicator_props.dart';

/// ShadCN Dot Indicator renderer.
class ShadcnDotIndicator extends StatelessComponent {
  final DotIndicatorProps props;

  const ShadcnDotIndicator(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final dotSize = switch (props.size) {
      DotIndicatorSize.sm => '6px',
      DotIndicatorSize.md => '8px',
      DotIndicatorSize.lg => '10px',
    };

    final effectiveSpacing = props.spacing ?? '0.5rem';
    final effectiveActiveColor = props.activeColor ?? 'var(--accent)';
    final effectiveInactiveColor = props.inactiveColor ?? 'var(--muted)';

    return dom.div(
      classes: 'arcane-dot-indicator',
      attributes: const {
        'role': 'tablist',
        'aria-label': 'Page indicators',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': effectiveSpacing,
      }),
      [
        for (var i = 0; i < props.length; i++)
          dom.button(
            type: dom.ButtonType.button,
            classes: 'arcane-dot ${i == props.index ? 'active' : ''}',
            attributes: {
              'role': 'tab',
              'aria-selected': '${i == props.index}',
              'aria-label': 'Page ${i + 1} of ${props.length}',
              if (!props.interactive) 'disabled': 'true',
            },
            styles: dom.Styles(raw: {
              'width': i == props.index ? 'calc($dotSize * 2)' : dotSize,
              'height': dotSize,
              'border-radius': 'var(--arcane-radius-full)',
              'background':
                  i == props.index ? effectiveActiveColor : effectiveInactiveColor,
              'border': 'none',
              'padding': '0',
              'cursor': props.interactive ? 'pointer' : 'default',
              'transition': 'all 0.2s ease',
            }),
            events: props.interactive && props.onChanged != null
                ? {'click': (_) => props.onChanged!(i)}
                : null,
            [],
          ),
      ],
    );
  }
}

/// ShadCN Step Indicator renderer.
class ShadcnStepIndicator extends StatelessComponent {
  final StepIndicatorProps props;

  const ShadcnStepIndicator(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (circleSize, fontSize, lineHeight) = switch (props.size) {
      StepIndicatorSize.sm => ('24px', '0.75rem', '2px'),
      StepIndicatorSize.md => ('32px', '0.875rem', '3px'),
      StepIndicatorSize.lg => ('40px', '1rem', '4px'),
    };

    return dom.div(
      classes: 'arcane-step-indicator',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
      }),
      [
        for (var i = 0; i < props.steps.length; i++) ...[
          // Step item
          dom.div(
            classes: 'arcane-step-item',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'gap': 'var(--arcane-space-1)',
            }),
            [
              // Circle
              dom.button(
                type: dom.ButtonType.button,
                classes:
                    'arcane-step-circle ${i < props.currentStep ? 'completed' : ''} ${i == props.currentStep ? 'active' : ''}',
                attributes: {
                  if (i == props.currentStep) 'aria-current': 'step',
                  if (!props.allowStepNavigation || i > props.currentStep)
                    'disabled': 'true',
                },
                styles: dom.Styles(raw: {
                  'width': circleSize,
                  'height': circleSize,
                  'border-radius': 'var(--arcane-radius-full)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': fontSize,
                  'font-weight': 'var(--arcane-font-weight-medium)',
                  'border': 'none',
                  'background':
                      i <= props.currentStep ? 'var(--accent)' : 'var(--muted)',
                  'color': i <= props.currentStep
                      ? 'var(--accent-foreground)'
                      : 'var(--muted-foreground)',
                  'cursor': props.allowStepNavigation && i <= props.currentStep
                      ? 'pointer'
                      : 'default',
                  'transition': 'all var(--arcane-transition)',
                }),
                events: props.allowStepNavigation &&
                        i <= props.currentStep &&
                        props.onStepTap != null
                    ? {'click': (_) => props.onStepTap!(i)}
                    : null,
                [
                  if (i < props.currentStep)
                    const Component.text('\u2713')
                  else
                    Component.text('${i + 1}'),
                ],
              ),

              // Label
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': fontSize,
                  'color': i == props.currentStep
                      ? 'var(--foreground)'
                      : 'var(--muted-foreground)',
                  'font-weight': i == props.currentStep ? '500' : '400',
                  'text-align': 'center',
                  'white-space': 'nowrap',
                }),
                [Component.text(props.steps[i])],
              ),
            ],
          ),

          // Connector line (not after last step)
          if (i < props.steps.length - 1)
            dom.div(
              classes: 'arcane-step-connector',
              styles: dom.Styles(raw: {
                'flex': '1',
                'height': lineHeight,
                'margin': '0 0.5rem',
                'margin-top': 'calc($circleSize / 2 - $lineHeight / 2)',
                'background':
                    i < props.currentStep ? 'var(--accent)' : 'var(--border)',
                'transition': 'all var(--arcane-transition)',
              }),
              [],
            ),
        ],
      ],
    );
  }
}
