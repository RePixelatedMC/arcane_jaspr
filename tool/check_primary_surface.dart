#!/usr/bin/env dart

library;

import 'dart:io';

void main(List<String> args) {
  final Directory packageRootDirectory = Directory.current;
  final File pubspecFile = File('${packageRootDirectory.path}/pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    stderr.writeln('Run this script from the arcane_jaspr package root.');
    exit(1);
  }

  final List<File> filesToScan = <File>[
    File('${packageRootDirectory.path}/README.md'),
    File('${packageRootDirectory.path}/arcane_jaspr_codex/README.md'),
    File(
      '${packageRootDirectory.path}/arcane_jaspr_codex/arcane_codex_web/README.md',
    ),
    File(
      '${packageRootDirectory.path}/arcane_jaspr_codex/arcane_codex_web/lib/components/demo_registry.dart',
    ),
  ];

  filesToScan.addAll(
    _collectFiles(
      Directory(
        '${packageRootDirectory.path}/arcane_jaspr_codex/arcane_codex_web/content',
      ),
      '.md',
    ),
  );
  filesToScan.addAll(
    _collectFiles(
      Directory(
        '${packageRootDirectory.path}/../Oracular/templates/arcane_jaspr_docs',
      ),
      '.md',
    ),
  );
  filesToScan.addAll(
    _collectFiles(
      Directory(
        '${packageRootDirectory.path}/../Oracular/templates/arcane_jaspr_app/lib',
      ),
      '.dart',
    ),
  );

  final List<_BannedToken> bannedTokens = <_BannedToken>[
    _BannedToken(
      label: 'StatelessComponent',
      pattern: RegExp(r'StatelessComponent'),
    ),
    _BannedToken(
      label: 'StatefulComponent',
      pattern: RegExp(r'StatefulComponent'),
    ),
    _BannedToken(
      label: 'Component build',
      pattern: RegExp(r'Component build\s*\('),
    ),
    _BannedToken(label: 'htmlFor', pattern: RegExp(r'htmlFor')),
    _BannedToken(label: 'dom.InputType', pattern: RegExp(r'dom\.InputType')),
    _BannedToken(label: '<Component>', pattern: RegExp(r'<Component>')),
    _BannedToken(label: '<Arcane', pattern: RegExp(r'<Arcane[A-Za-z]')),
    _BannedToken(label: 'const <Type>[', pattern: RegExp(r'const\s+<[A-Za-z]')),
  ];

  final List<String> failures = <String>[];

  for (File file in filesToScan) {
    if (!file.existsSync()) {
      continue;
    }

    final String content = file.readAsStringSync();

    for (_BannedToken bannedToken in bannedTokens) {
      if (bannedToken.pattern.hasMatch(content)) {
        failures.add('${file.path}: ${bannedToken.label}');
      }
    }
  }

  if (failures.isNotEmpty) {
    stderr.writeln('Primary surface check failed:');
    for (String failure in failures) {
      stderr.writeln('- $failure');
    }
    exit(1);
  }

  stdout.writeln('Primary surface check passed.');
}

List<File> _collectFiles(Directory directory, String extension) {
  if (!directory.existsSync()) {
    return <File>[];
  }

  final List<File> files = <File>[];
  final List<FileSystemEntity> entities = directory.listSync(recursive: true);

  for (FileSystemEntity entity in entities) {
    if (entity is File && entity.path.endsWith(extension)) {
      files.add(entity);
    }
  }

  files.sort((File left, File right) => left.path.compareTo(right.path));
  return files;
}

class _BannedToken {
  final String label;
  final RegExp pattern;

  const _BannedToken({required this.label, required this.pattern});
}
