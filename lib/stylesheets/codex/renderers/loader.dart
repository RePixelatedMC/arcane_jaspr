import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/loader_props.dart';

/// Codex loader component.
class CodexLoader extends StatelessComponent {
  final LoaderProps props;

  const CodexLoader(this.props, {super.key});

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
      classes: 'codex-loader-spinner',
      styles: dom.Styles(raw: {
        'width': props.size,
        'height': props.size,
        'border': '${props.strokeWidth} solid var(--border)',
        'border-top-color': props.color ?? 'var(--codex-accent)',
        'border-radius': 'var(--arcane-radius-full)',
        'animation': 'spin 1s linear infinite',
      }),
      [],
    );
  }

  Component _buildDots() {
    return dom.div(
      classes: 'codex-dots-loader',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'gap': '6px',
        'align-items': 'center',
      }),
      [
        for (int i = 0; i < 3; i++)
          dom.div(
            styles: dom.Styles(raw: {
              'width': props.dotSize,
              'height': props.dotSize,
              'border-radius': 'var(--arcane-radius-full)',
              'background': props.color ?? 'var(--codex-accent)',
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
      classes: 'codex-pulse-loader',
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
            'background': props.color ?? 'var(--codex-accent)',
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
            'background': props.color ?? 'var(--codex-accent)',
          }),
          [],
        ),
      ],
    );
  }
}

/// Codex loading overlay component.
class CodexLoadingOverlay extends StatelessComponent {
  final LoadingOverlayProps props;

  const CodexLoadingOverlay(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-loading-overlay',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': 'var(--arcane-space-6)',
        'background': 'rgba(0, 0, 0, 0.8)',
        'backdrop-filter': 'blur(12px)',
        '-webkit-backdrop-filter': 'blur(12px)',
        'z-index': '9999',
      }),
      [
        props.loader ?? const CodexLoader(LoaderProps.spinner(size: '56px')),
        if (props.message != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'color': 'var(--muted-foreground)',
              'font-size': 'var(--arcane-font-size-base)',
            }),
            [Component.text(props.message!)],
          ),
      ],
    );
  }
}
