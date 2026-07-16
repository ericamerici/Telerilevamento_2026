//================================================================================================================
//================================================================================================================
// Analisi Multitemporale dello Stato di Conservazione della Vegetazione nel Parco di Gutturu Mannu (2015–2025)
// Erica Merici, matricola 0001186080, Telerilevamento Geo-Ecologico in R
// Codice in JavaScript utilizzato per scaricare le immagini satellitari da Google Earth Engine
// https://code.earthengine.google.com/
//================================================================================================================
//================================================================================================================

//=========================================
  // Limiti amministrativi del parco di interesse importati in formato shapefile da Sardegna Geoportale
//=========================================


//=========================================
  // Mashcera nubi (QA60)
//=========================================

function maskS2clouds(image) {   // la funzione prende un’immagine Sentinel-2 e maschera i pixel nuvolosi
  var qa = image.select('QA60'); // prende la banda QA60, che contiene flag binari per nubi e cirri
  var cloudBitMask = 1 << 10; // sceglie il bit 10 per nuvola
  var cirrusBitMask = 1 << 11; // sceglie il bit 11 per cirri

  var mask = qa.bitwiseAnd(cloudBitMask).eq(0) // costruisce una maschera; vero quando il bit nuvola è 0 (quindi niente nuvola)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0)); // vero anche quando il bit cirri è 0.

  return image.updateMask(mask).divide(10000); // updateMark(mask) applica la maschera, quindi i pixel con nuvole diventano "nodata"; .divde(10000) scala i valori delle bande, dato che spesso sono come interi "scaled" e vanno divisi per 10000 per ottenere riflettanza (da 0–10000 ➝ 0–1).
}

//=========================================
// AOI (Area of interest) e visualizzazione
//=========================================

var aoi = table; // table è lo shapefile importato
Map.centerObject(aoi, 11); // centra la mappa su aoi con zoom 11
Map.addLayer(aoi, {color: 'red'}, 'AOI GM'); // aggiunge il layer di rettangolo rosso sulla mappa. 

//=========================================
// Collezione immagini Sentinel-2
//=========================================

////////////////////////////////////////////////////////////////
// Immagine del 2015

var collection15 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2015-01-07', '2015-08-31') // range temporale: mesi di luglio e agosto (estate)
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print(collection15.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite15 = collection15.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
var first15 = ee.Image(collection15.first());
Map.addLayer(first15, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First image RGB 15');

// Composite mediano RGB
Map.addLayer(composite15, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB 15');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite15.select(['B2','B3','B4','B8','B11']),  // Include tutte le bande che mi servono per l'analisi
  description: 'S15',
  folder: 'GEE_exports',
  fileNamePrefix: 'S15',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});

////////////////////////////////////////////////////////////////
// Immagine del 2018

var collection18 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2018-01-07', '2018-08-31') // range temporale: mesi di luglio e agosto (estate)
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print(collection18.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite18 = collection18.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
var first18 = ee.Image(collection18.first());
Map.addLayer(first18, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First image RGB 18');

// Composite mediano RGB
Map.addLayer(composite18, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB 18');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite18.select(['B2','B3','B4','B8','B11']),  // Include tutte le bande che mi servono per l'analisi
  description: 'S18',
  folder: 'GEE_exports',
  fileNamePrefix: 'S18',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});

//////////////////////////////////////////////////////////////////
// Immagine del 2020


//=========================================
// Collezione immagini Sentinel-2
//=========================================

var collection20 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2020-07-01', '2020-08-31') // range temporale
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print(collection20.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite20 = collection20.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
var first20 = ee.Image(collection20.first());
Map.addLayer(first20, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First image RGB 20');

// Composite mediano RGB
Map.addLayer(composite20, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB 20');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite20.select(['B2','B3','B4','B8','B11']),  // Include tutte le bande che mi servono per l'analisi
  description: 'S20',
  folder: 'GEE_exports',
  fileNamePrefix: 'S20',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});

////////////////////////////////////////////////////////////////
// Immagine del 2022

var collection22 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2022-01-07', '2022-08-31') // range temporale: mesi di luglio e agosto (estate)
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print(collection22.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite22 = collection22.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
var first22 = ee.Image(collection22.first());
Map.addLayer(first22, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First image RGB 15');

// Composite mediano RGB
Map.addLayer(composite22, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB 15');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite15.select(['B2','B3','B4','B8','B11']),  // Include tutte le bande che mi servono per l'analisi
  description: 'S22',
  folder: 'GEE_exports',
  fileNamePrefix: 'S22',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});

////////////////////////////////////////////////////////////////
// Immagine del 2025

//=========================================
// Collezione immagini Sentinel-2
//=========================================

var collection25 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2025-07-01', '2025-08-31') // range temporale: mesi di luglio e agosto
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20%.
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print(collection25.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite25 = collection25.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
var first25 = ee.Image(collection25.first());
Map.addLayer(first25, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First image RGB 25');

// Composite mediano RGB
Map.addLayer(composite25, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB 25');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite25.select(['B2','B3','B4','B8', 'B11']),  // Include tutte le bande che mi servono per l'analisi
  description: 'S25',
  folder: 'GEE_exports',
  fileNamePrefix: 'S25',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});


/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//================================================================================================================
//================================================================================================================
// Analisi Multitemporale dello Stato di Conservazione della Vegetazione nel Parco di Gutturu Mannu (2015–2025)
// Erica Merici, matricola 0001186080, Telerilevamento Geo-Ecologico in R
// Codice in JavaScript utilizzato per scaricare le immagini satellitari da Google Earth Engine
// https://code.earthengine.google.com/
//================================================================================================================
//================================================================================================================

//=========================================
  // Limiti amministrativi della provincia di interesse importati in formato shapefile da ISTAT
//=========================================


//=========================================
  // Mashcera nubi (QA60)
//=========================================

function maskS2clouds(image) {   // la funzione prende un’immagine Sentinel-2 e maschera i pixel nuvolosi
  var qa = image.select('QA60'); // prende la banda QA60, che contiene flag binari per nubi e cirri
  var cloudBitMask = 1 << 10; // sceglie il bit 10 per nuvola
  var cirrusBitMask = 1 << 11; // sceglie il bit 11 per cirri

  var mask = qa.bitwiseAnd(cloudBitMask).eq(0) // costruisce una maschera; vero quando il bit nuvola è 0 (quindi niente nuvola)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0)); // vero anche quando il bit cirri è 0.

  return image.updateMask(mask).divide(10000); // updateMark(mask) applica la maschera, quindi i pixel con nuvole diventano "nodata"; .divde(10000) scala i valori delle bande, dato che spesso sono come interi "scaled" e vanno divisi per 10000 per ottenere riflettanza (da 0–10000 ➝ 0–1).
}

//=========================================
// AOI (Area of interest) e visualizzazione
//=========================================

var aoi = table; // geometry è il rettangolo 
Map.centerObject(aoi, 11); // centra la mappa su aoi con zoom 11
Map.addLayer(aoi, {color: 'red'}, 'AOI G'); // aggiunge il layer di rettangolo rosso sulla mappa. 

//=========================================
// Collezione immagini Sentinel-2
//=========================================

////////////////////////////////////////////////////////////////
// Immagine del 2016

var collection16 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2016-01-05', '2016-06-30') // range temporale: mesi di luglio e agosto (estate)
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 35)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print(collection16.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite16 = collection16.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
var first16 = ee.Image(collection16.first());
Map.addLayer(first16, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First image RGB 15');

// Composite mediano RGB
Map.addLayer(composite16, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB 16');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite16.select(['B2','B3','B4','B8','B11']),  // Include tutte le bande che mi servono per l'analisi
  description: 'P16',
  folder: 'GEE_exports',
  fileNamePrefix: 'P16',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});


//////////////////////////////////////////////////////////////////
// Immagine del 2021


//=========================================
// Collezione immagini Sentinel-2
//=========================================

var collection20 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2021-05-01', '2021-06-30') // range temporale
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print(collection20.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite20 = collection20.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
var first20 = ee.Image(collection20.first());
Map.addLayer(first20, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First image RGB 20');

// Composite mediano RGB
Map.addLayer(composite20, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB 20');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite20.select(['B2','B3','B4','B8','B11']),  // Include tutte le bande che mi servono per l'analisi
  description: 'P21',
  folder: 'GEE_exports',
  fileNamePrefix: 'P21',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});


////////////////////////////////////////////////////////////////
// Immagine del 2026

//=========================================
// Collezione immagini Sentinel-2
//=========================================

var collection25 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2026-05-01', '2026-06-30') // range temporale: mesi di luglio e agosto
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20%.
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print(collection25.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite25 = collection25.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
var first25 = ee.Image(collection25.first());
Map.addLayer(first25, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'First image RGB 25');

// Composite mediano RGB
Map.addLayer(composite25, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB 25');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite25.select(['B2','B3','B4','B8', 'B11']),  // Include tutte le bande che mi servono per l'analisi
  description: 'P26',
  folder: 'GEE_exports',
  fileNamePrefix: 'P26',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});

