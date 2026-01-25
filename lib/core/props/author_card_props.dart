import 'package:jaspr/jaspr.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize;

/// Author card component properties.
class AuthorCardProps {
  final String? avatarUrl;
  final String name;
  final String? role;
  final ComponentSize size;
  final String? initials;
  final String? avatarBackground;
  final String? nameColor;
  final String? roleColor;

  const AuthorCardProps({
    this.avatarUrl,
    required this.name,
    this.role,
    this.size = ComponentSize.md,
    this.initials,
    this.avatarBackground,
    this.nameColor,
    this.roleColor,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for author card components.
mixin AuthorCardRendererContract {
  Component authorCard(AuthorCardProps props);
}
