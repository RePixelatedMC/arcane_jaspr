library;

class ArcaneBaseCss {
  const ArcaneBaseCss._();

  static const String shared = '''
@font-face {
  font-family: 'lucide';
  src: url('/assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('/fonts/lucide/lucide.woff2') format('woff2'),
       url('assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('fonts/lucide/lucide.woff2') format('woff2'),
       url('../assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('../fonts/lucide/lucide.woff2') format('woff2'),
       url('../../assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('../../fonts/lucide/lucide.woff2') format('woff2'),
       url('https://cdn.jsdelivr.net/gh/ArcaneArts/arcane_jaspr@master/assets/fonts/lucide/lucide.woff2') format('woff2'),
       url('/assets/fonts/lucide/lucide.woff') format('woff'),
       url('/fonts/lucide/lucide.woff') format('woff'),
       url('assets/fonts/lucide/lucide.woff') format('woff'),
       url('fonts/lucide/lucide.woff') format('woff'),
       url('../assets/fonts/lucide/lucide.woff') format('woff'),
       url('../fonts/lucide/lucide.woff') format('woff'),
       url('../../assets/fonts/lucide/lucide.woff') format('woff'),
       url('../../fonts/lucide/lucide.woff') format('woff'),
       url('/assets/fonts/lucide/lucide.ttf') format('truetype'),
       url('/fonts/lucide/lucide.ttf') format('truetype'),
       url('assets/fonts/lucide/lucide.ttf') format('truetype'),
       url('fonts/lucide/lucide.ttf') format('truetype'),
       url('../assets/fonts/lucide/lucide.ttf') format('truetype'),
       url('../fonts/lucide/lucide.ttf') format('truetype'),
       url('../../assets/fonts/lucide/lucide.ttf') format('truetype'),
       url('../../fonts/lucide/lucide.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
  font-display: block;
}

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
  font-family: var(--font-sans);
  background-color: var(--background);
  color: var(--foreground);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

* {
  scrollbar-width: thin;
  scrollbar-color: var(--primary) transparent;
}

*::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

*::-webkit-scrollbar-track {
  background: transparent;
}

*::-webkit-scrollbar-thumb {
  background: var(--primary);
  border-radius: 9999px;
  border: 2px solid transparent;
  background-clip: padding-box;
}

*::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--primary) 80%, white);
  border: 2px solid transparent;
  background-clip: padding-box;
}

*::-webkit-scrollbar-corner {
  background: transparent;
}

html.dark, html.dark body,
html.light, html.light body {
  scrollbar-width: thin;
  scrollbar-color: var(--primary) var(--background);
}

html::-webkit-scrollbar,
body::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

html.dark::-webkit-scrollbar-track,
html.dark body::-webkit-scrollbar-track,
html.light::-webkit-scrollbar-track,
html.light body::-webkit-scrollbar-track {
  background: var(--background);
}

html.dark::-webkit-scrollbar-thumb,
html.dark body::-webkit-scrollbar-thumb,
html.light::-webkit-scrollbar-thumb,
html.light body::-webkit-scrollbar-thumb {
  background: var(--primary);
  border-radius: 9999px;
  border: 2px solid transparent;
  background-clip: padding-box;
}

html.dark::-webkit-scrollbar-thumb:hover,
html.dark body::-webkit-scrollbar-thumb:hover,
html.light::-webkit-scrollbar-thumb:hover,
html.light body::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--primary) 80%, white);
  border: 2px solid transparent;
  background-clip: padding-box;
}

html.dark::-webkit-scrollbar-corner,
html.dark body::-webkit-scrollbar-corner,
html.light::-webkit-scrollbar-corner,
html.light body::-webkit-scrollbar-corner {
  background: var(--background);
}

::selection {
  background: var(--primary);
  color: var(--primary-foreground);
}

::-moz-selection {
  background: var(--primary);
  color: var(--primary-foreground);
}

.focus-ring:focus-visible {
  outline: none;
  box-shadow: 0 0 0 2px var(--background), 0 0 0 4px var(--ring);
}

@keyframes arcane-spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

@keyframes arcane-fade-in {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes arcane-fade-out {
  from { opacity: 1; }
  to { opacity: 0; }
}

@keyframes arcane-slide-in-up {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes arcane-slide-in-down {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes arcane-slide-in-left {
  from { opacity: 0; transform: translateX(-10px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes arcane-slide-in-right {
  from { opacity: 0; transform: translateX(10px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes arcane-scale-in {
  from { opacity: 0; transform: scale(0.95); }
  to { opacity: 1; transform: scale(1); }
}

@keyframes arcane-scale-out {
  from { opacity: 1; transform: scale(1); }
  to { opacity: 0; transform: scale(0.95); }
}

@keyframes arcane-bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

@keyframes arcane-pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

@keyframes arcane-dropdown-fade {
  from { opacity: 0; transform: scale(0.95) translateY(-4px); }
  to { opacity: 1; transform: scale(1) translateY(0); }
}

.arcane-button:hover:not([disabled]) {
  filter: brightness(0.95);
}

.arcane-button:active:not([disabled]) {
  filter: brightness(0.9);
}

@keyframes scroll-carousel {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

.arcane-carousel-track:hover {
  animation-play-state: paused;
}

.arcane-carousel-track.dragging {
  animation: none !important;
  cursor: grabbing;
}

.arcane-carousel-track.dragging * {
  pointer-events: none;
}

.arcane-carousel-track.resuming {
  transition: none;
}
''';
}
