import 'package:jaspr/jaspr.dart';

/// Section component properties.
class SectionProps {
  final String? header;
  final Component? headerComponent;
  final List<Component> children;
  final bool showDivider;
  final String? padding;
  final String? gap;
  final bool card;

  const SectionProps({
    this.header,
    this.headerComponent,
    required this.children,
    this.showDivider = false,
    this.padding,
    this.gap,
    this.card = false,
  });
}
