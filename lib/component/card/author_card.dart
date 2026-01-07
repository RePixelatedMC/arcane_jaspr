import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/author_card_props.dart';

/// Author attribution card with avatar, name, and role.
class ArcaneAuthorCard extends StatelessComponent {
  final String? avatarUrl;
  final String name;
  final String? role;
  final AuthorCardSize size;
  final String? initials;
  final String? avatarBackground;
  final String? nameColor;
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
