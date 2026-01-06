import '../core/renderers.dart';

export '../core/renderers.dart' hide SheetPosition;

/// Base class for stylesheets.
///
/// A stylesheet provides component renderers that output HTML/CSS
/// according to a specific design language (ShadCN, DaisyUI, etc.).
///
/// Each stylesheet must implement [ComponentRenderers] for ALL components.
/// There are no optional components - if a design system doesn't have
/// a native concept for something, the stylesheet must create an
/// appropriate implementation.
///
/// ## Usage
///
/// ```dart
/// ArcaneApp(
///   stylesheet: ArcaneStylesheet.shadcn,
///   child: MyApp(),
/// )
/// ```
///
/// ## Creating Custom Stylesheets
///
/// ```dart
/// class MyStylesheet extends ArcaneStylesheet {
///   const MyStylesheet();
///
///   @override
///   String get id => 'my-style';
///
///   @override
///   String get name => 'My Style';
///
///   @override
///   ComponentRenderers get renderers => const MyRenderers();
/// }
/// ```
abstract class ArcaneStylesheet {
  const ArcaneStylesheet();

  /// Unique identifier for this stylesheet
  String get id;

  /// Human-readable display name
  String get name;

  /// Component renderers for this stylesheet
  ComponentRenderers get renderers;

  /// Base CSS to inject into the document.
  ///
  /// This is where you define CSS custom properties, base styles,
  /// and any CSS that components depend on.
  String? get baseCss => null;

  /// External CSS URLs to load (Google Fonts, CDN stylesheets, etc.)
  List<String> get externalCssUrls => const [];

  /// Additional CSS for light mode specifically
  String? get lightModeCss => null;

  /// Additional CSS for dark mode specifically
  String? get darkModeCss => null;

  // ==========================================================================
  // PREDEFINED STYLESHEETS
  // ==========================================================================

  /// ShadCN UI stylesheet - minimal, modern, accessible.
  ///
  /// This is the DEFAULT stylesheet and fallback for all components.
  /// Based on https://ui.shadcn.com
  static const ArcaneStylesheet shadcn = _ShadcnStylesheetRef();

  /// Codex stylesheet - gaming aesthetic with glass effects.
  ///
  /// Sharp corners, rich shadows, premium fonts.
  static const ArcaneStylesheet codex = _CodexStylesheetRef();
}

/// Placeholder that gets replaced with actual ShadcnStylesheet at runtime.
/// This allows the base class to reference ShadCN without circular imports.
class _ShadcnStylesheetRef extends ArcaneStylesheet {
  const _ShadcnStylesheetRef();

  @override
  String get id => 'shadcn';

  @override
  String get name => 'ShadCN UI';

  @override
  ComponentRenderers get renderers =>
      throw UnimplementedError('Import shadcn_stylesheet.dart to use ShadCN');
}

/// Placeholder for CodexStylesheet
class _CodexStylesheetRef extends ArcaneStylesheet {
  const _CodexStylesheetRef();

  @override
  String get id => 'codex';

  @override
  String get name => 'Codex';

  @override
  ComponentRenderers get renderers =>
      throw UnimplementedError('Import codex_stylesheet.dart to use Codex');
}
