import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/stepper_props.dart';

/// Step item data (convenience class for the component wrapper)
class ArcaneStepItem {
  /// Step title
  final String title;

  /// Step description
  final String? description;

  /// Step status
  final StepStatus status;

  /// Optional custom content
  final Component? content;

  const ArcaneStepItem({
    required this.title,
    this.description,
    this.status = StepStatus.pending,
    this.content,
  });

  /// Convert to StepItemData for the renderer
  StepItemData toData() => StepItemData(
        title: title,
        description: description,
        status: status,
        content: content,
      );
}

/// A numbered steps component for showing progress through a process.
///
/// Supports vertical and horizontal layouts with numbered indicators.
///
/// ```dart
/// ArcaneSteps(
///   items: [
///     ArcaneStepItem(
///       title: 'Account',
///       description: 'Create your account',
///       status: StepStatus.complete,
///     ),
///     ArcaneStepItem(
///       title: 'Profile',
///       description: 'Set up your profile',
///       status: StepStatus.current,
///     ),
///     ArcaneStepItem(
///       title: 'Complete',
///       description: 'Start using the app',
///       status: StepStatus.pending,
///     ),
///   ],
/// )
/// ```
class ArcaneSteps extends StatelessComponent {
  /// Step items
  final List<ArcaneStepItem> items;

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

  const ArcaneSteps({
    required this.items,
    this.layout = StepsLayout.horizontal,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
    super.key,
  });

  /// Vertical layout steps
  const ArcaneSteps.vertical({
    required this.items,
    this.size = StepsSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
    super.key,
  }) : layout = StepsLayout.vertical;

  /// Horizontal layout steps
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

/// Alias for ArcaneSteps
typedef ASteps = ArcaneSteps;
