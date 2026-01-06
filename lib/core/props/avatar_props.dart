/// Avatar size variants.
enum AvatarSize {
  /// Extra small (24px)
  xs,

  /// Small (32px)
  sm,

  /// Medium (40px) - ShadCN default
  md,

  /// Large (56px)
  lg,

  /// Extra large (80px)
  xl,
}

/// Avatar shape variants.
enum AvatarShape {
  /// Circular avatar (default)
  circle,

  /// Rounded square avatar
  rounded,

  /// Square avatar
  square,
}

/// Properties for avatar components.
class AvatarProps {
  /// Image URL for the avatar
  final String? imageUrl;

  /// Fallback initials when no image
  final String? initials;

  /// Avatar size
  final AvatarSize size;

  /// Avatar shape
  final AvatarShape shape;

  /// Optional border color
  final String? borderColor;

  /// Whether to show status indicator
  final bool showStatus;

  /// Status indicator color
  final String? statusColor;

  /// Click handler
  final void Function()? onTap;

  const AvatarProps({
    this.imageUrl,
    this.initials,
    this.size = AvatarSize.md,
    this.shape = AvatarShape.circle,
    this.borderColor,
    this.showStatus = false,
    this.statusColor,
    this.onTap,
  });

  /// Create a copy with modified properties
  AvatarProps copyWith({
    String? imageUrl,
    String? initials,
    AvatarSize? size,
    AvatarShape? shape,
    String? borderColor,
    bool? showStatus,
    String? statusColor,
    void Function()? onTap,
  }) {
    return AvatarProps(
      imageUrl: imageUrl ?? this.imageUrl,
      initials: initials ?? this.initials,
      size: size ?? this.size,
      shape: shape ?? this.shape,
      borderColor: borderColor ?? this.borderColor,
      showStatus: showStatus ?? this.showStatus,
      statusColor: statusColor ?? this.statusColor,
      onTap: onTap ?? this.onTap,
    );
  }
}
