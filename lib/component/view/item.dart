import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

class ArcaneItem extends StatelessComponent {
  final Component child;
  final String? href;
  final bool external;
  final ArcaneStyleData? styles;
  final String? classes;

  const ArcaneItem({
    required this.child,
    this.href,
    this.external = false,
    this.styles,
    this.classes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.item(
      ItemProps(
        child: child,
        href: href,
        external: external,
        styles: styles,
        classes: classes,
      ),
    );
  }
}
