import 'map_scripts.dart';

/// Aggregates all view-related interactivity scripts.

class ViewScripts {
  ViewScripts._();

  static String get code => '''
  ${MapScripts.code}
''';
}
