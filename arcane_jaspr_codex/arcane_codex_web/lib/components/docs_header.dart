import 'package:arcane_jaspr/arcane_jaspr.dart';

import '../utils/constants.dart';

/// Documentation site header
class DocsHeader extends StatelessComponent {
  final bool isDark;
  final VoidCallback? onThemeToggle;

  const DocsHeader({super.key, this.isDark = true, this.onThemeToggle});

  @override
  Component build(BuildContext context) {
    final base = AppConstants.baseUrl;

    return header(
      styles: const ArcaneStyleData(
        display: Display.flex,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        padding: PaddingPreset.horizontalLg,
        heightCustom: '64px',
        borderBottom: BorderPreset.subtle,
        background: Background.background,
        position: Position.sticky,
        top: '0',
        zIndex: ZIndex.sticky,
        width: Size.full,
      ).toStyles(),
      [
        _buildNavigation(base),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            crossAxisAlignment: CrossAxisAlignment.center,
            gap: Gap.lg,
          ),
          children: [
            _buildSearch(),
            if (AppConstants.githubUrl.isNotEmpty) _buildGitHubButton(),
            _buildThemeButton(),
          ],
        ),
      ],
    );
  }

  Component _buildNavigation(String base) {
    return ArcaneNav(
      styles: const ArcaneStyleData(
        display: Display.flex,
        crossAxisAlignment: CrossAxisAlignment.center,
        gap: Gap.xs,
      ),
      children: [
        _navLink('Docs', '$base/docs'),
        _navLink('Components', '$base/docs/components-catalog'),
        _navLink('Guides', '$base/guides'),
      ],
    );
  }

  Component _navLink(String label, String href) {
    return ArcaneLink(
      href: href,
      styles: const ArcaneStyleData(
        padding: PaddingPreset.smMd,
        fontSize: FontSize.sm,
        fontWeight: FontWeight.w500,
        textColor: TextColor.mutedForeground,
        textDecoration: TextDecoration.none,
        borderRadius: Radius.md,
        transition: Transition.colors,
      ),
      child: ArcaneText(label),
    );
  }

  Component _buildSearch() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(widthCustom: '280px'),
      children: const [
        ArcaneTextInput(
          id: 'docs-search',
          placeholder: 'Search documentation...',
          size: ComponentSize.sm,
        ),
      ],
    );
  }

  Component _buildGitHubButton() {
    return ArcaneLink(
      href: AppConstants.githubUrl,
      target: '_blank',
      rel: 'noopener noreferrer',
      styles: const ArcaneStyleData(
        display: Display.inlineFlex,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        widthCustom: '36px',
        heightCustom: '36px',
        borderRadius: Radius.md,
        textColor: TextColor.mutedForeground,
        transition: Transition.allFast,
      ),
      child: ArcaneIcon.github(size: IconSize.sm),
    );
  }

  Component _buildThemeButton() {
    return ArcaneDiv(
      id: 'theme-toggle',
      styles: const ArcaneStyleData(
        display: Display.inlineFlex,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        widthCustom: '36px',
        heightCustom: '36px',
        border: BorderPreset.subtle,
        borderRadius: Radius.md,
        background: Background.transparent,
        textColor: TextColor.mutedForeground,
        cursor: Cursor.pointer,
        transition: Transition.allFast,
      ),
      children: [
        // Sun icon - shown in dark mode (to switch to light)
        ArcaneDiv(
          classes: 'theme-icon-sun',
          styles: ArcaneStyleData(
            display: isDark ? Display.flex : Display.none,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          children: [ArcaneIcon.sun(size: IconSize.sm)],
        ),
        // Moon icon - shown in light mode (to switch to dark)
        ArcaneDiv(
          classes: 'theme-icon-moon',
          styles: ArcaneStyleData(
            display: isDark ? Display.none : Display.flex,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          children: [ArcaneIcon.moon(size: IconSize.sm)],
        ),
      ],
    );
  }
}
