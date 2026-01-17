// Tool to generate the complete ArcaneIcon wrapper for all Lucide icons
// Uses the Lucide icon font for efficient loading (single font file vs 1600+ separate SVG components)
// Run with: dart tool/generate_icons.dart

import 'dart:convert';
import 'dart:io';

import 'package:fast_log/fast_log.dart';

/// Dart reserved words that need special handling
const Set<String> dartReservedWords = <String>{
  'assert', 'break', 'case', 'catch', 'class', 'const', 'continue',
  'default', 'do', 'else', 'enum', 'extends', 'false', 'final',
  'finally', 'for', 'if', 'in', 'is', 'new', 'null', 'rethrow',
  'return', 'super', 'switch', 'this', 'throw', 'true', 'try',
  'var', 'void', 'while', 'with', 'yield',
  // Also handle common type names that conflict
  'int', 'double', 'bool', 'String', 'List', 'Map', 'Set',
  'Function', 'Type', 'Object', 'dynamic', 'Future', 'Stream',
  'import', 'export', 'library', 'part', 'typedef', 'abstract',
  // Jaspr types that would conflict
  'component',
};

/// Special abbreviations - keep uppercase for AZ/ZA sorting icons only
const Map<String, String> upperAbbreviations = <String, String>{
  'az': 'AZ',
  'za': 'ZA',
};

/// Semantic aliases for common icon names
/// Maps alias method name -> actual lucide icon name (kebab-case)
const Map<String, String> semanticAliases = <String, String>{
  // Navigation
  'home': 'house',
  'close': 'x',
  'back': 'arrow-left',
  'forward': 'arrow-right',
  'up': 'arrow-up',
  'down': 'arrow-down',

  // Actions
  'edit': 'pencil',
  'delete': 'trash-2',
  'remove': 'trash',
  'add': 'plus',
  'create': 'plus',
  'cancel': 'x',
  'confirm': 'check',

  // UI elements
  'dropdown': 'chevron-down',
  'expand': 'chevron-down',
  'collapse': 'chevron-up',
  'next': 'chevron-right',
  'prev': 'chevron-left',
  'previous': 'chevron-left',

  // Grid/Layout
  'grid': 'grid-3x3',
  'dashboard': 'layout-dashboard',
  'sidebar': 'panel-left',

  // Status
  'success': 'circle-check',
  'error': 'circle-x',
  'warning': 'triangle-alert',
  'danger': 'triangle-alert',
  'info': 'info',
  'help': 'circle-question-mark',

  // User
  'profile': 'user',
  'account': 'user',
  'avatar': 'circle-user-round',

  // Misc
  'search': 'search',
  'settings': 'settings',
  'options': 'settings',
  'preferences': 'settings',
  'config': 'settings',
  'notifications': 'bell',
  'alerts': 'bell',
  'email': 'mail',
  'message': 'message-square',
  'chat': 'message-circle',
  'comment': 'message-square',
  'attachment': 'paperclip',
  'link': 'link',
  'share': 'share-2',
  'save': 'save',
  'download': 'download',
  'upload': 'upload',
  'copy': 'copy',
  'paste': 'clipboard',
  'cut': 'scissors',
  'undo': 'undo-2',
  'redo': 'redo-2',
  'refresh': 'refresh-cw',
  'reload': 'refresh-cw',
  'sync': 'refresh-cw',
  'loading': 'loader-circle',
  'spinner': 'loader-circle',
  'lock': 'lock',
  'unlock': 'lock-open',
  'visible': 'eye',
  'hidden': 'eye-off',
  'show': 'eye',
  'hide': 'eye-off',
  'play': 'play',
  'pause': 'pause',
  'stop': 'square',
  'record': 'circle',
  'volume': 'volume-2',
  'mute': 'volume-x',
  'fullscreen': 'maximize',
  'exitFullscreen': 'minimize',
  'zoomIn': 'zoom-in',
  'zoomOut': 'zoom-out',
  'calendar': 'calendar',
  'date': 'calendar',
  'time': 'clock',
  'timer': 'timer',
  'alarm': 'alarm-clock',
  'location': 'map-pin',
  'pin': 'map-pin',
  'phone': 'phone',
  'call': 'phone',
  'video': 'video',
  'camera': 'camera',
  'image': 'image',
  'photo': 'image',
  'gallery': 'images',
  'music': 'music',
  'audio': 'music',
  'file': 'file',
  'document': 'file-text',
  'folder': 'folder',
  'directory': 'folder',
  'print': 'printer',
  'export': 'file-output',
  'moreHorizontal': 'ellipsis',
  'moreVertical': 'ellipsis-vertical',
  'filter': 'funnel',
  'sort': 'arrow-up-down',
};

/// Icons that need manual name adjustments (kebab-case key -> method name)
const Map<String, String> nameOverrides = <String, String>{
  // Reserved words or conflicts
  'import': 'importIcon',
  'type': 'typeIcon',
  'switch': 'switchIcon',
  'case': 'caseIcon',
  'default': 'defaultIcon',
  'for': 'forIcon',
  'if': 'ifIcon',
  'return': 'returnIcon',
  'try': 'tryIcon',
  'catch': 'catchIcon',
  'finally': 'finallyIcon',
  'throw': 'throwIcon',
  'new': 'newIcon',
  'null': 'nullIcon',
  'true': 'trueIcon',
  'false': 'falseIcon',
  'this': 'thisIcon',
  'super': 'superIcon',
  'class': 'classIcon',
  'enum': 'enumIcon',
  'void': 'voidIcon',
  'var': 'varIcon',
  'final': 'finalIcon',
  'const': 'constIcon',
  'assert': 'assertIcon',
  'break': 'breakIcon',
  'continue': 'continueIcon',
  'do': 'doIcon',
  'else': 'elseIcon',
  'extends': 'extendsIcon',
  'in': 'inIcon',
  'is': 'isIcon',
  'rethrow': 'rethrowIcon',
  'while': 'whileIcon',
  'with': 'withIcon',
  'yield': 'yieldIcon',
  // Common type conflicts
  'list': 'listIcon',
  'map': 'mapIcon',
  'set': 'setIcon',
  'key': 'keyIcon',
  'view': 'viewIcon',
  'factory': 'factoryIcon',
  'target': 'targetIcon',
  'timer': 'timerIcon',
  'contrast': 'contrastIcon',
  'radius': 'radiusIcon',
};

/// Convert kebab-case to camelCase (for method names)
String kebabToCamel(String kebab) {
  final List<String> parts = kebab.split('-');
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < parts.length; i++) {
    String part = parts[i];
    if (part.isEmpty) continue;

    // Check for special abbreviations (AZ/ZA)
    final String lower = part.toLowerCase();
    if (upperAbbreviations.containsKey(lower)) {
      if (i == 0) {
        buffer.write(lower); // First part stays lowercase
      } else {
        buffer.write(upperAbbreviations[lower]!);
      }
      continue;
    }

    // Handle numeric parts
    if (RegExp(r'^\d').hasMatch(part)) {
      if (buffer.isEmpty) {
        buffer.write('icon$part');
      } else {
        buffer.write(part);
      }
      continue;
    }

    if (i == 0) {
      buffer.write(part.toLowerCase());
    } else {
      buffer.write(part[0].toUpperCase() + part.substring(1).toLowerCase());
    }
  }

  return buffer.toString();
}

/// Get the method name, handling reserved words
String getMethodName(String kebabName) {
  // Check for overrides first
  if (nameOverrides.containsKey(kebabName)) {
    return nameOverrides[kebabName]!;
  }

  final String camel = kebabToCamel(kebabName);

  // Check if it's a reserved word
  if (dartReservedWords.contains(camel)) {
    return '${camel}Icon';
  }

  return camel;
}

void main() async {
  // Read icon info from the lucide font info.json
  final File infoFile = File('assets/fonts/lucide/info.json');
  if (!infoFile.existsSync()) {
    error('info.json not found. Run: npm pack lucide-static && extract font files');
    exit(1);
  }

  final String infoContent = await infoFile.readAsString();
  final Map<String, dynamic> iconInfo = jsonDecode(infoContent) as Map<String, dynamic>;

  final List<String> iconNames = iconInfo.keys.toList()..sort();
  print('Found ${iconNames.length} icons in Lucide font');

  // Build codepoint map
  final Map<String, String> codepoints = <String, String>{};
  for (final String name in iconNames) {
    final Map<String, dynamic> info = iconInfo[name] as Map<String, dynamic>;
    // encodedCode is like "\\e585" - we need just "e585"
    String code = info['encodedCode'] as String;
    if (code.startsWith('\\')) {
      code = code.substring(1);
    }
    codepoints[name] = code;
  }

  // Generate the Dart file
  final StringBuffer buffer = StringBuffer();

  buffer.writeln('''
// GENERATED FILE - DO NOT EDIT MANUALLY
// Generated by tool/generate_icons.dart
// Uses the Lucide icon font for efficient loading
// Font files: assets/fonts/lucide/lucide.woff2 (245KB for all ${iconNames.length} icons)

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

/// Icon size presets for consistent sizing.
enum IconSize {
  xs,
  sm,
  md,
  lg,
  xl,
  xl2,
}

/// Extension to convert IconSize to pixel values.
extension IconSizeExtension on IconSize {
  double get pixels => switch (this) {
        IconSize.xs => 12,
        IconSize.sm => 16,
        IconSize.md => 20,
        IconSize.lg => 24,
        IconSize.xl => 32,
        IconSize.xl2 => 48,
      };
}

/// Base component for font-based icons.
/// Uses the Lucide icon font with Unicode codepoints.
class _LucideIcon extends StatelessComponent {
  final String codepoint;
  final IconSize size;

  const _LucideIcon({
    required this.codepoint,
    this.size = IconSize.md,
  });

  @override
  Component build(BuildContext context) {
    final double px = size.pixels;
    return dom.i(
      styles: dom.Styles(raw: <String, String>{
        'font-family': "'lucide', sans-serif",
        'font-style': 'normal',
        'font-weight': 'normal',
        'font-size': '\${px}px',
        'line-height': '1',
        'display': 'inline-block',
        'width': '\${px}px',
        'height': '\${px}px',
        '-webkit-font-smoothing': 'antialiased',
        '-moz-osx-font-smoothing': 'grayscale',
      }),
      [Component.text(String.fromCharCode(int.parse(codepoint, radix: 16)))],
    );
  }
}

/// Wrapper class providing access to all ${iconNames.length} Lucide icons.
///
/// Uses the Lucide icon font for efficient loading - a single 245KB font file
/// instead of 1600+ separate SVG component files.
///
/// Usage:
/// ```dart
/// ArcaneIcon.house()
/// ArcaneIcon.search(size: IconSize.lg)
/// ArcaneIcon.settings()
/// ```
///
/// All methods accept an optional [size] parameter (default: IconSize.md = 20px).
///
/// For the complete icon catalog, visit: https://lucide.dev/icons
class ArcaneIcon {
  ArcaneIcon._();
''');

  // Generate methods for each icon
  for (final String name in iconNames) {
    final String methodName = getMethodName(name);
    final String codepoint = codepoints[name]!;
    // Convert name to PascalCase for the doc comment
    final String displayName = name
        .split('-')
        .map((String s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1))
        .join('');

    buffer.writeln('''
  /// $displayName icon
  static Component $methodName({IconSize size = IconSize.md}) =>
      _LucideIcon(codepoint: '$codepoint', size: size);
''');
  }

  // Add semantic aliases section
  buffer.writeln('''
  // ============================================================================
  // Semantic Aliases
  // These provide intuitive names that map to the actual Lucide icon names.
  // For example: home() -> house(), edit() -> pencil(), close() -> x()
  // ============================================================================
''');

  // Generate alias methods
  final Set<String> existingMethods = iconNames.map((String n) => getMethodName(n)).toSet();

  for (final MapEntry<String, String> entry in semanticAliases.entries) {
    final String aliasName = entry.key;
    final String targetIconName = entry.value;

    // Skip if alias would conflict with an existing method
    if (existingMethods.contains(aliasName)) {
      continue;
    }

    // Get the codepoint for the target icon
    if (!codepoints.containsKey(targetIconName)) {
      warn('Alias "$aliasName" -> "$targetIconName" not found in icon set');
      continue;
    }

    final String codepoint = codepoints[targetIconName]!;

    buffer.writeln('''
  /// Alias for $targetIconName - semantic name for common use case
  static Component $aliasName({IconSize size = IconSize.md}) =>
      _LucideIcon(codepoint: '$codepoint', size: size);
''');
  }

  buffer.writeln('}');

  // Write the generated file
  final File outputFile = File('lib/component/view/icon.dart');
  await outputFile.writeAsString(buffer.toString());

  info('Generated ${outputFile.path} with ${iconNames.length} icons');

  // Generate CSS file for the font
  await _generateFontCss();
}

/// Generate CSS file with @font-face for the Lucide icon font
Future<void> _generateFontCss() async {
  const String css = '''
/* Lucide Icon Font - Generated by tool/generate_icons.dart */
/* Include this CSS in your web app to load the icon font */

@font-face {
  font-family: 'lucide';
  src: url('fonts/lucide/lucide.woff2') format('woff2'),
       url('fonts/lucide/lucide.woff') format('woff'),
       url('fonts/lucide/lucide.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
  font-display: block;
}
''';

  final File cssFile = File('assets/fonts/lucide/lucide.css');
  await cssFile.writeAsString(css);
  info('Generated ${cssFile.path}');
}
