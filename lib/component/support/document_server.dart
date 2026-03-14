import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide Document;
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/server.dart' show Document;

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

/// Server-side document manipulation using jaspr's Document API
class DocumentHelper {
  /// Set attributes on the html element
  static Widget html({Map<String, String>? attributes}) {
    return Document.html(attributes: attributes);
  }

  /// Inject elements into the document head
  static Widget head({List<HeadElementData>? elements}) {
    if (elements == null || elements.isEmpty) {
      return const Document.head(children: []);
    }

    final List<Widget> children = [];
    for (final HeadElementData element in elements) {
      if (element.tag == 'link') {
        children.add(
          Component.element(
            tag: 'link',
            attributes: element.attributes ?? {},
            children: const [],
          ),
        );
      } else if (element.tag == 'style' && element.textContent != null) {
        children.add(
          Component.element(
            tag: 'style',
            children: [dom.RawText(element.textContent!)],
          ),
        );
      }
    }

    return Document.head(children: children);
  }
}