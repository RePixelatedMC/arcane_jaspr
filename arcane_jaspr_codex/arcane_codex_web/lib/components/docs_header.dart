import 'package:arcane_jaspr/arcane_jaspr.dart';

import '../utils/constants.dart';

/// Documentation site header - stylesheet-agnostic design using Arcane widgets
///
/// Accepts generic variants from any ArcaneStyleSheet, allowing the header
/// to work with any stylesheet without modification.
class DocsHeader extends StatelessComponent {
  final bool isDark;
  final VoidCallback? onThemeToggle;

  /// Available variants from the current stylesheet
  final List<StyleSheetVariant> variants;

  /// Currently selected variant ID
  final String currentVariantId;

  /// Callback when variant selection changes
  final void Function(String)? onVariantChanged;

  const DocsHeader({
    super.key,
    this.isDark = true,
    this.onThemeToggle,
    this.variants = const [],
    this.currentVariantId = '',
    this.onVariantChanged,
  });

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
        // LEFT: Navigation
        _buildNavigation(base),

        // RIGHT: Search + Controls
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            crossAxisAlignment: CrossAxisAlignment.center,
            gap: Gap.lg,
          ),
          children: [
            _buildSearch(),
            if (AppConstants.githubUrl.isNotEmpty) _buildGitHubButton(),
            // Only show variant selector if stylesheet has multiple variants
            if (variants.length > 1) _buildVariantSelect(),
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
        _navLink('Components', '$base/docs/inputs/arcane-button'),
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

  /// Search with inline results dropdown
  Component _buildSearch() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.relative,
        display: Display.flex,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      children: [
        // Search input container
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            crossAxisAlignment: CrossAxisAlignment.center,
            gap: Gap.sm,
            padding: PaddingPreset.horizontalMd,
            heightCustom: '36px',
            widthCustom: '280px',
            border: BorderPreset.subtle,
            borderRadius: Radius.md,
            background: Background.input,
            textColor: TextColor.mutedForeground,
            fontSize: FontSize.sm,
          ),
          children: [
            ArcaneIcon.search(size: IconSize.sm),
            input(
              id: 'docs-search',
              type: InputType.text,
              attributes: const {
                'placeholder': 'Search documentation...',
                'autocomplete': 'off',
              },
              styles: const ArcaneStyleData(
                flex: FlexPreset.expand,
                background: Background.transparent,
                border: BorderPreset.none,
                textColor: TextColor.primary,
                fontSize: FontSize.sm,
                raw: {
                  'outline': 'none',
                },
              ).toStyles(),
            ),
            ArcaneKbd('\u2318K', size: KbdSize.sm),
          ],
        ),
        // Search results dropdown
        ArcaneDiv(
          id: 'search-results',
          styles: const ArcaneStyleData(
            display: Display.none,
            position: Position.absolute,
            top: '44px',
            left: '0',
            widthCustom: '280px',
            maxHeight: '400px',
            overflow: Overflow.auto,
            background: Background.card,
            border: BorderPreset.subtle,
            borderRadius: Radius.md,
            shadow: Shadow.lg,
            zIndex: ZIndex.dropdown,
          ),
          children: const [],
        ),
      ],
    );
  }

  /// GitHub icon button
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
      child: Github(width: Unit.pixels(18), height: Unit.pixels(18)),
    );
  }

  /// Stylesheet variant selector (generic, works with any stylesheet)
  Component _buildVariantSelect() {
    return ArcaneSelect(
      id: 'variant-select',
      value: currentVariantId,
      options: [
        for (final variant in variants)
          ArcaneSelectOption(value: variant.id, label: variant.displayName),
      ],
      size: InputSizeStyle.sm,
    );
  }

  /// Theme toggle button
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
        ArcaneDiv(
          classes: 'theme-icon',
          styles: const ArcaneStyleData(
            display: Display.flex,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          children: [
            if (isDark) ArcaneIcon.sun(size: IconSize.sm),
            if (!isDark) ArcaneIcon.moon(size: IconSize.sm),
          ],
        ),
      ],
    );
  }
}
