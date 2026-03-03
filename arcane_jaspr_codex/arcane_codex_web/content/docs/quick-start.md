---
title: Quick Start
description: Get up and running in 5 minutes
layout: kb
previous:
  url: /docs/installation
  title: Installation
---

# Quick Start

Get your first documentation page live in under 5 minutes.

> [!WARNING] Java 21 Required
> Arcane Jaspr tooling requires Java 21 or newer for full compatibility.

## Creating Your First Page

<Steps>
  <Step title="Create a markdown file in content/">
    Add a new `.md` file under `content/` with frontmatter and body content.
  </Step>
  <Step title="Define required frontmatter">
    Set `title`, `description`, and `layout: kb` so the page is indexed and themed correctly.
  </Step>
  <Step title="Link it from section navigation">
    Add or update `_section.json5` ordering in the folder so the page appears where you expect.
  </Step>
  <Step title="Run and verify">
    Start the dev server, open the page, and confirm TOC, callouts, cards, and page footer nav.
  </Step>
</Steps>

<Badge color="info">Mintlify-style</Badge>

<AccordionGroup>
  <Accordion title="Can I mix this with normal markdown?" defaultOpen={true}>
    Yes. Accordions, cards, steps, and callout tags all render inside the standard markdown pipeline.
  </Accordion>
</AccordionGroup>

## Rich Markdown Parity

<Columns cols={2}>
  <Column>
    <Panel title="Feature Rollup" icon="panel">
      Use panels for grouped notes and rollout detail blocks.
    </Panel>
  </Column>
  <Column>
    <Banner title="Deployment Checklist" href="/guides/deployment" type="info">
      Open the guide before shipping your first docs build.
    </Banner>
  </Column>
</Columns>

<Tiles cols={3}>
  <Tile title="ArcaneArts GitHub" href="https://github.com/ArcaneArts" icon="github">
    External link tile with top-right indicator.
  </Tile>
  <Tile title="Component Catalog" href="/docs/components-catalog" icon="component">
    Internal link tile with directional indicator.
  </Tile>
  <Tile title="Styles" href="/docs/styles/colors" icon="palette">
    Style and token references.
  </Tile>
</Tiles>

<FieldGroup>
  <ParamField query="page" type="number" required={true}>
    Which result page to return.
  </ParamField>
  <ParamField body="filter" type="object">
    Optional filter criteria object.
  </ParamField>
  <ResponseField name="items" type="array" required={true}>
    The matched records.
  </ResponseField>
</FieldGroup>

<Tree>
  <Tree.Folder name="content" defaultOpen={true}>
    <Tree.File name="index.md" />
    <Tree.File name="docs/quick-start.md" />
  </Tree.Folder>
</Tree>

<Color>
  <Color.Item label="Primary" value="#3b82f6" />
  <Color.Item label="Warning" value="#f59e0b" />
  <Color.Item label="Danger" value="#ef4444" />
</Color>

<Frame label="Preview" caption="Frame and caption wrapper for media or examples.">
  This area accepts normal markdown content.
</Frame>

<Update label="Last updated" date="2026-03-03">
  Mintlify-style parity blocks are enabled by default in Arcane Inkwell.
</Update>

<Expandable title="Need more examples?" defaultOpen={false}>
  You can mix these blocks with normal markdown headings, lists, tables, and code fences.
</Expandable>

## Create a New Page

Add a new markdown file to the `content/` directory:

```markdown
---
title: My New Page
description: A brief description
layout: kb
---

# My New Page

Your content here.
```

## Frontmatter

Each page starts with YAML frontmatter:

| Field | Description |
|-------|-------------|
| `title` | Page title (used in header and navigation) |
| `description` | Brief description for meta tags |
| `layout` | Layout to use (`docs` for documentation) |
| `previous` | Optional link to previous page |
| `next` | Optional link to next page |
| `pageNav` | Optional page-level toggle for footer prev/next links |

## Markdown Features

The documentation supports standard Markdown plus:

### Code Blocks

Use triple backticks with a language identifier:

```dart
void main() {
  print('Hello, Jaspr!');
}
```

### Headings

Headings automatically get anchor links and appear in the table of contents.

### Links

Both internal and external links work:

- [Internal link](/docs)
- [External link](https://jaspr.site)

## Update Navigation

Edit `lib/components/docs_sidebar.dart` to add your page to the navigation:

```dart
SidebarItem(
  label: 'My New Page',
  icon: Icons.file,
  href: '/docs/my-new-page',
  active: currentPath == '/docs/my-new-page',
),
```

## Deploy

Build and deploy to any static hosting:

```bash
jaspr build
# Upload build/jaspr/ to your host
```
