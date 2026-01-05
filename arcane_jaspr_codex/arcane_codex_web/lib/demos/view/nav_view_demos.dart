import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Navigation and indicator view demos (accordion, tabs, tree-view, indicators)
class NavViewDemos {
  static List<Component> accordion() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneAccordion(
              items: [
                ArcaneAccordionItem(
                  title: 'Section 1',
                  content: 'Content for section 1',
                ),
                ArcaneAccordionItem(
                  title: 'Section 2',
                  content: 'Content for section 2',
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> inlineTabs() => [
        ArcaneTabBar(
          tabs: const [
            ArcaneTabBarItem(label: 'Overview'),
            ArcaneTabBarItem(label: 'Features'),
            ArcaneTabBarItem(label: 'Pricing'),
          ],
          selectedIndex: 0,
          onChanged: (_) {},
        ),
      ];

  static List<Component> treeView() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '250px'),
          children: [
            ArcaneTreeView(
              nodes: [
                TreeNode(
                  id: 'src',
                  label: 'src',
                  icon: ArcaneIcon.folder(),
                  children: [
                    TreeNode(id: 'main', label: 'main.dart', icon: ArcaneIcon.file()),
                    TreeNode(id: 'app', label: 'app.dart', icon: ArcaneIcon.file()),
                  ],
                ),
                TreeNode(id: 'pubspec', label: 'pubspec.yaml', icon: ArcaneIcon.file()),
              ],
            ),
          ],
        ),
      ];

  static List<Component> dotIndicator() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Basic Dot Indicator', weight: FontWeight.w600),
            ArcaneDotIndicator(
              index: 2,
              length: 5,
              onChanged: (_) {},
            ),
            ArcaneText('Large Dots', weight: FontWeight.w600),
            ArcaneDotIndicator(
              index: 1,
              length: 4,
              size: DotIndicatorSize.lg,
              onChanged: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> stepIndicator() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '500px'),
          children: [
            ArcaneStepIndicator(
              currentStep: 1,
              steps: const ['Account', 'Profile', 'Review', 'Complete'],
              onStepTap: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> switcher() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '300px',
            heightCustom: '100px',
            background: Background.surfaceVariant,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneSwitcher(
              index: 0,
              direction: SwitcherDirection.fade,
              children: [
                ArcaneCenter(child: ArcaneText('Step 1 Content')),
                ArcaneCenter(child: ArcaneText('Step 2 Content')),
                ArcaneCenter(child: ArcaneText('Step 3 Content')),
              ],
            ),
          ],
        ),
      ];
}
