import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/stepper_props.dart';

/// Step item data for the component wrapper.
class ArcaneStepItem {
  final String title;
  final String? description;
  final StepStatus status;
  final Component? content;

  const ArcaneStepItem({
    required this.title,
    this.description,
    this.status = StepStatus.pending,
    this.content,
  });

  StepItemData toData() => StepItemData(
        title: title,
        description: description,
        status: status,
        content: content,
      );
}

/// A numbered steps component for showing progress through a process.
class ArcaneSteps extends StatelessComponent {
  final List<ArcaneStepItem> items;
  final StepsLayout layout;
  final StepsSize size;
  final bool showConnectors;
  final int? currentStep;
  final void Function(int index)? onStepTap;

  const ArcaneSteps({
    required this.items,
    this.layout = StepsLayout.horizontal,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
    super.key,
  });

  const ArcaneSteps.vertical({
    required this.items,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
    super.key,
  }) : layout = StepsLayout.vertical;

  const ArcaneSteps.horizontal({
    required this.items,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
    super.key,
  }) : layout = StepsLayout.horizontal;

  @override
  Component build(BuildContext context) {
    return context.renderers.stepper(StepperProps(
      items: items.map((item) => item.toData()).toList(),
      layout: layout,
      size: size,
      showConnectors: showConnectors,
      currentStep: currentStep,
      onStepTap: onStepTap,
    ));
  }
}

typedef ASteps = ArcaneSteps;
