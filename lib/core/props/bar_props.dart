import 'package:jaspr/jaspr.dart';

enum BarBackButtonMode {
  always,
  never,
  auto,
}

/// Bar/app bar component properties.
class BarProps {
  final String? titleText;
  final Component? title;
  final String? subtitleText;
  final Component? subtitle;
  final List<Component>? leading;
  final List<Component>? trailing;
  final BarBackButtonMode backButton;
  final void Function()? onBack;
  final bool transparent;
  final bool centerTitle;
  final double? height;
  final String? padding;

  const BarProps({
    this.titleText,
    this.title,
    this.subtitleText,
    this.subtitle,
    this.leading,
    this.trailing,
    this.backButton = BarBackButtonMode.auto,
    this.onBack,
    this.transparent = false,
    this.centerTitle = false,
    this.height,
    this.padding,
  });
}

/// Dialog bar component properties.
class DialogBarProps {
  final String? title;
  final void Function()? onClose;

  const DialogBarProps({
    this.title,
    this.onClose,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for bar components.
mixin BarRendererContract {
  Component bar(BarProps props);
  Component dialogBar(DialogBarProps props);
}
