import 'package:arcane_jaspr/arcane_jaspr.dart';

import '../utils/constants.dart';

/// Documentation sidebar with collapsible navigation groups
class DocsSidebar extends StatelessComponent {
  final String currentPath;

  const DocsSidebar({
    super.key,
    required this.currentPath,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneScrollRail(
      width: '280px',
      topOffset: '0px',
      showBorder: true,
      padding: '0',
      scrollPersistenceId: 'docs-sidebar',
      // Use same background as page - ShadCN style
      children: [
        // Header
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            borderBottom: BorderPreset.subtle,
          ),
          children: [
            ArcaneLink(
              href: '${AppConstants.baseUrl}/',
              styles: const ArcaneStyleData(
                textDecoration: TextDecoration.none,
              ),
              child: ArcaneDiv(
                styles: const ArcaneStyleData(
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.lg,
                  textColor: TextColor.primary,
                ),
                children: [ArcaneText(AppConstants.siteName)],
              ),
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.sm,
                textColor: TextColor.mutedForeground,
                margin: MarginPreset.topXs,
              ),
              children: [const ArcaneText('Documentation')],
            ),
          ],
        ),

        // Navigation
        ArcaneNav(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.sm,
          ),
          children: [
            // Getting Started section (always expanded, not collapsible)
            _buildFixedSection('Getting Started', ArcaneIcon.zap(size: IconSize.sm), [
              _buildNavItem(label: 'Introduction', href: '/docs'),
              _buildNavItem(label: 'Why Jaspr?', href: '/docs/why-jaspr'),
              _buildNavItem(label: 'Installation', href: '/docs/installation'),
              _buildNavItem(label: 'Quick Start', href: '/docs/quick-start'),
              _buildNavItem(label: 'Theming', href: '/docs/concepts/theming'),
              _buildNavItem(label: 'Styling', href: '/docs/concepts/styling'),
              _buildNavItem(label: 'Design Tokens', href: '/docs/concepts/tokens'),
              _buildNavItem(label: 'Component Aliases', href: '/docs/concepts/aliases'),
            ]),

            // Style Reference section
            _buildCollapsibleSection('Style Reference', ArcaneIcon.edit(size: IconSize.sm), [
              _buildNavItem(label: 'Display & Layout', href: '/docs/styles/display'),
              _buildNavItem(label: 'Spacing', href: '/docs/styles/spacing'),
              _buildNavItem(label: 'Typography', href: '/docs/styles/typography'),
              _buildNavItem(label: 'Colors', href: '/docs/styles/colors'),
              _buildNavItem(label: 'Borders', href: '/docs/styles/borders'),
              _buildNavItem(label: 'Effects', href: '/docs/styles/effects'),
            ], defaultOpen: _sectionContainsPath('styles')),

            // Input Components section
            _buildCollapsibleSection('Inputs', ArcaneIcon.settings(size: IconSize.sm), [
              _buildNavItem(label: 'Button', href: '/docs/inputs/arcane-button'),
              _buildNavItem(label: 'IconButton', href: '/docs/inputs/arcane-icon-button'),
              _buildNavItem(label: 'Close Button', href: '/docs/inputs/arcane-close-button'),
              _buildNavItem(label: 'FAB', href: '/docs/inputs/arcane-fab'),
              _buildNavItem(label: 'CtaLink', href: '/docs/inputs/arcane-cta-link'),
              _buildNavItem(label: 'TextInput', href: '/docs/inputs/arcane-text-input'),
              _buildNavItem(label: 'TextArea', href: '/docs/inputs/arcane-text-area'),
              _buildNavItem(label: 'Search', href: '/docs/inputs/arcane-search'),
              _buildNavItem(label: 'SearchBar', href: '/docs/inputs/arcane-search-bar'),
              _buildNavItem(label: 'DropdownMenu', href: '/docs/inputs/arcane-dropdown-menu'),
              _buildNavItem(label: 'Select', href: '/docs/inputs/arcane-select'),
              _buildNavItem(label: 'Checkbox', href: '/docs/inputs/arcane-checkbox'),
              _buildNavItem(label: 'Radio', href: '/docs/inputs/arcane-radio'),
              _buildNavItem(label: 'RadioGroup', href: '/docs/inputs/arcane-radio-group'),
              _buildNavItem(label: 'ToggleSwitch', href: '/docs/inputs/arcane-toggle-switch'),
              _buildNavItem(label: 'Slider', href: '/docs/inputs/arcane-slider'),
              _buildNavItem(label: 'RangeSlider', href: '/docs/inputs/arcane-range-slider'),
              _buildNavItem(label: 'ToggleButton', href: '/docs/inputs/arcane-toggle-button'),
              _buildNavItem(label: 'ToggleButtonGroup', href: '/docs/inputs/arcane-toggle-button-group'),
              _buildNavItem(label: 'CycleButton', href: '/docs/inputs/arcane-cycle-button'),
              _buildNavItem(label: 'Selector', href: '/docs/inputs/arcane-selector'),
              _buildNavItem(label: 'TagInput', href: '/docs/inputs/arcane-tag-input'),
              _buildNavItem(label: 'NumberInput', href: '/docs/inputs/arcane-number-input'),
              _buildNavItem(label: 'FileUpload', href: '/docs/inputs/arcane-file-upload'),
              _buildNavItem(label: 'ColorInput', href: '/docs/inputs/arcane-color-input'),
              _buildNavItem(label: 'MutableText', href: '/docs/inputs/arcane-mutable-text'),
              _buildNavItem(label: 'OtpInput', href: '/docs/inputs/arcane-otp-input'),
              _buildNavItem(label: 'Calendar', href: '/docs/inputs/arcane-calendar'),
              _buildNavItem(label: 'DatePicker', href: '/docs/inputs/arcane-date-picker'),
              _buildNavItem(label: 'TimePicker', href: '/docs/inputs/arcane-time-picker'),
              _buildNavItem(label: 'FormattedInput', href: '/docs/inputs/arcane-formatted-input'),
            ], defaultOpen: _sectionContainsPath('inputs')),

            // Layout Components section
            _buildCollapsibleSection('Layout', ArcaneIcon.grid(size: IconSize.sm), [
              _buildNavItem(label: 'Styled', href: '/docs/layout/arcane-div'),
              _buildNavItem(label: 'Row', href: '/docs/layout/arcane-row'),
              _buildNavItem(label: 'Column', href: '/docs/layout/arcane-column'),
              _buildNavItem(label: 'Container', href: '/docs/layout/arcane-container'),
              _buildNavItem(label: 'Section', href: '/docs/layout/arcane-section'),
              _buildNavItem(label: 'SectionHeader', href: '/docs/layout/arcane-section-header'),
              _buildNavItem(label: 'Box', href: '/docs/layout/arcane-box'),
              _buildNavItem(label: 'Center', href: '/docs/layout/arcane-center'),
              _buildNavItem(label: 'Flow', href: '/docs/layout/arcane-flow'),
              _buildNavItem(label: 'Spacer', href: '/docs/layout/arcane-spacer'),
              _buildNavItem(label: 'Expanded', href: '/docs/layout/arcane-expanded'),
              _buildNavItem(label: 'Stack', href: '/docs/layout/arcane-stack'),
              _buildNavItem(label: 'Positioned', href: '/docs/layout/arcane-positioned'),
              _buildNavItem(label: 'Padding', href: '/docs/layout/arcane-padding'),
              _buildNavItem(label: 'Gutter', href: '/docs/layout/arcane-gutter'),
              _buildNavItem(label: 'Card', href: '/docs/layout/arcane-card'),
              _buildNavItem(label: 'Tabs', href: '/docs/layout/arcane-tabs'),
              _buildNavItem(label: 'Tile', href: '/docs/layout/arcane-tile'),
              _buildNavItem(label: 'ButtonGroup', href: '/docs/layout/arcane-button-group'),
              _buildNavItem(label: 'HeroSection', href: '/docs/layout/arcane-hero-section'),
              _buildNavItem(label: 'Footer', href: '/docs/layout/arcane-footer'),
              _buildNavItem(label: 'FooterColumn', href: '/docs/layout/arcane-footer-column'),
              _buildNavItem(label: 'AuthLayout', href: '/docs/layout/arcane-auth-layout'),
              _buildNavItem(label: 'DashboardLayout', href: '/docs/layout/arcane-dashboard-layout'),
              _buildNavItem(label: 'PageBody', href: '/docs/layout/arcane-page-body'),
              _buildNavItem(label: 'Drawer', href: '/docs/layout/arcane-drawer'),
              _buildNavItem(label: 'ScrollArea', href: '/docs/layout/arcane-scroll-area'),
              _buildNavItem(label: 'AspectRatio', href: '/docs/layout/arcane-aspect-ratio'),
              _buildNavItem(label: 'Resizable', href: '/docs/layout/arcane-resizable'),
              _buildNavItem(label: 'Sheet', href: '/docs/layout/arcane-sheet'),
              _buildNavItem(label: 'ActionSheet', href: '/docs/layout/arcane-action-sheet'),
            ], defaultOpen: _sectionContainsPath('layout')),

            // Typography Components section
            _buildCollapsibleSection('Typography', ArcaneIcon.fileText(size: IconSize.sm), [
              _buildNavItem(label: 'Text', href: '/docs/typography/arcane-text'),
              _buildNavItem(label: 'Heading', href: '/docs/typography/arcane-heading'),
              _buildNavItem(label: 'Headline', href: '/docs/typography/arcane-headline'),
              _buildNavItem(label: 'Subheadline', href: '/docs/typography/arcane-subheadline'),
              _buildNavItem(label: 'Paragraph', href: '/docs/typography/arcane-paragraph'),
              _buildNavItem(label: 'TextSpan', href: '/docs/typography/arcane-span'),
              _buildNavItem(label: 'GradientText', href: '/docs/typography/arcane-gradient-text'),
              _buildNavItem(label: 'GlowText', href: '/docs/typography/arcane-glow-text'),
              _buildNavItem(label: 'RichText', href: '/docs/typography/arcane-rich-text'),
              _buildNavItem(label: 'CodeSnippet', href: '/docs/typography/arcane-code-snippet'),
              _buildNavItem(label: 'InlineCode', href: '/docs/typography/arcane-inline-code'),
              _buildNavItem(label: 'CodeBlock', href: '/docs/typography/arcane-pre'),
            ], defaultOpen: _sectionContainsPath('typography')),

            // View Components section
            _buildCollapsibleSection('View', ArcaneIcon.eye(size: IconSize.sm), [
              _buildNavItem(label: 'Icon', href: '/docs/view/arcane-icon'),
              _buildNavItem(label: 'Avatar', href: '/docs/view/arcane-avatar'),
              _buildNavItem(label: 'Badge', href: '/docs/view/arcane-badge'),
              _buildNavItem(label: 'Chip', href: '/docs/view/arcane-chip'),
              _buildNavItem(label: 'Divider', href: '/docs/view/arcane-divider'),
              _buildNavItem(label: 'Separator', href: '/docs/view/arcane-separator'),
              _buildNavItem(label: 'ProgressBar', href: '/docs/view/arcane-progress-bar'),
              _buildNavItem(label: 'Loader', href: '/docs/view/arcane-loader'),
              _buildNavItem(label: 'Skeleton', href: '/docs/view/arcane-skeleton'),
              _buildNavItem(label: 'EmptyState', href: '/docs/view/arcane-empty-state'),
              _buildNavItem(label: 'DataTable', href: '/docs/view/arcane-data-table'),
              _buildNavItem(label: 'Timeline', href: '/docs/view/arcane-timeline'),
              _buildNavItem(label: 'Steps', href: '/docs/view/arcane-steps'),
              _buildNavItem(label: 'StatDisplay', href: '/docs/view/arcane-stat-display'),
              _buildNavItem(label: 'AuthorCard', href: '/docs/view/arcane-author-card'),
              _buildNavItem(label: 'FeatureCard', href: '/docs/view/arcane-feature-card'),
              _buildNavItem(label: 'CheckList', href: '/docs/view/arcane-check-list'),
              _buildNavItem(label: 'CodeWindow', href: '/docs/view/arcane-code-window'),
              _buildNavItem(label: 'Tooltip', href: '/docs/view/arcane-tooltip'),
              _buildNavItem(label: 'Accordion', href: '/docs/view/arcane-accordion'),
              _buildNavItem(label: 'Toast', href: '/docs/view/arcane-toast'),
              _buildNavItem(label: 'Callout', href: '/docs/view/arcane-callout'),
              _buildNavItem(label: 'Kbd', href: '/docs/view/arcane-kbd'),
              _buildNavItem(label: 'Meter', href: '/docs/view/arcane-meter'),
              _buildNavItem(label: 'Alert', href: '/docs/view/arcane-alert'),
              _buildNavItem(label: 'InlineTabs', href: '/docs/view/arcane-inline-tabs'),
              _buildNavItem(label: 'TreeView', href: '/docs/view/arcane-tree-view'),
              _buildNavItem(label: 'Popover', href: '/docs/view/arcane-popover'),
              _buildNavItem(label: 'Hovercard', href: '/docs/view/arcane-hovercard'),
              _buildNavItem(label: 'Expander', href: '/docs/view/arcane-expander'),
              _buildNavItem(label: 'FadeEdge', href: '/docs/view/arcane-fade-edge'),
              _buildNavItem(label: 'Marquee', href: '/docs/view/arcane-marquee'),
              _buildNavItem(label: 'Svg', href: '/docs/view/arcane-svg'),
              _buildNavItem(label: 'AvatarGroup', href: '/docs/view/arcane-avatar-group'),
              _buildNavItem(label: 'DotIndicator', href: '/docs/view/arcane-dot-indicator'),
              _buildNavItem(label: 'StepIndicator', href: '/docs/view/arcane-step-indicator'),
              _buildNavItem(label: 'Tracker', href: '/docs/view/arcane-tracker'),
              _buildNavItem(label: 'SurfaceCard', href: '/docs/view/arcane-surface-card'),
              _buildNavItem(label: 'Switcher', href: '/docs/view/arcane-switcher'),
              _buildNavItem(label: 'FlexiCards', href: '/docs/view/arcane-flexi-cards'),
              _buildNavItem(label: 'SlotCounter', href: '/docs/view/arcane-slot-counter'),
              _buildNavItem(label: 'ArrowLink', href: '/docs/view/arcane-arrow-link'),
              _buildNavItem(label: 'FeatureShowcase', href: '/docs/view/arcane-feature-showcase'),
              _buildNavItem(label: 'WorldMap', href: '/docs/view/arcane-world-map'),
              _buildNavItem(label: 'USAMap', href: '/docs/view/arcane-usa-map'),
            ], defaultOpen: _sectionContainsPath('view')),

            // Navigation Components section
            _buildCollapsibleSection('Navigation', ArcaneIcon.compass(size: IconSize.sm), [
              _buildNavItem(label: 'Header', href: '/docs/navigation/arcane-header'),
              _buildNavItem(label: 'Sidebar', href: '/docs/navigation/arcane-sidebar'),
              _buildNavItem(label: 'BottomNav', href: '/docs/navigation/arcane-bottom-nav'),
              _buildNavItem(label: 'MobileMenu', href: '/docs/navigation/arcane-mobile-menu'),
              _buildNavItem(label: 'MegaMenu', href: '/docs/navigation/arcane-mega-menu'),
              _buildNavItem(label: 'Breadcrumbs', href: '/docs/navigation/arcane-breadcrumbs'),
              _buildNavItem(label: 'Pagination', href: '/docs/navigation/arcane-pagination'),
              _buildNavItem(label: 'ContextMenu', href: '/docs/navigation/arcane-context-menu'),
              _buildNavItem(label: 'Menubar', href: '/docs/navigation/arcane-menubar'),
            ], defaultOpen: _sectionContainsPath('navigation')),

            // Feedback Components section
            _buildCollapsibleSection('Feedback', ArcaneIcon.bell(size: IconSize.sm), [
              _buildNavItem(label: 'Dialog', href: '/docs/feedback/arcane-dialog'),
              _buildNavItem(label: 'AlertBanner', href: '/docs/feedback/arcane-alert-banner'),
              _buildNavItem(label: 'StatusBadge', href: '/docs/feedback/arcane-status-badge'),
              _buildNavItem(label: 'Command', href: '/docs/feedback/arcane-command'),
              _buildNavItem(label: 'InputDialog', href: '/docs/feedback/arcane-input-dialog'),
              _buildNavItem(label: 'TimeDialog', href: '/docs/feedback/arcane-time-dialog'),
              _buildNavItem(label: 'ItemPicker', href: '/docs/feedback/arcane-item-picker'),
            ], defaultOpen: _sectionContainsPath('feedback')),

            // Forms section
            _buildCollapsibleSection('Forms', ArcaneIcon.file(size: IconSize.sm), [
              _buildNavItem(label: 'Form', href: '/docs/forms/arcane-form'),
              _buildNavItem(label: 'Field', href: '/docs/forms/arcane-field'),
              _buildNavItem(label: 'FieldWrapper', href: '/docs/forms/arcane-field-wrapper'),
            ], defaultOpen: _sectionContainsPath('forms')),

            // Authentication section
            _buildCollapsibleSection('Authentication', ArcaneIcon.lock(size: IconSize.sm), [
              _buildNavItem(label: 'LoginCard', href: '/docs/auth/arcane-login-card'),
              _buildNavItem(label: 'SignupCard', href: '/docs/auth/arcane-signup-card'),
              _buildNavItem(label: 'ForgotPasswordCard', href: '/docs/auth/arcane-forgot-password-card'),
              _buildNavItem(label: 'Social Sign-In Buttons', href: '/docs/auth/social-buttons'),
              _buildNavItem(label: 'AuthSplitLayout', href: '/docs/auth/auth-split-layout'),
              _buildNavItem(label: 'AuthBrandingPanel', href: '/docs/auth/auth-branding-panel'),
              _buildNavItem(label: 'PasswordPolicy', href: '/docs/auth/password-policy'),
            ], defaultOpen: _sectionContainsPath('auth')),

            // Screens section
            _buildCollapsibleSection('Screens', ArcaneIcon.monitor(size: IconSize.sm), [
              _buildNavItem(label: 'Screen', href: '/docs/screens/arcane-screen'),
              _buildNavItem(label: 'ChatScreen', href: '/docs/screens/arcane-chat-screen'),
            ], defaultOpen: _sectionContainsPath('screens')),

            // Guides section
            _buildCollapsibleSection('Guides', ArcaneIcon.bookmark(size: IconSize.sm), [
              _buildNavItem(label: 'Deployment', href: '/guides/deployment'),
            ], defaultOpen: currentPath.startsWith('/guides')),
          ],
        ),
      ],
    );
  }

  bool _sectionContainsPath(String section) {
    return currentPath.startsWith('/docs/$section');
  }

  /// Build a fixed section that's always expanded (no toggle)
  Component _buildFixedSection(String title, Component icon, List<Component> items) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomMd,
      ),
      children: [
        // Section header - ShadCN style: minimal, no background
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            gap: Gap.sm,
            crossAxisAlignment: CrossAxisAlignment.center,
            fontSize: FontSize.xs,
            fontWeight: FontWeight.w500,
            padding: PaddingPreset.horizontalSm,
            margin: MarginPreset.bottomXs,
            textColor: TextColor.mutedForeground,
          ),
          children: [
            icon,
            ArcaneText(title),
          ],
        ),
        // Items (always visible)
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.horizontalSm,
          ),
          children: items,
        ),
      ],
    );
  }

  /// Build a collapsible section using ArcaneDisclosure
  Component _buildCollapsibleSection(String title, Component icon, List<Component> items, {bool defaultOpen = false}) {
    return ArcaneDisclosure.minimal(
      open: defaultOpen,
      summary: ArcaneRow(
        gapSize: Gap.sm,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.xs,
              fontWeight: FontWeight.w500,
              textColor: TextColor.mutedForeground,
            ),
            children: [ArcaneText(title)],
          ),
        ],
      ),
      child: ArcaneColumn(
        children: items,
      ),
    );
  }

  /// Build a navigation item that links to a page
  Component _buildNavItem({
    required String label,
    required String href,
  }) {
    final fullHref = '${AppConstants.baseUrl}$href';
    final isActive = currentPath == href || currentPath == '$href/';

    return ArcaneLink(
      href: fullHref,
      styles: ArcaneStyleData(
        display: Display.flex,
        gap: Gap.sm,
        fontSize: FontSize.sm,
        borderRadius: Radius.md,
        margin: MarginPreset.bottomXs,
        transition: Transition.allFast,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDecoration: TextDecoration.none,
        padding: PaddingPreset.buttonSm,
        // ShadCN-style: muted background for active, no border indicator
        textColor: isActive ? TextColor.primary : TextColor.mutedForeground,
        fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
        background: isActive ? Background.muted : Background.transparent,
      ),
      child: ArcaneSpan(child: ArcaneText(label)),
    );
  }
}
