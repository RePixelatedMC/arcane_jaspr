import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/dot_indicator_props.dart';

/// Dot indicator for carousels, steppers, and page indicators.
class ArcaneDotIndicator extends StatelessComponent {
  final int index;
  final int length;
  final void Function(int)? onChanged;
  final DotIndicatorSize size;
  final String? activeColor;
  final String? inactiveColor;
  final String? spacing;
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

/// Step indicator with labels.
class ArcaneStepIndicator extends StatelessComponent {
  final int currentStep;
  final List<String> steps;
  final void Function(int)? onStepTap;
  final bool allowStepNavigation;
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
