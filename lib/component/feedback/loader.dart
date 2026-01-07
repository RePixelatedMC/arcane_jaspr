import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../core/theme_provider.dart';

export '../../core/props/loader_props.dart'
    show LoaderVariant, LoaderProps, LoadingOverlayProps;

/// Spinner loader component.
class ArcaneLoader extends StatelessComponent {
  final String size;
  final String? color;
  final String strokeWidth;

  const ArcaneLoader({
    this.size = '32px',
    this.color,
    this.strokeWidth = '3px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.loader(LoaderProps.spinner(
      size: size,
      color: color,
      strokeWidth: strokeWidth,
    ));
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes spin').styles(raw: {
      'to': 'transform: rotate(360deg)',
    }),
  ];
}

/// Dots loader animation.
class ArcaneDotsLoader extends StatelessComponent {
  final String? color;
  final String dotSize;

  const ArcaneDotsLoader({
    this.color,
    this.dotSize = '8px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.loader(LoaderProps.dots(
      color: color,
      dotSize: dotSize,
    ));
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes dotBounce').styles(raw: {
      '0%, 80%, 100%': 'transform: scale(0)',
      '40%': 'transform: scale(1)',
    }),
  ];
}

/// Pulse loader animation.
class ArcanePulseLoader extends StatelessComponent {
  final String size;
  final String? color;

  const ArcanePulseLoader({
    this.size = '40px',
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.loader(LoaderProps.pulse(
      size: size,
      color: color,
    ));
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes pulseGrow').styles(raw: {
      '0%, 100%': 'transform: scale(0.8); opacity: 0.5',
      '50%': 'transform: scale(1.2); opacity: 0.2',
    }),
  ];
}

/// Full-screen loading overlay.
class ArcaneLoadingOverlay extends StatelessComponent {
  final Component? loader;
  final String? message;

  const ArcaneLoadingOverlay({
    this.loader,
    this.message,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.loadingOverlay(LoadingOverlayProps(
      loader: loader,
      message: message,
    ));
  }
}

/// Style injection for loader animations.
class ArcaneLoaderStyles extends StatelessComponent {
  const ArcaneLoaderStyles({super.key});

  @override
  Component build(BuildContext context) {
    return const Component.element(
      tag: 'style',
      children: [Component.text('''
        @keyframes spin {
          to { transform: rotate(360deg); }
        }
        @keyframes dotBounce {
          0%, 80%, 100% { transform: scale(0); }
          40% { transform: scale(1); }
        }
        @keyframes pulseGrow {
          0%, 100% { transform: scale(0.8); opacity: 0.5; }
          50% { transform: scale(1.2); opacity: 0.2; }
        }
        @keyframes pulse {
          0%, 100% { opacity: 0.4; transform: scale(1); }
          50% { opacity: 0.2; transform: scale(1.3); }
        }
        @keyframes arcane-pulse {
          0%, 100% { opacity: 1; }
          50% { opacity: 0.5; }
        }
      ''')],
    );
  }
}
