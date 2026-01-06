import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/stepper_props.dart';

/// ShadCN Steps renderer.
class ShadcnStepper extends StatelessComponent {
  final StepperProps props;

  const ShadcnStepper(this.props, {super.key});

  String get _indicatorSize => switch (props.size) {
        StepsSize.sm => '28px',
        StepsSize.md => '36px',
        StepsSize.lg => '44px',
      };

  String get _connectorSize => switch (props.size) {
        StepsSize.sm => '2px',
        StepsSize.md => '2px',
        StepsSize.lg => '3px',
      };

  String get _numberSize => switch (props.size) {
        StepsSize.sm => '0.875rem',
        StepsSize.md => '1rem',
        StepsSize.lg => '1.125rem',
      };

  StepStatus _getEffectiveStatus(int index) {
    if (props.currentStep != null) {
      if (index < props.currentStep!) return StepStatus.complete;
      if (index == props.currentStep!) return StepStatus.current;
      return StepStatus.pending;
    }
    return props.items[index].status;
  }

  @override
  Component build(BuildContext context) {
    return switch (props.layout) {
      StepsLayout.vertical => _buildVertical(),
      StepsLayout.horizontal => _buildHorizontal(),
    };
  }

  Component _buildVertical() {
    return dom.div(
      classes: 'arcane-steps arcane-steps-vertical',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          _buildVerticalStep(props.items[i], i, _getEffectiveStatus(i)),
      ],
    );
  }

  Component _buildVerticalStep(StepItemData step, int index, StepStatus status) {
    final isLast = index == props.items.length - 1;
    final colors = _getStatusColors(status);
    final isClickable = props.onStepTap != null && status == StepStatus.complete;

    return dom.div(
      classes: 'arcane-steps-item',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': '1.5rem',
        'position': 'relative',
        'padding-bottom': isLast ? '0' : '2rem',
      }),
      [
        // Number indicator and connector column
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            // Number indicator
            _buildIndicator(index, status, colors, isClickable),
            // Connector line
            if (props.showConnectors && !isLast)
              dom.div(
                classes: 'arcane-steps-connector',
                styles: dom.Styles(raw: {
                  'width': _connectorSize,
                  'flex': '1',
                  'min-height': '1.5rem',
                  'background': status == StepStatus.complete
                      ? colors['line']!
                      : 'var(--border)',
                  'position': 'absolute',
                  'top': _indicatorSize,
                  'bottom': '0',
                }),
                [],
              ),
          ],
        ),
        // Content column
        dom.div(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'padding-top': '6px',
          }),
          [_buildContent(step, status, colors)],
        ),
      ],
    );
  }

  Component _buildHorizontal() {
    return dom.div(
      classes: 'arcane-steps arcane-steps-horizontal',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          _buildHorizontalStep(props.items[i], i, _getEffectiveStatus(i)),
      ],
    );
  }

  Component _buildHorizontalStep(StepItemData step, int index, StepStatus status) {
    final isLast = index == props.items.length - 1;
    final colors = _getStatusColors(status);
    final isClickable = props.onStepTap != null && status == StepStatus.complete;

    return dom.div(
      classes: 'arcane-steps-item',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'flex': isLast ? '0 0 auto' : '1',
        'min-width': '100px',
      }),
      [
        // Indicator row with connectors
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'width': '100%',
          }),
          [
            _buildIndicator(index, status, colors, isClickable),
            // Connector line
            if (props.showConnectors && !isLast)
              dom.div(
                classes: 'arcane-steps-connector',
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'height': _connectorSize,
                  'background': status == StepStatus.complete
                      ? colors['line']!
                      : 'var(--border)',
                  'margin': '0 0.5rem',
                }),
                [],
              ),
          ],
        ),
        // Content below
        dom.div(
          styles: const dom.Styles(raw: {
            'margin-top': '1rem',
            'text-align': 'center',
            'padding-right': '0.5rem',
          }),
          [_buildContent(step, status, colors, centered: true)],
        ),
      ],
    );
  }

  Component _buildIndicator(
    int index,
    StepStatus status,
    Map<String, String> colors,
    bool isClickable,
  ) {
    final isFilled = status == StepStatus.complete || status == StepStatus.current;

    return dom.button(
      classes: 'arcane-steps-indicator arcane-steps-indicator-${status.name}',
      attributes: {
        'type': 'button',
        if (isClickable) 'data-step-index': '$index',
        if (!isClickable) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'width': _indicatorSize,
        'height': _indicatorSize,
        'border-radius': '9999px',
        'background': isFilled ? colors['bg']! : 'var(--background)',
        'border': '2px solid ${colors['border']!}',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'font-size': _numberSize,
        'font-weight': '600',
        'color': isFilled ? colors['text']! : colors['border']!,
        'flex-shrink': '0',
        'z-index': '1',
        'cursor': isClickable ? 'pointer' : 'default',
        'transition': 'all 150ms ease',
        'padding': '0',
      }),
      events: isClickable
          ? {'click': (e) => props.onStepTap?.call(index)}
          : null,
      [
        if (status == StepStatus.complete)
          dom.span([Component.text('\u2713')])
        else
          dom.span([Component.text('${index + 1}')]),
      ],
    );
  }

  Component _buildContent(
    StepItemData step,
    StepStatus status,
    Map<String, String> colors, {
    bool centered = false,
  }) {
    return dom.div(
      classes: 'arcane-steps-content',
      styles: dom.Styles(raw: {'text-align': centered ? 'center' : 'left'}),
      [
        // Title
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': '1rem',
            'font-weight': '600',
            'color': status == StepStatus.pending
                ? 'var(--muted)'
                : 'var(--foreground)',
            'margin-bottom':
                step.description != null || step.content != null ? '0.25rem' : '0',
          }),
          [Component.text(step.title)],
        ),
        // Description
        if (step.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'line-height': '1.5',
            }),
            [Component.text(step.description!)],
          ),
        // Custom content
        if (step.content != null)
          dom.div(
            styles: const dom.Styles(raw: {'margin-top': '0.5rem'}),
            [step.content!],
          ),
      ],
    );
  }

  Map<String, String> _getStatusColors(StepStatus status) {
    return switch (status) {
      StepStatus.complete => {
          'bg': 'hsl(142 76% 36%)',
          'border': 'hsl(142 76% 36%)',
          'text': 'var(--background)',
          'line': 'hsl(142 76% 36%)',
        },
      StepStatus.current => {
          'bg': 'var(--accent)',
          'border': 'var(--accent)',
          'text': 'var(--background)',
          'line': 'var(--accent)',
        },
      StepStatus.pending => {
          'bg': 'transparent',
          'border': 'var(--border)',
          'text': 'var(--muted-foreground)',
          'line': 'var(--border)',
        },
    };
  }
}
