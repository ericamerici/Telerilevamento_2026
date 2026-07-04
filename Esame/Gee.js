//================================================================================================================
//================================================================================================================
// Titolo
// Erica Merici, matricola 0001186080, Telerilevamento Geo-Ecologico in R
// Codice in JavaScript utilizzato per scaricare le immagini satellitari da Google Earth Engine
// https://code.earthengine.google.com/
//================================================================================================================
//================================================================================================================

// Immagine del 2017

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

var aoi = ee.Geometry.Rectangle([-6.5, 41.8, -6.1, 42.1]); // aoi è un rettangolo in coordinate [xmin, ymin, xmax, ymax] = [lonmin, latmin, lonmax, latmax]; GEE interpreta come WGS84/lat-lon.
Map.centerObject(aoi, 11); // centra la mappa su aoi con zoom 11; di solito lo zoom va da 0 a 20.
Map.addLayer(aoi, {color: 'red'}, 'AOI Nome'); // aggiunge il layer di rettangolo rosso sulla mappa. 

//=========================================
// Collezione immagini Sentinel-2
//=========================================

var collection17 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2017-01-01', '2017-12-31') // range temporale
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print('Number of images in collection:', collection17.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite17 = collection17.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
Map.addLayer(collection17, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'Image');

// Composite mediano RGB
Map.addLayer(composite17, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite17.select(['B2','B3','B4','B8','B12']),  // Include tutte le bande che mi servono per l'analisi
  description: 'I17',
  folder: 'GEE_exports',
  fileNamePrefix: 'I17',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});


// Immagine del 2021

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

var aoi = ee.Geometry.Rectangle([-6.5, 41.8, -6.1, 42.1]); // aoi è un rettangolo in coordinate [xmin, ymin, xmax, ymax] = [lonmin, latmin, lonmax, latmax]; GEE interpreta come WGS84/lat-lon.
Map.centerObject(aoi, 11); // centra la mappa su aoi con zoom 11; di solito lo zoom va da 0 a 20.
Map.addLayer(aoi, {color: 'red'}, 'AOI Nome'); // aggiunge il layer di rettangolo rosso sulla mappa. 

//=========================================
// Collezione immagini Sentinel-2
//=========================================

var collection21 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2021-01-01', '20221-12-31') // range temporale
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print('Number of images in collection:', collection21.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite21 = collection21.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
Map.addLayer(collection21, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'Image');

// Composite mediano RGB
Map.addLayer(composite21, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite21.select(['B2','B3','B4','B8','B12']),  // Include tutte le bande che mi servono per l'analisi
  description: 'I21',
  folder: 'GEE_exports',
  fileNamePrefix: 'I21',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});


// Immagine del 2025

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

var aoi = ee.Geometry.Rectangle([-6.5, 41.8, -6.1, 42.1]); // aoi è un rettangolo in coordinate [xmin, ymin, xmax, ymax] = [lonmin, latmin, lonmax, latmax]; GEE interpreta come WGS84/lat-lon.
Map.centerObject(aoi, 11); // centra la mappa su aoi con zoom 11; di solito lo zoom va da 0 a 20.
Map.addLayer(aoi, {color: 'red'}, 'AOI Nome'); // aggiunge il layer di rettangolo rosso sulla mappa. 

//=========================================
// Collezione immagini Sentinel-2
//=========================================

var collection25 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED') // prende la collezione Harmonized, Surface Reflectance
  .filterBounds(aoi) // solo immagini che coprono l'Area of Interest
  .filterDate('2025-01-01', '2025-12-31') // range temporale
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // tiene solo immagini con percentuale di pixel nuvolosi minore del 20% (metadato)
  .map(maskS2clouds); // applica la maschera nubi a ogni immagine della collezione

//=========================================
// Numero di immagini disponibili
//=========================================

print('Number of images in collection:', collection25.size()); // dà quante immagini ci sono dopo i filtri. 

// ==============================================
// Creazione median composite
// ==============================================

var composite25 = collection25.median().clip(aoi); // per ogni pixel e per ogni banda prende il valore mediano tra tutte le immagini disponibili (riduce rumore e outlier); clip() ritaglia il risultato al rettangolo

// ==============================================
// Visualizzazione sulla mappa 
// ==============================================

Map.centerObject(aoi, 10);

// Prima immagine RGB
Map.addLayer(collection25, {
  bands: ['B4','B3','B2'],   // Solo RGB per visualizzazione
  min: 0,
  max: 0.3
}, 'Image');

// Composite mediano RGB
Map.addLayer(composite25, {
  bands: ['B8','B3','B2'],   // Solo false colour per visualizzazione
  min: 0,
  max: 0.3
}, 'Median composite RGB');

// ==============================================
// Export su Google Drive
// ==============================================

Export.image.toDrive({
  image: composite25.select(['B2','B3','B4','B8','B12']),  // Include tutte le bande che mi servono per l'analisi
  description: 'I25',
  folder: 'GEE_exports',
  fileNamePrefix: 'I25',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326', // coordinate reference system
  maxPixels: 1e13
});





