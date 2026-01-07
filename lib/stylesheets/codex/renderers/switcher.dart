import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/switcher_props.dart';

/// Codex Switcher renderer.
class CodexSwitcher extends StatelessComponent {
  final SwitcherProps props;

  const CodexSwitcher(this.props, {super.key});

  String get _transformAxis => switch (props.direction) {
        SwitcherDirection.up || SwitcherDirection.down => 'Y',
        SwitcherDirection.left || SwitcherDirection.right => 'X',
        SwitcherDirection.fade => '',
      };

  @override
  Component build(BuildContext context) {
    if (props.children.isEmpty) {
      return const dom.div(classes: 'codex-switcher', []);
    }

    final safeIndex = props.index.clamp(0, props.children.length - 1);

    return dom.div(
      classes: 'codex-switcher',
      attributes: {
        'data-switcher': 'true',
        'data-index': '$safeIndex',
        'data-direction': props.direction.name,
      },
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'overflow': 'hidden',
        'width': '100%',
      }),
      [
        // Render all children but only show current
        for (var i = 0; i < props.children.length; i++)
          dom.div(
            classes: 'codex-switcher-item ${i == safeIndex ? 'active' : ''}',
            styles: dom.Styles(raw: {
              'width': '100%',
              if (i != safeIndex) ...{
                'position': 'absolute',
                'top': '0',
                'left': '0',
                'opacity': '0',
                'pointer-events': 'none',
                if (props.direction != SwitcherDirection.fade)
                  'transform': i < safeIndex
                      ? 'translate$_transformAxis(-100%)'
                      : 'translate$_transformAxis(100%)',
              } else ...{
                'opacity': '1',
                'transform': 'none',
              },
              'transition':
                  'opacity ${props.duration}ms ease, transform ${props.duration}ms ease',
            }),
            [props.children[i]],
          ),
      ],
    );
  }
}

/// Codex Indexed Stack renderer.
class CodexIndexedStack extends StatelessComponent {
  final IndexedStackProps props;

  const CodexIndexedStack(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (props.children.isEmpty) {
      return const dom.div(classes: 'codex-indexed-stack', []);
    }

    final safeIndex = props.index.clamp(0, props.children.length - 1);

    return dom.div(
      classes: 'codex-indexed-stack',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
      }),
      [
        for (var i = 0; i < props.children.length; i++)
          dom.div(
            classes: 'codex-indexed-stack-item',
            styles: dom.Styles(raw: {
              'width': '100%',
              if (i != safeIndex) 'display': 'none',
            }),
            [props.children[i]],
          ),
      ],
    );
  }
}
