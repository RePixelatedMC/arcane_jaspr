/// Button interactivity scripts barrel file.
///
/// Aggregates all button-related scripts for use in static sites.
library;

import 'button_feedback_scripts.dart';
import 'copy_button_scripts.dart';
import 'cycle_button_scripts.dart';
import 'toggle_button_group_scripts.dart';
import 'toggle_button_scripts.dart';

export 'button_feedback_scripts.dart';
export 'copy_button_scripts.dart';
export 'cycle_button_scripts.dart';
export 'toggle_button_group_scripts.dart';
export 'toggle_button_scripts.dart';

/// Combined button scripts.
class ButtonScripts {
  ButtonScripts._();

  static String get code => '''
${ToggleButtonGroupScripts.code}
${CycleButtonScripts.code}
${ToggleButtonScripts.code}
${ButtonFeedbackScripts.code}
${CopyButtonScripts.code}
''';
}
