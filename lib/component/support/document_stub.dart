import 'package:jaspr/jaspr.dart';

/// Data for head element injection
class HeadElementData {
  final String tag;
  final Map<String, String>? attributes;
  final String? textContent;

  const HeadElementData({
    required this.tag,
    this.attributes,
    this.textContent,
  });

  factory HeadElementData.link(String href, {String rel = 'stylesheet'}) {
    return HeadElementData(
      tag: 'link',
      attributes: {'href': href, 'rel': rel},
    );
  }

  factory HeadElementData.preconnect(String href, {bool crossorigin = false}) {
    return HeadElementData(
      tag: 'link',
      attributes: crossorigin
          ? {'href': href, 'rel': 'preconnect', 'crossorigin': ''}
          : {'href': href, 'rel': 'preconnect'},
    );
  }

  factory HeadElementData.style(String css) {
    return HeadElementData(
      tag: 'style',
      textContent: css,
    );
  }
}

/// Stub for document manipulation - platform implementations provide the actual logic
class DocumentHelper {
  /// Set attributes on the html element
  static Component html({Map<String, String>? attributes}) {
    throw UnsupportedError('Cannot use DocumentHelper without a platform implementation');
  }

  /// Inject elements into the document head using data objects
  static Component head({List<HeadElementData>? elements}) {
    throw UnsupportedError('Cannot use DocumentHelper without a platform implementation');
  }
}
