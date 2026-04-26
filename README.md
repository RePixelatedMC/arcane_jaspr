# Arcane Jaspr

Arcane Jaspr gives Jaspr apps a Flutter-first UI surface.
Use familiar Dart widget structure, keep semantic HTML output, and only drop to HTML or raw Jaspr when you explicitly choose to.

## Install

```yaml
dependencies:
  arcane_jaspr: ^3.1.0
  arcane_jaspr_neon: ^3.1.0
  arcane_jaspr_shadcn: ^3.1.0
```

## Demo

From the `arcane_jaspr` package root, serve the demo/docs app with:

```bash
dart run arcane_jaspr:serve
```

It serves at `http://localhost:8080` and replaces any previous Arcane Jaspr demo process using that port.

Build the same demo with:

```bash
dart run arcane_jaspr:serve build
```

## Import Surfaces

Use the primary import for normal app code:

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';

const ArcaneStylesheet shadcnStylesheet = ShadcnStylesheet(
  theme: ShadcnTheme.midnight,
);
const ArcaneStylesheet neonStylesheet = NeonStylesheet(
  theme: NeonTheme.green,
);
const ArcaneStylesheet selectedStylesheet = shadcnStylesheet;
```

Only reach for the advanced layers when you need them:

```dart
import 'package:arcane_jaspr/html.dart';
import 'package:arcane_jaspr/web.dart';
```

## Counter Example

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';

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
      stylesheet: selectedStylesheet,
      brightness: Brightness.dark,
      home: ArcaneScaffold(
        title: 'Counter',
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            gap: 16,
            children: [
              Text.heading2('Count: $_count'),
              Button.primary(
                label: 'Increment',
                onPressed: _increment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Common Examples

```dart
TextInput(
  label: 'Email',
  placeholder: 'you@example.com',
  type: TextInputType.email,
)

ArcaneCombobox(
  value: 'jaspr',
  options: const [
    ComboboxOption(value: 'jaspr', label: 'Jaspr'),
    ComboboxOption(value: 'flutter', label: 'Flutter'),
  ],
  onChanged: (String? value) {},
)

ArcaneMenubar(
  menus: const [
    ArcaneMenubarMenu(
      label: 'File',
      items: [MenuItemAction(label: 'New')],
    ),
  ],
)
```

## What The Primary Surface Includes

- `Widget`, `StatelessWidget`, `StatefulWidget`, `State`, `BuildContext`, and `runApp`
- `ArcaneApp`, neutral renderer contracts, adaptive layout contracts, and theme provider access
- Arcane widgets for layout, input, menus, dialogs, data display, adaptive scaffolds, and theming
- Type-safe styling through `ArcaneStyleData`

## Advanced Imports

`package:arcane_jaspr/html.dart` contains the low-level HTML wrapper layer such as `ArcaneDiv`, `ArcaneLabel`, `ArcaneLink`, tables, lists, and SVG helpers.
`package:arcane_jaspr/web.dart` exposes raw Jaspr and DOM escape hatches.

## Docs

- Package docs: [arcanearts.github.io/arcane_jaspr](https://arcanearts.github.io/arcane_jaspr/)
- Neon workspace: `arcane_jaspr_neon/arcane_neon_web`
- Generated component catalog: `arcane_jaspr_neon/arcane_neon_web/content/docs/components-catalog.md`

## License

GNU Public
