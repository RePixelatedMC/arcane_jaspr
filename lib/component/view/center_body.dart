import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

// Re-export props for usage
export '../../core/props/center_body_props.dart';

/// A component that centers its content both horizontally and vertically.
class ArcaneCenterBody extends StatelessComponent {
  /// The child component
  final Component child;

  /// Maximum width of the content
  final double? maxWidth;

  /// Custom padding
  final EdgeInsets? padding;

  /// Whether to fill the entire viewport height
  final bool fillHeight;

  const ArcaneCenterBody({
    required this.child,
    this.maxWidth,
    this.padding,
    this.fillHeight = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.centerBody(CenterBodyProps(
      child: child,
      maxWidth: maxWidth,
      padding: padding?.padding,
      fillHeight: fillHeight,
    ));
  }
}

/// A page-level centered content container
class ArcanePageBody extends StatelessComponent {
  final List<Component> children;
  final double maxWidth;
  final EdgeInsets? padding;

  const ArcanePageBody({
    required this.children,
    this.maxWidth = 1200,
    this.padding,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.pageBody(PageBodyProps(
      children: children,
      maxWidth: maxWidth,
      padding: (padding ?? const EdgeInsets.all(16)).padding,
    ));
  }
}

/// An empty state component for when there's no content
class ArcaneEmptyState extends StatelessComponent {
  final String? title;
  final String? message;
  final Component? icon;
  final Component? action;

  const ArcaneEmptyState({
    this.title,
    this.message,
    this.icon,
    this.action,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneCenterBody(
      child: div(
        classes: 'arcane-empty-state',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'text-align': 'center',
          'padding': '4rem 2rem',
          'gap': '1.5rem',
        }),
        [
          if (icon != null)
            div(
              styles: const Styles(raw: {
                'color': 'var(--muted-foreground)',
                'font-size': '2.5rem',
                'opacity': '0.5',
              }),
              [icon!],
            ),
          if (title != null)
            div(
              styles: const Styles(raw: {
                'font-size': '1.25rem',
                'font-weight': '600',
                'color': 'var(--foreground)',
              }),
              [Component.text(title!)],
            ),
          if (message != null)
            div(
              styles: const Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--muted-foreground)',
                'max-width': '400px',
              }),
              [Component.text(message!)],
            ),
          if (action != null)
            div(
              styles: const Styles(raw: {
                'margin-top': '0.5rem',
              }),
              [action!],
            ),
        ],
      ),
    );
  }
}

/// A loading state component
class ArcaneLoadingState extends StatelessComponent {
  final String? message;

  const ArcaneLoadingState({
    this.message,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.loadingState(LoadingStateProps(
      message: message,
    ));
  }
}

/// An error state component
class ArcaneErrorState extends StatelessComponent {
  final String? title;
  final String? message;
  final Component? action;

  const ArcaneErrorState({
    this.title,
    this.message,
    this.action,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.errorState(ErrorStateProps(
      title: title,
      message: message,
      action: action,
    ));
  }
}
