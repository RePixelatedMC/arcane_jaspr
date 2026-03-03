# ArcaneCodex Web

Static documentation site for `arcane_jaspr`.

## Current Catalog Snapshot (March 3, 2026)

- **Shadcn-aligned functional components:** `59`
- **Total exported component modules:** `81`
- **Foundation modules outside Shadcn cap:** `27`

Canonical component index:
- `content/docs/components-catalog.md`

## Quick Start

```bash
# Install dependencies
dart pub get

# Development server (http://localhost:8080)
jaspr serve

# Build static site
jaspr build
```

## Content Model

- `content/index.md`: site home
- `content/docs/index.md`: docs landing
- `content/docs/components-catalog.md`: authoritative component surface
- `content/docs/**`: topic/component markdown pages

## Runtime

The site is built with:
- `jaspr`
- `jaspr_content`
- `arcane_inkwell` knowledge-base shell
- local path dependency on `arcane_jaspr`

## Notes

The catalog page is generated from the live package exports and audit manifest, and should be treated as the source of truth when docs pages and implementation diverge.
