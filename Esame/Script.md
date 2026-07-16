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


<img width="1920" height="1440" alt="parco" src="https://github.com/user-attachments/assets/ddb3a304-acd7-4a76-9469-2b9c4e463cd8" />


>Parco Gutturu Mannu. Immagine dal [sito del parco](https://www.parcogutturumannu.it/).


# Obiettivo

L'obiettivo principale del progetto è **valutare l'evoluzione dello stato della vegetazione** del Parco, analizzando le **immagini satellitari** in cinque momenti distinti: 2015, 2018, 2020, 2022, e 2025. Tale analisi si sviluppa attorno al calcolo di **indici spettrali** legati alla vegetazione, quali:
- **DVI** (Difference Vegetation Index);
- **NDVI** (Normalized Difference Vegetation Index);
- **NDMI** (Normalized Difference Moist Index);
- **BSI** (Bare Soil Index).
  
## Giustificazione
L'analisi è stata sviluppata nei limiti del parco per valutare l'efficacia di enti di protezione come quella del Parco Naturale Regionale, caratterizzata da politiche di conservazione e da una struttura molto diversa dal territorio circostante. Si è deciso di analizzare questo parco perché risulta una foresta stabile e significativa per la salute ambientale e umana dell'intera regione, ma è localizzata in un contesto particolarmente vulnerabile alla desertificazione. 

Si vuole, in questo modo, fornire agli incaricati all'amministrazione del parco uno strumento che possa apportare ulteriori risultati da combinare con altre analisi legate al campo, ad esempio.

Si è scelto un lasso di tempo di 10 anni, per sfruttare la totalità della missione Sentinel 2. 

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
gutturu18 <- rast("S18.tif")
gutturu20 <- rast("S20.tif")
gutturu22 <- rast("S22.tif")
gutturu25 <- rast("S25.tif")
````
> [!NOTE]
> Come specificato nel file del codice GEE, il periodo considerato è quello estivo, specificatamente i mesi di luglio e agosto, in tutti gli anni. Si è scelto questo periodo in quanto la vegetazione è maggiormente stressata: si ricerca di valutarne lo stato di salute nei momenti di stress idrico e di maggiore esposizione agli incendi.




## Visualizzazione immagini
### 2015
#### Visualizzazione singole bande

Vengono visualizzate tutte le bande comprese nell'immagine importata, attraverso il plottaggio.

````R
plot(gutturu15) # funzione che permette di visualizzare l'immagine importata nelle sue diverse bande
dev.off() # eliminare il plot
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione `im.multiframe()`, appartenente al pacchetto imageRy.
````R
im.multiframe(2,3) # 2 righe e 3 colonne
plot(gutturu15[[1]], main = "B2 - Blue", col=cividis(100)) # [[]] corrisponde alla banda da plottare, alla quale si assegna un titolo "main" e una palette di colori; 100 è il numero di tonalità
plot(gutturu15[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu15[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu15[[4]], main = "B8 - NIR", col=cividis(100)) # Near Infrared
plot(gutturu15[[5]], main = "B11 - SWIR", col=cividis(100)) # Shortwave Infrared

dev.off()
````
<img width="1536" height="738" alt="Bande15im" src="https://github.com/user-attachments/assets/cda51e27-6c98-4af8-8a43-7755a4176e1a" />

#### Visualizzazione RGB

Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione.
````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu15, r=3, g=2, b=1, title = "Colori naturali (2015)")  # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 1 (BLUE) nel blu; title assegna un titolo all'uscita grafica.

# plot RGB, nir in red
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)")  # visualizza la banda 4 (NIR) nel rosso, la banda 3 (RED) nel verde e la banda 2 (GREEN) nel blu;

# plot RGB, nir in blue
im.plotRGB(gutturu15, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2015)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 4 (NIR) nel blu; accentua maggiormente il contrasto tra vegetazione e suolo nudo

dev.off()
````

<img width="1536" height="738" alt="RGB15" src="https://github.com/user-attachments/assets/e3d5a6c9-9993-4c3f-ab16-985e433dd38d" />

### 2018

L'anno 2018 è stato un anno meno critico dal punto di vista della siccità [Sardegna ARPAS](https://www.sar.sardegna.it/).

#### Visualizzazione singole bande

Vengono visualizzate tutte le bande comprese nell'immagine importata, attraverso il plottaggio.

````R
plot(gutturu18)
dev.off() # eliminare il plot
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione `im.multiframe()`.
````R
im.multiframe(2,3)
plot(gutturu18[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu18[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu18[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu18[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu18[[5]], main = "B11 - SWIR", col=cividis(100))

dev.off()
````
<img width="1536" height="738" alt="bande18" src="https://github.com/user-attachments/assets/7204744d-405a-48ab-8a56-0d6f824c309f" />


#### Visualizzazione RGB

Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione. Si utilizza la funzione `im.plotRGB`, appartenente al pacchetto imageRy.
````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu18, r=3, g=2, b=1, title = "Colori naturali (2018)")

# plot RGB, nir in red
im.plotRGB(gutturu18, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2018)")

# plot RGB, nir in blue
im.plotRGB(gutturu18, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2018)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 4 (NIR) nel blu; accentua maggiormente il contrasto tra vegetazione e suolo nudo

dev.off()
````
<img width="1536" height="738" alt="rgb18" src="https://github.com/user-attachments/assets/5b3234bc-67b2-464d-af2c-6a90f2ab17ff" />


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

### 2022

Si compie lo stesso procedimento con le immagine relative al periodo estivo del 2022, che è risultato molto secco [Sardegna ARPAS](https://www.sar.sardegna.it/).

#### Visualizzazione singole bande

````R
plot(gutturu22)
dev.off()
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione `im.multiframe()`.
````R
im.multiframe(2,3)
plot(gutturu22[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu22[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu22[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu22[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu22[[5]], main = "B11 - SWIR", col=cividis(100))

dev.off()
````
<img width="1536" height="738" alt="bande22" src="https://github.com/user-attachments/assets/1d81b549-8ae6-4370-8267-83f582d2c95c" />


#### Visualizzazione RGB
Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione, sempre utilizzando la funzione `im.multiframe()`
````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu22, r=3, g=2, b=1, title = "Colori naturali (2022)")

# plot RGB, nir in red
im.plotRGB(gutturu22, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2022)")

# plot RGB, nir in blue
im.plotRGB(gutturu22, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2022)")

dev.off()
````
<img width="1536" height="738" alt="RGB22" src="https://github.com/user-attachments/assets/8f35fbc3-0c49-4a50-8cfe-2bd341f20cb1" />


### 2025

Si ripete lo stesso procedimento per l'anno 2025, sempre nei mesi di luglio e agosto.

#### Visualizzazione singole bande

````R
plot(gutturu25)
dev.off()
````
Si scarica l'immagine in formato .png, utilizzando la visualizzazione `im.multiframe()`.
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

Per ogni indice il procedimento è il seguente: 
- si calcola l'indice attraverso la formula (si tratta di una operazione tra bande);
- si visualizzano i plot di tutti gli anni considerati;
- si interpretano i risultati. 

## DVI

L'indice DVI (Difference Vegetation Index) misura la differenza assoluta tra riflettanza nel vicino infrarosso e nel rosso. Infatti, la sua formula è: 

$DVI=NIR-RED$

- NIR: Infrarosso vicino (che in Sentinel corrisponde alla banda 08);
- RED: Rosso (che in Sentinel corrisponde alla banda 04).

Questo indice si basa sul contrasto della risposta alle due bande da parte di una vegetazione sana:
- NIR: riflette molto;
- RED: assorbe molto.

Maggiori sono i valori del DVI, più vigorosa risulta la vegetazione.

Procedendo, si visualizza l'indice DVI per ogni anno considerato, utilizzando la funzione `im.dvi()`, appartenente al pacchetto imageRy.

````R
# 2015
dvi15 <- im.dvi(gutturu15, 4, 3) # im.dvi(x, NIR, RED)

# 2018
dvi18 <- im.dvi(gutturu18, 4, 3)

# 2020
dvi20 <- im.dvi(gutturu20, 4, 3)

# 2022
dvi22 <- im.dvi(gutturu22, 4, 3)

# 2025
dvi25 <- im.dvi(gutturu25, 4, 3)
````



Si visualizzano tutti e cinque i risultati tramite la funzione `im.multiframe()`.
````R
im.multiframe(2,3)
plot(dvi15, main = "DVI 2015", col=viridis(100))
plot(dvi18, main = "DVI 2018", col=viridis(100))
plot(dvi20, main = "DVI 2020", col=viridis(100))
plot(dvi22, main = "DVI 2022", col=viridis(100))
plot(dvi25, main = "DVI 2025", col=viridis(100))

dev.off()
````
<img width="1536" height="738" alt="dvi5" src="https://github.com/user-attachments/assets/eaed21b5-c8bc-400c-aa88-cda7568b70f6" />

>Commento: Ciò che emerge a livello interno è che nella zona centro-occidentale del parco la vegetazione è più presente e rigorosa, nel versante settentrionale tende ad essere più scarsa, così come nella punta orientale. A livello multitemporale, non si riscontrano grandi differenze.


## NDVI

L'indice NDVI (Normalized Difference Vegetation Index) è simile al DVI, ma standardizzato. La sua formula è: 

$NDVI=\frac{NIR-RED}{NIR+RED}$

e i suoi risultati sono compresi tra -1 e 1.

| Valore NDVI | Interpretazione |
|---|---|
| < 0 | Acqua, neve, superfici molto scure o non vegetate |
| 0 - 0.1 | Suolo nudo, rocce, aree urbanizzate |
| 0.1 - 0.2 | Vegetazione molto rada o fortemente stressata |
| 0.2 - 0.4 | Vegetazione bassa o moderatamente presente (prati, pascoli, arbusti) |
| 0.4 - 0.6 | Vegetazione moderata e in buone condizioni |
| 0.6 - 0.8 | Vegetazione densa e vigorosa (boschi, colture in crescita) |
| > 0.8 | Vegetazione molto fitta e altamente produttiva |


Si visualizza l'indice NDVI per ogni anno considerato, utilizzando la funzione `im.ndvi()`, appartenente al pacchetto imageRy.

````R
# 2015
ndvi15 <- im.ndvi(gutturu15, 4, 3) # im.ndvi(x, NIR, RED)

# 2018
ndvi18 <- im.ndvi(gutturu18, 4, 3)

# 2020
ndvi20 <- im.ndvi(gutturu20, 4, 3)

# 2022
ndvi22 <- im.ndvi(gutturu22, 4, 3)

# 2025
ndvi25 <- im.ndvi(gutturu25, 4, 3)
````



Si visualizzano tutti e cinque i risultati tramite la funzione `im.multiframe()`.
````R
im.multiframe(2,3)
plot(ndvi15, main = "NDVI 2015", col=viridis(100))
plot(ndvi18, main = "NDVI 2018", col=viridis(100))
plot(ndvi20, main = "NDVI 2020", col=viridis(100))
plot(ndvi22, main = "NDVI 2022", col=viridis(100))
plot(ndvi25, main = "NDVI 2025", col=viridis(100))

dev.off()
````
<img width="1536" height="738" alt="ndviL" src="https://github.com/user-attachments/assets/0620276a-3f75-46b8-8c3f-032c1539c439" />

>Commento: Il commento a questo risultato risulta simile all'indice DVI. 

## NDMI

Si visualizza l'indice NMDI per ogni anno considerato.

````R
# 2015
ndmi15 <- (gutturu15[[4]]-gutturu15[[5]])/(gutturu15[[4]]+gutturu15[[5]])

# 2018
ndmi18 <- (gutturu18[[4]]-gutturu18[[5]])/(gutturu18[[4]]+gutturu18[[5]])

# 2020
ndmi20 <- (gutturu20[[4]]-gutturu20[[5]])/(gutturu20[[4]]+gutturu20[[5]])

# 2022
ndmi22 <- (gutturu22[[4]]-gutturu22[[5]])/(gutturu22[[4]]+gutturu22[[5]])

# 2025
ndmi25 <- (gutturu25[[4]]-gutturu25[[5]])/(gutturu25[[4]]+gutturu25[[5]])
````

Si visualizzano tutti e cinque i risultati tramite la funzione `im.multiframe()`.

````R
im.multiframe(2,3)
plot(ndmi15, main = "NDMI 2015", col=viridis(100))
plot(ndmi18, main = "NDMI 2018", col=viridis(100))
plot(ndmi20, main = "NDMI 2020", col=viridis(100))
plot(ndmi22, main = "NDMI 2022", col=viridis(100))
plot(ndmi25, main = "NDMI 2025", col=viridis(100))

dev.off()
````
<img width="1536" height="738" alt="ndmi5" src="https://github.com/user-attachments/assets/56d2422a-5e04-42dd-bc81-2de1510064d4" />

## BSI

````R
# 2015
bsi15 <- ((gutturu15[[5]] + gutturu15[[3]]) - (gutturu15[[4]] + gutturu15[[1]])) /
         ((gutturu15[[5]] + gutturu15[[3]]) + (gutturu15[[4]] + gutturu15[[1]]))
# 2018
bsi18 <- ((gutturu18[[5]] + gutturu18[[3]]) - (gutturu18[[4]] + gutturu18[[1]])) /
         ((gutturu18[[5]] + gutturu18[[3]]) + (gutturu18[[4]] + gutturu18[[1]]))
# 2020

bsi20 <- ((gutturu20[[5]] + gutturu20[[3]]) - (gutturu20[[4]] + gutturu20[[1]])) /
         ((gutturu20[[5]] + gutturu20[[3]]) + (gutturu20[[4]] + gutturu20[[1]]))
# 2022

bsi22 <- ((gutturu22[[5]] + gutturu22[[3]]) - (gutturu22[[4]] + gutturu22[[1]])) /
         ((gutturu22[[5]] + gutturu22[[3]]) + (gutturu22[[4]] + gutturu22[[1]]))
# 2025

bsi25 <- ((gutturu25[[5]] + gutturu25[[3]]) - (gutturu25[[4]] + gutturu25[[1]])) /
         ((gutturu25[[5]] + gutturu25[[3]]) + (gutturu25[[4]] + gutturu25[[1]]))
````

Si visualizzano tutti e cinque i risultati tramite la funzione `im.multiframe()`.

````R
# Plottaggio insieme BSI

im.multiframe(2,3)
plot(bsi15, main = "BSI 2015", col = viridis(100))
plot(bsi18, main = "BSI 2018", col = viridis(100))
plot(bsi20, main = "BSI 2020", col = viridis(100))
plot(bsi22, main = "BSI 2022", col = viridis(100))
plot(bsi25, main = "BSI 2025", col = viridis(100))
````
<img width="1536" height="738" alt="bsi5" src="https://github.com/user-attachments/assets/f5847aa8-6629-46fc-ac0c-966389b4eaa9" />
>Commento: efjnoefnelfvmelfvmàfmv
>elfvnlfnvl

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

#### ΔBSI

````R
bsi.diff <- bsi15 - bsi25
````

### Differenza spettrale

Si visualizzano insieme attraverso la funzione `im.multiframe()`

````R
# Visualizzazione dei tre risultati
im.multiframe(2,2)
plot(dvi.diff, main = "ΔDVI 2015-2025", col=magma(100))
plot(ndvi.diff, main = "ΔNDVI 2015-2025", col=magma(100))
plot(ndmi.diff, main = "ΔNDMI 2015-2025", col=magma(100))
plot(bsi.diff, main = "ΔBSI 2015-2025", col=magma(100))

dev.off()
````

<img width="1536" height="738" alt="delta" src="https://github.com/user-attachments/assets/8a429f03-763d-47a5-9a79-59c607139410" />

### Ridge plots

#### ΔDVI

````R
# DVI
  
dvi_ridg=c(dvi15, dvi18, dvi20, dvi22, dvi25)  
names(dvi_ridg) =c("DVI 2015", "DVI 2018", "DVI 2020", "DVI 2022", "DVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(dvi_ridg, scale=2, palette="magma")

dev.off()
````
<img width="1536" height="738" alt="dviRP" src="https://github.com/user-attachments/assets/970847f7-b867-4388-8ec7-50f28197bbeb" />

#### ΔNDVI

````R
# NDVI

ndvi_ridg=c(ndvi15, ndvi18, ndvi20, ndvi22, ndvi25)  
names(ndvi_ridg) =c("NDVI 2015", "NDVI 2018, "NDVI 2020", "NDVI 2022", "NDVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndvi_ridg, scale=2, palette="magma")

dev.off()
````

<img width="766" height="729" alt="ndviRP" src="https://github.com/user-attachments/assets/c4915012-68ec-440d-ad82-5b1108e4ee9b" />


#### ΔNDMI

````R
# NDMI

ndmi_ridg=c(ndmi15, ndmi18, ndmi20, ndmi22, ndmi25)  
names(ndmi_ridg)=c("NDMI 2015", "NDMI 2018" "NDMI 2020", "NDMI 2022", "NDMI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndmi_ridg, scale=2, palette="magma")

dev.off()
````

<img width="1536" height="738" alt="ndmiRP" src="https://github.com/user-attachments/assets/5c1b66b2-80e5-468e-aea4-b9090a926caf" />

#### ΔBSI

````R
# BSI

bsi_ridg=c(bsi15, bsi18, bsi20, bsi22, bsi25)  
names(bsi_ridg)=c("BSI 2015", "BSI 2018" "BSI 2020", "BSI 2022", "BSI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(bsi_ridg, scale=2, palette="magma")

dev.off()
````
<img width="1536" height="738" alt="bsiRidge" src="https://github.com/user-attachments/assets/3c84e516-3301-4695-91d4-dd8644ace594" />

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
