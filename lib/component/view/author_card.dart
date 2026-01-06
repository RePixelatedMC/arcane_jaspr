import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/author_card_props.dart';

/// An author attribution card with avatar, name, and role.
///
/// Common for testimonials, blog posts, comments, and user profiles.
///
/// ```dart
/// ArcaneAuthorCard(
///   avatarUrl: 'https://example.com/avatar.jpg',
///   name: 'John Doe',
///   role: 'Software Engineer',
/// )
/// ```
class ArcaneAuthorCard extends StatelessComponent {
  /// Avatar image URL
  final String? avatarUrl;

  /// Author name
  final String name;

  /// Role/title/subtitle
  final String? role;

  /// Size variant
  final AuthorCardSize size;

  /// Fallback initials when no avatar (uses first letter of name if not provided)
  final String? initials;

  /// Avatar background color for initials fallback
  final String? avatarBackground;

  /// Name text color
  final String? nameColor;

  /// Role text color
  final String? roleColor;

  const ArcaneAuthorCard({
    this.avatarUrl,
    required this.name,
    this.role,
    this.size = AuthorCardSize.md,
    this.initials,
    this.avatarBackground,
    this.nameColor,
    this.roleColor,
    super.key,
  });

  /// Create a small author card
  const ArcaneAuthorCard.sm({
    this.avatarUrl,
    required this.name,
    this.role,
    this.initials,
    this.avatarBackground,
    this.nameColor,
    this.roleColor,
    super.key,
  }) : size = AuthorCardSize.sm;

  /// Create a large author card
  const ArcaneAuthorCard.lg({
    this.avatarUrl,
    required this.name,
    this.role,
    this.initials,
    this.avatarBackground,
    this.nameColor,
    this.roleColor,
    super.key,
  }) : size = AuthorCardSize.lg;

  @override
  Component build(BuildContext context) {
    return context.renderers.authorCard(AuthorCardProps(
      avatarUrl: avatarUrl,
      name: name,
      role: role,
      size: size,
      initials: initials,
      avatarBackground: avatarBackground,
      nameColor: nameColor,
      roleColor: roleColor,
    ));
  }
}
