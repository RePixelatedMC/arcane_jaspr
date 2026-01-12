import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/placeholder_image_props.dart';

/// A placeholder image component that abstracts various placeholder services.
///
/// Supports multiple sources:
/// - [PlaceholderSource.cat] - Random cat images from cataas.com
/// - [PlaceholderSource.picsum] - Random photos from picsum.photos
/// - [PlaceholderSource.placeholder] - Solid color placeholders
///
/// Example usage:
/// ```dart
/// // Random cat with seed for consistency
/// ArcanePlaceholderImage(seed: 'my-cat')
///
/// // Animated cat GIF
/// ArcanePlaceholderImage.cat(seed: 'animated', animated: true)
///
/// // Cat with text overlay
/// ArcanePlaceholderImage.catSays('Hello!', seed: 'talking')
///
/// // Random photo
/// ArcanePlaceholderImage.photo(seed: '42', grayscale: true)
///
/// // Solid color placeholder
/// ArcanePlaceholderImage.solid(backgroundColor: '#3b82f6')
/// ```
class ArcanePlaceholderImage extends StatelessComponent {
  final PlaceholderImageProps _props;

  /// Create a placeholder image with custom options.
  ArcanePlaceholderImage({
    PlaceholderSource source = PlaceholderSource.cat,
    String? seed,
    PlaceholderSize size = PlaceholderSize.md,
    int? width,
    int? height,
    PlaceholderShape shape = PlaceholderShape.rounded,
    PlaceholderFit fit = PlaceholderFit.cover,
    String? alt,
    String? text,
    bool animated = false,
    bool grayscale = false,
    int? blur,
    String? backgroundColor,
    String? textColor,
    bool lazy = true,
    void Function()? onTap,
    String? classes,
    super.key,
  }) : _props = PlaceholderImageProps(
          source: source,
          seed: seed,
          size: size,
          width: width,
          height: height,
          shape: shape,
          fit: fit,
          alt: alt,
          text: text,
          animated: animated,
          grayscale: grayscale,
          blur: blur,
          backgroundColor: backgroundColor,
          textColor: textColor,
          lazy: lazy,
          onTap: onTap,
          classes: classes,
        );

  ArcanePlaceholderImage._fromProps(this._props, {super.key});

  /// Create a random cat image.
  factory ArcanePlaceholderImage.cat({
    String? seed,
    PlaceholderSize size = PlaceholderSize.md,
    int? width,
    int? height,
    PlaceholderShape shape = PlaceholderShape.rounded,
    PlaceholderFit fit = PlaceholderFit.cover,
    String? alt,
    bool animated = false,
    bool lazy = true,
    void Function()? onTap,
    String? classes,
    Key? key,
  }) {
    return ArcanePlaceholderImage._fromProps(
      PlaceholderImageProps(
        source: PlaceholderSource.cat,
        seed: seed,
        size: size,
        width: width,
        height: height,
        shape: shape,
        fit: fit,
        alt: alt,
        animated: animated,
        lazy: lazy,
        onTap: onTap,
        classes: classes,
      ),
      key: key,
    );
  }

  /// Create a cat image with text overlay.
  factory ArcanePlaceholderImage.catSays(
    String text, {
    String? seed,
    PlaceholderSize size = PlaceholderSize.md,
    int? width,
    int? height,
    PlaceholderShape shape = PlaceholderShape.rounded,
    PlaceholderFit fit = PlaceholderFit.cover,
    String? alt,
    bool animated = false,
    bool lazy = true,
    void Function()? onTap,
    String? classes,
    Key? key,
  }) {
    return ArcanePlaceholderImage._fromProps(
      PlaceholderImageProps(
        source: PlaceholderSource.cat,
        seed: seed,
        size: size,
        width: width,
        height: height,
        shape: shape,
        fit: fit,
        alt: alt,
        text: text,
        animated: animated,
        lazy: lazy,
        onTap: onTap,
        classes: classes,
      ),
      key: key,
    );
  }

  /// Create a random photo from picsum.
  factory ArcanePlaceholderImage.photo({
    String? seed,
    PlaceholderSize size = PlaceholderSize.md,
    int? width,
    int? height,
    PlaceholderShape shape = PlaceholderShape.rounded,
    PlaceholderFit fit = PlaceholderFit.cover,
    String? alt,
    bool grayscale = false,
    int? blur,
    bool lazy = true,
    void Function()? onTap,
    String? classes,
    Key? key,
  }) {
    return ArcanePlaceholderImage._fromProps(
      PlaceholderImageProps(
        source: PlaceholderSource.picsum,
        seed: seed,
        size: size,
        width: width,
        height: height,
        shape: shape,
        fit: fit,
        alt: alt,
        grayscale: grayscale,
        blur: blur,
        lazy: lazy,
        onTap: onTap,
        classes: classes,
      ),
      key: key,
    );
  }

  /// Create a solid color placeholder.
  factory ArcanePlaceholderImage.solid({
    String? backgroundColor,
    String? textColor,
    String? text,
    PlaceholderSize size = PlaceholderSize.md,
    int? width,
    int? height,
    PlaceholderShape shape = PlaceholderShape.rounded,
    String? alt,
    bool lazy = true,
    void Function()? onTap,
    String? classes,
    Key? key,
  }) {
    return ArcanePlaceholderImage._fromProps(
      PlaceholderImageProps(
        source: PlaceholderSource.placeholder,
        size: size,
        width: width,
        height: height,
        shape: shape,
        fit: PlaceholderFit.cover,
        alt: alt,
        text: text,
        backgroundColor: backgroundColor,
        textColor: textColor,
        lazy: lazy,
        onTap: onTap,
        classes: classes,
      ),
      key: key,
    );
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.placeholderImage(_props);
  }
}
