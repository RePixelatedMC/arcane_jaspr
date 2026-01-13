import 'dart:js_interop';

import 'package:jaspr/jaspr.dart';
import 'package:web/web.dart' as web;

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

/// Client-side document manipulation
class DocumentHelper {
  static bool _htmlInitialized = false;
  static bool _stylesInjected = false;

  /// Set attributes on the html element (e.g., dark/light class)
  static Component html({Map<String, String>? attributes}) {
    if (!_htmlInitialized && attributes != null) {
      _htmlInitialized = true;
      final web.HTMLElement htmlEl = web.document.documentElement as web.HTMLElement;
      for (final MapEntry<String, String> entry in attributes.entries) {
        htmlEl.setAttribute(entry.key, entry.value);
      }
    }
    return Component.fragment(const []);
  }

  /// Inject elements into the document head synchronously
  static Component head({List<HeadElementData>? elements}) {
    if (_stylesInjected || elements == null || elements.isEmpty) {
      return Component.fragment(const []);
    }
    _stylesInjected = true;

    final web.HTMLHeadElement head = web.document.head!;

    for (final HeadElementData element in elements) {
      if (element.tag == 'link') {
        final web.HTMLLinkElement link =
            web.document.createElement('link') as web.HTMLLinkElement;
        if (element.attributes != null) {
          for (final MapEntry<String, String> attr in element.attributes!.entries) {
            link.setAttribute(attr.key, attr.value);
          }
        }
        head.appendChild(link);
      } else if (element.tag == 'style' && element.textContent != null) {
        final web.HTMLStyleElement style =
            web.document.createElement('style') as web.HTMLStyleElement;
        style.textContent = element.textContent!;
        head.appendChild(style);
      }
    }

    // Hide loading screen after fonts are ready
    _hideLoadingScreenWhenReady();

    return Component.fragment(const []);
  }

  /// Hide the loading screen after fonts have loaded
  static void _hideLoadingScreenWhenReady() {
    // Wait for fonts to be ready, then hide loading screen
    web.document.fonts.ready.toDart.then((_) {
      final web.Element? loading = web.document.getElementById('loading');
      if (loading != null) {
        loading.classList.add('hidden');
      }
    });
  }
}
