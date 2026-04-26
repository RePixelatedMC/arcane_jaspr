---
title: Import Surfaces
description: There is no alias layer; use the primary import first and advanced imports only by choice
layout: kb
component: aliases
---

# Import Surfaces

Arcane Jaspr does not ship a short-name alias layer.
There is no `aliases.dart`, and the primary documentation path does not assume one.

## Primary Import

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';
```

Use this for normal app code.
It exposes the Flutter-shaped base types and the Arcane widget surface.

## Advanced Imports

```dart
import 'package:arcane_jaspr/html.dart';
import 'package:arcane_jaspr/web.dart';
```

Use `html.dart` only for low-level HTML wrapper components such as `ArcaneDiv`, `ArcaneLabel`, and `ArcaneLink`.
Use `web.dart` only when you intentionally want raw Jaspr and DOM APIs.

## Naming Rule

The default authoring path keeps the explicit `Arcane*` names.
That keeps package examples, generated docs, and Oracular templates aligned on one surface.
