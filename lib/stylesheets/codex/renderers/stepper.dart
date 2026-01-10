import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/stepper_props.dart';

/// Codex Stepper renderer.
///
/// Implements the Codex design language:
/// - Accent-colored active and complete states
/// - Glow effects on current step
/// - Larger sizing
class CodexStepper extends StatelessComponent {
  final StepperProps props;

  const CodexStepper(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes
    final (String stepSize, String fontSize, String numSize) = switch (props.size) {
      StepsSize.sm => ('28px', '0.8125rem', '0.75rem'),
      StepsSize.md => ('36px', '0.9375rem', '0.875rem'), // Codex: larger
      StepsSize.lg => ('44px', '1rem', '1rem'),
    };

    // Determine status from currentStep if provided
    List<StepItemData> items = props.items;
    if (props.currentStep != null) {
      items = [
        for (int i = 0; i < props.items.length; i++)
          StepItemData(
            title: props.items[i].title,
            description: props.items[i].description,
            content: props.items[i].content,
            status: i < props.currentStep!
                ? StepStatus.complete
                : i == props.currentStep
                    ? StepStatus.current
                    : StepStatus.pending,
          ),
      ];
    }

    if (props.layout == StepsLayout.vertical) {
      return _buildVertical(items, stepSize, fontSize, numSize);
    }

    return _buildHorizontal(items, stepSize, fontSize, numSize);
  }

  Component _buildHorizontal(
    List<StepItemData> items,
    String stepSize,
    String fontSize,
    String numSize,
  ) {
    return dom.div(
      classes: 'codex-stepper codex-stepper-horizontal',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
      }),
      [
        for (int i = 0; i < items.length; i++)
          _buildHorizontalStep(
            items[i],
            i,
            i == items.length - 1,
            stepSize,
            fontSize,
            numSize,
          ),
      ],
    );
  }

  Component _buildHorizontalStep(
    StepItemData item,
    int index,
    bool isLast,
    String stepSize,
    String fontSize,
    String numSize,
  ) {
    final (String bgColor, String textColor, String borderColor, String glow) =
        _getStepStyles(item.status);
    final bool isClickable =
        item.status == StepStatus.complete && props.onStepTap != null;

    return dom.div(
      classes: 'codex-stepper-step ${item.status.name}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'flex': isLast ? '0 0 auto' : '1',
      }),
      [
        // Connector row
        dom.div(
          classes: 'codex-stepper-connector-row',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'width': '100%',
          }),
          [
            // Left connector
            if (index > 0 && props.showConnectors)
              dom.div(
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'height': '2px',
                  'background-color': item.status == StepStatus.pending
                      ? 'var(--border)'
                      : 'var(--primary)',
                }),
                [],
              )
            else
              const dom.div(styles: dom.Styles(raw: {'flex': '1'}), []),

            // Step number/indicator
            dom.div(
              classes: 'codex-stepper-indicator',
              styles: dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': stepSize,
                'height': stepSize,
                'border-radius': '50%',
                'background-color': bgColor,
                'border': '2px solid $borderColor',
                'color': textColor,
                'font-size': numSize,
                'font-weight': 'var(--font-weight-semibold)',
                'box-shadow': glow,
                'flex-shrink': '0',
                'cursor': isClickable ? 'pointer' : 'default',
                'transition': 'all var(--transition)',
              }),
              events: isClickable ? {'click': (_) => props.onStepTap!(index)} : null,
              [
                Component.text(item.status == StepStatus.complete
                    ? '!' // Checkmark substitute
                    : '${index + 1}'),
              ],
            ),

            // Right connector
            if (!isLast && props.showConnectors)
              dom.div(
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'height': '2px',
                  'background-color':
                      item.status == StepStatus.complete
                          ? 'var(--primary)'
                          : 'var(--border)',
                }),
                [],
              )
            else
              const dom.div(styles: dom.Styles(raw: {'flex': '1'}), []),
          ],
        ),

        // Labels
        dom.div(
          classes: 'codex-stepper-labels',
          styles: const dom.Styles(raw: {
            'text-align': 'center',
            'padding-top': '0.75rem',
          }),
          [
            dom.div(
              classes: 'codex-stepper-title',
              styles: dom.Styles(raw: {
                'font-size': fontSize,
                'font-weight': 'var(--font-weight-medium)',
                'color': item.status == StepStatus.current
                    ? 'var(--primary)'
                    : item.status == StepStatus.pending
                        ? 'var(--muted-foreground)'
                        : 'var(--foreground)',
              }),
              [Component.text(item.title)],
            ),
            if (item.description != null)
              dom.div(
                classes: 'codex-stepper-description',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.25rem',
                  'max-width': '120px',
                }),
                [Component.text(item.description!)],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildVertical(
    List<StepItemData> items,
    String stepSize,
    String fontSize,
    String numSize,
  ) {
    return dom.div(
      classes: 'codex-stepper codex-stepper-vertical',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
      }),
      [
        for (int i = 0; i < items.length; i++)
          _buildVerticalStep(
            items[i],
            i,
            i == items.length - 1,
            stepSize,
            fontSize,
            numSize,
          ),
      ],
    );
  }

  Component _buildVerticalStep(
    StepItemData item,
    int index,
    bool isLast,
    String stepSize,
    String fontSize,
    String numSize,
  ) {
    final (String bgColor, String textColor, String borderColor, String glow) =
        _getStepStyles(item.status);
    final bool isClickable =
        item.status == StepStatus.complete && props.onStepTap != null;

    return dom.div(
      classes: 'codex-stepper-step-vertical ${item.status.name}',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'gap': 'var(--space-4)', // Codex: larger gap
      }),
      [
        // Connector column
        dom.div(
          classes: 'codex-stepper-connector-col',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
          }),
          [
            // Step indicator
            dom.div(
              classes: 'codex-stepper-indicator',
              styles: dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': stepSize,
                'height': stepSize,
                'border-radius': '50%',
                'background-color': bgColor,
                'border': '2px solid $borderColor',
                'color': textColor,
                'font-size': numSize,
                'font-weight': 'var(--font-weight-semibold)',
                'box-shadow': glow,
                'flex-shrink': '0',
                'cursor': isClickable ? 'pointer' : 'default',
              }),
              events: isClickable ? {'click': (_) => props.onStepTap!(index)} : null,
              [
                Component.text(item.status == StepStatus.complete
                    ? '!'
                    : '${index + 1}'),
              ],
            ),

            // Vertical connector
            if (!isLast && props.showConnectors)
              dom.div(
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'width': '2px',
                  'min-height': '2rem',
                  'background-color':
                      item.status == StepStatus.complete
                          ? 'var(--primary)'
                          : 'var(--border)',
                }),
                [],
              ),
          ],
        ),

        // Content
        dom.div(
          classes: 'codex-stepper-content',
          styles: dom.Styles(raw: {
            'flex': '1',
            'padding-bottom': isLast ? '0' : '1.5rem',
          }),
          [
            dom.div(
              classes: 'codex-stepper-title',
              styles: dom.Styles(raw: {
                'font-size': fontSize,
                'font-weight': 'var(--font-weight-medium)',
                'color': item.status == StepStatus.current
                    ? 'var(--primary)'
                    : item.status == StepStatus.pending
                        ? 'var(--muted-foreground)'
                        : 'var(--foreground)',
              }),
              [Component.text(item.title)],
            ),
            if (item.description != null)
              dom.div(
                classes: 'codex-stepper-description',
                styles: const dom.Styles(raw: {
                  'font-size': '0.8125rem',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.25rem',
                }),
                [Component.text(item.description!)],
              ),
            if (item.content != null)
              dom.div(
                classes: 'codex-stepper-custom',
                styles: const dom.Styles(raw: {
                  'margin-top': '0.75rem',
                }),
                [item.content!],
              ),
          ],
        ),
      ],
    );
  }

  (String bg, String text, String border, String glow) _getStepStyles(
      StepStatus status) {
    return switch (status) {
      StepStatus.complete => (
          'var(--primary)',
          '#ffffff',
          'var(--primary)',
          '0 0 15px rgba(var(--primary-rgb), 0.2)',
        ),
      StepStatus.current => (
          'transparent',
          'var(--primary)',
          'var(--primary)',
          '0 0 15px rgba(var(--primary-rgb), 0.2)',
        ),
      StepStatus.pending => (
          'transparent',
          'var(--muted-foreground)',
          'var(--border)',
          'none',
        ),
    };
  }
}