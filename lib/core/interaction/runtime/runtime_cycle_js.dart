library;

const String runtimeCycleJs = r'''
function cycleRoot(cycleId) {
  return document.querySelector('[data-arcane-cycle="' + cssEscape(cycleId) + '"]');
}

function cycleValues(root) {
  const raw = root.getAttribute('data-arcane-cycle-values');
  if (!raw) return [];
  try { return JSON.parse(raw); } catch (e) { return []; }
}

function cycleLabels(root) {
  const raw = root.getAttribute('data-arcane-cycle-labels');
  if (!raw) return null;
  try { return JSON.parse(raw); } catch (e) { return null; }
}

function cycleStep(cycleId, delta) {
  const root = cycleRoot(cycleId);
  if (!root) return;
  const values = cycleValues(root);
  if (!values.length) return;
  const cur = parseInt(root.getAttribute('data-arcane-cycle-active') || '0', 10);
  const loop = root.getAttribute('data-arcane-cycle-loop') !== 'false';
  let next = cur + delta;
  if (loop) {
    if (next < 0) next = values.length - 1;
    if (next >= values.length) next = 0;
  } else {
    if (next < 0) next = 0;
    if (next >= values.length) next = values.length - 1;
  }
  if (next === cur) return;
  setCycleIndex(cycleId, next);
}

function setCycleIndex(cycleId, idx) {
  const root = cycleRoot(cycleId);
  if (!root) return;
  const values = cycleValues(root);
  if (idx < 0 || idx >= values.length) return;
  const labels = cycleLabels(root);
  root.setAttribute('data-arcane-cycle-active', idx.toString());
  root.setAttribute('data-arcane-value', values[idx]);
  const display = root.querySelector('[data-arcane-cycle-display]') || root;
  if (display !== root) {
    display.textContent = labels && labels[idx] != null ? labels[idx] : values[idx];
  } else {
    const label = root.querySelector('[data-arcane-cycle-label]');
    if (label) {
      label.textContent = labels && labels[idx] != null ? labels[idx] : values[idx];
    }
  }
  fireEvent(root, 'arcane:cycle-change', {
    id: cycleId, index: idx, value: values[idx]
  });
}

ARCANE.cycle = {
  step: cycleStep,
  set: setCycleIndex
};
''';
