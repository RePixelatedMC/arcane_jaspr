library;

enum NeonTheme {
  green(
    color: 0xFF00f5a0,
    accentHot: 0xFFcaff64,
    accentCool: 0xFF00e5ff,
    lightSurface: 0xFFf6fbf8,
    lightSecondary: 0xFFe6f4ec,
    lightAccent: 0xFFd2ecdd,
    lightBorder: 0xFF8fcfa9,
    lightInk: 0xFF064e3b,
  ),

  red(
    color: 0xFFff3b3b,
    accentHot: 0xFFffaa1f,
    accentCool: 0xFFff2bd6,
    lightSurface: 0xFFfff8f8,
    lightSecondary: 0xFFffe5e5,
    lightAccent: 0xFFffcfcf,
    lightBorder: 0xFFf28a8a,
    lightInk: 0xFF7f1d1d,
  ),

  blue(
    color: 0xFF00d9ff,
    accentHot: 0xFF00f5a0,
    accentCool: 0xFF6366f1,
    lightSurface: 0xFFf6fbff,
    lightSecondary: 0xFFe1f4ff,
    lightAccent: 0xFFc6eaff,
    lightBorder: 0xFF7fc8e6,
    lightInk: 0xFF0c4a6e,
  ),

  purple(
    color: 0xFFa855f7,
    accentHot: 0xFFff2bd6,
    accentCool: 0xFF6366f1,
    lightSurface: 0xFFfaf7ff,
    lightSecondary: 0xFFede5ff,
    lightAccent: 0xFFddd1ff,
    lightBorder: 0xFFb8a3e8,
    lightInk: 0xFF4c1d95,
  ),

  cyan(
    color: 0xFF00e5ff,
    accentHot: 0xFF7fffd4,
    accentCool: 0xFF6366f1,
    lightSurface: 0xFFf5fcff,
    lightSecondary: 0xFFddf4fa,
    lightAccent: 0xFFc2eaf3,
    lightBorder: 0xFF7fc7d6,
    lightInk: 0xFF155e75,
  ),

  pink(
    color: 0xFFff2bd6,
    accentHot: 0xFFff5169,
    accentCool: 0xFFa855f7,
    lightSurface: 0xFFfff7fc,
    lightSecondary: 0xFFffe1f3,
    lightAccent: 0xFFffc7e7,
    lightBorder: 0xFFe698c0,
    lightInk: 0xFF831843,
  ),

  orange(
    color: 0xFFff8a1f,
    accentHot: 0xFFff2d55,
    accentCool: 0xFFffd23f,
    lightSurface: 0xFFfff9f3,
    lightSecondary: 0xFFffead2,
    lightAccent: 0xFFffd9b0,
    lightBorder: 0xFFf2a96b,
    lightInk: 0xFF7c2d12,
  ),

  rainbow(
    color: 0xFF00e5ff,
    accentHot: 0xFFff2bd6,
    accentCool: 0xFFa855f7,
    lightSurface: 0xFFf7f8ff,
    lightSecondary: 0xFFe6e8ff,
    lightAccent: 0xFFd1d6ff,
    lightBorder: 0xFF8b9ad1,
    lightInk: 0xFF1e1b4b,
  );

  final int color;

  final int accentHot;

  final int accentCool;

  final int lightSurface;

  final int lightSecondary;

  final int lightAccent;

  final int lightBorder;

  final int lightInk;

  const NeonTheme({
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
