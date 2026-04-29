library;

const String runtimeFormJs = r'''
function formRoot(formId) {
  return document.querySelector('[data-arcane-form="' + cssEscape(formId) + '"]');
}

function fieldEls(formId, fieldName) {
  return document.querySelectorAll(
    '[data-arcane-form="' + cssEscape(formId) +
    '"][data-arcane-field="' + cssEscape(fieldName) + '"]'
  );
}

function fieldValue(formId, fieldName) {
  const els = fieldEls(formId, fieldName);
  if (!els.length) return null;
  const el = els[0];
  if (el.tagName === 'INPUT') {
    if (el.type === 'checkbox') return el.checked;
    if (el.type === 'radio') {
      for (let i = 0; i < els.length; i++) if (els[i].checked) return els[i].value;
      return null;
    }
    return el.value;
  }
  if (el.tagName === 'SELECT' || el.tagName === 'TEXTAREA') return el.value;
  return el.getAttribute('data-arcane-field-value') || el.textContent;
}

function setFieldValue(formId, fieldName, value) {
  const els = fieldEls(formId, fieldName);
  for (let i = 0; i < els.length; i++) {
    const el = els[i];
    if (el.tagName === 'INPUT' && el.type === 'checkbox') {
      el.checked = !!value;
    } else if (el.tagName === 'INPUT' && el.type === 'radio') {
      el.checked = el.value === value;
    } else if (el.tagName === 'INPUT' || el.tagName === 'SELECT' ||
      el.tagName === 'TEXTAREA') {
      el.value = value;
    } else {
      el.setAttribute('data-arcane-field-value', value);
    }
  }
  const root = formRoot(formId);
  if (root) {
    fireEvent(root, 'arcane:field-change', {
      formId: formId, field: fieldName, value: value
    });
  }
}

function collectForm(formId) {
  const root = formRoot(formId);
  if (!root) return null;
  const out = {};
  const fields = root.querySelectorAll('[data-arcane-field]');
  const seen = {};
  for (let i = 0; i < fields.length; i++) {
    const name = fields[i].getAttribute('data-arcane-field');
    if (seen[name]) continue;
    seen[name] = true;
    out[name] = fieldValue(formId, name);
  }
  return out;
}

function validateField(formId, fieldName) {
  const els = fieldEls(formId, fieldName);
  if (!els.length) return { ok: true };
  const el = els[0];
  const validate = el.getAttribute('data-arcane-field-validate') || '';
  const required = el.getAttribute('data-arcane-field-required') === 'true';
  const value = fieldValue(formId, fieldName);
  const errors = [];

  if (required) {
    if (value == null || value === '' || value === false) {
      errors.push('required');
    }
  }
  if (value && validate) {
    const rules = validate.split(/\s+/);
    for (let i = 0; i < rules.length; i++) {
      const r = rules[i];
      if (r === 'email') {
        if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(value)) errors.push('email');
      } else if (r === 'url') {
        try { new URL(value); } catch (e) { errors.push('url'); }
      } else if (r.indexOf('min:') === 0) {
        const min = parseInt(r.substring(4), 10);
        if (typeof value === 'string' && value.length < min) errors.push('min');
      } else if (r.indexOf('max:') === 0) {
        const max = parseInt(r.substring(4), 10);
        if (typeof value === 'string' && value.length > max) errors.push('max');
      } else if (r.indexOf('pattern:') === 0) {
        try {
          const re = new RegExp(r.substring(8));
          if (!re.test(value)) errors.push('pattern');
        } catch (e) {}
      }
    }
  }

  for (let i = 0; i < els.length; i++) {
    if (errors.length) {
      els[i].setAttribute('data-arcane-field-invalid', 'true');
      els[i].setAttribute('aria-invalid', 'true');
    } else {
      els[i].removeAttribute('data-arcane-field-invalid');
      els[i].setAttribute('aria-invalid', 'false');
    }
  }
  const errorEl = document.querySelector(
    '[data-arcane-form="' + cssEscape(formId) +
    '"][data-arcane-field-error="' + cssEscape(fieldName) + '"]'
  );
  if (errorEl) {
    errorEl.textContent = errors.length ? errorEl.getAttribute('data-arcane-error-' + errors[0]) || errors[0] : '';
    if (errors.length) errorEl.removeAttribute('hidden');
    else errorEl.setAttribute('hidden', '');
  }
  return { ok: errors.length === 0, errors: errors };
}

function validateForm(formId) {
  const root = formRoot(formId);
  if (!root) return { ok: true };
  const fields = root.querySelectorAll('[data-arcane-field]');
  let allOk = true;
  const seen = {};
  for (let i = 0; i < fields.length; i++) {
    const name = fields[i].getAttribute('data-arcane-field');
    if (seen[name]) continue;
    seen[name] = true;
    const result = validateField(formId, name);
    if (!result.ok) allOk = false;
  }
  return { ok: allOk };
}

function submitForm(formId) {
  const root = formRoot(formId);
  if (!root) return;
  const validation = validateForm(formId);
  if (!validation.ok) {
    fireEvent(root, 'arcane:form-invalid', { formId: formId });
    return;
  }
  const data = collectForm(formId);
  fireEvent(root, 'arcane:form-submit', { formId: formId, data: data });
  if (root.getAttribute('data-arcane-form-reset-on-submit') === 'true') {
    resetForm(formId);
  }
}

function resetForm(formId) {
  const root = formRoot(formId);
  if (!root) return;
  if (root.tagName === 'FORM') root.reset();
  const fields = root.querySelectorAll('[data-arcane-field]');
  for (let i = 0; i < fields.length; i++) {
    const el = fields[i];
    if (el.tagName === 'INPUT') {
      if (el.type === 'checkbox' || el.type === 'radio') el.checked = el.defaultChecked;
      else el.value = el.defaultValue;
    } else if (el.tagName === 'SELECT') {
      for (let j = 0; j < el.options.length; j++) el.options[j].selected = el.options[j].defaultSelected;
    } else if (el.tagName === 'TEXTAREA') {
      el.value = el.defaultValue;
    }
    el.removeAttribute('data-arcane-field-invalid');
    el.setAttribute('aria-invalid', 'false');
  }
  fireEvent(root, 'arcane:form-reset', { formId: formId });
}

ARCANE.forms = {
  submit: submitForm,
  reset: resetForm,
  validate: validateForm,
  setField: setFieldValue,
  fieldValue: fieldValue,
  collect: collectForm
};
''';

const String runtimeThemeJs = r'''
function setThemeMode(mode) {
  document.documentElement.setAttribute('data-arcane-theme', mode);
  document.documentElement.classList.remove('light', 'dark');
  if (mode === 'dark' || mode === 'light') {
    document.documentElement.classList.add(mode);
  }
  try { localStorage.setItem('arcane.theme.mode', mode); } catch (e) {}
  fireEvent(document, 'arcane:theme-change', { mode: mode });
}

function toggleThemeMode() {
  const cur = document.documentElement.getAttribute('data-arcane-theme') ||
    (document.documentElement.classList.contains('dark') ? 'dark' : 'light');
  setThemeMode(cur === 'dark' ? 'light' : 'dark');
}

function setStylesheet(id) {
  document.documentElement.setAttribute('data-arcane-stylesheet', id);
  try { localStorage.setItem('arcane.theme.stylesheet', id); } catch (e) {}
  fireEvent(document, 'arcane:stylesheet-change', { id: id });
}

function setPalette(stylesheetId, paletteId) {
  document.documentElement.setAttribute('data-arcane-stylesheet', stylesheetId);
  document.documentElement.setAttribute('data-arcane-palette', paletteId);
  try {
    localStorage.setItem('arcane.theme.stylesheet', stylesheetId);
    localStorage.setItem('arcane.theme.palette', paletteId);
  } catch (e) {}
  fireEvent(document, 'arcane:palette-change', { id: paletteId, stylesheetId: stylesheetId });
}

function hydrateThemeFromStorage() {
  try {
    const m = localStorage.getItem('arcane.theme.mode');
    if (m && (m === 'light' || m === 'dark')) {
      document.documentElement.setAttribute('data-arcane-theme', m);
      document.documentElement.classList.remove('light', 'dark');
      document.documentElement.classList.add(m);
    }
    const s = localStorage.getItem('arcane.theme.stylesheet');
    if (s) document.documentElement.setAttribute('data-arcane-stylesheet', s);
    const p = localStorage.getItem('arcane.theme.palette');
    if (p) document.documentElement.setAttribute('data-arcane-palette', p);
  } catch (e) {}
}

ARCANE.theme = {
  setMode: setThemeMode,
  toggleMode: toggleThemeMode,
  setStylesheet: setStylesheet,
  setPalette: setPalette,
  hydrate: hydrateThemeFromStorage
};
''';

const String runtimeToastJs = r'''
function ensureToastSurface() {
  let surf = document.querySelector('[data-arcane-toast-surface]');
  if (!surf) {
    surf = document.createElement('div');
    surf.setAttribute('data-arcane-toast-surface', '');
    surf.setAttribute('role', 'region');
    surf.setAttribute('aria-label', 'Notifications');
    surf.setAttribute('aria-live', 'polite');
    document.body.appendChild(surf);
  }
  return surf;
}

function showToast(payload) {
  const surf = ensureToastSurface();
  const el = document.createElement('div');
  el.className = 'arcane-toast';
  el.setAttribute('data-arcane-toast', '');
  el.setAttribute('data-arcane-toast-variant', payload.variant || 'info');
  el.setAttribute('role', 'status');
  if (payload.title) {
    const titleEl = document.createElement('div');
    titleEl.className = 'arcane-toast-title';
    titleEl.textContent = payload.title;
    el.appendChild(titleEl);
  }
  const msgEl = document.createElement('div');
  msgEl.className = 'arcane-toast-message';
  msgEl.textContent = payload.message || '';
  el.appendChild(msgEl);
  const closeBtn = document.createElement('button');
  closeBtn.type = 'button';
  closeBtn.className = 'arcane-toast-close';
  closeBtn.setAttribute('aria-label', 'Dismiss');
  closeBtn.textContent = '\u00d7';
  closeBtn.addEventListener('click', function() { dismissToast(el); });
  el.appendChild(closeBtn);
  surf.appendChild(el);
  nextFrame(function() { el.classList.add('arcane-toast-shown'); });
  const duration = payload.duration || 4000;
  if (duration > 0) {
    setTimeout(function() { dismissToast(el); }, duration);
  }
  fireEvent(document, 'arcane:toast', { variant: payload.variant, message: payload.message });
}

function dismissToast(el) {
  if (!el) return;
  el.classList.remove('arcane-toast-shown');
  el.classList.add('arcane-toast-leaving');
  setTimeout(function() {
    if (el.parentNode) el.parentNode.removeChild(el);
  }, 250);
}

ARCANE.toast = {
  show: showToast,
  dismiss: dismissToast
};
''';

const String runtimeCopyJs = r'''
function copyText(text, feedback) {
  if (!navigator.clipboard) {
    const ta = document.createElement('textarea');
    ta.value = text;
    ta.style.position = 'fixed';
    ta.style.left = '-9999px';
    document.body.appendChild(ta);
    ta.select();
    try {
      document.execCommand('copy');
      ta.remove();
      if (feedback) showToast({ message: feedback, variant: 'success' });
      fireEvent(document, 'arcane:copy', { text: text });
      return Promise.resolve(true);
    } catch (e) {
      ta.remove();
      return Promise.reject(e);
    }
  }
  return navigator.clipboard.writeText(text).then(function() {
    if (feedback) showToast({ message: feedback, variant: 'success' });
    fireEvent(document, 'arcane:copy', { text: text });
    return true;
  });
}

ARCANE.copy = copyText;
''';

const String runtimeNavJs = r'''
function navGo(href) {
  const evt = fireEvent(document, 'arcane:nav', { href: href });
  if (!evt.defaultPrevented) {
    window.location.href = href;
  }
}

function navExternal(href) {
  window.open(href, '_blank', 'noopener,noreferrer');
}

function navBack() {
  if (window.history.length > 1) window.history.back();
}

ARCANE.nav = {
  go: navGo,
  external: navExternal,
  back: navBack
};
''';
