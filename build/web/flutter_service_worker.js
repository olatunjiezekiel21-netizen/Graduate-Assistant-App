'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "06395903be5fb4ad9e2c596f2cb36f52",
"assets/AssetManifest.bin.json": "096fe116b9d829882ef13c1f37a5b8c2",
"assets/AssetManifest.json": "7a86bacd1d73d883ba4404ddd471dedd",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4ee992afb214071bfc17d13511a4123f",
"assets/NOTICES": "a03805927c696f7282cd3036a03cc1de",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/pages%2520assets/3dicons-file-text-dynamic-color.png": "8ff2b71d454cc3bab8ed5fdf3c55fbce",
"assets/pages%2520assets/3dicons-notebook-dynamic-color%2520(1)_2.png": "078d44ecd783fba886bb7991984b0f91",
"assets/pages%2520assets/Annotation.png": "f0fb746f6ff79da3d33a33d4a3b6ea85",
"assets/pages%2520assets/Bell.png": "2b25fae2d2a934fc051d5766d8132aa6",
"assets/pages%2520assets/Customer%2520care%2520(1).png": "e65f33c1a269474ab8551c79d2b4e424",
"assets/pages%2520assets/Ellipse%25201.png": "c2b1a19d26822dbc654e2ed65a60e2b2",
"assets/pages%2520assets/Ellipse%25202.png": "2b00c653e28daf6c9e0305d43b55b3a4",
"assets/pages%2520assets/Fresh%2520Folk%2520Teaching.png": "03bec246c77d2ca0c1a50ca8c29b8c26",
"assets/pages%2520assets/Happy%2520Bunch%2520Chat.png": "4f301be639c03937b0f955f598f36749",
"assets/pages%2520assets/Home%2520(1).png": "3ac363f7a8e45be06f585974ac06b193",
"assets/pages%2520assets/Home%2520screen.png": "427e22f2c365df2858c088acbe54dc46",
"assets/pages%2520assets/image%25201%2520(2).png": "29f78570a32af41c8ac2f07c7c770bd3",
"assets/pages%2520assets/job%2520task.png": "1328e95701ad7025474ff3c675a7fec0",
"assets/pages%2520assets/login%2520(1).png": "494c54bce102a1b0b9472510c5235f57",
"assets/pages%2520assets/Masters%2520update.png": "97cd9a0f41ff21a42287f2d8307e1f7e",
"assets/pages%2520assets/Me.png": "c7e8c4cdfaed1e878abffa10edf01811",
"assets/pages%2520assets/Messages.png": "604b7daa3675ba7f43f3cd009769c7c2",
"assets/pages%2520assets/nysc%2520logo.png": "28af3338b00a5303be757bda93ab2dda",
"assets/pages%2520assets/Ol%25C3%25A1%2520Playing%2520Video%2520Games.png": "1fcc5090edd40b626c0b086fb5c94807",
"assets/pages%2520assets/Rectangle%25201.png": "96f6b26bebb0f0cd6b1d76eba582d922",
"assets/pages%2520assets/Rectangle%252042.png": "3efbdad569f6d93f3330beb3ab516a2d",
"assets/pages%2520assets/Rectangle%252043.png": "2d2e1526842f376bec0abe1e98c5001b",
"assets/pages%2520assets/Rectangle%252049.png": "6be5c7b86c3d0116e94faca3805d862d",
"assets/pages%2520assets/Resume%2520Buider%2520(1).png": "d0d8f4e5ab0b656cecbf08bf622fa3b5",
"assets/pages%2520assets/skill%2520Progress.png": "d1be563dc50d48aeadd75c1e0fb3be07",
"assets/pages%2520assets/Skills.png": "c8a8b0bfa12bca39167d3cb2e8573c7a",
"assets/pages%2520assets/Speakerphone.png": "46e7a6a099bb20f65e891caee791b87c",
"assets/pages%2520assets/TASK%2520(1).png": "68c551ef7cb3a046cc1a6cdeef3747f9",
"assets/pages%2520assets/updates.png": "33f14d03d1276efd93360a21a0180926",
"assets/pages%2520assets/UserCircle.png": "7e1a4b0355d591f0f99e4ea1c614e1c8",
"assets/preloader%2520assets/Charco%2520Education.png": "c17f4d5ebfabfaf6cc049004622205ff",
"assets/preloader%2520assets/Fresh%2520Folk%2520Teaching.png": "03bec246c77d2ca0c1a50ca8c29b8c26",
"assets/preloader%2520assets/Happy%2520Bunch%2520Chat.png": "4f301be639c03937b0f955f598f36749",
"assets/preloader%2520assets/Ol%25C3%25A1%2520Playing%2520Video%2520Games.png": "1fcc5090edd40b626c0b086fb5c94807",
"assets/preloader%2520assets/Preloader1%2520(1).png": "41533ddf2d10197d5d1de5bfabb16630",
"assets/preloader%2520assets/Preloader2%2520(1).png": "b7a7187cd42241dd4b7f2bcfaf0e82cc",
"assets/preloader%2520assets/Preloader3%2520(1).png": "5455d261485d2fcbd24cd71ecc860dc6",
"assets/preloader%2520assets/Preloader4%2520(1).png": "bcc670d781a2546ca83b0dfce87cd726",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "32d77230031eec604346b33f0466a79d",
"index.html": "70e1ff1b4b53235958ed6cfbb83ba50a",
"/": "70e1ff1b4b53235958ed6cfbb83ba50a",
"main.dart.js": "c61a9fa3a7e08b7d555c061e32ebd1c4",
"version.json": "9522bf0ac66c9f48f40469ebcd3121a5"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
