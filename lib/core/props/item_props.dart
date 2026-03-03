import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';

class ItemProps {
  final Component child;
  final String? href;
  final bool external;
  final ArcaneStyleData? styles;
  final String? classes;

  const ItemProps({
    required this.child,
    this.href,
    this.external = false,
    this.styles,
    this.classes,
  });

  ItemProps copyWith({
    Component? child,
    String? href,
    bool? external,
    ArcaneStyleData? styles,
    String? classes,
  }) {
    return ItemProps(
      child: child ?? this.child,
      href: href ?? this.href,
      external: external ?? this.external,
      styles: styles ?? this.styles,
      classes: classes ?? this.classes,
    );
  }
}

mixin ItemRendererContract {
  Component item(ItemProps props);
}
