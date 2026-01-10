import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/loader_props.dart';

/// ShadCN-style loader component
class ShadcnLoader extends StatelessComponent {
  final LoaderProps props;

  const ShadcnLoader(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return switch (props.variant) {
      LoaderVariant.spinner => _buildSpinner(),
      LoaderVariant.dots => _buildDots(),
      LoaderVariant.pulse => _buildPulse(),
    };
  }

  Component _buildSpinner() {
    return dom.div(
      classes: 'arcane-loader-spinner',
      styles: dom.Styles(raw: {
        'width': props.size,
        'height': props.size,
        'border': '${props.strokeWidth} solid var(--border)',
        'border-top-color': props.color ?? 'var(--primary)',
        'border-radius': 'var(--arcane-radius-full)',
        'animation': 'spin 1s linear infinite',
      }),
      [],
    );
  }

  Component _buildDots() {
    return dom.div(
      classes: 'arcane-dots-loader',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'gap': 'var(--space-1)',
        'align-items': 'center',
      }),
      [
        for (int i = 0; i < 3; i++)
          dom.div(
            styles: dom.Styles(raw: {
              'width': props.dotSize,
              'height': props.dotSize,
              'border-radius': 'var(--arcane-radius-full)',
              'background': props.color ?? 'var(--primary)',
              'animation': 'dotBounce 1.4s infinite ease-in-out both',
              'animation-delay': '${i * 0.16}s',
            }),
            [],
          ),
      ],
    );
  }

  Component _buildPulse() {
    return dom.div(
      classes: 'arcane-pulse-loader',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'width': props.size,
        'height': props.size,
      }),
      [
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'inset': '0',
            'border-radius': 'var(--arcane-radius-full)',
            'background': props.color ?? 'var(--primary)',
            'opacity': '0.4',
            'animation': 'pulseGrow 1.5s infinite ease-in-out',
          }),
          [],
        ),
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'inset': '25%',
            'border-radius': 'var(--arcane-radius-full)',
            'background': props.color ?? 'var(--primary)',
          }),
          [],
        ),
      ],
    );
  }
}

/// ShadCN-style loading overlay component
class ShadcnLoadingOverlay extends StatelessComponent {
  final LoadingOverlayProps props;

  const ShadcnLoadingOverlay(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-loading-overlay',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '24px',
        'background': 'rgba(0, 0, 0, 0.5)',
        'backdrop-filter': 'blur(8px)',
        '-webkit-backdrop-filter': 'blur(8px)',
        'z-index': '9999',
      }),
      [
        props.loader ?? const ShadcnLoader(LoaderProps.spinner(size: '48px')),
        if (props.message != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'color': 'var(--muted-foreground)',
              'font-size': 'var(--font-size-base)',
            }),
            [Component.text(props.message!)],
          ),
      ],
    );
  }
}