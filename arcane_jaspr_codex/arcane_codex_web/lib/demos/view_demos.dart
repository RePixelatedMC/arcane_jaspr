// Re-export all view demos from split files
export 'view/basic_view_demos.dart';
export 'view/data_view_demos.dart';
export 'view/card_view_demos.dart';
export 'view/nav_view_demos.dart';
export 'view/interactive_view_demos.dart';
export 'view/icon_view_demos.dart';
export 'view/visual_view_demos.dart';
export 'view/link_map_demos.dart';

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'view/basic_view_demos.dart';
import 'view/data_view_demos.dart';
import 'view/card_view_demos.dart';
import 'view/nav_view_demos.dart';
import 'view/interactive_view_demos.dart';
import 'view/icon_view_demos.dart';
import 'view/visual_view_demos.dart';
import 'view/link_map_demos.dart';

/// Aggregator class for all view demos - delegates to split files
class ViewDemos {
  // Basic view demos
  static List<Component> avatar() => BasicViewDemos.avatar();
  static List<Component> badge() => BasicViewDemos.badge();
  static List<Component> chip() => BasicViewDemos.chip();
  static List<Component> divider() => BasicViewDemos.divider();
  static List<Component> loader() => BasicViewDemos.loader();
  static List<Component> skeleton() => BasicViewDemos.skeleton();
  static List<Component> emptyState() => BasicViewDemos.emptyState();
  static List<Component> avatarGroup() => BasicViewDemos.avatarGroup();

  // Data view demos
  static List<Component> progressBar() => DataViewDemos.progressBar();
  static List<Component> dataTable() => DataViewDemos.dataTable();
  static List<Component> toast() => DataViewDemos.toast();
  static List<Component> callout() => DataViewDemos.callout();
  static List<Component> meter() => DataViewDemos.meter();
  static List<Component> alert() => DataViewDemos.alert();
  static List<Component> statDisplay() => DataViewDemos.statDisplay();
  static List<Component> tracker() => DataViewDemos.tracker();

  // Card view demos
  static List<Component> featureCard() => CardViewDemos.featureCard();
  static List<Component> authorCard() => CardViewDemos.authorCard();
  static List<Component> codeWindow() => CardViewDemos.codeWindow();
  static List<Component> checkList() => CardViewDemos.checkList();
  static List<Component> surfaceCard() => CardViewDemos.surfaceCard();
  static List<Component> flexiCards() => CardViewDemos.flexiCards();
  static List<Component> slotCounter() => CardViewDemos.slotCounter();

  // Nav view demos
  static List<Component> accordion() => NavViewDemos.accordion();
  static List<Component> inlineTabs() => NavViewDemos.inlineTabs();
  static List<Component> treeView() => NavViewDemos.treeView();
  static List<Component> dotIndicator() => NavViewDemos.dotIndicator();
  static List<Component> stepIndicator() => NavViewDemos.stepIndicator();
  static List<Component> switcher() => NavViewDemos.switcher();

  // Interactive view demos
  static List<Component> tooltip() => InteractiveViewDemos.tooltip();
  static List<Component> popover() => InteractiveViewDemos.popover();
  static List<Component> hovercard() => InteractiveViewDemos.hovercard();
  static List<Component> kbd() => InteractiveViewDemos.kbd();

  // Icon view demos
  static List<Component> icon() => IconViewDemos.icon();
  static List<Component> svg() => IconViewDemos.svg();

  // Visual view demos
  static List<Component> fadeEdge() => VisualViewDemos.fadeEdge();
  static List<Component> marquee() => VisualViewDemos.marquee();

  // Link and map view demos
  static List<Component> arrowLink() => LinkMapDemos.arrowLink();
  static List<Component> featureShowcase() => LinkMapDemos.featureShowcase();
  static List<Component> worldMap() => LinkMapDemos.worldMap();
  static List<Component> usaMap() => LinkMapDemos.usaMap();
}
