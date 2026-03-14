import 'package:arcane_jaspr/arcane_jaspr.dart';

class SelectionExamples extends StatefulWidget {
  const SelectionExamples({super.key});

  @override
  State<SelectionExamples> createState() => _SelectionExamplesState();
}

class _SelectionExamplesState extends State<SelectionExamples> {
  String _framework = 'jaspr';
  String _tier = 'starter';
  String _role = 'admin';

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
          ArcaneCombobox(
            value: _framework,
            options: const [
              ComboboxOption(value: 'jaspr', label: 'Jaspr'),
              ComboboxOption(value: 'flutter', label: 'Flutter'),
            ],
            onChanged: (String? value) {
              if (value != null) {
                setState(() => _framework = value);
              }
            },
          ),
          ArcaneRadioGroup(
            value: _role,
            options: const [
              RadioOption(value: 'admin', label: 'Admin'),
              RadioOption(value: 'editor', label: 'Editor'),
            ],
            onChanged: (String value) {
              setState(() => _role = value);
            },
          ),
          ArcaneSelect(
            value: _tier,
            options: const [
              ArcaneSelectOption(label: 'Starter', value: 'starter'),
              ArcaneSelectOption(label: 'Pro', value: 'pro'),
            ],
            onChange: (String value) {
              setState(() => _tier = value);
            },
          ),
          ArcaneDataTable(
            items: const [
              _SmokeUser(name: 'Alex', role: 'Admin'),
              _SmokeUser(name: 'Sam', role: 'Editor'),
            ],
            columns: [
              ArcaneDataColumn(
                header: 'Name',
                builder: (_SmokeUser user) => ArcaneText(user.name),
              ),
              ArcaneDataColumn(
                header: 'Role',
                builder: (_SmokeUser user) => ArcaneText(user.role),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmokeUser {
  final String name;
  final String role;

  const _SmokeUser({required this.name, required this.role});
}
