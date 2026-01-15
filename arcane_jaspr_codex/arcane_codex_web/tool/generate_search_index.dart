#!/usr/bin/env dart
/// Generates a search index from markdown content files.
///
/// Scans all .md files in content/, extracts frontmatter and content,
/// and outputs a JSON search index for client-side search.
///
/// Usage:
///   dart tool/generate_search_index.dart [--base-url=/path]
///
/// Output: web/assets/search-index.json
library;

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final String baseUrl = _getArg(args, 'base-url') ?? '';

  print('Generating search index...\n');

  final Directory contentDir = Directory('content');
  if (!contentDir.existsSync()) {
    print('Error: content/ directory not found');
    exit(1);
  }

  final List<Map<String, dynamic>> searchItems = [];

  await _scanDirectory(contentDir, searchItems, baseUrl);

  // Sort by title for consistent output
  searchItems.sort((a, b) =>
      (a['title'] as String).toLowerCase().compareTo((b['title'] as String).toLowerCase()));

  // Ensure output directory exists
  final Directory assetsDir = Directory('web/assets');
  if (!assetsDir.existsSync()) {
    assetsDir.createSync(recursive: true);
  }

  // Write search index
  final File outputFile = File('web/assets/search-index.json');
  final String jsonOutput = const JsonEncoder.withIndent('  ').convert({
    'generated': DateTime.now().toUtc().toIso8601String(),
    'itemCount': searchItems.length,
    'items': searchItems,
  });

  outputFile.writeAsStringSync(jsonOutput);

  print('Generated search index with ${searchItems.length} items');
  print('Output: web/assets/search-index.json');
}

String? _getArg(List<String> args, String name) {
  for (final arg in args) {
    if (arg.startsWith('--$name=')) {
      return arg.substring('--$name='.length);
    }
  }
  return null;
}

Future<void> _scanDirectory(
  Directory dir,
  List<Map<String, dynamic>> items,
  String baseUrl,
) async {
  final List<FileSystemEntity> entities = dir.listSync();

  for (final entity in entities) {
    if (entity is Directory) {
      // Skip hidden directories
      if (entity.path.split('/').last.startsWith('.')) continue;
      await _scanDirectory(entity, items, baseUrl);
    } else if (entity is File && entity.path.endsWith('.md')) {
      final Map<String, dynamic>? item = await _parseMarkdownFile(entity, baseUrl);
      if (item != null) {
        items.add(item);
      }
    }
  }
}

Future<Map<String, dynamic>?> _parseMarkdownFile(File file, String baseUrl) async {
  final String content = file.readAsStringSync();

  // Parse frontmatter (YAML between --- markers)
  if (!content.startsWith('---')) {
    return null;
  }

  final int endMarker = content.indexOf('---', 3);
  if (endMarker == -1) {
    return null;
  }

  final String frontmatter = content.substring(3, endMarker).trim();
  final String body = content.substring(endMarker + 3).trim();

  // Parse YAML frontmatter (simple key: value parsing)
  final Map<String, String> meta = {};
  for (final line in frontmatter.split('\n')) {
    final int colonIndex = line.indexOf(':');
    if (colonIndex != -1) {
      final String key = line.substring(0, colonIndex).trim();
      final String value = line.substring(colonIndex + 1).trim();
      // Only capture simple string values (not nested YAML)
      if (!value.startsWith('-') && !value.contains('\n')) {
        meta[key] = value;
      }
    }
  }

  final String? title = meta['title'];
  if (title == null || title.isEmpty) {
    return null;
  }

  // Generate URL from file path
  // content/docs/installation.md -> /docs/installation
  // content/docs/auth/overview.md -> /docs/auth/overview
  String url = file.path
      .replaceFirst('content', '')
      .replaceFirst('.md', '');

  // Handle index.md -> parent path
  if (url.endsWith('/index')) {
    url = url.replaceFirst('/index', '');
  }

  // Ensure leading slash
  if (!url.startsWith('/')) {
    url = '/$url';
  }

  // Add base URL if provided
  if (baseUrl.isNotEmpty) {
    url = '$baseUrl$url';
  }

  // Extract searchable text from body (strip markdown syntax)
  final String searchableText = _stripMarkdown(body);

  // Extract keywords from heading, first paragraph, code blocks
  final List<String> keywords = _extractKeywords(body, title);

  return {
    'title': title,
    'description': meta['description'] ?? '',
    'url': url,
    'section': _extractSection(file.path),
    'keywords': keywords,
    'content': searchableText.length > 500
        ? searchableText.substring(0, 500)
        : searchableText,
  };
}

String _extractSection(String filePath) {
  // content/docs/auth/overview.md -> auth
  // content/docs/installation.md -> docs
  // content/guides/theming.md -> guides
  final List<String> parts = filePath.split('/');

  if (parts.length >= 3) {
    // Skip 'content' and get the first meaningful directory
    if (parts[1] == 'docs' && parts.length >= 4) {
      return parts[2]; // Return subdirectory like 'auth', 'layout', etc.
    }
    return parts[1]; // Return 'docs' or 'guides'
  }

  return '';
}

String _stripMarkdown(String markdown) {
  String text = markdown;

  // Remove code blocks
  text = text.replaceAll(RegExp(r'```[\s\S]*?```'), ' ');
  text = text.replaceAll(RegExp(r'`[^`]+`'), ' ');

  // Remove headers
  text = text.replaceAll(RegExp(r'^#{1,6}\s+', multiLine: true), '');

  // Remove links but keep text
  text = text.replaceAll(RegExp(r'\[([^\]]+)\]\([^)]+\)'), r'$1');

  // Remove images
  text = text.replaceAll(RegExp(r'!\[[^\]]*\]\([^)]+\)'), '');

  // Remove bold/italic
  text = text.replaceAll(RegExp(r'\*\*([^*]+)\*\*'), r'$1');
  text = text.replaceAll(RegExp(r'\*([^*]+)\*'), r'$1');
  text = text.replaceAll(RegExp(r'__([^_]+)__'), r'$1');
  text = text.replaceAll(RegExp(r'_([^_]+)_'), r'$1');

  // Remove HTML tags
  text = text.replaceAll(RegExp(r'<[^>]+>'), '');

  // Collapse whitespace
  text = text.replaceAll(RegExp(r'\s+'), ' ');

  return text.trim();
}

List<String> _extractKeywords(String body, String title) {
  final Set<String> keywords = {};

  // Add title words
  keywords.addAll(
    title.toLowerCase().split(RegExp(r'\s+')).where((w) => w.length > 2),
  );

  // Extract headings
  final RegExp headingPattern = RegExp(r'^#{1,6}\s+(.+)$', multiLine: true);
  for (final match in headingPattern.allMatches(body)) {
    keywords.addAll(
      match.group(1)!.toLowerCase().split(RegExp(r'\s+')).where((w) => w.length > 2),
    );
  }

  // Extract component names (PascalCase words)
  final RegExp pascalPattern = RegExp(r'\b([A-Z][a-z]+(?:[A-Z][a-z]+)+)\b');
  for (final match in pascalPattern.allMatches(body)) {
    keywords.add(match.group(1)!.toLowerCase());
  }

  // Extract code identifiers from inline code
  final RegExp codePattern = RegExp(r'`([^`]+)`');
  for (final match in codePattern.allMatches(body)) {
    final String code = match.group(1)!;
    if (code.length > 2 && code.length < 30 && !code.contains(' ')) {
      keywords.add(code.toLowerCase());
    }
  }

  return keywords.toList()..sort();
}
