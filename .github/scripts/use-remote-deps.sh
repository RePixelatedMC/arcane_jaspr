#!/usr/bin/env bash
set -euo pipefail

workspace_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
target_pubspec_overrides="${workspace_root}/arcane_jaspr_codex/arcane_codex_web/pubspec_overrides.yaml"

cat > "${target_pubspec_overrides}" <<'YAML'
dependency_overrides:
  arcane_jaspr:
    git:
      url: https://github.com/ArcaneArts/arcane_jaspr.git
  arcane_inkwell:
    git:
      url: https://github.com/ArcaneArts/arcane_inkwell.git
YAML
