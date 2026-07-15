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

In particolare, la zona meridionale della Sardegna risulta estremamente vulnerabile ai fenomeni appena elencati. Da decenni, negli studi sulla vulnerabilità alla desertificazione (2006), tale zona emerge fortemente, insieme ad altri territori prevalentemente pugliesi e siciliani.

Per questo motivo il monitoraggio dello stato della vegetazione mediante tecniche di telerilevamento rappresenta uno strumento fondamentale per valutare l'efficacia della conservazione del patrimonio forestale.


<img width="660" height="500" alt="gutturu_mannu" src="https://github.com/user-attachments/assets/f710ab78-ffed-481a-a9a2-7bc7721c3b85" />


>Parco Gutturu Mannu. Immagine da [maps.adac.de](https://maps.adac.de/poi/parco-naturale-regionale-di-gutturu-mannu?bounds=39.01488,8.73298-39.18642,9.05142).


# Obiettivo

L'obiettivo principale del progetto è **valutare l'evoluzione dello stato della vegetazione** del Parco, analizzando le **immagini satellitari** in tre momenti distinti: 2015, 2020 e 2025. Tale analisi si sviluppa attorno al calcolo di **indici spettrali** legati alla vegetazione, quali:
- **DVI** (Difference Vegetation Index);
- **NDVI** (Normalized Difference Vegetation Index);
- **NDMI** (Normalized Difference Moist Index).
  
## Giustificazione
L'analisi è stata sviluppata nei limiti del parco per valutare l'efficacia di enti di protezione come quella del Parco Naturale Regionale, caratterizzata da politiche di conservazione e da una struttura molto diversa dal territorio circostante. Si è deciso di analizzare questo parco perché risulta una foresta stabile e significativa per la salute ambientale e umana dell'intera regione, ma è localizzata in un contesto particolarmente vulnerabile alla desertificazione. 

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
#### Visualizzazione singole bande

Vengono visualizzate tutte le bande comprese nell'immagine importata, attraverso il plottaggio.

````R
plot(gutturu15)
dev.off() # eliminare il plot
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione `im.multiframe()`
````R
im.multiframe(2,3)
plot(gutturu15[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu15[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu15[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu15[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu15[[5]], main = "B11 - SWIR", col=cividis(100))

dev.off()
````
<img width="1536" height="738" alt="Bande15im" src="https://github.com/user-attachments/assets/cda51e27-6c98-4af8-8a43-7755a4176e1a" />

#### Visualizzazione RGB

Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione.
````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu15, r=3, g=2, b=1, title = "Colori naturali (2015)")

# plot RGB, nir in red
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)")

# plot RGB, nir in blue
im.plotRGB(gutturu15, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2015)")

dev.off()
````

<img width="1536" height="738" alt="RGB15" src="https://github.com/user-attachments/assets/e3d5a6c9-9993-4c3f-ab16-985e433dd38d" />

### 2020

Si compie lo stesso procedimento con le immagine relative al periodo estivo del 2020.

#### Visualizzazione singole bande

````R
plot(gutturu20)
dev.off()
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione `im.multiframe()`.
````R
im.multiframe(2,3)
plot(gutturu20[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu20[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu20[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu20[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu20[[5]], main = "B11 - SWIR", col=cividis(100))

dev.off()
````
<img width="1536" height="738" alt="bande20" src="https://github.com/user-attachments/assets/9bb11784-5a22-406b-bbfd-e5cb766725aa" />


#### Visualizzazione RGB
Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione, sempre utilizzando la funzione `im.multiframe()`
````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu20, r=3, g=2, b=1, title = "Colori naturali (2020)")

# plot RGB, nir in red
im.plotRGB(gutturu20, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2020)")

# plot RGB, nir in blue
im.plotRGB(gutturu20, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2020)")

dev.off()
````
<img width="1536" height="738" alt="RGB20" src="https://github.com/user-attachments/assets/07f767a9-7eec-42a7-8d88-7d7ecabf0712" />


### 2025

Si ripete lo stesso procedimento per l'anno 2025, sempre nei mesi di luglio e agosto.

#### Visualizzazione singole bande

````R
plot(gutturu25)
dev.off()
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione `im.multiframe()`
````R
im.multiframe(2,3)
plot(gutturu25[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu25[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu25[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu25[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu25[[5]], main = "B11 - SWIR", col=cividis(100))

dev.off()
````
<img width="1536" height="738" alt="bande25im" src="https://github.com/user-attachments/assets/76469277-7c72-4631-86e6-206c69211e93" />


#### Visualizzazione RGB
Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione, sempre utilizzando la funzione `im.multiframe()`

````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu25, r=3, g=2, b=1, title = "Colori naturali (2025)")

# plot RGB, nir in red
im.plotRGB(gutturu25, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2025)")

# plot RGB, nir in blue
im.plotRGB(gutturu25, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2025)")

dev.off()
````

<img width="1536" height="738" alt="RGB25" src="https://github.com/user-attachments/assets/936dd6cc-c192-4960-8d00-a3ceb79d25ef" />

# Calcolo Indici

## DVI

L'indice DVI (Difference Vegetation Index)

Si visualizza l'indice DVI per ogni anno considerato.

````R
# 2015
dvi15 <- im.dvi(gutturu15, 4, 3)

# 2020
dvi20 <- im.dvi(gutturu20, 4, 3)

# 2025
dvi25 <- im.dvi(gutturu25, 4, 3)
````

Si visualizzano tutti e tre i risultati tramite la funzione `im.multiframe()`.
````R
im.multiframe(1,3)
plot(dvi15, main = "DVI 2015", col=viridis(100))
plot(dvi20, main = "DVI 2020", col=viridis(100))
plot(dvi25, main = "DVI 2025", col=viridis(100))

dev.off()
````
<img width="1536" height="738" alt="dvi" src="https://github.com/user-attachments/assets/10d38462-7298-448a-8de0-fd8bc65cbd8e" />


## NDVI

Si visualizza l'indice DVI per ogni anno considerato.

````R
# 2015
ndvi15 <- im.ndvi(gutturu15, 4, 3)

# 2020
ndvi20 <- im.ndvi(gutturu20, 4, 3)

# 2025
ndvi25 <- im.ndvi(gutturu25, 4, 3)
````

Si visualizzano tutti e tre i risultati tramite la funzione `im.multiframe()`.
````R
im.multiframe(1,3)
plot(ndvi15, main = "NDVI 2015", col=viridis(100))
plot(ndvi20, main = "NDVI 2020", col=viridis(100))
plot(ndvi25, main = "NDVI 2025", col=viridis(100))

dev.off()
````
<img width="1536" height="738" alt="ndvi" src="https://github.com/user-attachments/assets/f602a8e7-da39-44c3-82f2-a2a727c70bb9" />


## NDMI

Si visualizza l'indice DVI per ogni anno considerato.

````R
# 2015
ndmi15 <- (gutturu15[[4]]-gutturu15[[5]])/(gutturu15[[4]]+gutturu15[[5]])

# 2020
ndmi20 <- (gutturu20[[4]]-gutturu20[[5]])/(gutturu20[[4]]+gutturu20[[5]])

# 2025
ndmi25 <- (gutturu25[[4]]-gutturu25[[5]])/(gutturu25[[4]]+gutturu25[[5]])
````

Si visualizzano tutti e tre i risultati tramite la funzione `im.multiframe()`.

````R
im.multiframe(1,3)
plot(ndmi15, main = "NDMI 2015", col=viridis(100))
plot(ndmi20, main = "NDMI 2020", col=viridis(100))
plot(ndmi25, main = "NDMI 2025", col=viridis(100))

dev.off()
````
<img width="1536" height="738" alt="ndmi" src="https://github.com/user-attachments/assets/a5cfba50-3033-4c69-a2d2-32b0cb0d9dcc" />


# Analisi multitemporale

## Visualizzazione in RGB

Innanzittutto, si visualizzano le diverse immagini RGB per avere un confronto indicativo. Si selezionano solamente le composizioni a colori naturali e a falsi colori con la banda NIR nel rosso.

````R
im.multiframe (2,3)

# plot RGB, colori naturali 2015
im.plotRGB(gutturu15, r=3, g=2, b=1, title = "Colori naturali (2015)")

# plot RGB, colori naturali 2020
im.plotRGB(gutturu20, r=3, g=2, b=1, title = "Colori naturali (2020)")

# plot RGB, colori naturali 2025
im.plotRGB(gutturu25, r=3, g=2, b=1, title = "Colori naturali (2025)")

# plot RGB, nir in red 2015
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)")

# plot RGB, nir in red 2020
im.plotRGB(gutturu20, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2020)")

# plot RGB, nir in red 2025
im.plotRGB(gutturu25, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2025)")

dev.off()
````
<img width="1536" height="738" alt="AMultiTRGB" src="https://github.com/user-attachments/assets/17a539d0-7d35-430e-a710-f44898a780d1" />

## Variazione degli indici

La variazione degli indici è espressa in due modi: 

- una differenza spettrale dei risultati degli anni 2015 e 2025;
- una comparazione attraverso il ridge plot di tutti e tre gli anni presi in considerazione.

#### ΔDVI

````R
dvi.diff <- dvi15 - dvi25
````

#### ΔNDVI

````R
ndvi.diff <- ndvi15 - ndvi25
````

#### ΔNDMI

````R
dvi.diff <- ndmi15 - ndmi25
````

### Differenza spettrale

Si visualizzano insieme attraverso la funzione `im.multiframe()`

````R
# Visualizzazione dei tre risultati
im.multiframe(1,3)
plot(dvi.diff, main = "ΔDVI", col=magma(100))
plot(ndvi.diff, main = "ΔNDVI", col=magma(100))
plot(ndmi.diff, main = "ΔNDMI", col=magma(100))

dev.off()
````

<img width="1536" height="738" alt="delta" src="https://github.com/user-attachments/assets/5ef50dba-fa59-44d2-8e67-08848c4c93e7" />

### Ridge plots

#### ΔDVI

````R
dvi_ridg=c(dvi15, dvi20, dvi25)  
names(dvi_ridg) =c("DVI 2015", "DVI 2020", "DVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(dvi_ridg, scale=2, palette="magma")
````
<img width="1536" height="738" alt="dviRP" src="https://github.com/user-attachments/assets/d71671ac-c4fa-4d59-900f-dfe623ebd98a" />

#### ΔNDVI

````R
ndvi_ridg=c(ndvi15, ndvi20, ndvi25)  
names(ndvi_ridg)=c("NDVI 2015", "NDVI 2020", "NDVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndvi_ridg, scale=2, palette="magma")
````

<img width="1536" height="738" alt="ndviRP" src="https://github.com/user-attachments/assets/48a1e1b1-2308-4a97-a010-a2d7405c08ac" />


#### ΔNDMI

````R
ndmi_ridg=c(ndmi15, ndmi20, ndmi25)  
names(ndmi_ridg)=c("NDMI 2015", "NDMI 2020", "NDMI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndmi_ridg, scale=2, palette="magma")

````

<img width="1536" height="738" alt="ndmiRP" src="https://github.com/user-attachments/assets/dba352e3-e365-4a64-806b-ca7129145d9e" />



# Conclusioni



# Bibliografia e Sitografia
Ministero dell’Ambiente e della Tutela del territorio e del Mare
Comitato Nazionale per la Lotta alla Siccità e alla Desertificazione (2006). La vulnerabilità
alla desertificazione in Italia:
raccolta, analisi, confronto
e verifica delle procedure
cartografiche di mappatura
e degli indicatori a scala
nazionale e locale. [link](https://www.isprambiente.gov.it/contentfiles/00003400/3468-manuali-2006-40.pdf/)
