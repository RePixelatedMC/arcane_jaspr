library;

const String runtimeCommandJs = r'''
function filterCommand(cmdId, query) {
  const surface = querySurface('command', cmdId) ||
    querySurface('popover', cmdId) ||
    document.querySelector('[data-arcane-command="' + cssEscape(cmdId) + '"]');
  if (!surface) return;
  const q = (query || '').toLowerCase().trim();
  const items = surface.querySelectorAll('[data-arcane-command-item]');
  let visibleCount = 0;
  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    const label = (item.getAttribute('data-label') || '').toLowerCase();
    const keywords = (item.getAttribute('data-keywords') || '').toLowerCase();
    const disabled = item.getAttribute('data-arcane-disabled') === 'true';
    let matches = q === '' || label.indexOf(q) >= 0 || keywords.indexOf(q) >= 0;
    if (matches) {
      item.removeAttribute('hidden');
      item.setAttribute('data-arcane-state', disabled ? 'disabled' : 'visible');
      if (!disabled) visibleCount++;
    } else {
      item.setAttribute('hidden', '');
      item.setAttribute('data-arcane-state', 'hidden');
    }
  }
  const groups = surface.querySelectorAll('[data-arcane-command-group]');
  for (let i = 0; i < groups.length; i++) {
    const g = groups[i];
    const groupId = g.getAttribute('data-arcane-command-group');
    const groupItems = surface.querySelectorAll(
      '[data-arcane-command-item][data-arcane-command-group-id="' + cssEscape(groupId) + '"]:not([hidden])'
    );
    if (groupItems.length === 0) {
      g.setAttribute('hidden', '');
    } else {
      g.removeAttribute('hidden');
    }
  }
  const empty = surface.querySelector('[data-arcane-command-empty]');
  if (empty) {
    if (visibleCount === 0) {
      empty.removeAttribute('hidden');
    } else {
      empty.setAttribute('hidden', '');
    }
  }
  fireEvent(surface, 'arcane:command-filter', { id: cmdId, query: q, visible: visibleCount });
}

function commandSelectFirst(cmdId) {
  const surface = querySurface('command', cmdId) ||
    querySurface('popover', cmdId);
  if (!surface) return;
  const visible = surface.querySelectorAll(
    '[data-arcane-command-item]:not([hidden]):not([data-arcane-disabled="true"])'
  );
  if (visible.length === 0) return;
  visible[0].click();
}

function bindCommandKeyboard() {
  document.addEventListener('keydown', function(e) {
    if (e.key !== 'Enter' && e.key !== 'ArrowDown' && e.key !== 'ArrowUp') return;
    const input = e.target;
    if (!input || !input.matches || !input.matches('[data-arcane-command-input]')) return;
    const cmdId = input.getAttribute('data-arcane-command-input');
    const surface = querySurface('command', cmdId) ||
      querySurface('popover', cmdId);
    if (!surface) return;
    const visible = Array.prototype.slice.call(surface.querySelectorAll(
      '[data-arcane-command-item]:not([hidden]):not([data-arcane-disabled="true"])'
    ));
    if (visible.length === 0) return;
    let activeIdx = visible.findIndex(function(el) {
      return el.getAttribute('data-arcane-state') === 'active';
    });
    if (e.key === 'Enter') {
      e.preventDefault();
      const target = activeIdx >= 0 ? visible[activeIdx] : visible[0];
      if (target) target.click();
      return;
    }
    e.preventDefault();
    if (activeIdx >= 0) {
      visible[activeIdx].setAttribute('data-arcane-state', 'visible');
    }
    let next = activeIdx;
    if (e.key === 'ArrowDown') next = activeIdx < 0 ? 0 : (activeIdx + 1) % visible.length;
    else next = activeIdx <= 0 ? visible.length - 1 : activeIdx - 1;
    visible[next].setAttribute('data-arcane-state', 'active');
    visible[next].scrollIntoView({ block: 'nearest' });
  }, true);
}

ARCANE.command = {
  filter: filterCommand,
  selectFirst: commandSelectFirst
};
''';
