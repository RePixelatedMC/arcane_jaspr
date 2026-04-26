# Arcane Jaspr Shadcn

Shadcn renderer package for Arcane Jaspr.

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';

ArcaneApp(
  stylesheet: const ShadcnStylesheet(theme: ShadcnTheme.midnight),
  home: MyApp(),
)
```

Use `package:arcane_jaspr` for core widgets and this package only for the concrete stylesheet.
