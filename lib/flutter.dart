library;

import 'package:jaspr/jaspr.dart' as jaspr;

export 'package:jaspr/jaspr.dart'
    show
        AsyncCallback,
        Builder,
        BuildContext,
        Key,
        UniqueKey,
        ValueChanged,
        ValueGetter,
        ValueKey,
        ValueSetter,
        VoidCallback,
        runApp;

typedef Widget = jaspr.Component;

typedef State<T extends StatefulWidget> = jaspr.State<T>;

typedef WidgetBuilder = Widget Function(jaspr.BuildContext context);

typedef IndexedWidgetBuilder =
    Widget Function(jaspr.BuildContext context, int index);

typedef NullableIndexedWidgetBuilder =
    Widget? Function(jaspr.BuildContext context, int index);

abstract class StatelessWidget extends jaspr.StatelessComponent {
  const StatelessWidget({super.key});
}

abstract class StatefulWidget extends jaspr.StatefulComponent {
  const StatefulWidget({super.key});
}

abstract class InheritedWidget extends jaspr.InheritedComponent {
  const InheritedWidget({required super.child, super.key});
}
