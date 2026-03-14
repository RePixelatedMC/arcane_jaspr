# Arcane Jaspr Codex Web

Static documentation site for `arcane_jaspr`.

## Development

```bash
dart pub get
dart run tool/generate_component_catalog.dart
jaspr serve
```

## Build

```bash
dart run tool/build.dart --domain=https://arcanearts.github.io/arcane_jaspr --base-url=/arcane_jaspr
```

## Primary Documentation Rules

- Teach `package:arcane_jaspr/arcane_jaspr.dart` first
- Keep HTML wrappers on `package:arcane_jaspr/html.dart`
- Keep raw Jaspr escape hatches on `package:arcane_jaspr/web.dart`
- Prefer Flutter-shaped examples with `Widget build(BuildContext context)` and no explicit type arguments in normal usage
