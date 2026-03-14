# ArcaneCodex

Documentation workspace for `arcane_jaspr`.

## What Lives Here

- `arcane_codex_web/`: the static docs site
- `arcane_codex_web/content/docs/components-catalog.md`: generated current-state catalog
- `arcane_codex_web/lib/components/demo_registry.dart`: live demo snippets and preview registry

## Development

```bash
cd arcane_codex_web
dart pub get
dart run tool/generate_component_catalog.dart
jaspr serve
```

## Build

```bash
cd arcane_codex_web
dart run tool/build.dart --domain=https://arcanearts.github.io/arcane_jaspr --base-url=/arcane_jaspr
```

The build script regenerates the component catalog before the search index and static build.
