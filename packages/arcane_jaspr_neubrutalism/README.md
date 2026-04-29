# Arcane Jaspr Neubrutalism

Neubrutalism renderer package for Arcane Jaspr. Bold pastel surfaces, thick black borders, hard offset shadows, no blur, no gradients. Comic-book aesthetic with modern UI primitives.

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neubrutalism/arcane_jaspr_neubrutalism.dart';

ArcaneApp(
  stylesheet: const NeubrutalismStylesheet(theme: NeubrutalismTheme.yellow),
  home: MyApp(),
)
```

Available themes: `yellow`, `pink`, `mint`, `orange`, `sky`, `lavender`, `lime`, `red`.

Reference: https://www.neobrutalism.dev/

Use `package:arcane_jaspr` for core widgets and this package only for the concrete stylesheet.
