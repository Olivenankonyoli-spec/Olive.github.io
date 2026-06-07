/* Apex STEM Tutors — site interactions */
(function () {
  // Reveal on scroll
  const items = document.querySelectorAll('.reveal-up, .reveal');
  if ('IntersectionObserver' in window && items.length) {
    const io = new IntersectionObserver((entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          e.target.classList.add('visible');
          io.unobserve(e.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });
    items.forEach((el) => io.observe(el));
  }

  // Back to top
  const top = document.querySelector('.fab-top');
  if (top) {
    window.addEventListener('scroll', () => {
      top.classList.toggle('show', window.scrollY > 480);
    }, { passive: true });
    top.addEventListener('click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));
  }

  // Smooth anchor scroll
  document.querySelectorAll('a[href^="#"]').forEach((a) => {
    a.addEventListener('click', (e) => {
      const href = a.getAttribute('href');
      if (href.length < 2) return;
      const target = document.querySelector(href);
      if (!target) return;
      e.preventDefault();
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
  });

  // View Transitions fallback for browsers without @view-transition
  if (!('startViewTransition' in document)) {
    document.querySelectorAll('a[href]').forEach((a) => {
      const url = a.getAttribute('href');
      if (!url || url.startsWith('#') || url.startsWith('http') || url.startsWith('mailto:') || url.startsWith('tel:') || a.target === '_blank') return;
      a.addEventListener('click', (e) => {
        e.preventDefault();
        document.body.style.transition = 'opacity .25s ease, transform .25s ease';
        document.body.style.opacity = '0';
        document.body.style.transform = 'translateY(-6px)';
        setTimeout(() => { window.location.href = url; }, 220);
      });
    });
  }

  // Enrollment form gentle submit
  const enrollForm = document.getElementById('enrollForm');
  if (enrollForm) {
    enrollForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const data = new FormData(enrollForm);
      const parent = data.get('parentName') || 'there';
      alert(`Thank you, ${parent}! We have received your enrollment. Our team will contact you within 24 hours to schedule the free one-hour session.`);
      enrollForm.reset();
    });
  }
})();
