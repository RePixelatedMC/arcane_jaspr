import 'dart:js_interop';

import 'package:web/web.dart' as web;

typedef DemoStyleListenerDisposer = void Function();

DemoStyleListenerDisposer registerDemoStyleListener(void Function() callback) {
  DemoStyleListenerRegistration registration = DemoStyleListenerRegistration(
    callback,
  );
  return registration.dispose;
}

class DemoStyleListenerRegistration {
  final void Function() callback;
  late JSFunction jsListener;

  DemoStyleListenerRegistration(this.callback) {
    jsListener = _handleEvent.toJS;
    web.window.addEventListener('arcane-style-change', jsListener);
  }

  void dispose() {
    web.window.removeEventListener('arcane-style-change', jsListener);
  }

  void _handleEvent(web.Event event) {
    callback();
  }
}
