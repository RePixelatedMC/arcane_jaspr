import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/placeholder_image_props.dart';

/// Codex Placeholder Image renderer.
///
/// Implements the Codex design language:
/// - Larger default sizes (1.25x)
/// - Accent-colored border
/// - Subtle glow effect on hover
class CodexPlaceholderImage extends StatelessComponent {
  final PlaceholderImageProps props;

  const CodexPlaceholderImage(this.props, {super.key});

  /// Codex sizes are 1.25x larger than base.
  int _codexSize(int baseSize) => (baseSize * 1.25).round();

  String get _src {
    final width = _codexSize(props.resolvedWidth);
    final height = _codexSize(props.resolvedHeight);

    return switch (props.source) {
      PlaceholderSource.cat => _buildCatUrl(width, height),
      PlaceholderSource.picsum => _buildPicsumUrl(width, height),
      PlaceholderSource.placeholder => _buildPlaceholderUrl(width, height),
    };
  }

  String _buildCatUrl(int width, int height) {
    final buffer = StringBuffer('https://cataas.com/cat');

    if (props.animated) {
      buffer.write('/gif');
    }

    if (props.text != null && props.text!.isNotEmpty) {
      buffer.write('/says/${Uri.encodeComponent(props.text!)}');
    }

    final params = <String>[];

    if (props.seed != null && props.seed!.isNotEmpty) {
      params.add(props.seed!);
    }

    if (width != 320) {
      params.add('width=$width');
    }

    if (height != 320) {
      params.add('height=$height');
    }

    if (params.isNotEmpty) {
      buffer.write('?${params.join('&')}');
    }

    return buffer.toString();
  }

  String _buildPicsumUrl(int width, int height) {
    final buffer = StringBuffer('https://picsum.photos');

    if (props.seed != null && props.seed!.isNotEmpty) {
      buffer.write('/seed/${Uri.encodeComponent(props.seed!)}');
    }

    buffer.write('/$width/$height');

    final params = <String>[];

    if (props.grayscale) {
      params.add('grayscale');
    }

    if (props.blur != null && props.blur! > 0) {
      params.add('blur=${props.blur!.clamp(1, 10)}');
    }

    if (params.isNotEmpty) {
      buffer.write('?${params.join('&')}');
    }

    return buffer.toString();
  }

  String _buildPlaceholderUrl(int width, int height) {
    final bgColor =
        (props.backgroundColor ?? '#1e1e2e').replaceAll('#', '').toUpperCase();
    final textColor =
        (props.textColor ?? '#f8f8f2').replaceAll('#', '').toUpperCase();
    final text = props.text ?? '${width}x$height';

    return 'https://via.placeholder.com/${width}x$height/$bgColor/$textColor?text=${Uri.encodeComponent(text)}';
  }

  @override
  Component build(BuildContext context) {
    final width = _codexSize(props.resolvedWidth);
    final height = _codexSize(props.resolvedHeight);

    // Codex shape border radius (larger than ShadCN)
    final borderRadius = switch (props.shape) {
      PlaceholderShape.circle => '9999px',
      PlaceholderShape.rounded => 'var(--radius, 0.75rem)',
      PlaceholderShape.square => 'var(--radius-sm, 0.25rem)',
    };

    // Object fit
    final objectFit = switch (props.fit) {
      PlaceholderFit.cover => 'cover',
      PlaceholderFit.contain => 'contain',
      PlaceholderFit.fill => 'fill',
    };

    // Container styles with Codex design language
    final containerStyles = <String, String>{
      'display': 'inline-block',
      'overflow': 'hidden',
      'border-radius': borderRadius,
      'background-color': 'var(--muted)',
      // Codex: accent border
      'border': '2px solid var(--border)',
      'box-sizing': 'border-box',
      'transition': 'all var(--transition, 150ms ease)',
      if (props.shape == PlaceholderShape.circle) 'aspect-ratio': '1',
      if (props.onTap != null) 'cursor': 'pointer',
    };

    // Image styles
    final imageStyles = <String, String>{
      'display': 'block',
      'width': '100%',
      'height': '100%',
      'object-fit': objectFit,
      if (props.grayscale && props.source != PlaceholderSource.picsum)
        'filter': 'grayscale(100%)',
    };

    return dom.div(
      classes: [
        'codex-placeholder-image',
        if (props.classes != null) props.classes!,
      ].join(' '),
      styles: dom.Styles(raw: containerStyles),
      events: props.onTap != null
          ? {'click': (event) => props.onTap!()}
          : null,
      [
        dom.img(
          src: _src,
          alt: props.alt ?? 'Placeholder image',
          styles: dom.Styles(raw: imageStyles),
          attributes: {
            'width': '$width',
            'height': '$height',
            if (props.lazy) 'loading': 'lazy',
            'decoding': 'async',
          },
        ),
      ],
    );
  }
}
