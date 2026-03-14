import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart' as jaspr;

import 'demo_registry.dart';

const ArcaneStylesheet _clientStylesheet = ShadcnStylesheet();

@jaspr.client
class InteractiveDemo extends StatefulWidget {
  final String componentType;

  const InteractiveDemo({required this.componentType, super.key});

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  @override
  Widget build(BuildContext context) {
    DemoDefinition? demo = demoRegistry[component.componentType];
    String exampleCode = demo?.code ?? 'ArcaneComponent(/* configure props */)';
    Widget preview =
        demo?.previewBuilder() ?? _buildMissingPreview(component.componentType);

    return ArcaneThemeProvider(
      stylesheet: _clientStylesheet,
      brightness: Brightness.dark,
      child: ArcaneBox(
        style: const ArcaneStyleData(
          margin: MarginPreset.bottomXl,
          padding: PaddingPreset.lg,
          borderRadius: Radius.lg,
          background: Background.transparent,
          border: BorderPreset.subtle,
        ),
        children: <Widget>[
          ArcaneBox(
            style: const ArcaneStyleData(
              fontSize: FontSize.sm,
              fontWeight: FontWeight.w600,
              textColor: TextColor.mutedForeground,
              margin: MarginPreset.bottomMd,
              textTransform: TextTransform.uppercase,
              letterSpacing: LetterSpacing.wide,
            ),
            children: const <Widget>[ArcaneText('Live Demo')],
          ),
          ArcaneBox(
            style: const ArcaneStyleData(
              display: Display.flex,
              alignItems: AlignItems.center,
              gap: Gap.md,
              margin: MarginPreset.bottomMd,
            ),
            children: <Widget>[
              ArcaneBox(
                style: const ArcaneStyleData(
                  padding: PaddingPreset.badge,
                  borderRadius: Radius.full,
                  background: Background.backgroundSecondary,
                ),
                children: <Widget>[
                  ArcaneText(
                    'Component: ${component.componentType}',
                    size: FontSize.sm,
                    color: TextColor.mutedForeground,
                  ),
                ],
              ),
            ],
          ),
          ArcaneBox(
            style: const ArcaneStyleData(
              margin: MarginPreset.bottomSm,
              fontSize: FontSize.sm,
              fontWeight: FontWeight.w600,
              textColor: TextColor.primary,
            ),
            children: const <Widget>[ArcaneText('Preview + Code')],
          ),
          preview,
          ArcaneBox(
            style: const ArcaneStyleData(
              margin: MarginPreset.topLg,
              fontSize: FontSize.sm,
              fontWeight: FontWeight.w600,
              textColor: TextColor.mutedForeground,
              raw: <String, String>{'margin-bottom': '12px'},
            ),
            children: const <Widget>[ArcaneText('Code')],
          ),
          dom.pre(
            styles: const dom.Styles(
              raw: <String, String>{
                'margin': '0',
                'padding': '16px',
                'background': 'var(--card)',
                'border': '1px solid var(--border)',
                'border-radius': 'var(--radius)',
                'overflow-x': 'auto',
              },
            ),
            <jaspr.Component>[
              dom.code(
                classes: 'language-dart',
                styles: const dom.Styles(
                  raw: <String, String>{'display': 'block'},
                ),
                <jaspr.Component>[jaspr.Component.text(exampleCode)],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMissingPreview(String componentType) {
    return ArcaneBox(
      style: const ArcaneStyleData(
        padding: PaddingPreset.lg,
        borderRadius: Radius.lg,
        border: BorderPreset.subtle,
        background: Background.backgroundSecondary,
      ),
      children: <Widget>[
        ArcaneAlert.warning(
          title: 'No Demo Found',
          message: 'No live preview is registered for "$componentType".',
        ),
      ],
    );
  }
}
