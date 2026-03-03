import 'package:jaspr/jaspr.dart';

import 'progress_bar.dart';

class ArcaneSpinner extends StatelessComponent {
  final String? size;
  final String? color;

  const ArcaneSpinner({
    this.size,
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneLoadingSpinner(
      size: size,
      color: color,
    );
  }
}
