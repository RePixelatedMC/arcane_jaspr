import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/scroll_rail_props.dart';

class CodexScrollRail extends StatelessComponent {
  final ScrollRailProps props;

  const CodexScrollRail(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String height = 'calc(100vh - ${props.topOffset} - ${props.bottomOffset})';
    final String id = props.scrollPersistenceId ?? 'codex-scroll-rail-${props.position.name}';
    final String width = _width(props.size, props.width);

    return dom.div(
      id: id,
      classes: 'codex-scroll-rail',
      styles: dom.Styles(raw: {
        'position': 'sticky',
        'top': props.topOffset,
        'width': width,
        'height': height,
        'max-height': height,
        'flex-shrink': '0',
        'overflow-y': 'auto',
        'overflow-x': 'hidden',
        'background': props.background ?? 'var(--codex-surface-1)',
        if (props.position == ScrollRailPosition.left)
          'border-right': _border(props.showBorder)
        else
          'border-left': _border(props.showBorder),
        if (props.customScrollbar) ...{
          'scrollbar-width': 'thin',
          'scrollbar-color': 'var(--codex-accent) transparent',
        },
      }),
      [
        dom.div(
          styles: dom.Styles(raw: {
            'padding': props.padding,
            'min-height': '100%',
          }),
          props.children,
        ),
        if (props.scrollPersistenceId != null)
          dom.script(content: '''
            (function() {
              var rail = document.getElementById('$id');
              if (!rail) return;
              var storageKey = 'scroll-rail-$id';
              var savedPos = sessionStorage.getItem(storageKey);
              if (savedPos) rail.scrollTop = parseInt(savedPos, 10);
              var saveTimeout;
              rail.addEventListener('scroll', function() {
                clearTimeout(saveTimeout);
                saveTimeout = setTimeout(function() {
                  sessionStorage.setItem(storageKey, rail.scrollTop.toString());
                }, 100);
              });
            })();
          '''),
      ],
    );
  }
}

class CodexScrollRailLayout extends StatelessComponent {
  final ScrollRailLayoutProps props;

  const CodexScrollRailLayout(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final Component rail = CodexScrollRail(
      ScrollRailProps(
        position: props.railPosition,
        size: props.railSize,
        width: props.railWidth,
        topOffset: props.headerHeight,
        showBorder: props.showBorder,
        background: props.railBackground,
        scrollPersistenceId: 'codex-main-rail',
        children: [props.rail],
      ),
    );

    final Component content = dom.div(
      classes: 'codex-scroll-rail-content',
      styles: dom.Styles(raw: {
        'flex': '1',
        'min-width': '0',
        'background': props.contentBackground ?? 'var(--codex-surface-0)',
      }),
      [props.child],
    );

    return dom.div(
      classes: 'codex-scroll-rail-layout',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'min-height': '100vh',
        'width': '100%',
      }),
      props.railPosition == ScrollRailPosition.left
          ? [rail, content]
          : [content, rail],
    );
  }
}

String _width(ScrollRailSize size, String? width) {
  return width ??
      switch (size) {
        ScrollRailSize.narrow => '200px',
        ScrollRailSize.sm => '240px',
        ScrollRailSize.md => '280px',
        ScrollRailSize.lg => '320px',
        ScrollRailSize.xl => '360px',
      };
}

String _border(bool showBorder) {
  if (!showBorder) {
    return 'none';
  }
  return '1px solid var(--codex-accent-border)';
}
