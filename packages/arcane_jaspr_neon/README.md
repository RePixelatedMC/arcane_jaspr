# Arcane Jaspr Neon

Neon renderer package for Arcane Jaspr.

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';

ArcaneApp(
  stylesheet: const NeonStylesheet(theme: NeonTheme.green),
  home: MyApp(),
)
```

Use `package:arcane_jaspr` for core widgets and this package only for the concrete stylesheet.
