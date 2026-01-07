enum DotIndicatorSize {
  sm,
  md,
  lg,
}

/// Dot indicator component properties.
class DotIndicatorProps {
  final int index;
  final int length;
  final void Function(int)? onChanged;
  final DotIndicatorSize size;
  final String? activeColor;
  final String? inactiveColor;
  final String? spacing;
  final bool interactive;

  const DotIndicatorProps({
    required this.index,
    required this.length,
    this.onChanged,
    this.size = DotIndicatorSize.md,
    this.activeColor,
    this.inactiveColor,
    this.spacing,
    this.interactive = true,
  });
}

enum StepIndicatorSize {
  sm,
  md,
  lg,
}

/// Step indicator component properties.
class StepIndicatorProps {
  final int currentStep;
  final List<String> steps;
  final void Function(int)? onStepTap;
  final bool allowStepNavigation;
  final StepIndicatorSize size;

  const StepIndicatorProps({
    required this.currentStep,
    required this.steps,
    this.onStepTap,
    this.allowStepNavigation = true,
    this.size = StepIndicatorSize.md,
  });
}
