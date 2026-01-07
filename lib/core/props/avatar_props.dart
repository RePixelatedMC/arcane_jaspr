enum AvatarSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

enum AvatarShape {
  circle,
  rounded,
  square,
}

/// Avatar component properties.
class AvatarProps {
  final String? imageUrl;
  final String? initials;
  final AvatarSize size;
  final AvatarShape shape;
  final String? borderColor;
  final bool showStatus;
  final String? statusColor;
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
