---
title: Arcane Jaspr
description: Flutter-first docs for Arcane Jaspr
layout: kb
---

# Arcane Jaspr Neon

Arcane Jaspr is the Flutter-first surface for Jaspr.
The primary path is `package:arcane_jaspr/arcane_jaspr.dart`, with HTML wrappers and raw Jaspr moved behind secondary imports.

## Start Here

- [Installation](/docs/installation)
- [Quick Start](/docs/quick-start)
- [Component Catalog](/docs/components-catalog)
- [Styling Concepts](/docs/concepts/styling)
- [Theme Concepts](/docs/concepts/theming)

## What Changed

- The primary import now exposes `Widget`, `StatelessWidget`, `StatefulWidget`, `State`, `BuildContext`, and `runApp`
- HTML-first wrappers such as `ArcaneDiv`, `ArcaneLabel`, and `ArcaneLink` now live on `package:arcane_jaspr/html.dart`
- Raw Jaspr escape hatches now live on `package:arcane_jaspr/web.dart`
- The component catalog is generated from the current export surface instead of hand-maintained counts

## Canonical Reference

Use the [Component Catalog](/docs/components-catalog) as the current source of truth for live demos, support modules, and advanced HTML wrappers.
