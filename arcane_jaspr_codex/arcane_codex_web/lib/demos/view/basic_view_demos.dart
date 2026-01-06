import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Basic view component demos (avatar, badge, chip, divider, loader, skeleton, empty state)
class BasicViewDemos {
  static List<Component> avatar() => [
        ArcaneAvatar(initials: 'JD'),
        ArcaneAvatar(initials: 'AB', size: AvatarSize.lg),
      ];

  static List<Component> badge() => [
        ArcaneBadge('Default'),
        ArcaneBadge('Success', variant: BadgeVariant.success),
        ArcaneBadge('Warning', variant: BadgeVariant.warning),
        ArcaneBadge('Error', variant: BadgeVariant.error),
      ];

  static List<Component> chip() => [
        ArcaneChip(label: 'Chip 1'),
        ArcaneChip(label: 'Chip 2'),
      ];

  static List<Component> divider() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneDivider(),
          ],
        ),
      ];

  static List<Component> loader() => [
        ArcaneLoader(),
        ArcaneLoader(size: '48px'),
      ];

  static List<Component> skeleton() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneSkeleton(height: '20px'),
            ArcaneDiv(
              styles: const ArcaneStyleData(margin: MarginPreset.topSm),
              children: [ArcaneSkeleton(height: '14px', width: '150px')],
            ),
          ],
        ),
      ];

  static List<Component> emptyState() => [
        ArcaneEmptyState(
          title: 'No items',
          message: 'Get started by adding your first item.',
        ),
      ];

  static List<Component> avatarGroup() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Avatar Group', weight: FontWeight.w600),
            ArcaneAvatarGroup.toRight(
              avatars: [
                ArcaneAvatar(initials: 'AB'),
                ArcaneAvatar(initials: 'CD'),
                ArcaneAvatar(initials: 'EF'),
                ArcaneAvatar(initials: 'GH'),
                ArcaneAvatar(initials: 'IJ'),
                ArcaneAvatar(initials: 'KL'),
              ],
              maxVisible: 4,
            ),
            ArcaneText('With Avatar Badge', weight: FontWeight.w600),
            ArcaneRow(
              gapSize: Gap.lg,
              children: [
                ArcaneDiv(
                  styles: const ArcaneStyleData(position: Position.relative),
                  children: [
                    ArcaneAvatar(initials: 'JD'),
                    ArcaneAvatarBadge.online(),
                  ],
                ),
                ArcaneDiv(
                  styles: const ArcaneStyleData(position: Position.relative),
                  children: [
                    ArcaneAvatar(initials: 'AB'),
                    ArcaneAvatarBadge.busy(),
                  ],
                ),
                ArcaneDiv(
                  styles: const ArcaneStyleData(position: Position.relative),
                  children: [
                    ArcaneAvatar(initials: 'CD'),
                    ArcaneAvatarBadge.away(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}
