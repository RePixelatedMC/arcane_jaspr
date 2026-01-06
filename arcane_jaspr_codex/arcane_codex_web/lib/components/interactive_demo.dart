import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/stylesheets/shadcn/shadcn_stylesheet.dart';
import 'package:jaspr/jaspr.dart' show client;

import '../demos/demo_registry.dart';

// Renderer stylesheet for client-side hydration
const ArcaneStylesheet _clientStylesheet = ShadcnStylesheet();

/// Client-hydrated wrapper for interactive demos
/// Only primitive parameters are allowed for @client components
@client
class InteractiveDemo extends StatefulComponent {
  final String componentType;

  const InteractiveDemo({
    required this.componentType,
    super.key,
  });

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  bool _isDark = true;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Component build(BuildContext context) {
    final demoRegistry = DemoRegistry(
      isDark: _isDark,
      onThemeToggle: _toggleTheme,
    );

    // Wrap with ArcaneThemeProvider for client-side hydration
    // (the parent provider is lost during hydration)
    return ArcaneThemeProvider(
      stylesheet: _clientStylesheet,
      brightness: _isDark ? Brightness.dark : Brightness.light,
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          margin: MarginPreset.bottomXl,
          padding: PaddingPreset.lg,
          borderRadius: Radius.lg,
          background: Background.transparent,
          border: BorderPreset.subtle,
        ),
        children: [
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              fontWeight: FontWeight.w600,
              textColor: TextColor.mutedForeground,
              margin: MarginPreset.bottomMd,
              textTransform: TextTransform.uppercase,
              letterSpacing: LetterSpacing.wide,
            ),
            children: [ArcaneText('Live Demo')],
          ),
          ArcaneDiv(
            styles: const ArcaneStyleData(
              display: Display.flex,
              flexWrap: FlexWrap.wrap,
              alignItems: AlignItems.center,
              gap: Gap.md,
              overflow: Overflow.auto,
              maxWidthCustom: '100%',
            ),
            children: demoRegistry.getDemo(component.componentType),
          ),
        ],
      ),
    );
  }
}
