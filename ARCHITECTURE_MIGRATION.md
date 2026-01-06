# Arcane Jaspr - Renderer Architecture

## Status: COMPLETE

The renderer-based architecture migration is complete. All visual components delegate to `context.renderers.xxx()` for stylesheet-specific rendering.

### Statistics

| Metric | Count |
|--------|-------|
| Renderer methods in interface | **204** |
| Component files using renderers | **123** |
| Stylesheets available | 2 (ShadCN, Codex) |

---

## Architecture Overview

### How It Works

```
ArcaneButton(label: "Click")
    ↓
context.renderers.button(ButtonProps(...))
    ↓
ShadcnRenderers.button() or CodexRenderers.button()
    ↓
Stylesheet-specific HTML/CSS output
```

**One line changes your entire app's design:**
```dart
ArcaneApp(
  styleSheet: ShadcnStyleSheet(),  // or CodexStyleSheet()
  child: MyApp(),
)
```

### Key Files

| File | Purpose |
|------|---------|
| `lib/core/renderers.dart` | Abstract interface (204 methods) |
| `lib/core/props/*.dart` | Shared property classes |
| `lib/core/theme_provider.dart` | `context.renderers` extension |
| `lib/stylesheets/shadcn/renderers/` | ShadCN implementations |
| `lib/util/appearance/stylesheets/` | Color/token definitions |

---

## Adding New Components

### 1. Create Props Class

`lib/core/props/{component}_props.dart`:

```dart
enum ComponentVariant { standard, primary }

class ComponentProps {
  final String label;
  final ComponentVariant variant;
  final void Function()? onPressed;

  const ComponentProps({
    required this.label,
    this.variant = ComponentVariant.standard,
    this.onPressed,
  });
}
```

### 2. Add to Interface

`lib/core/renderers.dart`:

```dart
// Add import and export
import 'props/component_props.dart';
export 'props/component_props.dart';

// Add method
abstract class ComponentRenderers {
  Component component(ComponentProps props);
}
```

### 3. Create Renderer

`lib/stylesheets/shadcn/renderers/component.dart`:

```dart
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;
import '../../../core/props/component_props.dart';

Component renderComponent(ComponentProps props) {
  return dom.div(
    styles: dom.Styles(raw: {
      'background': 'var(--arcane-primary)',
      'border-radius': 'var(--arcane-radius)',
    }),
    [dom.text(props.label)],
  );
}
```

### 4. Register Implementation

`lib/stylesheets/shadcn/renderers/shadcn_renderers.dart`:

```dart
import 'component.dart';

@override
Component component(ComponentProps props) => renderComponent(props);
```

### 5. Create Wrapper

`lib/component/{category}/component.dart`:

```dart
import '../../core/theme_provider.dart';

class ArcaneComponent extends StatelessComponent {
  final String label;

  const ArcaneComponent({required this.label});

  @override
  Component build(BuildContext context) {
    return context.renderers.component(ComponentProps(label: label));
  }
}
```

---

## Components NOT Using Renderers (By Design)

These components don't need renderers because they're structural/primitive:

| Category | Components | Reason |
|----------|------------|--------|
| HTML Primitives | div, span, text, heading, paragraph, lists, table, section, nav, header, footer, code_block, quote, svg | Direct HTML wrappers |
| Data Files | usa_map_data, world_map_data, *_paths | Raw SVG data |
| Infrastructure | app, provider, toast_manager | Plumbing, not visual |
| Icon | icon.dart | Direct SVG rendering |

---

## CSS Variables

All renderers use CSS variables for theming:

### Core Colors
```css
--arcane-background, --arcane-foreground
--arcane-primary, --arcane-primary-foreground
--arcane-secondary, --arcane-secondary-foreground
--arcane-muted, --arcane-muted-foreground
--arcane-accent, --arcane-accent-foreground
--arcane-destructive, --arcane-destructive-foreground
--arcane-border, --arcane-input, --arcane-ring
```

### Semantic Colors
```css
--arcane-success, --arcane-warning, --arcane-info
```

### Structure Tokens
```css
--arcane-radius, --arcane-radius-sm/md/lg/xl
--arcane-shadow-xs/sm/md/lg/xl
--arcane-transition-fast, --arcane-transition, --arcane-transition-slow
```

---

## Verification

```bash
# Count renderer methods
grep "Component " lib/core/renderers.dart | wc -l

# Find components using renderers
find lib/component -name "*.dart" | xargs grep -l "context\.renderers\." | wc -l

# Run analyzer
dart analyze lib/
```
