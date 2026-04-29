typedef DemoStyleListenerDisposer = void Function();

DemoStyleListenerDisposer registerDemoStyleListener(void Function() callback) =>
    () {};
