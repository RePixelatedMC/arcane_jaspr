library;

enum NeubrutalismTheme {
  yellow(
    color: 0xFFFFD23F,
    accentHot: 0xFFFF6B6B,
    accentCool: 0xFF4ECDC4,
    lightSurface: 0xFFFFFCEB,
    lightSecondary: 0xFFFFF4B8,
    lightAccent: 0xFFFFE066,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  ),

  pink(
    color: 0xFFFF6B9D,
    accentHot: 0xFFFFD23F,
    accentCool: 0xFFA8E6CF,
    lightSurface: 0xFFFFF5F8,
    lightSecondary: 0xFFFFD1DC,
    lightAccent: 0xFFFFB3C6,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  ),

  mint(
    color: 0xFF95E1D3,
    accentHot: 0xFFFF6B9D,
    accentCool: 0xFF4ECDC4,
    lightSurface: 0xFFF1FBF8,
    lightSecondary: 0xFFC8F0E6,
    lightAccent: 0xFFA8E6CF,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  ),

  orange(
    color: 0xFFFF8C42,
    accentHot: 0xFFFFD23F,
    accentCool: 0xFF95E1D3,
    lightSurface: 0xFFFFF7F0,
    lightSecondary: 0xFFFFD9B8,
    lightAccent: 0xFFFFB380,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  ),

  sky(
    color: 0xFF6FB3FF,
    accentHot: 0xFFFFD23F,
    accentCool: 0xFF95E1D3,
    lightSurface: 0xFFF0F7FF,
    lightSecondary: 0xFFC8DDFF,
    lightAccent: 0xFFA0C4FF,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  ),

  lavender(
    color: 0xFFB983FF,
    accentHot: 0xFFFF6B9D,
    accentCool: 0xFF6FB3FF,
    lightSurface: 0xFFF8F3FF,
    lightSecondary: 0xFFE0D1FF,
    lightAccent: 0xFFCDB0FF,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  ),

  lime(
    color: 0xFFC1FF72,
    accentHot: 0xFFFF6B9D,
    accentCool: 0xFF6FB3FF,
    lightSurface: 0xFFF6FFE8,
    lightSecondary: 0xFFD9FFAA,
    lightAccent: 0xFFC1FF72,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  ),

  red(
    color: 0xFFFF4747,
    accentHot: 0xFFFFD23F,
    accentCool: 0xFFFF8A8A,
    lightSurface: 0xFFFFF2F2,
    lightSecondary: 0xFFFFCCCC,
    lightAccent: 0xFFFF8080,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  ),

  greyscale(
    color: 0xFF1F1F1F,
    accentHot: 0xFF000000,
    accentCool: 0xFF6E6E6E,
    lightSurface: 0xFFF5F5F5,
    lightSecondary: 0xFFE6E6E6,
    lightAccent: 0xFFCFCFCF,
    lightBorder: 0xFF000000,
    lightInk: 0xFF000000,
  );

  final int color;

  final int accentHot;

  final int accentCool;

  final int lightSurface;

  final int lightSecondary;

  final int lightAccent;

  final int lightBorder;

  final int lightInk;

  const NeubrutalismTheme({
    required this.color,
    required this.accentHot,
    required this.accentCool,
    required this.lightSurface,
    required this.lightSecondary,
    required this.lightAccent,
    required this.lightBorder,
    required this.lightInk,
  });
}
