import 'package:arcane_jaspr/arcane_jaspr.dart';

class FormsAndMenuExample extends StatelessWidget {
  const FormsAndMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ArcaneApp(
      stylesheet: const ShadcnStylesheet(theme: ShadcnTheme.midnight),
      brightness: Brightness.dark,
      child: ArcaneBox(
        style: const ArcaneStyleData(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.lg,
        ),
        children: [
          ArcaneTextInput(
            label: 'Email',
            placeholder: 'name@example.com',
            type: TextInputType.email,
            onChange: (String value) {},
          ),
          ArcaneFieldWrapper(
            labelText: 'Plan',
            field: ArcaneSelect(
              value: 'pro',
              options: const [
                ArcaneSelectOption(label: 'Starter', value: 'starter'),
                ArcaneSelectOption(label: 'Pro', value: 'pro'),
              ],
              onChange: (String value) {},
            ),
          ),
          const ArcaneMenubar(
            menus: [
              ArcaneMenubarMenu(
                label: 'File',
                items: [
                  MenuItemAction(label: 'New'),
                  MenuItemAction(label: 'Open'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
