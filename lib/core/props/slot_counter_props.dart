
/// Size variant for slot counter display.
enum SlotCounterSize { xs, sm, md, lg, xl }

/// Color variant for slot counter display.
enum SlotCounterColor { primary, accent, muted, success, warning, destructive }

/// Props for the SlotCounter component.
class SlotCounterProps {
  /// Minimum value in the random range
  final int minValue;

  /// Maximum value in the random range
  final int maxValue;

  /// Optional fixed value (disables random generation)
  final int? fixedValue;

  /// Text shown before the number (e.g., "\$", "<")
  final String? prefix;

  /// Text shown after the number (e.g., "ms", "%", "+")
  final String? suffix;

  /// Optional label shown below the counter
  final String? label;

  /// Duration of the spinning animation in milliseconds
  final int spinDurationMs;

  /// Interval between digit changes during spin in milliseconds
  final int spinIntervalMs;

  /// Base pause duration in seconds before next spin cycle
  final int basePauseSeconds;

  /// Random additional pause (0 to this value) in seconds
  final int randomPauseSeconds;

  /// Whether to auto-start the animation cycle
  final bool autoStart;

  /// Size for the value display
  final SlotCounterSize valueSize;

  /// Size for prefix/suffix
  final SlotCounterSize affixSize;

  /// Size for the label
  final SlotCounterSize labelSize;

  /// Color for the value
  final SlotCounterColor valueColor;

  /// Color for the prefix/suffix
  final SlotCounterColor affixColor;

  /// Color for the label
  final SlotCounterColor labelColor;

  /// Whether the value text should be bold
  final bool valueBold;

  /// Whether to use monospace font for consistent digit width
  final bool monospace;

  /// Minimum digit padding (e.g., 3 = "005", "042", "123")
  final int? minDigits;

  /// Callback when value changes
  final void Function(int value)? onValueChange;

  const SlotCounterProps({
    this.minValue = 0,
    this.maxValue = 9999,
    this.fixedValue,
    this.prefix,
    this.suffix,
    this.label,
    this.spinDurationMs = 1500,
    this.spinIntervalMs = 50,
    this.basePauseSeconds = 4,
    this.randomPauseSeconds = 5,
    this.autoStart = true,
    this.valueSize = SlotCounterSize.xl,
    this.affixSize = SlotCounterSize.sm,
    this.labelSize = SlotCounterSize.xs,
    this.valueColor = SlotCounterColor.accent,
    this.affixColor = SlotCounterColor.muted,
    this.labelColor = SlotCounterColor.muted,
    this.valueBold = true,
    this.monospace = true,
    this.minDigits,
    this.onValueChange,
  });

  /// Creates a latency/ping display with sensible defaults
  factory SlotCounterProps.latency({
    int minLatency = 5,
    int maxLatency = 150,
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.lg,
    SlotCounterColor valueColor = SlotCounterColor.accent,
    bool autoStart = true,
  }) {
    return SlotCounterProps(
      minValue: minLatency,
      maxValue: maxLatency,
      suffix: 'ms',
      label: label,
      valueSize: valueSize,
      valueColor: valueColor,
      basePauseSeconds: 4,
      randomPauseSeconds: 5,
      spinDurationMs: 1200,
      autoStart: autoStart,
    );
  }

  /// Creates a percentage display
  factory SlotCounterProps.percentage({
    int minValue = 0,
    int maxValue = 100,
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.xl,
    SlotCounterColor valueColor = SlotCounterColor.accent,
  }) {
    return SlotCounterProps(
      minValue: minValue,
      maxValue: maxValue,
      suffix: '%',
      label: label,
      valueSize: valueSize,
      valueColor: valueColor,
    );
  }

  /// Creates a currency display
  factory SlotCounterProps.currency({
    int minValue = 0,
    int maxValue = 10000,
    String currencySymbol = '\$',
    String? label,
    SlotCounterSize valueSize = SlotCounterSize.xl,
    SlotCounterColor valueColor = SlotCounterColor.accent,
  }) {
    return SlotCounterProps(
      minValue: minValue,
      maxValue: maxValue,
      prefix: currencySymbol,
      label: label,
      valueSize: valueSize,
      valueColor: valueColor,
    );
  }
}

/// Props for the SlotCounterRow component.
class SlotCounterRowProps {
  /// The slot counter props list
  final List<SlotCounterProps> counters;

  /// Gap between counters
  final String gap;

  /// Whether to wrap on smaller screens
  final bool wrap;

  /// Justify content
  final String justifyContent;

  const SlotCounterRowProps({
    required this.counters,
    this.gap = '2rem',
    this.wrap = true,
    this.justifyContent = 'center',
  });
}

/// Props for the SlotCounterCard component.
class SlotCounterCardProps {
  /// The slot counter props
  final SlotCounterProps counter;

  /// Padding
  final String padding;

  /// Border radius
  final String borderRadius;

  /// Whether to show border
  final bool showBorder;

  /// Whether to show background
  final bool showBackground;

  const SlotCounterCardProps({
    required this.counter,
    this.padding = '1rem',
    this.borderRadius = '0.375rem',
    this.showBorder = false,
    this.showBackground = false,
  });
}
