import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Interactive view demos (tooltip, popover, hovercard, expander)
class InteractiveViewDemos {
  static List<Component> tooltip() => [
        ArcaneFloating.tooltip(
          textContent: 'Tooltip message',
          child: ArcaneButton.secondary(label: 'Hover me', onPressed: () {}),
        ),
      ];

  static List<Component> popover() => [
        ArcaneFloating.popover(
          trigger: ArcaneButton.secondary(label: 'Open Popover', onPressed: () {}),
          content: ArcaneDiv(
            styles: const ArcaneStyleData(padding: PaddingPreset.sm),
            children: [
              ArcaneText('Popover content'),
            ],
          ),
          position: FloatingPosition.bottom,
        ),
      ];

  static List<Component> hovercard() => [
        ArcaneFloating.hovercard(
          trigger: ArcaneButton.secondary(label: 'Hover me', onPressed: () {}),
          content: ArcaneColumn(
            gapSize: Gap.sm,
            children: [
              ArcaneRow(
                gapSize: Gap.sm,
                children: [
                  ArcaneAvatar(initials: 'JD'),
                  ArcaneColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ArcaneText('John Doe', weight: FontWeight.bold),
                      ArcaneText('Software Engineer', color: TextColor.muted),
                    ],
                  ),
                ],
              ),
            ],
          ),
          position: FloatingPosition.bottom,
        ),
      ];

  static List<Component> kbd() => [
        ArcaneRow(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ArcaneKbd('Cmd'),
            ArcaneText('+'),
            ArcaneKbd('K'),
          ],
        ),
      ];
}
