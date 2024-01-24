'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "ae989b3605a7078bbb8ac6a35cfe2cfe",
"assets/AssetManifest.bin.json": "1fb17338eb167f728b42732aaea6f52d",
"assets/AssetManifest.json": "2b6e42f52ab7ce501a82bc831171308c",
"assets/assets/icons/css.png": "96b0bd9fefa52463c49c996216dd9af1",
"assets/assets/icons/html.png": "c2d6e9861f5bb81ecd0231e80adbfbe3",
"assets/assets/icons/Terra_globe_icon.png": "6b0cf479b78412b5ce831e745ee37a3c",
"assets/assets/images/badges/00634f82-b07f-4bbd-a6bb-53de397fc3a6.png": "0f3d3b9e77814786846301bbfffa4f4f",
"assets/assets/images/badges/2784d0d8-327c-406f-971e-9f0e15097003.png": "6f145a2f265b693006452b4240767f10",
"assets/assets/images/badges/OCIF2023CA.png": "0ce82fff4c544e75850b3ace1cf6dbac",
"assets/assets/images/espaco/1.jpg": "aba0b5815ec06ff493d1995a424b5a10",
"assets/assets/images/espaco/10.jpg": "951556dfccd1104a613b8dedea94b18b",
"assets/assets/images/espaco/11.jpg": "f9a7f51b334ac38da2c5fb9264ef00e6",
"assets/assets/images/espaco/12.jpg": "1f351811a4cb507d1982724a4a4449c3",
"assets/assets/images/espaco/2.jpg": "6e9532b0af82f38efa72fc2e7f0c9686",
"assets/assets/images/espaco/3.jpg": "0edb047954bf254136c52645d5e99b0e",
"assets/assets/images/espaco/4.jpg": "393517f8c86bdbf92205a174880643ec",
"assets/assets/images/espaco/5.jpg": "ac05c837f454106f4105d6660c3b42b2",
"assets/assets/images/espaco/6.jpg": "935538e8b78d0da8bf8f79f83e60941e",
"assets/assets/images/espaco/7.jpg": "5489575765c3373df41ffab8217b6f26",
"assets/assets/images/espaco/8.jpg": "5fec3254faaf25f2326138c588ea0705",
"assets/assets/images/espaco/9.jpg": "7239feb38892370920c79db1fef55180",
"assets/assets/images/kae1/1.webp": "90dd56e51ab41890ad64a490b0e15d29",
"assets/assets/images/kae1/2.webp": "a2b363d36f71600593afad7530c71d5f",
"assets/assets/images/kae2/1.webp": "a299036a3cdaf0572ae3318f1744fe2a",
"assets/assets/images/kae2/2.webp": "377f4573f6023e14ea09a008d253782b",
"assets/assets/images/kae2/3.webp": "ae9aafc2df27c645cf27723acbd8219b",
"assets/assets/images/kae2/4.webp": "58d4f71bb85ece43322167eda5964c3f",
"assets/assets/images/kae2/5.webp": "8d5333a5f4ae79698cf31d887da0dd04",
"assets/assets/images/kae3/1.webp": "b159247a2fc2215f4309d95b34aad883",
"assets/assets/images/kae3/2.webp": "cb403c4926658d8b384c3ccda8f585e3",
"assets/assets/images/kae3/3.webp": "b428888bcc14fe9ae2b29e70e492457c",
"assets/assets/images/kae3/4.webp": "4ec8446aae91c851d17a47178c96a026",
"assets/assets/images/kae4/1.webp": "7c5a82b8ed44c2a9f8524897da850108",
"assets/assets/images/kae4/2.webp": "c9ca72a014dc40079c8e1a69d245193d",
"assets/assets/images/pcbk1/1.webp": "e2264df4dbd132c5de3cfa2f26994ed7",
"assets/assets/images/pcbk1/2.webp": "d9cf3ace6a8ed61d5c85b2bfb5c535a5",
"assets/assets/images/pcbk1/3.webp": "aa53d409c38a786faab0697f858dcd10",
"assets/assets/images/pcbk1/4.webp": "4e2904cb3751d9d301108bf93adacac5",
"assets/assets/images/pcbk2/1.webp": "d1c47c985f8564415587dc26813d4d68",
"assets/assets/images/pcbk2/2.webp": "317b0dd414398ae866a3701cfdf93d4a",
"assets/assets/images/pcbk2/3.webp": "4e672cfc4b91d0a8b680389ca08ac0ca",
"assets/assets/images/pcbk2/4.webp": "ffe8e1304bdb99d23e9da314c902b810",
"assets/assets/images/pcbk2/5.webp": "9225fac3fb2e0445361653ee7b027ea6",
"assets/assets/images/pcbk2/6.webp": "dba9211fb7d7e0d3edaa26d4bb24bb1b",
"assets/assets/images/pck1/1.webp": "b619a55f309cc2e660d7db2697970a3e",
"assets/assets/images/pck1/2.webp": "3895e3201ab6e1b5f26d9d6781242237",
"assets/assets/images/pck1/3.webp": "4347fb86f3025ff8f97076c14abc4d12",
"assets/assets/images/pck1/4.webp": "6a7d882faeda42ec6e54155f9c1d58ed",
"assets/assets/images/pck2/1.webp": "d380c94b3e425980a1cbca249112a21f",
"assets/assets/images/pck2/2.webp": "d0aa016693c4c78d8e76695134e3d4a3",
"assets/assets/images/pck2/3.webp": "84c2e7e25804c32681fee3f495f308e3",
"assets/assets/images/pck2/4.webp": "15845bdb2488bbacdfadc33e61df97b5",
"assets/assets/images/pck2/5.webp": "e4c016e81ee786a8d142ea827d567090",
"assets/assets/images/pck2/6.webp": "954cf315b91fe0aa7dff903a85e65c9e",
"assets/assets/images/pcpt1/1.webp": "8b4ab8408cfd6725d8d0df92fc84122f",
"assets/assets/images/pcpt1/2.webp": "84654552ef4feb372f51f8d4eac63c45",
"assets/assets/images/pcpt1/3.webp": "f9704083f61dd239647e43c9cb2f8a26",
"assets/assets/images/pcpt1/4.webp": "0eb18f2bf071a1a5807b4556d365ac1f",
"assets/assets/images/pcpt1/5.webp": "b75735f1218af90898ac134a1e712498",
"assets/assets/images/pcpt1/6.webp": "db22f8e7557de092be747255eb8eb086",
"assets/assets/images/pcpt2/1.webp": "ec0be4fecd618e40aad998aea92c67de",
"assets/assets/images/pcpt2/2.webp": "710319d1f9e90f2351fca8d48aeabd40",
"assets/assets/images/pcpt2/3.webp": "3bbdc9318606c757ca0bcdb0dfd07132",
"assets/assets/images/pcpt2/4.webp": "a0e76ceafa422c9ca490c4c42071d8f5",
"assets/assets/images/pcpt2/5.webp": "b4e352f9cb29b7fd018618dcc060acdc",
"assets/assets/images/pcpt2/6.webp": "048463888a5493d7bde303bc1ba5b5dd",
"assets/assets/images/pk1/1.webp": "029db17f26201d2eb589a8555c405565",
"assets/assets/images/pk1/2.webp": "96481f04c10048bd05e8fd6c73f57a86",
"assets/assets/images/pk1/3.webp": "58c3a37406b4d889a60619be55f33a23",
"assets/assets/images/pk1/4.webp": "fcaddcda0b6484477532b9d5dfc3a4b2",
"assets/assets/images/pk1/5.webp": "744cfae7292be7edd2bea2925eff0bb2",
"assets/assets/images/pk2/1.webp": "12ba49736cabd8468b5be910331593b5",
"assets/assets/images/pk2/2.webp": "cec716f86b139e1c8c852897ed83cc73",
"assets/assets/images/pk2/3.webp": "88d9be478fd8e55fedede5ad028e2f8f",
"assets/assets/images/pk2/4.webp": "a69bb3d02b68a16b4b6e46ebe18a74f5",
"assets/assets/images/pk3/1.webp": "9efe79134a90e75cf7c2b9fa9ba9a402",
"assets/assets/images/pk3/2.webp": "f2c504429dceb0147ff66edc369d6ceb",
"assets/assets/images/pk3/3.webp": "04d84c1bd1a79309baa444be58a807c4",
"assets/assets/images/pk3/4.webp": "464b3076dc97c8a9a3665a45b799031f",
"assets/assets/images/pk4/1.webp": "155d8b4818df438a58ea11f560cdb7d3",
"assets/assets/images/pk4/2.webp": "4800d6fe4acd63dab7520017fe34f6e0",
"assets/assets/images/pk4/3.webp": "7137d6546138349f1336c40d32a5c9ea",
"assets/assets/images/pk4/4.webp": "a2b90603f7db219fa1b966c96750745a",
"assets/assets/images/pk4/5.webp": "0facbf0f0a848a8aa30abf3d9ff160df",
"assets/assets/images/pk5/1.webp": "09747bf97434a113bc57c85cd9f17e4c",
"assets/assets/images/pk5/2.webp": "a35406c6e37f3584137b6b181875e5a8",
"assets/assets/images/pk5/3.webp": "60840491c43206a0b9a9e0781562e649",
"assets/assets/images/pk5/4.webp": "1508479b0c12511055bd5b8e6d54f2c1",
"assets/assets/images/pk6/1.webp": "9eed3e3acab2ce6ec6d4efafac0c391a",
"assets/assets/images/pk6/2.webp": "f25832d661e0e969d97233f475ff7fb3",
"assets/assets/images/pk6/3.webp": "23256a32252e1ee22e461091e22053e1",
"assets/assets/images/pk6/4.webp": "1c146cf97e1845502728abd438f5f81b",
"assets/assets/images/quiz/1.png": "f5db5f793a6b28f2a1f80b50c8c1d62b",
"assets/assets/images/quiz/2.png": "b42f61f8a285fea1795b1dbd4202bdc6",
"assets/assets/images/quiz/3.png": "c9ef915fcc2497099885cb3132e9494b",
"assets/assets/images/quiz/4.png": "1e0dac42b1b50e185ba9739a3e032a19",
"assets/assets/images/quiz/5.png": "3187688c82a5392fb82c7981673d8c1f",
"assets/assets/images/quiz/6.png": "8ddbcbfb467123b2e2b31af6f547a11b",
"assets/assets/images/sintaosom/1.webp": "09143a32bb602d9e275241b0b5aba0d7",
"assets/assets/images/sintaosom/2.webp": "c5262c48ac1427614302f45c67b8f7dc",
"assets/assets/images/sintaosom/3.webp": "b52f0e7207681a60c5640a78f8b9c4f8",
"assets/assets/images/sintaosom/4.webp": "90b64c1ec560b7ef76b3848da9524a9c",
"assets/assets/images/sintaosom/5.webp": "2d178dc03db6e73ec1089eab4b24dc15",
"assets/FontManifest.json": "8767d47cfc9d6cfd23bcc48d174c2fe4",
"assets/fonts/Azonix.otf": "cdfe47b31e9184a55cf02eef1baf7240",
"assets/fonts/MaterialIcons-Regular.otf": "89279250061a3ef2cb2c0c99d6192a0c",
"assets/NOTICES": "5f71632147f1d0daacb283627d5ff45c",
"assets/packages/clone_banco_inter/assets/br.png": "19e8a1b304d07a5d6a5c03d7389bc8ef",
"assets/packages/clone_banco_inter/assets/us.png": "525d07d8bad1002321bc9fda5db2fa92",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "1292da21ef9de0db559773e2dbddf658",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "4b1b21b4b452d674f377b8ec6006e296",
"/": "4b1b21b4b452d674f377b8ec6006e296",
"main.dart.js": "9b7dbb4a903ebde8e856ab888dceb349",
"manifest.json": "e74af8957b5899dc6da961caee768ec9",
"version.json": "009c9e65172e010890f7f65fde438006"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
