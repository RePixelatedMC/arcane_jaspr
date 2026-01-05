import 'dart:async';
import 'dart:math';
import 'package:jaspr/jaspr.dart';

import '../html/div.dart';
import '../html/arcane_span.dart';
import '../html/arcane_text.dart';
import '../../util/style_types/index.dart';
import '../../util/arcane.dart' show FontWeight;

/// A slot-machine style animated counter that spins through random values
/// before settling on a target value. Perfect for latency displays, live stats,
/// or any numeric value that updates periodically.
///
/// The animation cycles through three phases:
/// 1. Pause - displays the current value for a configurable duration
/// 2. Spin - rapidly cycles through random values
/// 3. Settle - converges toward the target value before stopping
///
/// Example usage:
/// ```dart
/// ArcaneSlotCounter(
///   minValue: 5,
///   maxValue: 150,
///   suffix: 'ms',
///   label: 'NYC',
/// )
/// ```
class ArcaneSlotCounter extends StatefulComponent {
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

  /// Font size for the value display
  final FontSize valueFontSize;

  /// Font size for prefix/suffix
  final FontSize affixFontSize;

  /// Font size for the label
  final FontSize labelFontSize;

  /// Color for the value
  final TextColor valueColor;

  /// Color for the prefix/suffix
  final TextColor affixColor;

  /// Color for the label
  final TextColor labelColor;

  /// Font weight for the value
  final FontWeight valueFontWeight;

  /// Whether to use monospace font for consistent digit width
  final bool monospace;

  /// Minimum digit padding (e.g., 3 = "005", "042", "123")
  final int? minDigits;

  /// Callback when value changes
  final void Function(int value)? onValueChange;

  const ArcaneSlotCounter({
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
    this.valueFontSize = FontSize.xl,
    this.affixFontSize = FontSize.sm,
    this.labelFontSize = FontSize.xs,
    this.valueColor = TextColor.brand,
    this.affixColor = TextColor.muted,
    this.labelColor = TextColor.muted,
    this.valueFontWeight = FontWeight.bold,
    this.monospace = true,
    this.minDigits,
    this.onValueChange,
    super.key,
  });

  /// Creates a latency/ping display with sensible defaults
  factory ArcaneSlotCounter.latency({
    int minLatency = 5,
    int maxLatency = 150,
    String? label,
    FontSize valueFontSize = FontSize.lg,
    TextColor valueColor = TextColor.brand,
    bool autoStart = true,
    Key? key,
  }) {
    return ArcaneSlotCounter(
      minValue: minLatency,
      maxValue: maxLatency,
      suffix: 'ms',
      label: label,
      valueFontSize: valueFontSize,
      valueColor: valueColor,
      basePauseSeconds: 4,
      randomPauseSeconds: 5,
      spinDurationMs: 1200,
      autoStart: autoStart,
      key: key,
    );
  }

  /// Creates a percentage display
  factory ArcaneSlotCounter.percentage({
    int minValue = 0,
    int maxValue = 100,
    String? label,
    FontSize valueFontSize = FontSize.xl,
    TextColor valueColor = TextColor.brand,
    Key? key,
  }) {
    return ArcaneSlotCounter(
      minValue: minValue,
      maxValue: maxValue,
      suffix: '%',
      label: label,
      valueFontSize: valueFontSize,
      valueColor: valueColor,
      key: key,
    );
  }

  /// Creates a currency display
  factory ArcaneSlotCounter.currency({
    int minValue = 0,
    int maxValue = 10000,
    String currencySymbol = '\$',
    String? label,
    FontSize valueFontSize = FontSize.xl,
    TextColor valueColor = TextColor.brand,
    Key? key,
  }) {
    return ArcaneSlotCounter(
      minValue: minValue,
      maxValue: maxValue,
      prefix: currencySymbol,
      label: label,
      valueFontSize: valueFontSize,
      valueColor: valueColor,
      key: key,
    );
  }

  @override
  State<ArcaneSlotCounter> createState() => _ArcaneSlotCounterState();
}

class _ArcaneSlotCounterState extends State<ArcaneSlotCounter> {
  final Random _random = Random();
  int _currentValue = 0;
  int _targetValue = 0;
  bool _isSpinning = false;
  Timer? _spinTimer;
  Timer? _pauseTimer;
  int _spinCount = 0;

  @override
  void initState() {
    super.initState();
    if (component.fixedValue != null) {
      _currentValue = component.fixedValue!;
      _targetValue = component.fixedValue!;
    } else {
      _currentValue = _generateRandomValue();
      _targetValue = _currentValue;
      if (component.autoStart) {
        _scheduleNextSpin();
      }
    }
  }

  @override
  void dispose() {
    _spinTimer?.cancel();
    _pauseTimer?.cancel();
    super.dispose();
  }

  int _generateRandomValue() {
    return component.minValue +
        _random.nextInt(component.maxValue - component.minValue + 1);
  }

  void _scheduleNextSpin() {
    if (component.fixedValue != null) return;

    final pauseMs = (component.basePauseSeconds * 1000) +
        (_random.nextInt(component.randomPauseSeconds + 1) * 1000);

    _pauseTimer = Timer(Duration(milliseconds: pauseMs), () {
      _startSpinning();
    });
  }

  void _startSpinning() {
    _targetValue = _generateRandomValue();
    _spinCount = 0;
    final totalSpinUpdates =
        component.spinDurationMs ~/ component.spinIntervalMs;

    setState(() {
      _isSpinning = true;
    });

    _spinTimer = Timer.periodic(
      Duration(milliseconds: component.spinIntervalMs),
      (timer) {
        _spinCount++;

        if (_spinCount >= totalSpinUpdates) {
          timer.cancel();
          setState(() {
            _currentValue = _targetValue;
            _isSpinning = false;
          });
          component.onValueChange?.call(_currentValue);
          _scheduleNextSpin();
        } else {
          final progress = _spinCount / totalSpinUpdates;

          if (progress > 0.8) {
            final diff = (_targetValue - _currentValue).abs();
            final maxDelta = (diff * (1 - progress) * 2).toInt().clamp(1, 500);
            final newValue =
                _targetValue + _random.nextInt(maxDelta * 2 + 1) - maxDelta;
            setState(() {
              _currentValue =
                  newValue.clamp(component.minValue, component.maxValue);
            });
          } else {
            setState(() {
              _currentValue = _generateRandomValue();
            });
          }
        }
      },
    );
  }

  String _formatValue(int value) {
    if (component.minDigits != null) {
      return value.toString().padLeft(component.minDigits!, '0');
    }
    return value.toString();
  }

  @override
  Component build(BuildContext context) {
    final displayValue = _formatValue(_currentValue);

    return ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.inlineFlex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
        gap: Gap.xs,
      ),
      children: [
        // Value row
        ArcaneDiv(
          styles: ArcaneStyleData(
            display: Display.inlineFlex,
            alignItems: AlignItems.baseline,
            gap: Gap.xs,
            fontFamily: component.monospace ? FontFamily.mono : null,
          ),
          children: [
            // Prefix
            if (component.prefix != null)
              ArcaneSpan(
                styles: ArcaneStyleData(
                  fontSize: component.affixFontSize,
                  textColor: component.affixColor,
                ),
                child: ArcaneText(component.prefix!),
              ),
            // Value
            ArcaneSpan(
              styles: ArcaneStyleData(
                fontSize: component.valueFontSize,
                fontWeight: component.valueFontWeight,
                textColor: component.valueColor,
                opacity: _isSpinning ? Opacity.high : null,
                transition: Transition.allFast,
              ),
              child: ArcaneText(displayValue),
            ),
            // Suffix
            if (component.suffix != null)
              ArcaneSpan(
                styles: ArcaneStyleData(
                  fontSize: component.affixFontSize,
                  textColor: component.affixColor,
                ),
                child: ArcaneText(component.suffix!),
              ),
          ],
        ),
        // Label
        if (component.label != null)
          ArcaneDiv(
            styles: ArcaneStyleData(
              fontSize: component.labelFontSize,
              textColor: component.labelColor,
              textTransform: TextTransform.uppercase,
              letterSpacing: LetterSpacing.wide,
            ),
            children: [ArcaneText(component.label!)],
          ),
      ],
    );
  }
}

/// A row of slot counters for displaying multiple live values
class ArcaneSlotCounterRow extends StatelessComponent {
  /// The slot counters to display
  final List<ArcaneSlotCounter> counters;

  /// Gap between counters
  final Gap gap;

  /// Whether to wrap on smaller screens
  final bool wrap;

  /// Justify content
  final JustifyContent justifyContent;

  const ArcaneSlotCounterRow({
    required this.counters,
    this.gap = Gap.lg,
    this.wrap = true,
    this.justifyContent = JustifyContent.center,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.flexStart,
        justifyContent: justifyContent,
        gap: gap,
        flexWrap: wrap ? FlexWrap.wrap : null,
      ),
      children: counters,
    );
  }
}

/// A card containing a slot counter with optional styling
class ArcaneSlotCounterCard extends StatelessComponent {
  /// The slot counter to display
  final ArcaneSlotCounter counter;

  /// Background
  final Background? background;

  /// Border radius
  final Radius borderRadius;

  /// Padding
  final PaddingPreset padding;

  /// Border style
  final BorderPreset? border;

  const ArcaneSlotCounterCard({
    required this.counter,
    this.background,
    this.borderRadius = Radius.md,
    this.padding = PaddingPreset.md,
    this.border,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        display: Display.inlineFlex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
        padding: padding,
        borderRadius: borderRadius,
        background: background,
        border: border,
      ),
      children: [counter],
    );
  }
}
