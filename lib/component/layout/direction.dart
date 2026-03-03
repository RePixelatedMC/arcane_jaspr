import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

enum ArcaneDirectionValue { ltr, rtl, auto }

class ArcaneDirection extends StatelessComponent {
  final ArcaneDirectionValue value;
  final List<Component> children;
  final String? classes;

  const ArcaneDirection({
    required this.children,
    this.value = ArcaneDirectionValue.ltr,
    this.classes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final DirectionValue mappedValue = switch (value) {
      ArcaneDirectionValue.ltr => DirectionValue.ltr,
      ArcaneDirectionValue.rtl => DirectionValue.rtl,
      ArcaneDirectionValue.auto => DirectionValue.auto,
    };

    return context.renderers.direction(
      DirectionProps(value: mappedValue, children: children, classes: classes),
    );
  }
}
