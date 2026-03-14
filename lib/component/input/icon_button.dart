import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/flutter.dart';

class IconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;
  final bool loading;
  final String? href;

  const IconButton({
    required this.icon,
    this.onPressed,
    this.variant = ButtonVariant.ghost,
    this.size = ButtonSize.icon,
    this.disabled = false,
    this.loading = false,
    this.href,
    super.key,
  });

  const IconButton.primary({
    required this.icon,
    this.onPressed,
    this.size = ButtonSize.icon,
    this.disabled = false,
    this.loading = false,
    this.href,
    super.key,
  }) : variant = ButtonVariant.primary;

  const IconButton.secondary({
    required this.icon,
    this.onPressed,
    this.size = ButtonSize.icon,
    this.disabled = false,
    this.loading = false,
    this.href,
    super.key,
  }) : variant = ButtonVariant.secondary;

  const IconButton.outline({
    required this.icon,
    this.onPressed,
    this.size = ButtonSize.icon,
    this.disabled = false,
    this.loading = false,
    this.href,
    super.key,
  }) : variant = ButtonVariant.outline;

  const IconButton.ghost({
    required this.icon,
    this.onPressed,
    this.size = ButtonSize.icon,
    this.disabled = false,
    this.loading = false,
    this.href,
    super.key,
  }) : variant = ButtonVariant.ghost;

  const IconButton.destructive({
    required this.icon,
    this.onPressed,
    this.size = ButtonSize.icon,
    this.disabled = false,
    this.loading = false,
    this.href,
    super.key,
  }) : variant = ButtonVariant.destructive;

  @override
  Widget build(BuildContext context) => Button(
    onPressed: onPressed,
    variant: variant,
    size: size,
    disabled: disabled,
    loading: loading,
    href: href,
    child: icon,
  );
}
