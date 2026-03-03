import 'package:jaspr/jaspr.dart';

class ChartPointProps {
  final String label;
  final num value;

  const ChartPointProps({required this.label, required this.value});
}

class ChartProps {
  final List<ChartPointProps> points;
  final String? title;
  final String? description;
  final String color;

  const ChartProps({
    required this.points,
    this.title,
    this.description,
    this.color = 'var(--primary)',
  });

  ChartProps copyWith({
    List<ChartPointProps>? points,
    String? title,
    String? description,
    String? color,
  }) {
    return ChartProps(
      points: points ?? this.points,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }
}

mixin ChartRendererContract {
  Component chart(ChartProps props);
}
