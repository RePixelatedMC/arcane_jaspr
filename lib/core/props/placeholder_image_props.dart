/// Placeholder image source provider.
enum PlaceholderSource {
  /// Random cat images from cataas.com.
  cat,

  /// Random photos from picsum.photos.
  picsum,

  /// Placeholder.com solid color images.
  placeholder,
}

/// Placeholder image size presets.
enum PlaceholderSize {
  /// 64x64
  xs,

  /// 128x128
  sm,

  /// 256x256
  md,

  /// 512x512
  lg,

  /// 1024x1024
  xl,
}

/// Shape of the placeholder image.
enum PlaceholderShape {
  /// No border radius.
  square,

  /// Rounded corners.
  rounded,

  /// Full circle (aspect 1:1).
  circle,
}

/// Object fit behavior for the image.
enum PlaceholderFit {
  /// Cover the container, may crop.
  cover,

  /// Fit within container, may letterbox.
  contain,

  /// Fill container, may stretch.
  fill,
}

/// Placeholder image component properties.
class PlaceholderImageProps {
  /// The placeholder image source provider.
  final PlaceholderSource source;

  /// Seed for deterministic/consistent images.
  /// The same seed will return the same image.
  final String? seed;

  /// Size preset for the image.
  final PlaceholderSize size;

  /// Custom width (overrides size preset).
  final int? width;

  /// Custom height (overrides size preset).
  final int? height;

  /// Shape of the image container.
  final PlaceholderShape shape;

  /// Object fit behavior.
  final PlaceholderFit fit;

  /// Alt text for accessibility.
  final String? alt;

  /// Text to overlay on cat images (only for [PlaceholderSource.cat]).
  final String? text;

  /// Use animated GIF (only for [PlaceholderSource.cat]).
  final bool animated;

  /// Grayscale filter.
  final bool grayscale;

  /// Blur amount (0-10, only for [PlaceholderSource.picsum]).
  final int? blur;

  /// Background color for placeholder source.
  final String? backgroundColor;

  /// Text color for placeholder source.
  final String? textColor;

  /// Use lazy loading.
  final bool lazy;

  /// Click handler.
  final void Function()? onTap;

  /// Custom CSS classes.
  final String? classes;

  const PlaceholderImageProps({
    this.source = PlaceholderSource.cat,
    this.seed,
    this.size = PlaceholderSize.md,
    this.width,
    this.height,
    this.shape = PlaceholderShape.rounded,
    this.fit = PlaceholderFit.cover,
    this.alt,
    this.text,
    this.animated = false,
    this.grayscale = false,
    this.blur,
    this.backgroundColor,
    this.textColor,
    this.lazy = true,
    this.onTap,
    this.classes,
  });

  PlaceholderImageProps copyWith({
    PlaceholderSource? source,
    String? seed,
    PlaceholderSize? size,
    int? width,
    int? height,
    PlaceholderShape? shape,
    PlaceholderFit? fit,
    String? alt,
    String? text,
    bool? animated,
    bool? grayscale,
    int? blur,
    String? backgroundColor,
    String? textColor,
    bool? lazy,
    void Function()? onTap,
    String? classes,
  }) {
    return PlaceholderImageProps(
      source: source ?? this.source,
      seed: seed ?? this.seed,
      size: size ?? this.size,
      width: width ?? this.width,
      height: height ?? this.height,
      shape: shape ?? this.shape,
      fit: fit ?? this.fit,
      alt: alt ?? this.alt,
      text: text ?? this.text,
      animated: animated ?? this.animated,
      grayscale: grayscale ?? this.grayscale,
      blur: blur ?? this.blur,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      lazy: lazy ?? this.lazy,
      onTap: onTap ?? this.onTap,
      classes: classes ?? this.classes,
    );
  }

  /// Get the resolved width in pixels.
  int get resolvedWidth => width ?? _sizeToPixels(size);

  /// Get the resolved height in pixels.
  int get resolvedHeight => height ?? _sizeToPixels(size);

  static int _sizeToPixels(PlaceholderSize size) {
    return switch (size) {
      PlaceholderSize.xs => 64,
      PlaceholderSize.sm => 128,
      PlaceholderSize.md => 256,
      PlaceholderSize.lg => 512,
      PlaceholderSize.xl => 1024,
    };
  }
}
