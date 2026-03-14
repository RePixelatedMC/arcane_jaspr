/// The entrypoint for the **server** app (static generation).
library;

import 'package:arcane_lexicon/arcane_lexicon.dart' hide runApp;
import 'package:jaspr/server.dart';

import 'components/interactive_demo.dart';
import 'main.server.options.dart';

/// Base URL for the site (for GitHub Pages subdirectory hosting)
const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: '');

void main() async {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    await KnowledgeBaseApp.create(
      config: SiteConfig(
        name: 'ArcaneJaspr Codex',
        description:
            'Documentation for ArcaneJaspr - A dart package for building web ui with Jaspr.',
        contentDirectory: 'content',
        baseUrl: baseUrl,
        githubUrl: 'https://github.com/ArcaneArts/arcane_jaspr',
        searchEnabled: true,
        tocEnabled: true,
        themeToggleEnabled: false,
        pageNavEnabled: true,
        navigationBarEnabled: true,
        navigationBarPosition: KBNavigationBarPosition.top,
        defaultTheme: KBThemeMode.dark,
        showEditLink: true,
        editBranch: 'master',
        sidebarFooter: 'Built with Arcane Lexicon',
        sidebarFooterUrl: 'https://github.com/ArcaneArts/arcane_lexicon',
      ),
      // stylesheet: const CodexStylesheet(theme: CodexTheme.green),
      stylesheet: const ShadcnStylesheet(theme: ShadcnTheme.midnight),
      demoBuilder: (String componentType) =>
          InteractiveDemo(componentType: componentType),
    ),
  );
}
