const CACHE_NAME = 'freezetrack-v4';
const ASSETS = ['./', './index.html', './manifest.json'];

// Domains that should NEVER be cached or intercepted
const PASSTHROUGH_DOMAINS = ['supabase.co', 'openfoodfacts.org', 'googleapis.com', 'cdn.jsdelivr.net'];

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE_NAME).then(c => c.addAll(ASSETS)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (e) => {
  const url = e.request.url;

  // NEVER intercept API calls — let them go straight to network
  if (PASSTHROUGH_DOMAINS.some(d => url.includes(d))) {
    return; // Don't call e.respondWith — let browser handle it normally
  }

  // For app files: network first, fall back to cache
  e.respondWith(
    fetch(e.request).then(r => {
      if (r.ok) {
        const c = r.clone();
        caches.open(CACHE_NAME).then(cache => cache.put(e.request, c));
      }
      return r;
    }).catch(() => caches.match(e.request))
  );
});
