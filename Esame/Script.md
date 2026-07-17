>Erica Merici

# Analisi Multitemporale dello Stato di Conservazione della Vegetazione nel Parco di Gutturu Mannu (2015–2025)


# Introduzione

Il **Parco Naturale Regionale di Gutturu Mannu**, situato nel settore sud-occidentale della Sardegna, rappresenta **una delle più estese foreste mediterranee italiane**. L'area ospita boschi di leccio, sughera e macchia mediterranea di elevato valore naturalistico, costituendo un importante habitat per numerose specie vegetali e animali.

Negli ultimi decenni gli ecosistemi forestali mediterranei sono stati sottoposti a numerose pressioni ambientali, tra cui:

- cambiamenti climatici;
- siccità estive sempre più frequenti;
- incendi boschivi;
- pressione antropica.

In particolare, la zona meridionale della Sardegna risulta estremamente vulnerabile ai fenomeni appena elencati. Da decenni, negli studi sulla vulnerabilità alla desertificazione (AA.VV. 2006), tale zona emerge fortemente, insieme ad altri territori prevalentemente pugliesi e siciliani.

Per questo motivo il monitoraggio dello stato della vegetazione mediante tecniche di telerilevamento rappresenta uno strumento fondamentale per valutare l'efficacia della conservazione del patrimonio forestale.


<img width="1920" height="1440" alt="parco" src="https://github.com/user-attachments/assets/ddb3a304-acd7-4a76-9469-2b9c4e463cd8" />


>Parco Gutturu Mannu. Immagine dal [sito del parco](https://www.parcogutturumannu.it/).

### Localizzazione

<img width="3519" height="2488" alt="mappa" src="https://github.com/user-attachments/assets/e5ffa11b-41cc-40b2-bca1-97313ef8794e" />

>Descrizione: Elaborazione propria da dati di Sardegna Geoportale (2023).

# Obiettivo

L'obiettivo principale del progetto è **valutare l'evoluzione dello stato della vegetazione** del Parco, analizzando le **immagini satellitari** in cinque momenti distinti: 2015, 2018, 2020, 2022, e 2025. Tale analisi si sviluppa attorno al calcolo di **indici spettrali** legati alla vegetazione, quali:
- **DVI** (Difference Vegetation Index);
- **NDVI** (Normalized Difference Vegetation Index);
- **NDMI** (Normalized Difference Moist Index);
- **BSI** (Bare Soil Index).
  
## Giustificazione
L'analisi è stata sviluppata nei limiti del parco per valutare l'efficacia di enti di protezione come quella del Parco Naturale Regionale, caratterizzata da politiche di conservazione e da una struttura molto diversa dal territorio circostante. Si è deciso di analizzare questo parco perché risulta una foresta stabile e significativa per la salute ambientale e umana dell'intera regione, ma è localizzata in un contesto particolarmente vulnerabile alla desertificazione. 

Si vuole, in questo modo, fornire agli incaricati all'amministrazione del parco uno strumento che possa apportare ulteriori risultati da combinare con altre analisi legate al campo, ad esempio.

Si è scelto un lasso di tempo di 10 anni, per sfruttare la totalità della missione Sentinel 2. L'istituzione del parco è avvenuta nel 2014, quindi risulta un buon periodo di tempo per verificare l'efficacia di tale istituzione.

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
im.multiframe(1,3) # 1 riga, 3 colonne

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
<img width="1536" height="738" alt="bande18" src="https://github.com/user-attachments/assets/0c9d4d8d-2f3a-436a-ac51-f4748fcd2a60" />


#### Visualizzazione RGB

Si visualizza in RGB: colori naturali, e colori falsati per avere una migliore percezione dello stato della vegetazione. Si utilizza la funzione `im.plotRGB`, appartenente al pacchetto imageRy.
````R
im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu18, r=3, g=2, b=1, title = "Colori naturali (2018)")  # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 1 (BLUE) nel blu; title assegna un titolo all'uscita grafica.

# plot RGB, nir in red
im.plotRGB(gutturu18, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2018)")

# plot RGB, nir in blue
im.plotRGB(gutturu18, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2018)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 4 (NIR) nel blu; accentua maggiormente il contrasto tra vegetazione e suolo nudo

dev.off()
````
<img width="1536" height="738" alt="rgb18" src="https://github.com/user-attachments/assets/f0e3c562-4e28-4964-b18b-75aad3d5e9e8" />


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
<img width="1536" height="738" alt="bande22" src="https://github.com/user-attachments/assets/b3ed1976-2901-49a5-95fe-b9268dc3cfc4" />


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
<img width="1536" height="738" alt="RGB22" src="https://github.com/user-attachments/assets/fc894702-d11d-465f-b682-701543233124" />



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
- si stabilisce un range comune (limiti massimi e minimi) per facitilare il confronto multi-temporale;
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

Si stabilisce un range comune,  affinché stessi colori siano assegnati a stessi valori nelle diverse immagini.
````R
lim_dvi <- range(values(c(dvi15, dvi18, dvi20, dvi22, dvi25)),
                 na.rm = TRUE) # values considera i DN; c rappresenta la concatenazione; na.rm rimuove i no data
````

Si visualizzano tutti e cinque i risultati tramite la funzione `im.multiframe()`.
````R
im.multiframe(2,3)
plot(dvi15, main="DVI 2015", col=viridis(100), range=lim_dvi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(dvi18, main="DVI 2018", col=viridis(100), range=lim_dvi)
plot(dvi20, main="DVI 2020", col=viridis(100), range=lim_dvi)
plot(dvi22, main="DVI 2022", col=viridis(100), range=lim_dvi)
plot(dvi25, main="DVI 2025", col=viridis(100), range=lim_dvi)

dev.off()
````
<img width="1536" height="738" alt="dvirange" src="https://github.com/user-attachments/assets/ef48e2c3-eecb-4dfd-af9f-d64f9cd96777" />

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

Si stabilisce un range comune.
````R
lim_ndvi <- range(values(c(ndvi15, ndvi18, ndvi20, ndvi22, ndvi25)),
                  na.rm = TRUE) # values considera i DN; c rappresenta la concatenazione; na.rm rimuove i no data
````

Si visualizzano tutti e cinque i risultati tramite la funzione `im.multiframe()`.
````R
im.multiframe(2,3)
plot(ndvi15, main="NDVI 2015", col=viridis(100), range=lim_ndvi)
plot(ndvi18, main="NDVI 2018", col=viridis(100), range=lim_ndvi)
plot(ndvi20, main="NDVI 2020", col=viridis(100), range=lim_ndvi)
plot(ndvi22, main="NDVI 2022", col=viridis(100), range=lim_ndvi)
plot(ndvi25, main="NDVI 2025", col=viridis(100), range=lim_ndvi)

dev.off()
````
<img width="1536" height="738" alt="ndvirange" src="https://github.com/user-attachments/assets/7b529e9e-8337-41c8-9140-5c4cc80c4d6e" />

>Commento: Il commento a questo risultato risulta simile all'indice DVI. Lo stato di salute della vegetazione risulta buono e piuttosto stabile. Nell'anno 2015 e 2022 la vegetazione risulta più stressata.

## NDMI

Il NDMI (Normalized Difference Moist Index) misura il contenuto di acqua della vegetazione, dunque risulta un indice importante in contesti di vulnerabilità alla siccità e alla desertificazione. La sua formula è:

$NDMI=\frac{NIR-SWIR}{NIR+SWIR}$

La banda SWIR corrisponde alla B11 in Sentinel, ed è sensibile all'acqua presente nelle foglie:

- più acqua → maggiore assorbimento SWIR;
- meno acqua → maggiore riflettanza SWIR.

Il valore ondeggia tra -1 e 1; maggiore il valore dell'indice più umida risulta la vegetazione. Valori negativi indicano una vegetazione molto secca.

Si visualizza l'indice NMDI per ogni anno considerato.

````R
# Calcolo NDMI, considerando la formula (NIR-SWIR)/(NIR+SWIR)
# 2015
ndmi15 <- (gutturu15[[4]]-gutturu15[[5]])/(gutturu15[[4]]+gutturu15[[5]]) # si sostituisce nella formula le bande corrispondenti: NIR=4, SWIR=5;

# 2018
ndmi18 <- (gutturu18[[4]]-gutturu18[[5]])/(gutturu18[[4]]+gutturu18[[5]])

# 2020
ndmi20 <- (gutturu20[[4]]-gutturu20[[5]])/(gutturu20[[4]]+gutturu20[[5]])

# 2022
ndmi22 <- (gutturu22[[4]]-gutturu22[[5]])/(gutturu22[[4]]+gutturu22[[5]])

# 2025
ndmi25 <- (gutturu25[[4]]-gutturu25[[5]])/(gutturu25[[4]]+gutturu25[[5]])
````

Si stabilisce un range comune.
````R
lim_ndmi <- range(values(c(ndmi15, ndmi18, ndmi20, ndmi22, ndmi25)),
                  na.rm = TRUE) # values considera i DN; c rappresenta la concatenazione; na.rm rimuove i no data
````

Si visualizzano tutti e cinque i risultati tramite la funzione `im.multiframe()`.

````R
im.multiframe(2,3)
plot(ndmi15, main="NDMI 2015", col=viridis(100), range=lim_ndmi) 
plot(ndmi18, main="NDMI 2018", col=viridis(100), range=lim_ndmi)
plot(ndmi20, main="NDMI 2020", col=viridis(100), range=lim_ndmi)
plot(ndmi22, main="NDMI 2022", col=viridis(100), range=lim_ndmi)
plot(ndmi25, main="NDMI 2025", col=viridis(100), range=lim_ndmi)

dev.off()
````
<img width="1536" height="738" alt="ndmirange" src="https://github.com/user-attachments/assets/d11f7f88-da28-4ba5-8119-8f1750205b1a" />


>Commento: La vegetazione presente nel versante occidentale risulta più umida, anche se con valori non altissimi. Questo risultato è in linea con le aspettative, dato che si sta considerando la macchia mediterranea nel suo periodo più secco. Nella zona settentrionale e orientale, nuovamente, la vegetazione è molto più secca. 
A livello multitemporale vi sono lievi cambiamenti, probabilmente dovuti al contesto annuale meteorologico, e nel 2015 e nel 2022 risulta esserci più vegetazione secca rispetto agli altri anni. Emergono cambiamenti nel pattern- In ogni caso, i cambiamenti non sono significativi. 

## BSI

Il BSI (Bare Soil Index) evidenzia la presenza di suolo nudo, per questo è un altro indice utile nell'analisi della siccità e del fenomeno della desertificazione.
La sua formula è:

$BSI=\frac{(SWIR+RED)-(NIR+BLUE)}
{(SWIR+RED)+(NIR+BLUE)}$

Il suolo nudo generalmente:

- riflette maggiormente nel SWIR e nel rosso;
- riflette meno nel NIR rispetto alla vegetazione.

Al contrario rispetto agli altri indici, il BSI evidenzia con numeri positivi una elevata presenza di suolo nuovo, mentre valori minori corrispondono a bassa presenza di suolo nudo. 

````R
# 2015
bsi15 <- ((gutturu15[[5]] + gutturu15[[3]]) - (gutturu15[[4]] + gutturu15[[1]])) /
         ((gutturu15[[5]] + gutturu15[[3]]) + (gutturu15[[4]] + gutturu15[[1]])) # Corrispondenze: SWIR:5; RED:3; NIR:4; BLUE:1
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

Si stabilisce un range comune.
````R
lim_bsi <- range(values(c(bsi15, bsi18, bsi20, bsi22, bsi25)),
                 na.rm = TRUE) # values considera i DN; c rappresenta la concatenazione; na.rm rimuove i no data
````

Si visualizzano tutti e cinque i risultati tramite la funzione `im.multiframe()`.

````R
# Plottaggio insieme BSI

im.multiframe(2,3)
plot(bsi15, main="BSI 2015", col=viridis(100), range=lim_bsi) 
plot(bsi18, main="BSI 2018", col=viridis(100), range=lim_bsi)
plot(bsi20, main="BSI 2020", col=viridis(100), range=lim_bsi)
plot(bsi22, main="BSI 2022", col=viridis(100), range=lim_bsi)
plot(bsi25, main="BSI 2025", col=viridis(100), range=lim_bsi)
````
<img width="1536" height="738" alt="bsirange" src="https://github.com/user-attachments/assets/b65247d3-c5ab-4703-a236-7d58cdcaf1a4" />

>Commento: Le immagini risultano scure perché i valori bassi corrispondono a presenza di vegetazione. Ci sono alcune zone in cui si evidenziano valori maggiori, nella zona a nord ed a ovest, soprattutto nel 2015 e nel 2025.
Si riscontrano alcuni cambiamenti di pattern.

# Analisi multitemporale tra gli anni

## Visualizzazione in RGB

Innanzittutto, si visualizzano le diverse immagini RGB per avere un confronto indicativo. Si selezionano solamente le composizioni a colori naturali e a falsi colori con la banda NIR nel rosso.

````R
im.multiframe (2,5)

# plot RGB, colori naturali 2015
im.plotRGB(gutturu15, r=3, g=2, b=1, title = "Colori naturali (2015)") 

# plot RGB, colori naturali 2018
im.plotRGB(gutturu20, r=3, g=2, b=1, title = "Colori naturali (2020)")

# plot RGB, colori naturali 2020
im.plotRGB(gutturu18, r=3, g=2, b=1, title = "Colori naturali (2018)")

# plot RGB, colori naturali 2022
im.plotRGB(gutturu22, r=3, g=2, b=1, title = "Colori naturali (2022)")

# plot RGB, colori naturali 2025
im.plotRGB(gutturu25, r=3, g=2, b=1, title = "Colori naturali (2025)")

# plot RGB, nir in red 2015
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)") # nir nel rosso, rosso nel verde, verde nel blu

# plot RGB, nir in red 2018
im.plotRGB(gutturu18, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2018)")

# plot RGB, nir in red 2020
im.plotRGB(gutturu20, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2020)")

# plot RGB, nir in red 2022
im.plotRGB(gutturu22, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2022)")

# plot RGB, nir in red 2025
im.plotRGB(gutturu25, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2025)")

dev.off()
````
<img width="1536" height="738" alt="rgbdelta" src="https://github.com/user-attachments/assets/5b7ae0df-ed92-4517-b1e5-3d2fc431ce02" />

>Commento: si può notare come in generale ci siano differenze tra gli anni (soprattutto tra 2015, e 2022 da un lato, e gli altri anni dall'altro), ma che non siano differenze significative.

## Variazione degli indici

La variazione degli indici è espressa in due modi: 

- una differenza spettrale dei risultati degli anni 2015 e 2025;
- una comparazione attraverso il ridge plot di tutti e cinque gli anni presi in considerazione.

### Differenza spettrale

#### ΔDVI

Si calcola la differenza tra l'indice DVI del 2015 e del 2025.

````R
dvi.diff <- dvi15 - dvi25
````

#### ΔNDVI

Si calcola la differenza tra l'indice NDVI del 2015 e del 2025.

````R
ndvi.diff <- ndvi15 - ndvi25
````

#### ΔNDMI

Si calcola la differenza tra l'indice NDMI del 2015 e del 2025.

````R
dvi.diff <- ndmi15 - ndmi25
````

#### ΔBSI

Si calcola la differenza tra l'indice BSI del 2015 e del 2025.

````R
bsi.diff <- bsi15 - bsi25
````

Si visualizzano insieme attraverso la funzione `im.multiframe()`

````R
# Visualizzazione dei risultati
im.multiframe(2,2)
plot(dvi.diff, main = "ΔDVI 2015-2025", col=magma(100))
plot(ndvi.diff, main = "ΔNDVI 2015-2025", col=magma(100))
plot(ndmi.diff, main = "ΔNDMI 2015-2025", col=magma(100))
plot(bsi.diff, main = "ΔBSI 2015-2025", col=magma(100))

dev.off()
````

<img width="1536" height="738" alt="delta" src="https://github.com/user-attachments/assets/8a429f03-763d-47a5-9a79-59c607139410" />

>Commento: si notano alcuni cambiamenti tra il 2015 e il 2020, come era già stato notato nel calcolo degli indici spettrali, soprattutto per quanto riguarda alcuni pattern.

> [!NOTE]
>A differenza degli altri indici, il BSI associa a numeri positivi il suolo nudo, per questa ragione i risultati risultano inversi.

### Ridge plots

Per completare l'analisi spaziale degli indici di vegetazione, è stata effettuata un'analisi della distribuzione statistica dei valori pixel mediante grafici ridgeline (ridge plots). Questa rappresentazione permette di confrontare contemporaneamente la distribuzione dei valori degli indici spettrali nei diversi anni analizzati, evidenziando eventuali variazioni nella risposta della vegetazione nel tempo.

#### ΔDVI

````R
# DVI
  
dvi_ridg=c(dvi15, dvi18, dvi20, dvi22, dvi25)  # concatenazione degli indici di ogni anno
names(dvi_ridg) =c("DVI 2015", "DVI 2018", "DVI 2020", "DVI 2022", "DVI 2025") # Assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(dvi_ridg, scale=2, palette="magma")

dev.off()
````
<img width="1536" height="738" alt="dviRP" src="https://github.com/user-attachments/assets/69fd0578-24e2-4779-9c21-b49ba8337988" />

>Commento: come già previsto, il cambio tra i diversi anni non è accentuato; la maggior parte dei pixel si trovano sempre attorno al valore 0.2; il 2015 e il 2022 sono costituiti da maggiori pixel vero il valore 0.2, mentre gli altri anni presentano una maggiore quantità con valori più elevati, segno che la vegetazione si trova in uno stato di salute migliore.


#### ΔNDVI

````R
# NDVI

ndvi_ridg=c(ndvi15, ndvi18, ndvi20, ndvi22, ndvi25)  
names(ndvi_ridg) =c("NDVI 2015", "NDVI 2018, "NDVI 2020", "NDVI 2022", "NDVI 2025") 
im.ridgeline(ndvi_ridg, scale=2, palette="magma")

dev.off()
````

<img width="1536" height="738" alt="ndviRP" src="https://github.com/user-attachments/assets/8b092ade-3a91-4021-8490-15a2c6724b95" />

>Commento: in modo simile all'indice DVI, non emergono significative differenze, a parte per una maggiore quantità di valori più bassi negli anni 2015 e 2022. In generale, come già notato in precedenza, i valori sono conformi alle aspettative, ovvero piuttosto alti, in quanto si tratta di vegetazione forestale in stato di protezione, dunque in salute.

#### ΔNDMI

````R
# NDMI

ndmi_ridg=c(ndmi15, ndmi18, ndmi20, ndmi22, ndmi25)  
names(ndmi_ridg)=c("NDMI 2015", "NDMI 2018" "NDMI 2020", "NDMI 2022", "NDMI 2025") 
im.ridgeline(ndmi_ridg, scale=2, palette="magma")

dev.off()
````

<img width="1536" height="738" alt="ndmiRP" src="https://github.com/user-attachments/assets/e50d8d21-feee-4dec-bb23-f2dd980687ab" />

>Commento: La distribuzione dei valori è più schiacciata rispetto al NDVI, infatti sebbene si tratti di vegetazione sana, è comunque vegetazione stressata a livello idrico, visto il contesto. Le differenze tra gli anni risultano come da aspettative.

#### ΔBSI

````R
# BSI

bsi_ridg=c(bsi15, bsi18, bsi20, bsi22, bsi25)  
names(bsi_ridg)=c("BSI 2015", "BSI 2018" "BSI 2020", "BSI 2022", "BSI 2025") 
im.ridgeline(bsi_ridg, scale=2, palette="magma")

dev.off()
````
<img width="1536" height="738" alt="bsiRP" src="https://github.com/user-attachments/assets/808b990b-9009-4fc2-9299-39767303ba7f" />

>Commento: i valori scuri indicano l'elevata presenza di vegetazione a discapito del suolo nudo o degradato, pur in minima parte presente.


>[!NOTA] Questo indice viene espresso sul suolo nudo e non sulla vegetazione, per questa ragione i risultati appaiono "inversi" rispetto agli altri indici.


# Classificazione

La classificazione viene svolta per la differenza tra 2015 e 2025. 
Per facilitare l'interpretazione dei risultati e confrontare le diverse immagini, i valori dell'NDMI sono stati raggruppati in quattro classi di stato idrico mediante la funzione `classify()` del pacchetto terra. La classificazione è stata definita attraverso una matrice `class_matrix` contenente, per ciascuna classe, il limite inferiore, il limite superiore e il codice identificativo assegnato. In questo modo ogni pixel del raster viene ricondotto a una categoria che rappresenta il livello di disponibilità idrica della vegetazione.

````R

# Creazione della matrice di classificazione per l'indice NDMI
# Ogni riga definisce un intervallo di valori NDMI e la classe assegnata

class_matrix <- matrix(c(
  -Inf, 0.00, 1,   # Classe 1: valori NDMI inferiori a 0 → elevato stress idrico / vegetazione molto secca
   0.00, 0.20, 2,  # Classe 2: valori NDMI tra 0 e 0.20 → stress idrico moderato
   0.20, 0.40, 3,  # Classe 3: valori NDMI tra 0.20 e 0.40 → buono stato idrico della vegetazione
   0.40, Inf, 4    # Classe 4: valori NDMI superiori a 0.40 → elevato contenuto idrico / vegetazione molto umida
), ncol = 3, byrow = TRUE) # ncol: la matrice ha tre colonne: valore minimo, valore massimo, classe assegnata; byrow: valori vengono inseriti riga per riga
````
````R
# Classificazione 15-25
ndmi15_cl <- classify(ndmi15, class_matrix)
ndmi25_cl <- classify(ndmi25, class_matrix)

# Plottaggio assegnando i colori a ciascuna classe
im.multiframe(1,2)
plot(ndmi15_cl, col = c("red", "orange", "yellowgreen", "darkgreen"), main = "NDMI classificato 2015") # il rosso è associato alla 1 classe, l'arancione alla 2, il giallo-verde alla 3 e il verdescuro alla 4

plot(ndmi25_cl, col = c("red", "orange", "yellowgreen", "darkgreen"), main = "NDMI classificato 2025")  
````

<img width="1536" height="738" alt="ndmi classificato" src="https://github.com/user-attachments/assets/5dc8df55-658a-48c6-9076-05ea50cc5289" />

>Commento: si nota un aumento della classe con elevato contenuto idrico e una diminuzione della classe a stress idrico elevato.

## Grafici di uscita

Per visualizzare la classificazione, è utile riportare il grafico corrispondente.

### Calcolo frequenze e percentuali

Dopo la classificazione dei raster NDMI, è stata calcolata la distribuzione spaziale delle classi attraverso la funzione `freq()` del pacchetto terra. Questa funzione permette di ottenere il numero di celle (pixel) appartenenti a ciascuna classe NDMI. Successivamente, il numero di pixel di ogni classe è stato convertito in percentuale rispetto al numero totale di celle del raster, al fine di quantificare la superficie occupata da ciascuna categoria di stato idrico della vegetazione.

````R
freq_2015 <- freq(ndmi15_cl)
freq_2025 <- freq(ndmi25_cl)

perc_2015 <- freq_2015$count * 100 / ncell(ndmi15_cl) # ncell è il numero di pixel totali del raster
perc_2025 <- freq_2025$count * 100 / ncell(ndmi25_cl)
````

### Tabella

I risultati ottenuti dal calcolo delle frequenze percentuali sono stati organizzati in una tabella tramite la funzione `data.frame()`. La tabella riporta, per ciascuna classe di stato idrico definita sulla base dell'NDMI, la percentuale di superficie occupata negli anni 2015 e 2025. Questo permette un confronto diretto della variazione della distribuzione delle classi tra i due periodi analizzati.

````R
# Creazione tabella
tabout <- data.frame(
  Classe = c("Stress elevato", "Stress moderato", "Buono stato idrico", "Elevato contenuto idrico"), # concatenazione delle 4 classi
  NDMI2015 = round(perc_2015, 2), # round arrotonda a 2 cifre decimali per semplificare la leggibilità
  NDMI2025 = round(perc_2025, 2)
)

tabout # visualizzazione della tabella in R
````
| Classe                     | NDMI2015 (%) | NDMI2025 (%) |
|----------------------------|-------------:|-------------:|
| Stress elevato             |         4.61 |         3.07 |
| Stress moderato            |        12.83 |        10.42 |
| Buono stato idrico         |        13.47 |        13.91 |
| Elevato contenuto idrico   |         1.81 |         5.33 |

### Grafici a confronto

Per rappresentare graficamente la distribuzione percentuale delle classi NDMI nei due anni analizzati è stato utilizzato il pacchetto `ggplot2`. Sono stati creati due grafici a barre separati, uno relativo al 2015 e uno al 2025, nei quali l'asse delle ascisse riporta le classi di stato idrico della vegetazione e l'asse delle ordinate la percentuale di superficie occupata da ciascuna classe. Tramite il pacchetto `patchwork`, i due grafici sono stati successivamente affiancati per permettere un confronto visivo immediato delle variazioni avvenute nel tempo.

````R
p15 <- ggplot(tabout, aes(x=Classe, y=NDMI2015, fill = Classe)) + # ggplot crea il grafico a partire dalla tabella; la variabile classe viene usata nelle ascisse, la variabile indice nelle ordinate; fill = Classe identifica che le barre vengono riempite in modo diverso a seconda della classe; 
   geom_bar(stat = "identity") + # creazione del grafico a barre; stat = "identity" indica a ggplot2 di non fare altri conteggi;
  scale_fill_manual(values = c(
    "Stress elevato" = "red",
    "Stress moderato" = "orange",
    "Buono stato idrico" = "yellowgreen",
    "Elevato contenuto idrico" = "darkgreen"
      )) + # assegnazione colori di riempimento alle classi
  ylim(c(0,20)) + # limiti
  theme(legend.position="none")  # rimuovere la legenda

p25 <- ggplot(tabout, aes(x=Classe, y=NDMI2025, fill=Classe)) + # stessa cosa, con il 2025
   geom_bar(stat = "identity") +
  scale_fill_manual(values = c(
    "Stress elevato" = "red",
    "Stress moderato" = "orange",
    "Buono stato idrico" = "yellowgreen",
    "Elevato contenuto idrico" = "darkgreen"
      )) + 
  ylim(c(0,20)) + 
  theme(legend.position="none")  

p15 + p25
````
<img width="1536" height="738" alt="tabella" src="https://github.com/user-attachments/assets/8da070fc-0418-4d42-bba9-b0af32f62432" />

>Commento: La vegetazione con stress moderato e con buono stato idrico non è cambiata di molto: i maggiori cambiamenti si rivelano nella percentuale di vegetazione a stress elevato, e in quella di vegetazione a elevato contenuto idrico, come anche mostrano le percentuali nella tabella.

# Conclusioni

L'analisi multitemporale degli indici spettrali (NDVI, DVI, NDMI e BSI) ha evidenziato una sostanziale stabilità della vegetazione del Parco di Gutturu Mannu tra il 2015 e il 2025. Non sono emerse variazioni significative tali da indicare un processo di degrado diffuso o di desertificazione.

In particolare, l'NDMI si è rivelato un indice particolarmente utile, poiché consente di valutare il contenuto idrico della vegetazione, un aspetto fondamentale negli ecosistemi mediterranei, dove la disponibilità di acqua rappresenta uno dei principali fattori che influenzano lo stato della copertura vegetale.

È importante considerare che la desertificazione è un fenomeno che si sviluppa su scale temporali molto lunghe. Un periodo di dieci anni può evidenziare gli effetti di annate particolarmente siccitose, ma non è sufficiente per valutare con certezza l'evoluzione di un processo di desertificazione. La stabilità osservata potrebbe inoltre essere favorita dallo stato di tutela del parco, che contribuisce a limitare le pressioni antropiche e a preservare gli ecosistemi.

Infine, questo studio mostra come il telerilevamento rappresenti uno strumento efficace per il monitoraggio della vegetazione, consentendo analisi rapide e ripetibili nel tempo. Tuttavia, i risultati devono essere interpretati insieme ad altre informazioni, come dati climatici e osservazioni sul campo, per ottenere una valutazione più completa dello stato e dell'evoluzione degli ecosistemi.

# Bibliografia e Sitografia
Ministero dell’Ambiente e della Tutela del territorio e del Mare
Comitato Nazionale per la Lotta alla Siccità e alla Desertificazione (2006). La vulnerabilità
alla desertificazione in Italia:
raccolta, analisi, confronto
e verifica delle procedure
cartografiche di mappatura
e degli indicatori a scala
nazionale e locale. [link](https://www.isprambiente.gov.it/contentfiles/00003400/3468-manuali-2006-40.pdf/)

GeoPortale Sardegna https://www.sardegnageoportale.it/

Sardegna Arpa https://www.sar.sardegna.it/

# Appendice

## Pacchetto sic

Siccome questo studio risulta sensato in una prospettiva di più largo periodo, e nell'ottica che sia utile per monitorare il parco per il tema siccità e desertificazione, è stato creato un pacchetto che semplifica alcune azioni svolte in questo progetto. 

Per l'installazione:
```r
library(devtools)
install_github("ericamerici/sic")
```

In particolare, sono state create le funzioni:

````R
sic.ndmi()
sic.bsi()
````
dove

````R
# NDMI 
# Normalized Difference Moist Index, useful when water must be detected in the vegetation
# How to use (an example)
# park2025 <- rast("p25.tif")
# ndmi2025 <- sic.ndmi(park2025, 5, 4)
# plot(ndmi2025)

sic.ndmi <- function(x, swir, nir) { 
  
  # Controllo che l'immagine in input sia un oggetto SpatRaster del pacchetto terra
  if (!inherits(x, "SpatRaster")) {
    stop("Input image should be a SpatRaster object.")
  }
  
  # Controllo che gli indici delle bande SWIR e NIR siano valori numerici
  if (!is.numeric(swir) || !is.numeric(nir)) {
    stop("SWIR and NIR must be numeric.")
  }
  
  # Calcolo dell'indice NDMI:
  # (NIR - SWIR) / (NIR + SWIR)
  # L'indice evidenzia il contenuto idrico della vegetazione
  ndmi <- (x[[nir]] - x[[swir]]) /
          (x[[nir]] + x[[swir]])
  
  # Restituisce il raster risultante con i valori NDMI calcolati
  return(ndmi)

}
````
e

````R
# BSI
# Bare Soil Index, useful when soil must be detected in relationship with vegetation
# How to use (an example)
# park2025 <- rast("p25.tif")
# bsi2025 <- sic.ndmi(park2025, 5, 3, 4, 1)
# plot(bsi2025)


sic.bsi <- function(x, swir, red, nir, blue) {

# Controllo che l'immagine in input sia un oggetto SpatRaster del pacchetto terra
  if (!inherits(x, "SpatRaster")) {
    stop("Input image should be a SpatRaster object.")
  }

 # Controllo che gli indici delle bande SWIR, RED, NIR E BLUE siano valori numerici
  if (!is.numeric(swir) || !is.numeric(red) || !is.numeric(nir) || !is.numeric(blue)) {
    stop("SWIR, RED, NIR and BLUE must be numeric.")
  }

 # Calcolo dell'indice BSI:
  # ((SWIR+RED) - (NIR+BLUE) / ((SWIR+RED) + (NIR+BLUE))
  # L'indice evidenzia la presenza di suolo rispetto alla vegetazione
  bsi <- ((x[[swir]] + x[[red]]) - (x[[nir]] + x[[blue]])) /
         ((x[[swir]] + x[[red]]) + (x[[nir]] + x[[blue]]))

 # Restituisce il raster risultante con i valori BSI calcolati
  return(bsi)
}
````
