---
title: Theming
description: Learn how to configure stylesheets and theming in Arcane Jaspr
layout: kb
component: theming
---

# Theming

Arcane Jaspr uses a stylesheet-based theming system built on CSS custom properties. Stylesheets provide complete design systems including colors, typography, spacing, and component renderers.

## ArcaneApp

Every Arcane application must be wrapped in an `ArcaneApp` component which provides the theme context and injects the stylesheet CSS.

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

ArcaneApp(
  stylesheet: ShadcnStylesheet(),
  brightness: Brightness.dark,
  child: YourApp(),
)
```

## Available Stylesheets

Arcane Jaspr includes two stylesheets:

| Stylesheet | Description |
|------------|-------------|
| `ShadcnStylesheet` | Minimal, modern, accessible. Based on shadcn/ui |
| `CodexStylesheet` | Gaming aesthetic with glass effects (WIP) |

```dart
// ShadCN (default) - clean, minimal design
ArcaneApp(
  stylesheet: ShadcnStylesheet(),
  child: MyApp(),
)

// Codex - gaming/premium aesthetic
ArcaneApp(
  stylesheet: CodexStylesheet(),
  child: MyApp(),
)
```

## Brightness Mode

Control light/dark mode with the `brightness` parameter:

```dart
ArcaneApp(
  stylesheet: ShadcnStylesheet(),
  brightness: Brightness.dark,  // or Brightness.light
  child: MyApp(),
)
```

| Value | Description |
|-------|-------------|
| `Brightness.dark` | Dark mode (default) |
| `Brightness.light` | Light mode |

## CSS Variables

Stylesheets define CSS custom properties that all components use. These are automatically injected into the document.

### Core Colors

```css
--background          /* Page background */
--foreground          /* Default text color */
--card                /* Card background */
--card-foreground     /* Text on cards */
--popover             /* Popover background */
--popover-foreground  /* Text in popovers */
--primary             /* Primary brand color */
--primary-foreground  /* Text on primary */
--secondary           /* Secondary color */
--secondary-foreground
--muted               /* Muted backgrounds */
--muted-foreground    /* Muted text */
--accent              /* Accent color */
--accent-foreground
--destructive         /* Error/danger color */
--destructive-foreground
--border              /* Border color */
--input               /* Input border color */
--ring                /* Focus ring color */
```

### Status Colors

```css
--success             /* Success state */
--success-foreground
--warning             /* Warning state */
--warning-foreground
--info                /* Info state */
--info-foreground
```

### Structure Tokens

```css
--radius              /* Base border radius (e.g., 0.5rem) */
--font-sans           /* Sans-serif font stack */
--font-mono           /* Monospace font stack */
```

### Arcane Aliases

For compatibility, stylesheets also define `--arcane-*` prefixed aliases:

```css
--arcane-background
--arcane-foreground
--arcane-primary
--arcane-primary-foreground
--arcane-secondary
--arcane-accent
--arcane-muted
--arcane-border
--arcane-radius
--arcane-radius-sm
--arcane-radius-md
--arcane-radius-lg
/* ... and more */
```

## Using CSS Variables in Styles

Reference these variables in your `ArcaneStyleData`:

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    raw: {
      'background': 'var(--card)',
      'border': '1px solid var(--border)',
      'color': 'var(--card-foreground)',
      'border-radius': 'var(--radius)',
    },
  ),
  children: [...],
)
```

Or use the type-safe presets which map to these variables:

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    background: Background.card,
    textColor: TextColor.cardForeground,
    border: BorderPreset.standard,
    borderRadius: Radius.md,
  ),
  children: [...],
)
```

## Component Renderers

Each stylesheet provides its own implementation of all components via the renderer system. Access renderers through context:

```dart
@override
Component build(BuildContext context) {
  // Components automatically use the current stylesheet's renderers
  return ArcaneButton(
    label: 'Click me',
    onPressed: () {},
  );

  // Under the hood, this calls:
  // context.renderers.button(ButtonProps(...))
}
```

## Creating Custom Stylesheets

To create a custom stylesheet, extend `ArcaneStylesheet`:

```dart
class MyStylesheet extends ArcaneStylesheet {
  const MyStylesheet();

  @override
  String get id => 'my-style';

  @override
  String get name => 'My Style';

  @override
  ComponentRenderers get renderers => const MyRenderers();

  @override
  String get baseCss => '''
    :root {
      --background: #ffffff;
      --foreground: #000000;
      --primary: #3b82f6;
      --primary-foreground: #ffffff;
      /* ... define all required variables */
    }

    .dark {
      --background: #0a0a0a;
      --foreground: #fafafa;
      /* ... dark mode overrides */
    }
  ''';

  @override
  List<String> get externalCssUrls => const [
    'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap',
  ];
}
```

Your custom `MyRenderers` class must implement all methods in `ComponentRenderers`.

## Theme Toggle

Use `ArcaneThemeToggle` to let users switch between light and dark modes:

```dart
ArcaneThemeToggle(
  isDark: true,
  onChanged: (isDark) {
    // Handle theme change
  },
)
```

## Static Site Support

When building static sites with `jaspr build`, include fallback scripts for interactivity:

```dart
ArcaneApp(
  stylesheet: ShadcnStylesheet(),
  includeFallbackScripts: true,  // Default: true
  child: MyApp(),
)
```

This injects JavaScript that provides interactivity when Jaspr client hydration is unavailable.
