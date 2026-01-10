import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/scroll_rail_props.dart';

String _getWidthValue(ScrollRailSize size, String? width) =>
    width ??
    switch (size) {
      ScrollRailSize.narrow => '220px',
      ScrollRailSize.sm => '260px',
      ScrollRailSize.md => '300px',
      ScrollRailSize.lg => '340px',
      ScrollRailSize.xl => '380px',
    };

String _getBorderStyle(bool showBorder) {
  if (!showBorder) return 'none';
  return '1px solid var(--border)';
}

/// Renders a Codex scroll rail component.
Component renderScrollRail(ScrollRailProps props) {
  final String heightCalc = 'calc(100vh - ${props.topOffset} - ${props.bottomOffset})';
  final String scrollbarId = props.scrollPersistenceId ?? 'scroll-rail-${props.position.name}';
  final String widthValue = _getWidthValue(props.size, props.width);

  return dom.div(
    id: scrollbarId,
    styles: dom.Styles(raw: {
      'position': 'sticky',
      'top': props.topOffset,
      'width': widthValue,
      'height': heightCalc,
      'max-height': heightCalc,
      'flex-shrink': '0',
      'overflow-y': 'auto',
      'overflow-x': 'hidden',
      'background': props.background ?? 'var(--card)',
      if (props.position == ScrollRailPosition.left)
        'border-right': _getBorderStyle(props.showBorder)
      else
        'border-left': _getBorderStyle(props.showBorder),
      if (props.customScrollbar) ...{
        'scrollbar-width': 'thin',
        'scrollbar-color': 'rgba(var(--primary-rgb), 0.3) transparent',
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
            var rail = document.getElementById('$scrollbarId');
            if (!rail) return;
            var storageKey = 'scroll-rail-$scrollbarId';
            var savedPos = sessionStorage.getItem(storageKey);
            if (savedPos) {
              rail.scrollTop = parseInt(savedPos, 10);
            }
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

/// Renders a Codex scroll rail layout component.
Component renderScrollRailLayout(ScrollRailLayoutProps props) {
  final railComponent = renderScrollRail(ScrollRailProps(
    position: props.railPosition,
    size: props.railSize,
    width: props.railWidth,
    topOffset: props.headerHeight,
    showBorder: props.showBorder,
    background: props.railBackground,
    scrollPersistenceId: 'main-rail',
    children: [props.rail],
  ));

  final mainContent = dom.div(
    styles: dom.Styles(raw: {
      'flex': '1',
      'min-width': '0',
      'background': props.contentBackground ?? 'var(--background)',
    }),
    [props.child],
  );

  return dom.div(
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'min-height': '100vh',
      'width': '100%',
    }),
    props.railPosition == ScrollRailPosition.left
        ? [railComponent, mainContent]
        : [mainContent, railComponent],
  );
}
