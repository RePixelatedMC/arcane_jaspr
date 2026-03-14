import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;
import 'package:jaspr/dom.dart' as dom;

import 'scripts/slider_scripts.dart';
import 'scripts/input/input_scripts.dart';
import 'scripts/button/button_scripts.dart';
import 'scripts/navigation/navigation_scripts.dart';
import 'scripts/dialog/dialog_scripts.dart';
import 'scripts/view/view_scripts.dart';
import 'scripts/theme/rainbow_scripts.dart';
import 'scripts/carousel/carousel_scripts.dart';

/// Fallback JavaScript for Arcane components on static sites.
class ArcaneScripts {
  ArcaneScripts._();

  static String get all =>
      '''
(function() {
  'use strict';

  // Wait for DOM to be ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindAllComponents);
  } else {
    // Small delay to ensure DOM is fully rendered
    setTimeout(bindAllComponents, 100);
  }

  function bindAllComponents() {
    console.log('[Arcane] Initializing component interactivity...');

    // Sliders
    bindSliders();

    // Inputs
    bindColorInputs();
    bindCheckboxes();
    bindToggleSwitches();
    bindRadioButtons();
    bindNumberInputs();
    bindTagInputs();
    bindFileUploads();
    bindMutableText();
    bindOtpInputs();
    bindComboboxes();
    bindCalendars();
    bindDatePickers();
    bindTimePickers();
    bindFormattedInputs();

    // Buttons
    bindToggleButtonGroups();
    bindCycleButtons();
    bindToggleButtons();
    bindButtons();
    bindCopyButtons();

    // Navigation
    bindTabs();
    bindExpandersAccordions();
    bindDropdowns();
    bindSelectors();
    bindTreeViews();
    bindPagination();
    bindChips();
    bindBackToTop();
    bindContextMenus();
    bindMenubars();
    bindResizables();
    bindCommandPalettes();
    bindSteps();
    bindTimelines();
    bindDotIndicators();
    bindTrackers();
    bindDocsToc();

    // Dialogs & Overlays
    bindToasts();
    bindPopovers();
    bindTooltips();
    bindDialogs();
    bindDrawers();
    bindMobileMenus();
    bindSheets();
    bindEmailDialogs();
    bindTimeDialogs();
    bindItemPickers();
    bindChatScreens();

    // Views
    bindMapDebugMode();
    bindMapPinTooltips();
    bindLocationListHover();

    // Theme
    bindRainbowTheme();

    // Carousels
    bindCarousels();
  }

  ${SliderScripts.code}
  ${InputScripts.code}
  ${ButtonScripts.code}
  ${NavigationScripts.code}
  ${DialogScripts.code}
  ${ViewScripts.code}
  ${RainbowScripts.code}
  ${CarouselScripts.code}
})();
''';
}

/// Widget that injects Arcane fallback scripts into the page.
class ArcaneScriptsComponent extends StatelessWidget {
  const ArcaneScriptsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return dom.script(content: ArcaneScripts.all);
  }
}
