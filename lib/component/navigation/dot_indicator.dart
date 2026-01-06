import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/dot_indicator_props.dart';

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
    return context.renderers.dotIndicator(DotIndicatorProps(
      index: index,
      length: length,
      onChanged: onChanged,
      size: size,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      spacing: spacing,
      interactive: interactive,
    ));
  }
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
    return context.renderers.stepIndicator(StepIndicatorProps(
      currentStep: currentStep,
      steps: steps,
      onStepTap: onStepTap,
      allowStepNavigation: allowStepNavigation,
      size: size,
    ));
  }
}
