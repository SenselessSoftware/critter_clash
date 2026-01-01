'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "15a5af0e7189199c47529371a025fe72",
"assets/AssetManifest.bin.json": "2ef897fef045c2c849810eb837d1d176",
"assets/assets/images/fightclub1.gif": "5994f8584c0b556c8efe281b65a486ff",
"assets/assets/images/fightclub1.png": "1d9edc85e50213c6e1a79cff6607c8fd",
"assets/assets/images/fighter1.png": "bf1cd31640b78652b311176a25223000",
"assets/assets/images/fighter1_win.png": "9e4dd78aa5aa91736b6a192acbc86b08",
"assets/assets/images/fighter2.png": "eea85a8f70b4fb2eb23d062324588d6a",
"assets/assets/images/fighter2_win.png": "9b5cb5b573bc1d6ce9c2559f2f182b92",
"assets/assets/images/fighter3.png": "068ed9d4d98b04b67bef7046ef07de1d",
"assets/assets/images/fighter3_win.png": "d1c10c9ebd37b8ad9f9667ab5a9e5f4c",
"assets/assets/images/fighter4.png": "3b995fcd7d74534bad9930e9cc4c48ef",
"assets/assets/images/fighter4_win.png": "67d9e43f43639006cc2839deffc33391",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "81e9dc0a6eea459c9883240a060acfd5",
"assets/NOTICES": "cfcf815d13ff59d5fceff700e6b83d01",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/player_model/assets/images/avatars/blankPlayer.jpg": "9935bc8d163c8c29de31d4398508b867",
"assets/packages/player_model/assets/images/avatars/female01.png": "9b49b7405732d71ae98ed13aae274436",
"assets/packages/player_model/assets/images/avatars/female02.png": "67070fcef5421e959d75de6c9b43c019",
"assets/packages/player_model/assets/images/avatars/female03.png": "60fbb732ffab2f7520f47561851a6785",
"assets/packages/player_model/assets/images/avatars/female04.png": "ec0a4d18ba592c662305d8c659b82805",
"assets/packages/player_model/assets/images/avatars/female05.png": "2376adf23994d58c24a5e54256e00d24",
"assets/packages/player_model/assets/images/avatars/female06.png": "ab929eb524119f0164c13f8b568cedfb",
"assets/packages/player_model/assets/images/avatars/female07.png": "8e90e0274e0416e4d275c616720e2671",
"assets/packages/player_model/assets/images/avatars/female08.png": "b4ab2bb54aa3b7b6305addfc85c3695c",
"assets/packages/player_model/assets/images/avatars/female09.png": "7c42ef26d17a98fa4e3338fbb56a1d3a",
"assets/packages/player_model/assets/images/avatars/female10.png": "c07279851678ce95307cec198864aef1",
"assets/packages/player_model/assets/images/avatars/female11.png": "a5c3d9ad9b6bd08afbb485d887882ec2",
"assets/packages/player_model/assets/images/avatars/female12.png": "3cd4d9f6fe4527185c0dcd561be61829",
"assets/packages/player_model/assets/images/avatars/male01.png": "5adbec9c7352c63faacabd169243bad2",
"assets/packages/player_model/assets/images/avatars/male02.png": "f30389ae4d04aa7908311d680bb8ffba",
"assets/packages/player_model/assets/images/avatars/male03.png": "058142896126a2816928361468d9cc9a",
"assets/packages/player_model/assets/images/avatars/male04.png": "99a9fe28e5267849aeab8cd9012ab7d9",
"assets/packages/player_model/assets/images/avatars/male05.png": "eb295c4c985e8260a89fece0b42a71ac",
"assets/packages/player_model/assets/images/avatars/male06.png": "c9cea6423952747b07ce16c50e70e861",
"assets/packages/player_model/assets/images/avatars/male07.png": "e387459d4ce392ef0041ee7b2ae342d4",
"assets/packages/player_model/assets/images/avatars/male08.png": "14d783d7719b70e74d6b665ac58f3c31",
"assets/packages/player_model/assets/images/avatars/male09.png": "81b449e51aac7b96d76ae1d7fe31d33b",
"assets/packages/player_model/assets/images/avatars/male10.png": "1663df73179faab81fa13f008fbd1cf5",
"assets/packages/player_model/assets/images/avatars/male11.png": "a4bf7209ef4fb916e9d9df66e35155fb",
"assets/packages/player_model/assets/images/avatars/male12.png": "7b3291f17990d87a72619bcc602f0a9b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "8652c512f0379a2e035dc8083997106a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "37b4807d75d4ac8a7e750a8a1a4049f4",
"/": "37b4807d75d4ac8a7e750a8a1a4049f4",
"main.dart.js": "806a9d017f2b5d4cd9a6ca8f90a113e2",
"manifest.json": "608ffc253b5774b8e9d7feb996176a72",
"version.json": "e193867c476b14f4ce5e94b6f2c2aae0"};
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
