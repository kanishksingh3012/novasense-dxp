const menuButton = document.querySelector('.menu-toggle');
const menu = document.querySelector('#main-nav');
function closeMenu() { menu?.classList.remove('is-open'); menuButton?.setAttribute('aria-expanded', 'false'); }
menuButton?.addEventListener('click', () => { const open = menuButton.getAttribute('aria-expanded') !== 'true'; menuButton.setAttribute('aria-expanded', String(open)); menu.classList.toggle('is-open', open); });
menu?.querySelectorAll('a').forEach(link => link.addEventListener('click', closeMenu));
document.addEventListener('keydown', event => { if (event.key === 'Escape' && menuButton?.getAttribute('aria-expanded') === 'true') { closeMenu(); menuButton.focus(); } });
window.matchMedia('(min-width: 761px)').addEventListener('change', event => { if(event.matches) closeMenu(); });

const entries = [
  { date:'Wednesday, 14 October', heading:'Finding your<br>own steady.', description:'A moment to notice what feels familiar. Your check-in adds the part only you can tell.', note:'“A slower morning. Feeling like myself.”', tag:'Energy: steady', path:'M0 95C60 95 55 63 115 67S190 105 245 78 305 29 365 48 450 98 500 58 540 44 560 48', point:58 },
  { date:'Thursday, 15 October', heading:'A day with<br>a little more room.', description:'Patterns are one part of the story. Today’s note captures a moment you might otherwise forget.', note:'“Made time for a walk. Glad I did.”', tag:'Mood: content', path:'M0 100C55 100 65 80 115 84S195 58 245 69 310 98 365 70 450 37 500 48 540 67 560 57', point:48 },
  { date:'Friday, 16 October', heading:'Different days.<br>Still your rhythm.', description:'There is room for variation. Look back with curiosity, and let your own experience add context.', note:'“A full day. Taking a quiet evening.”', tag:'Energy: winding down', path:'M0 77C55 77 65 44 115 55S195 98 245 88 310 47 365 62 450 108 500 90 540 66 560 72', point:90 }
];
document.querySelectorAll('[data-entry]').forEach(button => button.addEventListener('click', () => {
  const index = Number(button.dataset.entry), entry = entries[index];
  document.querySelector('.journal-date').textContent = entry.date;
  document.querySelector('#entry-heading').innerHTML = entry.heading;
  document.querySelector('#entry-description').textContent = entry.description;
  document.querySelector('#entry-note').textContent = entry.note;
  document.querySelector('#entry-tag').textContent = entry.tag;
  document.querySelector('#entry-count').textContent = `ENTRY 0${index + 1} / 03`;
  document.querySelector('#pattern-line').setAttribute('d', entry.path);
  document.querySelector('#pattern-area').setAttribute('d', `${entry.path}V145H0Z`);
  document.querySelector('#pattern-point').setAttribute('cy', String(entry.point));
  document.querySelectorAll('[data-entry]').forEach(item => item.setAttribute('aria-pressed', String(item === button)));
  const panel = document.querySelector('.journal-entry'); panel.classList.remove('entry-changing'); requestAnimationFrame(() => panel.classList.add('entry-changing'));
}));

const tabs = [...document.querySelectorAll('[role="tab"]')];
function activateTab(tab) {
  tabs.forEach(item => { const active = item === tab; item.setAttribute('aria-selected', String(active)); item.tabIndex = active ? 0 : -1; document.getElementById(item.getAttribute('aria-controls')).hidden = !active; });
}
tabs.forEach((tab, index) => {
  tab.addEventListener('click', () => activateTab(tab));
  tab.addEventListener('keydown', event => {
    let next;
    if(event.key === 'ArrowRight') next = (index + 1) % tabs.length;
    if(event.key === 'ArrowLeft') next = (index - 1 + tabs.length) % tabs.length;
    if(event.key === 'Home') next = 0;
    if(event.key === 'End') next = tabs.length - 1;
    if(next !== undefined) { event.preventDefault(); activateTab(tabs[next]); tabs[next].focus(); }
  });
});
const dialog = document.querySelector('#kit-dialog');
document.querySelectorAll('[data-open-kit]').forEach(button => button.addEventListener('click', () => dialog?.showModal()));
dialog?.querySelector('.dialog-close').addEventListener('click', () => dialog.close());
dialog?.addEventListener('click', event => { if(event.target === dialog) { const rect=dialog.getBoundingClientRect(); if(event.clientX < rect.left || event.clientX > rect.right || event.clientY < rect.top || event.clientY > rect.bottom) dialog.close(); } });
