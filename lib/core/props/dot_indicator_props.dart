import 'package:jaspr/jaspr.dart';

import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize;

/// Dot indicator component properties.
class DotIndicatorProps {
  final int index;
  final int length;
  final void Function(int)? onChanged;
  final ComponentSize size;
  final String? activeColor;
  final String? inactiveColor;
  final String? spacing;
  final bool interactive;

  const DotIndicatorProps({
    required this.index,
    required this.length,
    this.onChanged,
    this.size = ComponentSize.md,
    this.activeColor,
    this.inactiveColor,
    this.spacing,
    this.interactive = true,
  });
}

/// Step indicator component properties.
class StepIndicatorProps {
  final int currentStep;
  final List<String> steps;
  final void Function(int)? onStepTap;
  final bool allowStepNavigation;
  final ComponentSize size;

  const StepIndicatorProps({
    required this.currentStep,
    required this.steps,
    this.onStepTap,
    this.allowStepNavigation = true,
    this.size = ComponentSize.md,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for indicator components.
mixin DotIndicatorRendererContract {
  /// Renders a dot indicator for pagination/carousel.
  Component dotIndicator(DotIndicatorProps props);

  /// Renders a step indicator for multi-step processes.
  Component stepIndicator(StepIndicatorProps props);
}
