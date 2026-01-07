import 'package:jaspr/jaspr.dart';

enum StepsLayout {
  vertical,
  horizontal,
}

enum StepStatus {
  complete,
  current,
  pending,
}

enum StepsSize {
  sm,
  md,
  lg,
}

/// Step item data.
class StepItemData {
  final String title;
  final String? description;
  final StepStatus status;
  final Component? content;

  const StepItemData({
    required this.title,
    this.description,
    this.status = StepStatus.pending,
    this.content,
  });
}

/// Stepper component properties.
class StepperProps {
  final List<StepItemData> items;
  final StepsLayout layout;
  final StepsSize size;
  final bool showConnectors;
  final int? currentStep;
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
