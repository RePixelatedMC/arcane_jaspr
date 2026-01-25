import 'package:jaspr/jaspr.dart';

/// Mixin for components with tap/navigation actions.
mixin CardActionProps {
  String? get href;
  void Function()? get onTap;
}

/// Mixin for components with icon or image media.
mixin CardMediaProps {
  String? get imageUrl;
  Component? get icon;
}

/// Mixin for components with title/description content.
mixin CardContentProps {
  String get title;
  String? get description;
}

/// Mixin for components with author/attribution info.
mixin CardAuthorProps {
  String get authorName;
  String? get authorTitle;
  String? get avatarUrl;
}
