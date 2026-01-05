import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:web/web.dart' as web;

/// A wrapper component that displays a live component demo alongside its code.
///
/// Use this to show users what a component looks like and how to implement it.
class ComponentDemo extends StatelessComponent {
  /// The title of the demo (optional)
  final String? title;

  /// Description of the demo (optional)
  final String? description;

  /// The live component to render
  final Component child;

  /// The code that produces the component
  final String code;

  /// The programming language for syntax highlighting
  final String language;

  /// Background style for the preview area
  final DemoBackground background;

  /// Padding around the preview component
  final PaddingPreset padding;

  const ComponentDemo({
    super.key,
    this.title,
    this.description,
    required this.child,
    required this.code,
    this.language = 'dart',
    this.background = DemoBackground.default_,
    this.padding = PaddingPreset.lg,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomXl,
        borderRadius: Radius.lg,
        overflow: Overflow.hidden,
        border: BorderPreset.standard,
      ),
      children: [
        // Title and description (if provided)
        if (title != null || description != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              padding: PaddingPreset.md,
              background: Background.backgroundSecondary,
              borderBottom: BorderPreset.standard,
            ),
            children: [
              if (title != null)
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.base,
                    textColor: TextColor.primary,
                    margin: MarginPreset.bottomXs,
                  ),
                  children: [ArcaneText(title!)],
                ),
              if (description != null)
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.sm,
                    textColor: TextColor.muted,
                  ),
                  children: [ArcaneText(description!)],
                ),
            ],
          ),

        // Preview area
        ArcaneDiv(
          styles: ArcaneStyleData(
            padding: padding,
            display: Display.flex,
            alignItems: AlignItems.center,
            justifyContent: JustifyContent.center,
            minHeight: '120px',
            raw: {
              'background': background.css,
            },
          ),
          children: [child],
        ),

        // Code block
        ArcaneDiv(
          styles: const ArcaneStyleData(
            borderTop: BorderPreset.standard,
          ),
          children: [
            _DemoCodeBlock(code: code, language: language),
          ],
        ),
      ],
    );
  }
}

/// Internal code block without margins for use in ComponentDemo
class _DemoCodeBlock extends StatefulComponent {
  final String code;
  final String language;

  const _DemoCodeBlock({
    required this.code,
    required this.language,
  });

  @override
  State<_DemoCodeBlock> createState() => _DemoCodeBlockState();
}

class _DemoCodeBlockState extends State<_DemoCodeBlock> {
  bool _expanded = false;
  bool _copied = false;

  void _toggleExpanded() {
    setState(() => _expanded = !_expanded);
  }

  void _copyToClipboard() {
    web.window.navigator.clipboard.writeText(component.code);
    setState(() => _copied = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final lines = component.code.split('\n');
    final isLong = lines.length > 10;
    final displayCode = _expanded || !isLong ? component.code : '${lines.take(10).join('\n')}\n...';

    return ArcaneDiv(
      styles: const ArcaneStyleData(
        background: Background.code,
        position: Position.relative,
      ),
      children: [
        // Actions overlay - top right
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.absolute,
            top: '8px',
            right: '8px',
            zIndex: ZIndex.dropdown,
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.xs,
          ),
          children: [
            // Language badge
            ArcaneSpan(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                textColor: TextColor.muted,
                padding: PaddingPreset.badge,
                background: Background.glassTint,
                borderRadius: Radius.xs,
              ),
              child: ArcaneText(component.language),
            ),
            if (isLong)
              ArcaneTooltip(
                content: _expanded ? 'Show less' : 'Show more',
                position: TooltipPosition.bottom,
                child: ArcaneIconButton.ghost(
                  icon: _expanded ? ArcaneIcon.minimize2(size: IconSize.sm) : ArcaneIcon.maximize2(size: IconSize.sm),
                  size: IconButtonSize.small,
                  onPressed: _toggleExpanded,
                ),
              ),
            ArcaneTooltip(
              content: _copied ? 'Copied!' : 'Copy code',
              position: TooltipPosition.bottom,
              child: ArcaneIconButton.ghost(
                icon: _copied ? ArcaneIcon.check(size: IconSize.sm) : ArcaneIcon.copy(size: IconSize.sm),
                size: IconButtonSize.small,
                onPressed: _copyToClipboard,
              ),
            ),
          ],
        ),

        // Code content with syntax highlighting
        ArcaneDiv(
          styles: ArcaneStyleData(
            overflow: Overflow.auto,
            maxHeight: _expanded ? 'none' : '300px',
            raw: const {'padding-top': '40px'}, // Space for overlay buttons
          ),
          children: [
            Component.element(
              tag: 'pre',
              styles: const Styles(raw: {
                'margin': '0',
                'padding': '16px',
                'background': 'transparent',
                'overflow': 'auto',
              }),
              children: [
                Component.element(
                  tag: 'code',
                  classes: 'language-${component.language}',
                  styles: const Styles(raw: {
                    'font-family': 'var(--font-mono)',
                    'font-size': '13px',
                    'line-height': '1.6',
                  }),
                  children: [Component.text(displayCode)],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Background styles for the demo preview area
enum DemoBackground {
  default_('var(--arcane-background-secondary)'),
  dark('var(--arcane-background)'),
  light('var(--arcane-surface)'),
  transparent('transparent'),
  checkered('repeating-conic-gradient(var(--arcane-surface-variant) 0% 25%, var(--arcane-surface) 0% 50%) 50% / 20px 20px');

  final String css;
  const DemoBackground(this.css);
}

/// A simple demo component for showing multiple variants in a row
class ComponentDemoRow extends StatelessComponent {
  final String? title;
  final List<Component> children;
  final Gap gap;

  const ComponentDemoRow({
    super.key,
    this.title,
    required this.children,
    this.gap = Gap.md,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomLg,
      ),
      children: [
        if (title != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
              margin: MarginPreset.bottomSm,
            ),
            children: [ArcaneText(title!)],
          ),
        ArcaneDiv(
          styles: ArcaneStyleData(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            alignItems: AlignItems.center,
            gap: gap,
            padding: PaddingPreset.lg,
            borderRadius: Radius.lg,
            background: Background.backgroundSecondary,
            border: BorderPreset.standard,
          ),
          children: children,
        ),
      ],
    );
  }
}
