/// Carousel interactivity scripts for drag-to-scroll with infinite looping.
class CarouselScripts {
  CarouselScripts._();

  static const String code = r'''
  function bindCarousels() {
    document.querySelectorAll('.arcane-carousel').forEach(function(carousel) {
      if (carousel.dataset.arcaneCarouselBound) return;
      carousel.dataset.arcaneCarouselBound = 'true';

      var track = carousel.querySelector('.arcane-carousel-track');
      if (!track) return;

      var isDragging = false;
      var startX = 0;
      var currentTranslateX = 0;
      var dragStartTranslateX = 0;
      var hasInteracted = false;
      var resumeTimer = null;
      var trackWidth = 0;
      var animationDuration = parseInt(carousel.dataset.animationDuration) || 60;
      var resumeDelay = parseInt(carousel.dataset.resumeDelay) || 5000;

      function getTrackWidth() {
        return track.scrollWidth / 2;
      }

      function parseTranslateX(transform) {
        if (transform === 'none' || !transform) return 0;
        var match = transform.match(/matrix\(([^)]+)\)/);
        if (match) {
          var values = match[1].split(',');
          if (values.length >= 5) {
            return parseFloat(values[4].trim()) || 0;
          }
        }
        return 0;
      }

      function applyTransform() {
        track.style.transform = 'translateX(' + currentTranslateX + 'px)';
      }

      function wrapPosition() {
        if (trackWidth <= 0) return;
        while (currentTranslateX > 0) {
          currentTranslateX -= trackWidth;
          dragStartTranslateX -= trackWidth;
        }
        while (currentTranslateX < -trackWidth) {
          currentTranslateX += trackWidth;
          dragStartTranslateX += trackWidth;
        }
      }

      function startDrag(clientX) {
        if (resumeTimer) {
          clearTimeout(resumeTimer);
          resumeTimer = null;
        }

        trackWidth = getTrackWidth();

        if (!hasInteracted) {
          var computedStyle = window.getComputedStyle(track);
          currentTranslateX = parseTranslateX(computedStyle.transform);
          hasInteracted = true;
        }

        isDragging = true;
        startX = clientX;
        dragStartTranslateX = currentTranslateX;

        track.classList.add('dragging');
        track.classList.remove('resuming');
        applyTransform();
      }

      function updateDrag(clientX) {
        if (!isDragging) return;
        var deltaX = clientX - startX;
        currentTranslateX = dragStartTranslateX + deltaX;
        wrapPosition();
        applyTransform();
      }

      function endDrag() {
        if (!isDragging) return;
        isDragging = false;

        if (resumeTimer) clearTimeout(resumeTimer);
        resumeTimer = setTimeout(resumeAnimation, resumeDelay);
      }

      function resumeAnimation() {
        if (!track) return;

        track.classList.add('resuming');

        setTimeout(function() {
          track.classList.remove('dragging');
          track.classList.remove('resuming');
          track.style.transform = '';
          hasInteracted = false;
        }, 500);
      }

      // Mouse events
      track.addEventListener('mousedown', function(e) {
        e.preventDefault();
        startDrag(e.clientX);
      });

      track.addEventListener('mousemove', function(e) {
        if (isDragging) {
          e.preventDefault();
          updateDrag(e.clientX);
        }
      });

      document.addEventListener('mouseup', function() {
        endDrag();
      });

      // Touch events
      track.addEventListener('touchstart', function(e) {
        if (e.touches.length > 0) {
          startDrag(e.touches[0].clientX);
        }
      }, { passive: true });

      track.addEventListener('touchmove', function(e) {
        if (isDragging && e.touches.length > 0) {
          updateDrag(e.touches[0].clientX);
        }
      }, { passive: true });

      document.addEventListener('touchend', function() {
        endDrag();
      });

      document.addEventListener('touchcancel', function() {
        endDrag();
      });
    });
  }

  // Initial binding
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindCarousels);
  } else {
    bindCarousels();
  }

  // Re-bind on dynamic content changes
  var carouselObserver = new MutationObserver(function() {
    bindCarousels();
  });
  carouselObserver.observe(document.body, { childList: true, subtree: true });
''';
}