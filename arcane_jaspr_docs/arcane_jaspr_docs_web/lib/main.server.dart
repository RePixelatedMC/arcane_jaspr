/// The entrypoint for the **server** app (static generation).
library;

import 'package:arcane_lexicon/arcane_lexicon.dart' hide runApp;
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:jaspr/server.dart';

import 'components/interactive_demo.dart';
import 'main.server.options.dart';

/// Base URL for the site (for GitHub Pages subdirectory hosting)
const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: '');
const ArcaneStylesheet shadcnStylesheet = ShadcnStylesheet(
  theme: ShadcnTheme.midnight,
);
const ArcaneStylesheet neonStylesheet = NeonStylesheet(theme: NeonTheme.green);
const ArcaneStylesheet selectedStylesheet = neonStylesheet;
const List<KBStylesheetOption> stylesheetOptions = <KBStylesheetOption>[
  KBStylesheetOption(
    id: 'shadcn',
    label: 'Shadcn',
    stylesheet: shadcnStylesheet,
  ),
  KBStylesheetOption(id: 'neon', label: 'Neon', stylesheet: neonStylesheet),
];

void main() async {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    await KnowledgeBaseApp.create(
      config: SiteConfig(
        name: 'ArcaneJaspr Neon',
        description:
            'Documentation for ArcaneJaspr - A dart package for building web ui with Jaspr.',
        contentDirectory: 'content',
        baseUrl: baseUrl,
        githubUrl: 'https://github.com/ArcaneArts/arcane_jaspr',
        searchEnabled: true,
        tocEnabled: true,
        themeToggleEnabled: true,
        stylesheetSwitcherEnabled: true,
        pageNavEnabled: true,
        navigationBarEnabled: true,
        navigationBarPosition: KBNavigationBarPosition.top,
        defaultTheme: KBThemeMode.dark,
        showEditLink: true,
        editBranch: 'master',
        sidebarFooter: 'Built with Arcane Lexicon',
        sidebarFooterUrl: 'https://github.com/ArcaneArts/arcane_lexicon',
      ),
      stylesheet: selectedStylesheet,
      stylesheetOptions: stylesheetOptions,
      demoBuilder: (String componentType) =>
          InteractiveDemo(componentType: componentType),
    ),
  );
}
