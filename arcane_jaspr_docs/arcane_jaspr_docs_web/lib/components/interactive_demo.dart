import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart' as jaspr;

import 'demo_registry.dart';

const ArcaneStylesheet clientNeonStylesheet = NeonStylesheet();
const ArcaneStylesheet selectedClientStylesheet = clientNeonStylesheet;

@jaspr.client
class InteractiveDemo extends StatefulWidget {
  final String componentType;

  const InteractiveDemo({required this.componentType, super.key});

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  final Map<String, bool> _boolValues = <String, bool>{};
  final Map<String, String> _stringValues = <String, String>{};
  final Map<String, double> _doubleValues = <String, double>{};
  final Map<String, int> _intValues = <String, int>{};

  @override
  Widget build(BuildContext context) {
    DemoStateController demoState = DemoStateController(
      boolValues: _boolValues,
      stringValues: _stringValues,
      doubleValues: _doubleValues,
      intValues: _intValues,
      notify: () => setState(() {}),
    );
    DemoDefinition? demo = demoRegistry[component.componentType];
    String exampleCode = demo?.code ?? 'ArcaneComponent(/* configure props */)';
    Widget preview =
        demo?.previewBuilder(demoState) ??
        _buildMissingPreview(component.componentType);
    ArcaneThemeProvider? parentTheme = ArcaneThemeProvider.of(context);
    ArcaneStylesheet stylesheet =
        parentTheme?.stylesheet ?? selectedClientStylesheet;
    Brightness brightness = parentTheme?.brightness ?? Brightness.dark;

    return ArcaneThemeProvider(
      stylesheet: stylesheet,
      brightness: brightness,
      child: dom.div(classes: 'arcane-demo-panel', [
        ArcaneBox(
          style: const ArcaneStyleData(
            margin: MarginPreset.bottomXl,
            padding: PaddingPreset.lg,
            borderRadius: Radius.lg,
            background: Background.transparent,
            border: BorderPreset.subtle,
          ),
          children: <Widget>[
            jaspr.Component.element(
              tag: 'style',
              children: const <jaspr.Component>[dom.RawText(_previewScopeCss)],
            ),
            ArcaneBox(
              style: const ArcaneStyleData(
                fontSize: FontSize.sm,
                fontWeight: FontWeight.w600,
                textColor: TextColor.mutedForeground,
                margin: MarginPreset.bottomMd,
                textTransform: TextTransform.uppercase,
                letterSpacing: LetterSpacing.wide,
              ),
              children: const <Widget>[Text('Live Demo')],
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
                    Text(
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
              children: const <Widget>[Text('Preview + Code')],
            ),
            dom.div(classes: 'arcane-demo-preview-scope', [preview]),
            ArcaneBox(
              style: const ArcaneStyleData(
                margin: MarginPreset.topLg,
                fontSize: FontSize.sm,
                fontWeight: FontWeight.w600,
                textColor: TextColor.mutedForeground,
                raw: <String, String>{'margin-bottom': '12px'},
              ),
              children: const <Widget>[Text('Code')],
            ),
            dom.pre(
              classes: 'arcane-demo-code',
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
      ]),
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

const String _previewScopeCss = '''
.arcane-demo-preview-scope {
  position: relative;
  overflow: hidden;
  isolation: isolate;
  min-height: 180px;
  border-radius: var(--neon-radius-panel, var(--radius));
  clip-path: var(--neon-panel-clip, none);
  border: 1px solid var(--neon-panel-border, var(--border));
  background:
    radial-gradient(circle at 12% 0%, color-mix(in srgb, var(--neon-cyan, var(--primary)) 12%, transparent), transparent 16rem),
    radial-gradient(circle at 88% 100%, color-mix(in srgb, var(--neon-magenta, var(--primary)) 9%, transparent), transparent 14rem),
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan, var(--primary)) 6%, transparent) 1px, transparent 1px),
    linear-gradient(color-mix(in srgb, var(--neon-cyan, var(--primary)) 5%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 70%, transparent);
  background-size: auto, auto, 28px 28px, 28px 28px, auto;
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.12),
    0 18px 42px rgba(0,0,0,0.28),
    0 0 30px color-mix(in srgb, var(--primary) 10%, transparent);
}

.arcane-demo-preview-scope::before {
  content: '';
  position: absolute;
  inset: 0;
  pointer-events: none;
  background:
    linear-gradient(90deg, var(--neon-accent, var(--primary)), transparent 26%) top left / 42% 1px no-repeat,
    linear-gradient(180deg, var(--neon-accent, var(--primary)), transparent 42%) top left / 1px 46% no-repeat,
    linear-gradient(270deg, var(--neon-cyan, var(--primary)), transparent 28%) bottom right / 46% 1px no-repeat,
    linear-gradient(0deg, var(--neon-cyan, var(--primary)), transparent 42%) bottom right / 1px 46% no-repeat;
  opacity: 0.72;
  z-index: 1;
}

.arcane-demo-preview-scope::after {
  content: '';
  position: absolute;
  inset: 0;
  pointer-events: none;
  background: repeating-linear-gradient(0deg, transparent 0 6px, color-mix(in srgb, var(--neon-cyan, var(--primary)) 8%, transparent) 6px 7px);
  opacity: 0.2;
  z-index: 1;
}

.arcane-demo-preview-scope > .arcane-box {
  position: relative;
  z-index: 2;
  width: 100%;
  min-height: inherit !important;
  border: 0 !important;
  border-radius: 0 !important;
  background: transparent !important;
  box-shadow: none !important;
}

.arcane-demo-preview-scope .arcane-dialog-overlay,
.arcane-demo-preview-scope .neon-dialog-overlay,
.arcane-demo-preview-scope .arcane-command-overlay,
.arcane-demo-preview-scope .neon-command-overlay,
.arcane-demo-preview-scope .arcane-sheet,
.arcane-demo-preview-scope .neon-sheet-overlay,
.arcane-demo-preview-scope .arcane-drawer-container,
.arcane-demo-preview-scope .neon-drawer-overlay,
.arcane-demo-preview-scope .arcane-dropdown-backdrop,
.arcane-demo-preview-scope .neon-dropdown-backdrop {
  position: absolute !important;
  inset: 0 !important;
  z-index: 25 !important;
  border-radius: inherit;
  overflow: hidden;
}

.arcane-demo-preview-scope .arcane-dialog-overlay,
.arcane-demo-preview-scope .neon-dialog-overlay {
  padding: 1rem !important;
}

.arcane-demo-preview-scope .arcane-command-overlay,
.arcane-demo-preview-scope .neon-command-overlay {
  padding: 1rem !important;
  padding-top: 1rem !important;
}

.arcane-demo-preview-scope .arcane-sheet-panel,
.arcane-demo-preview-scope .neon-sheet,
.arcane-demo-preview-scope .arcane-drawer,
.arcane-demo-preview-scope .neon-drawer {
  position: absolute !important;
  max-width: 100% !important;
  max-height: 100% !important;
}

.arcane-demo-preview-scope .arcane-command-dialog,
.arcane-demo-preview-scope .neon-command-dialog {
  max-width: min(640px, calc(100% - 2rem)) !important;
  max-height: calc(100% - 2rem) !important;
}

.arcane-demo-preview-scope .arcane-context-menu,
.arcane-demo-preview-scope .neon-context-menu {
  position: absolute !important;
}

.arcane-demo-code {
  position: relative;
  clip-path: var(--neon-panel-clip, none);
  border-color: var(--neon-panel-border, var(--border)) !important;
  background:
    linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan, var(--primary)) 7%, transparent) 1px, transparent 1px),
    color-mix(in srgb, var(--card) 78%, transparent) !important;
  background-size: 24px 24px, auto !important;
  box-shadow:
    inset 0 1px 0 rgba(255,255,255,0.1),
    0 14px 34px color-mix(in srgb, var(--primary) 10%, transparent);
}

.arcane-demo-code code {
  color: var(--foreground);
  font-size: 0.8125rem;
  line-height: 1.65;
}
''';
