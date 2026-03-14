import 'package:arcane_jaspr/arcane_jaspr.dart';

class SelectionExamples extends StatefulWidget {
  const SelectionExamples({super.key});

  @override
  State<SelectionExamples> createState() => _SelectionExamplesState();
}

class _SelectionExamplesState extends State<SelectionExamples> {
  String _framework = 'jaspr';
  String _tier = 'starter';

  @override
  Widget build(BuildContext context) => ArcaneApp(
    stylesheet: const ShadcnStylesheet(theme: ShadcnTheme.midnight),
    brightness: Brightness.dark,
    child: Screen(
      title: 'Selection',
      subtitle: 'Selector, radio cards, and data table',
      child: Collection(
        children: [
          Section(
            titleText: 'Framework',
            card: true,
            children: [
              Selector(
                value: _framework,
                values: const ['jaspr', 'flutter'],
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _framework = value;
                    });
                  }
                },
                labelBuilder: (String entry) => entry,
              ),
              RadioCards(
                value: _tier,
                values: const ['starter', 'pro'],
                onChanged: (String value) {
                  setState(() {
                    _tier = value;
                  });
                },
                labelBuilder: (String entry) => entry,
              ),
            ],
          ),
          Section(
            titleText: 'Accounts',
            card: true,
            children: [
              DataTable(
                items: const [
                  _SmokeUser(name: 'Alex', role: 'Admin'),
                  _SmokeUser(name: 'Sam', role: 'Editor'),
                ],
                columns: [
                  DataColumn(
                    header: 'Name',
                    builder: (_SmokeUser user) => Text(user.name),
                  ),
                  DataColumn(
                    header: 'Role',
                    builder: (_SmokeUser user) => Text(user.role),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _SmokeUser {
  final String name;
  final String role;

  const _SmokeUser({required this.name, required this.role});
}
