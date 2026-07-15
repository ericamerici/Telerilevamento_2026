>Erica Merici

# Analisi Multitemporale dello Stato di Conservazione della Vegetazione nel Parco di Gutturu Mannu (2015–2025)

Scaletta:
Introduzione
Obiettivi
Localizzazione
Data Gathering e Metodologia
Calcolo Indici
Analisi
Conclusioni
Bibliografia


# Introduzione

Il **Parco Naturale Regionale di Gutturu Mannu**, situato nel settore sud-occidentale della Sardegna, rappresenta **una delle più estese foreste mediterranee italiane**. L'area ospita boschi di leccio, sughera e macchia mediterranea di elevato valore naturalistico, costituendo un importante habitat per numerose specie vegetali e animali.

Negli ultimi decenni gli ecosistemi forestali mediterranei sono stati sottoposti a numerose pressioni ambientali, tra cui:

- cambiamenti climatici;
- siccità estive sempre più frequenti;
- incendi boschivi;
- pressione antropica.

In particolare, la zona meridionale della Sardegna risulta estremamente vulnerabile ai fenomeni di siccità e di desertificazione. 

Per questo motivo il monitoraggio dello stato della vegetazione mediante tecniche di telerilevamento rappresenta uno strumento fondamentale per valutare l'efficacia della conservazione del patrimonio forestale.


<img width="660" height="500" alt="gutturu_mannu" src="https://github.com/user-attachments/assets/f710ab78-ffed-481a-a9a2-7bc7721c3b85" />


>Parco Gutturu Mannu. Immagine da [maps.adac.de](https://maps.adac.de/poi/parco-naturale-regionale-di-gutturu-mannu?bounds=39.01488,8.73298-39.18642,9.05142).


# Obiettivo

L'obiettivo principale del progetto è **valutare l'evoluzione dello stato della vegetazione** del Parco, analizzando le **immagini satellitari** in tre momenti distinti: 2015, 2020 e 2025. Tale analisi si sviluppa attorno al calcolo di **indici spettrali** legati alla vegetazione, quali:
- **DVI** (Difference Vegetation Index);
- **NDVI** (Normalized Difference Vegetation Index);
- **NDMI** (Normalized Difference Moist Index).
  
## Giustificazione
L'analisi è stata sviluppata nei limiti del parco per valutare l'efficacia di enti di protezione come quella del Parco Naturale Regionale.

# Raccolta dati e metodologia

## Raccolta delle immagini
Lo shapefile del Parco è stato scaricato dal sito web di [Sardegna GeoPortale](https://www.sardegnageoportale.it/index.html).

Le immagini sono state scaricate attraverso il sito web di [Google Earth Engine](https://earthengine.google.com/), importando lo shapefile del parco come cartella compressa .zip, contentente i formati .cpg, .dbf, .prj, .qmd, .shp, .shx. 

> [!NOTE]
>
> Il codice completo in JavaScript utilizzato per ottenere le immagini si trova nel file Gee.js

## Impostazione della working directory
````R
setwd("C:/Users/Erica/OneDrive/Documents/RS_R") # set working directory
getwd() # get working directory
````

## Caricamento pacchetti

Vengono caricati i pacchetti necessari per il progetto in R.

````R
library(terra)  
library(imageRy) # utile per alcune funzioni di visualizzazione o di calcolo degli indici
library(viridis) # visualizzazione mappe con colori adatti a colorblind
library(ggplot2)  # creazione grafici
library(patchwork) # combinazione grafici
library(ggridges)  # creazione grafici di tipo ridge plot
````

## Importazione raster Sentinel-2

Si importano i raster dalla cartella impostata come working directory. I raster sono stati scaricati da Google Drive, dove erano stati salvati attraverso Google Earth Engine in formato .tif.

````R
gutturu15 <- rast("S15.tif")
gutturu20 <- rast("S20.tif")
gutturu25 <- rast("S25.tif")
````
> [!NOTE]
> Come specificato nel file del codice GEE, il periodo considerato è quello estivo, specificatamente i mesi di luglio e agosto, in tutti e tre gli anni. Si è scelto questo periodo in quanto la vegetazione è maggiormente stressata: si ricerca di valutarne lo stato di salute nei momenti di stress idrico e di maggiore esposizione agli incendi.




## Visualizzazione immagini
### 2015

Vengono visualizzate tutte le bande comprese nell'immagine importata, attraverso il plottaggio.

````R
plot(gutturu15)
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione im.multiframe()
````R
im.multiframe(2,3)
plot(gutturu15[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu15[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu15[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu15[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu15[[5]], main = "B11 - SWIR", col=cividis(100))
````
<img width="1536" height="738" alt="Bande15im" src="https://github.com/user-attachments/assets/cda51e27-6c98-4af8-8a43-7755a4176e1a" />

Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione.
````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu15, r=3, g=2, b=1, title = "Colori naturali (2015)")

# plot RGB, nir in red
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)")

# plot RGB, nir in blue
im.plotRGB(gutturu15, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2015)")
````

<img width="1536" height="738" alt="RGB15" src="https://github.com/user-attachments/assets/e3d5a6c9-9993-4c3f-ab16-985e433dd38d" />

### 2020

Si compie lo stesso procedimento con le immagine relative al periodo estivo del 2020.

````R
plot(gutturu20)
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione im.multiframe()
````R
im.multiframe(2,3)
plot(gutturu20[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu20[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu20[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu20[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu20[[5]], main = "B11 - SWIR", col=cividis(100))
````


Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione.
````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu20, r=3, g=2, b=1, title = "Colori naturali (2020)")

# plot RGB, nir in red
im.plotRGB(gutturu20, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2020)")

# plot RGB, nir in blue
im.plotRGB(gutturu20, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2020)")
````


# Bibliografia e Sitografia
Ministero dell’Ambiente e della Tutela del territorio e del Mare
Comitato Nazionale per la Lotta alla Siccità e alla Desertificazione (2006). La vulnerabilità
alla desertificazione in Italia:
raccolta, analisi, confronto
e verifica delle procedure
cartografiche di mappatura
e degli indicatori a scala
nazionale e locale. [link](https://www.isprambiente.gov.it/contentfiles/00003400/3468-manuali-2006-40.pdf/)
