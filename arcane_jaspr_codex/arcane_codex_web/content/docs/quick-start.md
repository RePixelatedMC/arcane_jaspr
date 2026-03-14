---
title: Quick Start
description: Build the canonical counter app with the Flutter-first Arcane Jaspr surface
layout: kb
previous:
  url: /docs/installation
  title: Installation
---

# Quick Start

This is the baseline Arcane Jaspr example. If you can write this app, you are on the intended primary surface.

## Counter App

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _count = 0;

  void _increment() {
    setState(() => _count += 1);
  }

  @override
  Widget build(BuildContext context) {
    return ArcaneApp(
      stylesheet: const ShadcnStylesheet(theme: ShadcnTheme.midnight),
      brightness: Brightness.dark,
      child: ArcaneBox(
        style: const ArcaneStyleData(
          minHeight: '100vh',
          display: Display.flex,
          flexDirection: FlexDirection.column,
          alignItems: AlignItems.center,
          justifyContent: JustifyContent.center,
          gap: Gap.lg,
        ),
        children: [
          Text.heading2('Count: $_count'),
          Button.primary(
            label: 'Increment',
            onPressed: _increment,
          ),
        ],
      ),
    );
  }
}
```

## What This Confirms

- You imported only `package:arcane_jaspr/arcane_jaspr.dart`
- You used `StatefulWidget`, `State`, `Widget build`, and `runApp`
- You did not need explicit type arguments in normal widget usage
- You did not need HTML wrappers or raw Jaspr types

## Next Steps

- Browse [Component Catalog](/docs/components-catalog)
- Read [Styling Concepts](/docs/concepts/styling)
- Read [Theme Concepts](/docs/concepts/theming)
