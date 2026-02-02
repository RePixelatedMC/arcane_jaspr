import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../view/map/map_data.dart';
import '../view/map/map_style.dart';

export '../../core/props/map_section_props.dart';

/// A map section component for displaying locations on an interactive map.
///
/// Includes optional location list panel, tabs for different map types,
/// and customizable tooltips.
class ArcaneMapSection extends StatelessComponent {
  /// Section title.
  final String title;

  /// Optional subtitle/description.
  final String? subtitle;

  /// Location data to display.
  final List<MapLocation> locations;

  /// Region configurations for grouping and coloring.
  final Map<String, MapRegionConfig> regions;

  /// Map style configuration.
  final MapStyle mapStyle;

  /// Whether to show the location list panel.
  final bool showLocationPanel;

  /// Location panel title.
  final String locationPanelTitle;

  /// Whether to show tabs for different map types.
  final bool showMapTabs;

  /// Custom tooltip builder.
  final Component Function(MapLocation)? tooltipBuilder;

  /// Callback when a location is selected.
  final void Function(MapLocation)? onLocationSelect;

  /// Height of the map container.
  final String height;

  const ArcaneMapSection({
    required this.title,
    this.subtitle,
    required this.locations,
    this.regions = const {},
    this.mapStyle = const MapStyle(),
    this.showLocationPanel = true,
    this.locationPanelTitle = 'Server Locations',
    this.showMapTabs = true,
    this.tooltipBuilder,
    this.onLocationSelect,
    this.height = '520px',
    super.key,
  });

  /// Creates a map section for server/datacenter locations with default regions.
  factory ArcaneMapSection.serverLocations({
    required String title,
    String? subtitle,
    required List<MapLocation> locations,
    MapStyle mapStyle = const MapStyle(),
    bool showLocationPanel = true,
    String locationPanelTitle = 'Server Locations',
    bool showMapTabs = true,
    Component Function(MapLocation)? tooltipBuilder,
    void Function(MapLocation)? onLocationSelect,
    String height = '520px',
    Key? key,
  }) {
    return ArcaneMapSection(
      title: title,
      subtitle: subtitle,
      locations: locations,
      regions: const {
        'North America': MapRegionConfig(name: 'North America', color: 'var(--primary)'),
        'Europe': MapRegionConfig(name: 'Europe', color: '#a855f7'),
        'Asia-Pacific': MapRegionConfig(name: 'Asia-Pacific', color: '#f97316'),
        'South America': MapRegionConfig(name: 'South America', color: '#06b6d4'),
      },
      mapStyle: mapStyle,
      showLocationPanel: showLocationPanel,
      locationPanelTitle: locationPanelTitle,
      showMapTabs: showMapTabs,
      tooltipBuilder: tooltipBuilder,
      onLocationSelect: onLocationSelect,
      height: height,
      key: key,
    );
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.mapSection(MapSectionProps(
      title: title,
      subtitle: subtitle,
      locations: locations,
      regions: regions,
      mapStyle: mapStyle,
      showLocationPanel: showLocationPanel,
      locationPanelTitle: locationPanelTitle,
      showMapTabs: showMapTabs,
      tooltipBuilder: tooltipBuilder,
      onLocationSelect: onLocationSelect,
      height: height,
    ));
  }
}
