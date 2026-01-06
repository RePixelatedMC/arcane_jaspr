import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

/// Dot indicator size variants
enum DotIndicatorSize {
  /// Small dots (6px)
  sm,

  /// Medium dots (8px) - default
  md,

  /// Large dots (10px)
  lg,
}

/// Dot indicator for carousels, steppers, and page indicators.
///
/// ```dart
/// ArcaneDotIndicator(
///   index: currentPage,
///   length: totalPages,
///   onChanged: (index) => setState(() => currentPage = index),
/// )
/// ```
class ArcaneDotIndicator extends StatelessComponent {
  /// Currently active index
  final int index;

  /// Total number of dots
  final int length;

  /// Callback when a dot is tapped
  final void Function(int)? onChanged;

  /// Size variant
  final DotIndicatorSize size;

  /// Active dot color
  final String? activeColor;

  /// Inactive dot color
  final String? inactiveColor;

  /// Spacing between dots
  final String? spacing;

  /// Whether dots are interactive (clickable)
  final bool interactive;

  const ArcaneDotIndicator({
    required this.index,
    required this.length,
    this.onChanged,
    this.size = DotIndicatorSize.md,
    this.activeColor,
    this.inactiveColor,
    this.spacing,
    this.interactive = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final dotSize = switch (size) {
      DotIndicatorSize.sm => '6px',
      DotIndicatorSize.md => '8px',
      DotIndicatorSize.lg => '10px',
    };

    final effectiveSpacing = spacing ?? '0.5rem';
    final effectiveActiveColor = activeColor ?? 'var(--accent)';
    final effectiveInactiveColor = inactiveColor ?? 'var(--muted)';

    return div(
      classes: 'arcane-dot-indicator',
      attributes: {
        'role': 'tablist',
        'aria-label': 'Page indicators',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': effectiveSpacing,
      }),
      [
        for (var i = 0; i < length; i++)
          button(
            type: ButtonType.button,
            classes: 'arcane-dot ${i == index ? 'active' : ''}',
            attributes: {
              'role': 'tab',
              'aria-selected': '${i == index}',
              'aria-label': 'Page ${i + 1} of $length',
              if (!interactive) 'disabled': 'true',
            },
            styles: Styles(raw: {
              'width': i == index ? 'calc($dotSize * 2)' : dotSize,
              'height': dotSize,
              'border-radius': '9999px',
              'background': i == index
                  ? effectiveActiveColor
                  : effectiveInactiveColor,
              'border': 'none',
              'padding': '0',
              'cursor': interactive ? 'pointer' : 'default',
              'transition': 'all 0.2s ease',
            }),
            events: interactive && onChanged != null
                ? {'click': (_) => onChanged!(i)}
                : null,
            [],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-dot:hover:not(:disabled):not(.active)').styles(raw: {
      'background': 'var(--muted-foreground)',
    }),
    css('.arcane-dot:focus-visible').styles(raw: {
      'outline': '2px solid var(--accent)',
      'outline-offset': '2px',
    }),
  ];
}

/// A more elaborate step indicator with labels.
///
/// ```dart
/// ArcaneStepIndicator(
///   currentStep: 2,
///   steps: ['Account', 'Profile', 'Review', 'Complete'],
///   onStepTap: (step) => goToStep(step),
/// )
/// ```
class ArcaneStepIndicator extends StatelessComponent {
  /// Current step (0-indexed)
  final int currentStep;

  /// List of step labels
  final List<String> steps;

  /// Callback when a step is tapped
  final void Function(int)? onStepTap;

  /// Whether completed steps are clickable
  final bool allowStepNavigation;

  /// Size variant
  final StepIndicatorSize size;

  const ArcaneStepIndicator({
    required this.currentStep,
    required this.steps,
    this.onStepTap,
    this.allowStepNavigation = true,
    this.size = StepIndicatorSize.md,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (circleSize, fontSize, lineHeight) = switch (size) {
      StepIndicatorSize.sm => ('24px', '0.75rem', '2px'),
      StepIndicatorSize.md => ('32px', '0.875rem', '3px'),
      StepIndicatorSize.lg => ('40px', '1rem', '4px'),
    };

    return div(
      classes: 'arcane-step-indicator',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
      }),
      [
        for (var i = 0; i < steps.length; i++) ...[
          // Step item
          div(
            classes: 'arcane-step-item',
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'gap': '0.25rem',
            }),
            [
              // Circle
              button(
                type: ButtonType.button,
                classes: 'arcane-step-circle ${i < currentStep ? 'completed' : ''} ${i == currentStep ? 'active' : ''}',
                attributes: {
                  if (i == currentStep) 'aria-current': 'step',
                  if (!allowStepNavigation || i > currentStep) 'disabled': 'true',
                },
                styles: Styles(raw: {
                  'width': circleSize,
                  'height': circleSize,
                  'border-radius': '9999px',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': fontSize,
                  'font-weight': '500',
                  'border': 'none',
                  'background': i <= currentStep
                      ? 'var(--accent)'
                      : 'var(--muted)',
                  'color': i <= currentStep
                      ? 'var(--accent-foreground)'
                      : 'var(--muted-foreground)',
                  'cursor': allowStepNavigation && i <= currentStep
                      ? 'pointer'
                      : 'default',
                  'transition': 'all 150ms ease',
                }),
                events: allowStepNavigation && i <= currentStep && onStepTap != null
                    ? {'click': (_) => onStepTap!(i)}
                    : null,
                [
                  if (i < currentStep)
                    text('\u2713')
                  else
                    text('${i + 1}'),
                ],
              ),

              // Label
              span(
                styles: Styles(raw: {
                  'font-size': fontSize,
                  'color': i == currentStep
                      ? 'var(--foreground)'
                      : 'var(--muted-foreground)',
                  'font-weight': i == currentStep
                      ? '500'
                      : '400',
                  'text-align': 'center',
                  'white-space': 'nowrap',
                }),
                [text(steps[i])],
              ),
            ],
          ),

          // Connector line (not after last step)
          if (i < steps.length - 1)
            div(
              classes: 'arcane-step-connector',
              styles: Styles(raw: {
                'flex': '1',
                'height': lineHeight,
                'margin': '0 0.5rem',
                'margin-top': 'calc($circleSize / 2 - $lineHeight / 2)',
                'background': i < currentStep
                    ? 'var(--accent)'
                    : 'var(--border)',
                'transition': 'all 150ms ease',
              }),
              [],
            ),
        ],
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-step-circle:hover:not(:disabled)').styles(raw: {
      'transform': 'scale(1.1)',
    }),
    css('.arcane-step-circle:focus-visible').styles(raw: {
      'outline': '2px solid var(--accent)',
      'outline-offset': '2px',
    }),
  ];
}

/// Size variants for step indicator
enum StepIndicatorSize {
  sm,
  md,
  lg,
}
