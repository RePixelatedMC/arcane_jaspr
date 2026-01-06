/// Dot indicator size variants
enum DotIndicatorSize {
  /// Small dots (6px)
  sm,

  /// Medium dots (8px) - default
  md,

  /// Large dots (10px)
  lg,
}

/// Properties for dot indicator components.
class DotIndicatorProps {
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

/// Size variants for step indicator
enum StepIndicatorSize {
  sm,
  md,
  lg,
}

/// Properties for step indicator components.
class StepIndicatorProps {
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

  const StepIndicatorProps({
    required this.currentStep,
    required this.steps,
    this.onStepTap,
    this.allowStepNavigation = true,
    this.size = StepIndicatorSize.md,
  });
}
