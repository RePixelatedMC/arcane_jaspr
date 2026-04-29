library;

import 'dart:convert';

abstract class ArcaneInteraction {
  const ArcaneInteraction();

  String encode();

  ArcaneInteraction then(ArcaneInteraction next) {
    final List<ArcaneInteraction> combined = <ArcaneInteraction>[];
    if (this is _ComposedInteraction) {
      combined.addAll((this as _ComposedInteraction).actions);
    } else {
      combined.add(this);
    }
    if (next is _ComposedInteraction) {
      combined.addAll(next.actions);
    } else {
      combined.add(next);
    }
    return _ComposedInteraction(combined);
  }

  static ArcaneInteraction compose(List<ArcaneInteraction> actions) =>
      _ComposedInteraction(List<ArcaneInteraction>.unmodifiable(actions));

  static const ArcaneInteraction noop = _NoopInteraction();

  static ArcaneInteraction openDialog(String id) =>
      _SurfaceInteraction('dialog', 'open', id);
  static ArcaneInteraction closeDialog([String? id]) =>
      _SurfaceInteraction('dialog', 'close', id);
  static ArcaneInteraction toggleDialog(String id) =>
      _SurfaceInteraction('dialog', 'toggle', id);

  static ArcaneInteraction openSheet(String id) =>
      _SurfaceInteraction('sheet', 'open', id);
  static ArcaneInteraction closeSheet([String? id]) =>
      _SurfaceInteraction('sheet', 'close', id);
  static ArcaneInteraction toggleSheet(String id) =>
      _SurfaceInteraction('sheet', 'toggle', id);

  static ArcaneInteraction openDrawer(String id) =>
      _SurfaceInteraction('drawer', 'open', id);
  static ArcaneInteraction closeDrawer([String? id]) =>
      _SurfaceInteraction('drawer', 'close', id);
  static ArcaneInteraction toggleDrawer(String id) =>
      _SurfaceInteraction('drawer', 'toggle', id);

  static ArcaneInteraction openPopover(String id) =>
      _SurfaceInteraction('popover', 'open', id);
  static ArcaneInteraction closePopover([String? id]) =>
      _SurfaceInteraction('popover', 'close', id);
  static ArcaneInteraction togglePopover(String id) =>
      _SurfaceInteraction('popover', 'toggle', id);

  static ArcaneInteraction openCommand(String id) =>
      _SurfaceInteraction('command', 'open', id);
  static ArcaneInteraction closeCommand([String? id]) =>
      _SurfaceInteraction('command', 'close', id);
  static ArcaneInteraction toggleCommand(String id) =>
      _SurfaceInteraction('command', 'toggle', id);

  static ArcaneInteraction openMenu(String id) =>
      _SurfaceInteraction('menu', 'open', id);
  static ArcaneInteraction closeMenu([String? id]) =>
      _SurfaceInteraction('menu', 'close', id);
  static ArcaneInteraction toggleMenu(String id) =>
      _SurfaceInteraction('menu', 'toggle', id);

  static ArcaneInteraction openContextMenu(String id) =>
      _SurfaceInteraction('context-menu', 'open', id);
  static ArcaneInteraction closeContextMenu([String? id]) =>
      _SurfaceInteraction('context-menu', 'close', id);

  static ArcaneInteraction openTooltip(String id) =>
      _SurfaceInteraction('tooltip', 'open', id);
  static ArcaneInteraction closeTooltip([String? id]) =>
      _SurfaceInteraction('tooltip', 'close', id);

  static ArcaneInteraction openMobileMenu(String id) =>
      _SurfaceInteraction('mobile-menu', 'open', id);
  static ArcaneInteraction closeMobileMenu([String? id]) =>
      _SurfaceInteraction('mobile-menu', 'close', id);
  static ArcaneInteraction toggleMobileMenu(String id) =>
      _SurfaceInteraction('mobile-menu', 'toggle', id);

  static const ArcaneInteraction dismissParent = _DismissParentInteraction();

  static ArcaneInteraction selectValue(String groupId, String value) =>
      _GroupInteraction(groupId, 'set', value);
  static ArcaneInteraction toggleValue(String groupId, String value) =>
      _GroupInteraction(groupId, 'toggle', value);
  static ArcaneInteraction clearValue(String groupId) =>
      _GroupInteraction(groupId, 'clear', null);

  static ArcaneInteraction activateTab(String groupId, String tabId) =>
      _TabInteraction(groupId, tabId);

  static ArcaneInteraction expandPanel(String groupId, String panelId) =>
      _PanelInteraction(groupId, panelId, 'expand');
  static ArcaneInteraction collapsePanel(String groupId, String panelId) =>
      _PanelInteraction(groupId, panelId, 'collapse');
  static ArcaneInteraction togglePanel(String groupId, String panelId) =>
      _PanelInteraction(groupId, panelId, 'toggle');

  static ArcaneInteraction nextStep(String groupId) =>
      _StepInteraction(groupId, 'next');
  static ArcaneInteraction prevStep(String groupId) =>
      _StepInteraction(groupId, 'prev');
  static ArcaneInteraction goToStep(String groupId, int step) =>
      _StepInteraction(groupId, step.toString());

  static ArcaneInteraction goToPage(String groupId, int page) =>
      _PageInteraction(groupId, page.toString());
  static ArcaneInteraction nextPage(String groupId) =>
      _PageInteraction(groupId, 'next');
  static ArcaneInteraction prevPage(String groupId) =>
      _PageInteraction(groupId, 'prev');

  static ArcaneInteraction carouselNext(String groupId) =>
      _CarouselInteraction(groupId, 'next');
  static ArcaneInteraction carouselPrev(String groupId) =>
      _CarouselInteraction(groupId, 'prev');
  static ArcaneInteraction carouselGoTo(String groupId, int index) =>
      _CarouselInteraction(groupId, index.toString());

  static ArcaneInteraction setSlider(String sliderId, double value,
          [String role = 'value']) =>
      _SliderInteraction(sliderId, value, role);

  static ArcaneInteraction cycleNext(String groupId) =>
      _CycleStepInteraction(groupId, 'next');
  static ArcaneInteraction cyclePrev(String groupId) =>
      _CycleStepInteraction(groupId, 'prev');

  static ArcaneInteraction calendarPrev(String calendarId) =>
      _CalendarInteraction('prev', calendarId, null);
  static ArcaneInteraction calendarNext(String calendarId) =>
      _CalendarInteraction('next', calendarId, null);
  static ArcaneInteraction calendarToday(String calendarId) =>
      _CalendarInteraction('today', calendarId, null);
  static ArcaneInteraction calendarSelect(String calendarId, String iso) =>
      _CalendarInteraction('select', calendarId, iso);

  static ArcaneInteraction submitForm(String formId) =>
      _FormInteraction(formId, 'submit');
  static ArcaneInteraction resetForm(String formId) =>
      _FormInteraction(formId, 'reset');
  static ArcaneInteraction setField(String formId, String field, String value) =>
      _FieldInteraction(formId, field, value);

  static ArcaneInteraction copy(String text, {String? feedback}) =>
      _CopyInteraction(text, feedback);

  static ArcaneInteraction navigate(String href, {bool external = false}) =>
      _NavigateInteraction(href, external);
  static const ArcaneInteraction navigateBack = _NavigateBackInteraction();

  static ArcaneInteraction setThemeMode(String mode) =>
      _ThemeInteraction('mode.set', mode);
  static const ArcaneInteraction toggleThemeMode =
      _ThemeInteraction('mode.toggle', null);
  static ArcaneInteraction setStylesheet(String id) =>
      _ThemeInteraction('stylesheet.set', id);
  static ArcaneInteraction setPalette(String stylesheetId, String paletteId) =>
      _ThemeInteraction('palette.set', '$stylesheetId/$paletteId');

  static ArcaneInteraction showToast(
    String message, {
    String variant = 'info',
    int? durationMs,
    String? title,
  }) =>
      _ToastInteraction(message, variant, durationMs, title);

  static ArcaneInteraction dispatch(
    String eventName, {
    Map<String, String> detail = const <String, String>{},
  }) =>
      _DispatchInteraction(eventName, detail);

  static ArcaneInteraction script(String fnName,
          [List<String> args = const <String>[]]) =>
      _ScriptInteraction(fnName, args);
}

String encodeArcaneActions(List<ArcaneInteraction> actions) {
  final List<String> parts = <String>[];
  for (final ArcaneInteraction action in actions) {
    final String encoded = action.encode();
    if (encoded.isEmpty) continue;
    parts.add(encoded);
  }
  return parts.join(';');
}

String encodeArcaneAction(ArcaneInteraction action) =>
    encodeArcaneActions(<ArcaneInteraction>[action]);

String _enc(String? value) {
  if (value == null) return '';
  return Uri.encodeComponent(value);
}

class _NoopInteraction extends ArcaneInteraction {
  const _NoopInteraction();
  @override
  String encode() => 'noop';
}

class _ComposedInteraction extends ArcaneInteraction {
  final List<ArcaneInteraction> actions;
  const _ComposedInteraction(this.actions);

  @override
  String encode() {
    final List<String> parts = <String>[];
    for (final ArcaneInteraction action in actions) {
      final String encoded = action.encode();
      if (encoded.isEmpty) continue;
      parts.add(encoded);
    }
    return parts.join(';');
  }
}

class _SurfaceInteraction extends ArcaneInteraction {
  final String surface;
  final String verb;
  final String? id;
  const _SurfaceInteraction(this.surface, this.verb, this.id);

  @override
  String encode() {
    if (id == null || id!.isEmpty) {
      return 'surface.$verb $surface';
    }
    return 'surface.$verb $surface ${_enc(id)}';
  }
}

class _DismissParentInteraction extends ArcaneInteraction {
  const _DismissParentInteraction();
  @override
  String encode() => 'surface.dismiss';
}

class _GroupInteraction extends ArcaneInteraction {
  final String groupId;
  final String verb;
  final String? value;
  const _GroupInteraction(this.groupId, this.verb, this.value);

  @override
  String encode() {
    if (value == null) {
      return 'value.$verb ${_enc(groupId)}';
    }
    return 'value.$verb ${_enc(groupId)} ${_enc(value)}';
  }
}

class _TabInteraction extends ArcaneInteraction {
  final String groupId;
  final String tabId;
  const _TabInteraction(this.groupId, this.tabId);

  @override
  String encode() => 'tab.activate ${_enc(groupId)} ${_enc(tabId)}';
}

class _PanelInteraction extends ArcaneInteraction {
  final String groupId;
  final String panelId;
  final String verb;
  const _PanelInteraction(this.groupId, this.panelId, this.verb);

  @override
  String encode() =>
      'panel.$verb ${_enc(groupId)} ${_enc(panelId)}';
}

class _StepInteraction extends ArcaneInteraction {
  final String groupId;
  final String target;
  const _StepInteraction(this.groupId, this.target);

  @override
  String encode() => 'step.go ${_enc(groupId)} ${_enc(target)}';
}

class _PageInteraction extends ArcaneInteraction {
  final String groupId;
  final String target;
  const _PageInteraction(this.groupId, this.target);

  @override
  String encode() => 'page.go ${_enc(groupId)} ${_enc(target)}';
}

class _CarouselInteraction extends ArcaneInteraction {
  final String groupId;
  final String target;
  const _CarouselInteraction(this.groupId, this.target);

  @override
  String encode() => 'carousel.go ${_enc(groupId)} ${_enc(target)}';
}

class _SliderInteraction extends ArcaneInteraction {
  final String sliderId;
  final double value;
  final String role;
  const _SliderInteraction(this.sliderId, this.value, this.role);

  @override
  String encode() =>
      'slider.set ${_enc(sliderId)} ${_enc(value.toString())} ${_enc(role)}';
}

class _CycleStepInteraction extends ArcaneInteraction {
  final String groupId;
  final String direction;
  const _CycleStepInteraction(this.groupId, this.direction);

  @override
  String encode() => 'cycle.$direction ${_enc(groupId)}';
}

class _CalendarInteraction extends ArcaneInteraction {
  final String verb;
  final String calendarId;
  final String? value;
  const _CalendarInteraction(this.verb, this.calendarId, this.value);

  @override
  String encode() {
    if (value == null) return 'calendar.$verb ${_enc(calendarId)}';
    return 'calendar.$verb ${_enc(calendarId)} ${_enc(value)}';
  }
}

class _FormInteraction extends ArcaneInteraction {
  final String formId;
  final String verb;
  const _FormInteraction(this.formId, this.verb);

  @override
  String encode() => 'form.$verb ${_enc(formId)}';
}

class _FieldInteraction extends ArcaneInteraction {
  final String formId;
  final String field;
  final String value;
  const _FieldInteraction(this.formId, this.field, this.value);

  @override
  String encode() =>
      'field.set ${_enc(formId)} ${_enc(field)} ${_enc(value)}';
}

class _CopyInteraction extends ArcaneInteraction {
  final String text;
  final String? feedback;
  const _CopyInteraction(this.text, this.feedback);

  @override
  String encode() {
    if (feedback == null || feedback!.isEmpty) {
      return 'copy ${_enc(text)}';
    }
    return 'copy ${_enc(text)} ${_enc(feedback)}';
  }
}

class _NavigateInteraction extends ArcaneInteraction {
  final String href;
  final bool external;
  const _NavigateInteraction(this.href, this.external);

  @override
  String encode() {
    if (external) {
      return 'nav.external ${_enc(href)}';
    }
    return 'nav.go ${_enc(href)}';
  }
}

class _NavigateBackInteraction extends ArcaneInteraction {
  const _NavigateBackInteraction();
  @override
  String encode() => 'nav.back';
}

class _ThemeInteraction extends ArcaneInteraction {
  final String verb;
  final String? arg;
  const _ThemeInteraction(this.verb, this.arg);

  @override
  String encode() {
    if (arg == null) return 'theme.$verb';
    return 'theme.$verb ${_enc(arg)}';
  }
}

class _ToastInteraction extends ArcaneInteraction {
  final String message;
  final String variant;
  final int? durationMs;
  final String? title;
  const _ToastInteraction(this.message, this.variant, this.durationMs, this.title);

  @override
  String encode() {
    final Map<String, dynamic> payload = <String, dynamic>{
      'message': message,
      'variant': variant,
    };
    if (durationMs != null) payload['duration'] = durationMs;
    if (title != null) payload['title'] = title;
    return 'toast.show ${_enc(jsonEncode(payload))}';
  }
}

class _DispatchInteraction extends ArcaneInteraction {
  final String eventName;
  final Map<String, String> detail;
  const _DispatchInteraction(this.eventName, this.detail);

  @override
  String encode() {
    if (detail.isEmpty) {
      return 'event.dispatch ${_enc(eventName)}';
    }
    return 'event.dispatch ${_enc(eventName)} ${_enc(jsonEncode(detail))}';
  }
}

class _ScriptInteraction extends ArcaneInteraction {
  final String fnName;
  final List<String> args;
  const _ScriptInteraction(this.fnName, this.args);

  @override
  String encode() {
    final List<String> parts = <String>['script.run', _enc(fnName)];
    for (final String arg in args) {
      parts.add(_enc(arg));
    }
    return parts.join(' ');
  }
}
