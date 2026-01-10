import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/center_body_props.dart';

/// ShadCN Center Body renderer.
class ShadcnCenterBody extends StatelessComponent {
  final CenterBodyProps props;

  const ShadcnCenterBody(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-center-body',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        if (props.fillHeight) 'min-height': '100%',
        if (props.fillHeight) 'flex': '1',
        if (props.padding != null) 'padding': props.padding!,
      }),
      [
        dom.div(
          classes: 'arcane-center-body-content',
          styles: dom.Styles(raw: {
            'width': '100%',
            if (props.maxWidth != null) 'max-width': '${props.maxWidth}px',
          }),
          [props.child],
        ),
      ],
    );
  }
}

/// ShadCN Page Body renderer.
class ShadcnPageBody extends StatelessComponent {
  final PageBodyProps props;

  const ShadcnPageBody(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-page-body',
      styles: dom.Styles(raw: {
        'width': '100%',
        'max-width': '${props.maxWidth}px',
        'margin': '0 auto',
        'padding': props.padding ?? '1rem',
      }),
      props.children,
    );
  }
}

/// ShadCN Loading State renderer.
class ShadcnLoadingState extends StatelessComponent {
  final LoadingStateProps props;

  const ShadcnLoadingState(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-loading-state',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'min-height': '100%',
        'flex': '1',
        'gap': 'var(--arcane-space-6)',
        'padding': '4rem 2rem',
      }),
      [
        // Spinner
        const dom.div(
          classes: 'arcane-loading-spinner',
          styles: dom.Styles(raw: {
            'width': '40px',
            'height': '40px',
            'border': '3px solid var(--border)',
            'border-top-color': 'var(--primary)',
            'border-radius': 'var(--arcane-radius-full)',
            'animation': 'arcane-spin 0.75s linear infinite',
          }),
          [],
        ),
        if (props.message != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.message!)],
          ),
      ],
    );
  }
}

/// ShadCN Error State renderer.
class ShadcnErrorState extends StatelessComponent {
  final ErrorStateProps props;

  const ShadcnErrorState(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-error-state',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'min-height': '100%',
        'flex': '1',
        'text-align': 'center',
        'padding': '4rem 2rem',
        'gap': 'var(--arcane-space-6)',
      }),
      [
        // Error icon
        const dom.div(
          styles: dom.Styles(raw: {
            'color': 'var(--destructive)',
            'font-size': '2.5rem',
          }),
          [Component.text('!')],
        ),
        if (props.title != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xl)',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.title!)],
          ),
        if (props.message != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--muted-foreground)',
              'max-width': '400px',
            }),
            [Component.text(props.message!)],
          ),
        if (props.action != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'margin-top': '0.5rem',
            }),
            [props.action!],
          ),
      ],
    );
  }
}