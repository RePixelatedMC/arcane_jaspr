/// Size variants for author card
enum AuthorCardSize {
  /// Small: 32px avatar
  sm,

  /// Medium: 40px avatar (default)
  md,

  /// Large: 48px avatar
  lg,
}

/// Props for author card component.
class AuthorCardProps {
  /// Avatar image URL
  final String? avatarUrl;

  /// Author name
  final String name;

  /// Role/title/subtitle
  final String? role;

  /// Size variant
  final AuthorCardSize size;

  /// Fallback initials when no avatar
  final String? initials;

  /// Avatar background color for initials fallback
  final String? avatarBackground;

  /// Name text color
  final String? nameColor;

  /// Role text color
  final String? roleColor;

  const AuthorCardProps({
    this.avatarUrl,
    required this.name,
    this.role,
    this.size = AuthorCardSize.md,
    this.initials,
    this.avatarBackground,
    this.nameColor,
    this.roleColor,
  });
}
