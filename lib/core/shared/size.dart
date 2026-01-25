/// Unified size enum supporting both naming conventions.
/// Use whichever style you prefer - they are aliases.
enum ComponentSize {
  sm,
  md,
  lg;

  /// Alias for [sm]
  static const ComponentSize small = sm;

  /// Alias for [md]
  static const ComponentSize medium = md;

  /// Alias for [lg]
  static const ComponentSize large = lg;
}
