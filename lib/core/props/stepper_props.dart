import 'package:jaspr/jaspr.dart';

/// Steps layout options
enum StepsLayout {
  /// Vertical layout with numbers on the left
  vertical,

  /// Horizontal layout with numbers on top
  horizontal,
}

/// Step status
enum StepStatus {
  /// Completed step
  complete,

  /// Current/active step
  current,

  /// Pending/upcoming step
  pending,
}

/// Steps size options
enum StepsSize {
  sm,
  md,
  lg,
}

/// Step item data
class StepItemData {
  /// Step title
  final String title;

  /// Step description
  final String? description;

  /// Step status
  final StepStatus status;

  /// Optional custom content
  final Component? content;

  const StepItemData({
    required this.title,
    this.description,
    this.status = StepStatus.pending,
    this.content,
  });
}

/// Properties for stepper components.
class StepperProps {
  /// Step items
  final List<StepItemData> items;

  /// Layout type
  final StepsLayout layout;

  /// Size
  final StepsSize size;

  /// Whether to show connector lines
  final bool showConnectors;

  /// Current step index (alternative to setting status on each item)
  final int? currentStep;

  /// Callback when a step is clicked (only works for completed steps)
  final void Function(int index)? onStepTap;

  const StepperProps({
    required this.items,
    this.layout = StepsLayout.horizontal,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
  });
}
