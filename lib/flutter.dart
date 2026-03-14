library;

import 'package:jaspr/jaspr.dart' as jaspr;

export 'package:jaspr/jaspr.dart'
    show BuildContext, Key, UniqueKey, ValueKey, runApp;

typedef Widget = jaspr.Component;

typedef State<T extends StatefulWidget> = jaspr.State<T>;

abstract class StatelessWidget extends jaspr.StatelessComponent {
  const StatelessWidget({super.key});
}

abstract class StatefulWidget extends jaspr.StatefulComponent {
  const StatefulWidget({super.key});
}

abstract class InheritedWidget extends jaspr.InheritedComponent {
  const InheritedWidget({required super.child, super.key});
}
