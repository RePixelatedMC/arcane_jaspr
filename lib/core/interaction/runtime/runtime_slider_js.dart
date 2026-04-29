library;

const String runtimeSliderJs = r'''
function sliderRoot(sliderId) {
  return document.querySelector('[data-arcane-slider="' + cssEscape(sliderId) + '"][data-arcane-slider-min]');
}

function sliderClampValue(root, value) {
  const min = parseFloat(root.getAttribute('data-arcane-slider-min') || '0');
  const max = parseFloat(root.getAttribute('data-arcane-slider-max') || '100');
  const step = parseFloat(root.getAttribute('data-arcane-slider-step') || '0') || 0;
  let v = Math.max(min, Math.min(max, value));
  if (step > 0) {
    const ticks = Math.round((v - min) / step);
    v = min + ticks * step;
  }
  if (v < min) v = min;
  if (v > max) v = max;
  return v;
}

function sliderApplyValue(root, value, opts) {
  opts = opts || {};
  const sliderId = root.getAttribute('data-arcane-slider');
  const min = parseFloat(root.getAttribute('data-arcane-slider-min') || '0');
  const max = parseFloat(root.getAttribute('data-arcane-slider-max') || '100');
  const range = root.getAttribute('data-arcane-slider-range') === 'true';
  const role = opts.role || 'value';

  const clamped = sliderClampValue(root, value);
  const pct = max > min ? ((clamped - min) / (max - min)) * 100 : 0;

  if (range) {
    let lo = parseFloat(root.getAttribute('data-arcane-slider-lo') || min);
    let hi = parseFloat(root.getAttribute('data-arcane-slider-hi') || max);
    if (role === 'lo') {
      lo = clamped;
      if (lo > hi) lo = hi;
    } else {
      hi = clamped;
      if (hi < lo) hi = lo;
    }
    root.setAttribute('data-arcane-slider-lo', String(lo));
    root.setAttribute('data-arcane-slider-hi', String(hi));
    const loPct = max > min ? ((lo - min) / (max - min)) * 100 : 0;
    const hiPct = max > min ? ((hi - min) / (max - min)) * 100 : 0;
    const fill = root.querySelector('[data-arcane-slider-fill]');
    if (fill) {
      fill.style.left = loPct + '%';
      fill.style.right = (100 - hiPct) + '%';
      fill.style.width = (hiPct - loPct) + '%';
    }
    const thumbLo = root.querySelector('[data-arcane-slider-thumb="lo"]');
    if (thumbLo) {
      thumbLo.style.left = loPct + '%';
      thumbLo.setAttribute('aria-valuenow', String(lo));
    }
    const thumbHi = root.querySelector('[data-arcane-slider-thumb="hi"]');
    if (thumbHi) {
      thumbHi.style.left = hiPct + '%';
      thumbHi.setAttribute('aria-valuenow', String(hi));
    }
    fireEvent(root, 'arcane:slider-change', {
      sliderId: sliderId, lo: lo, hi: hi
    });
  } else {
    root.setAttribute('data-arcane-slider-value', String(clamped));
    const fill = root.querySelector('[data-arcane-slider-fill]');
    if (fill) {
      fill.style.width = pct + '%';
    }
    const thumb = root.querySelector('[data-arcane-slider-thumb]');
    if (thumb) {
      thumb.style.left = pct + '%';
      thumb.setAttribute('aria-valuenow', String(clamped));
    }
    fireEvent(root, 'arcane:slider-change', {
      sliderId: sliderId, value: clamped
    });
  }

  const changeAction = root.getAttribute('data-arcane-slider-change');
  if (changeAction) {
    runActions(changeAction, { trigger: root, sliderId: sliderId });
  }
}

function sliderValueFromPointer(root, clientX) {
  const track = root.querySelector('[data-arcane-slider-track]') || root;
  const rect = track.getBoundingClientRect();
  if (rect.width <= 0) return 0;
  const min = parseFloat(root.getAttribute('data-arcane-slider-min') || '0');
  const max = parseFloat(root.getAttribute('data-arcane-slider-max') || '100');
  const ratio = Math.max(0, Math.min(1, (clientX - rect.left) / rect.width));
  return min + ratio * (max - min);
}

function sliderRoleFromTarget(root, target) {
  const t = findClosest(target, '[data-arcane-slider-thumb]');
  if (t) {
    return t.getAttribute('data-arcane-slider-thumb') === 'hi' ? 'hi' : 'lo';
  }
  if (root.getAttribute('data-arcane-slider-range') === 'true') {
    const lo = parseFloat(root.getAttribute('data-arcane-slider-lo') || '0');
    const hi = parseFloat(root.getAttribute('data-arcane-slider-hi') || '100');
    const target_value = sliderValueFromPointer(root, event.clientX);
    return Math.abs(target_value - lo) < Math.abs(target_value - hi) ? 'lo' : 'hi';
  }
  return 'value';
}

function bindSliders() {
  let activeSlider = null;
  let activeRole = null;

  function onMove(e) {
    if (!activeSlider) return;
    e.preventDefault();
    const v = sliderValueFromPointer(activeSlider, e.clientX);
    sliderApplyValue(activeSlider, v, { role: activeRole });
  }

  function onUp() {
    activeSlider = null;
    activeRole = null;
    document.removeEventListener('pointermove', onMove);
    document.removeEventListener('pointerup', onUp);
    document.removeEventListener('pointercancel', onUp);
  }

  document.addEventListener('pointerdown', function(e) {
    const root = findClosest(e.target, '[data-arcane-slider]');
    if (!root) return;
    if (root.getAttribute('data-arcane-disabled') === 'true') return;
    const range = root.getAttribute('data-arcane-slider-range') === 'true';
    let role = 'value';
    if (range) {
      const t = findClosest(e.target, '[data-arcane-slider-thumb]');
      if (t) {
        role = t.getAttribute('data-arcane-slider-thumb');
      } else {
        const v = sliderValueFromPointer(root, e.clientX);
        const lo = parseFloat(root.getAttribute('data-arcane-slider-lo') || '0');
        const hi = parseFloat(root.getAttribute('data-arcane-slider-hi') || '100');
        role = Math.abs(v - lo) < Math.abs(v - hi) ? 'lo' : 'hi';
      }
    }
    activeSlider = root;
    activeRole = role;
    const v = sliderValueFromPointer(root, e.clientX);
    sliderApplyValue(root, v, { role: role });
    document.addEventListener('pointermove', onMove);
    document.addEventListener('pointerup', onUp);
    document.addEventListener('pointercancel', onUp);
  }, true);

  document.addEventListener('keydown', function(e) {
    const thumb = findClosest(e.target, '[data-arcane-slider-thumb]');
    if (!thumb) return;
    const root = findClosest(thumb, '[data-arcane-slider]');
    if (!root) return;
    if (root.getAttribute('data-arcane-disabled') === 'true') return;
    const role = thumb.getAttribute('data-arcane-slider-thumb');
    const step = parseFloat(root.getAttribute('data-arcane-slider-step') || '1') || 1;
    const min = parseFloat(root.getAttribute('data-arcane-slider-min') || '0');
    const max = parseFloat(root.getAttribute('data-arcane-slider-max') || '100');
    let cur;
    if (role === 'lo' || role === 'hi') {
      cur = parseFloat(root.getAttribute('data-arcane-slider-' + role) || '0');
    } else {
      cur = parseFloat(root.getAttribute('data-arcane-slider-value') || '0');
    }
    let next = cur;
    if (e.key === 'ArrowLeft' || e.key === 'ArrowDown') next = cur - step;
    else if (e.key === 'ArrowRight' || e.key === 'ArrowUp') next = cur + step;
    else if (e.key === 'PageDown') next = cur - step * 10;
    else if (e.key === 'PageUp') next = cur + step * 10;
    else if (e.key === 'Home') next = min;
    else if (e.key === 'End') next = max;
    else return;
    e.preventDefault();
    sliderApplyValue(root, next, {
      role: role === 'lo' || role === 'hi' ? role : 'value'
    });
  }, true);
}

function setSliderValue(sliderId, value, role) {
  const root = sliderRoot(sliderId);
  if (!root) return;
  const v = parseFloat(value);
  if (isNaN(v)) return;
  sliderApplyValue(root, v, { role: role || 'value' });
}

ARCANE.slider = {
  set: setSliderValue,
  bind: bindSliders
};
''';
