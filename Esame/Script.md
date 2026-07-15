# Analisi multitemporale della desertificazione nella provincia del Sulcis Iglesiente, Sardegna (2017-2025)

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

La Sardegna risulta essere una regione particolarmente sensibile alla desertificazione. L’Isola, infatti, è tra le regioni d’Europa a maggior rischio. Le motivazioni sono legate ad un aumento dei processi di degrado del suolo e della vegetazione a seguito di variazioni climatiche, ma soprattutto di attività antropiche.

![Immagine di Gloria Calvi]<img width="1382" height="914" alt="DesertificazioneSardegna" src="https://github.com/user-attachments/assets/efeb9011-3004-4ef5-9580-4b39ad0183df" />

# Obiettivo

L'obiettivo principale del progetto è **analizzare i cambiamenti** nel tempo di una zona che risulta essere vulnerabile alla desertificazione, analizzando **immagini satellitari** in tre momenti distinti: 2017, 2021 e 2025. Tale analisi si sviluppa attorno al calcolo di **indici spettrali** legati alla vegetazione, quali:
- **DVI** (Difference Vegetation Index);
- **NDVI** (Normalized Difference Vegetation Index).
  
## Giustificazione
L'analisi è stata sviluppata nei limiti di una provincia per facilitare l'azione politica da parte delle amministrazioni, che in questo modo possono venire a conoscenza in modo specifico del territorio sui cui possono e devono agire.

La scelta di questa provincia è dovuta alla sua eterogeneità, che rende il territorio complesso e sfaccettato. La presenza di zone protette e naturali, di zone militare e di spiaggie antropizzate può costituire un interessante punto di partenza per un studio più approfondito, contestuale alle diverse identità e multi-disciplinare.

# Localizzazione
La provincia del Sulcis-Iglesiente si trova nella parte sud-occidentale dell'Isola. Si estende per un'area di circa 1 747 km<sup>2</sup> (ISTAT 2026), e comprende le isole di Sant'Antioco e San Pietro. Al suo interno è presente una porzione di Parco Naturale Regionale di Gutturu Mannu, alcune Zone di Protezione Speciale e Zone Speciali di Conservazione; è presente un importante poligono militare, ovvero il poligono di Capo Teulada. 

Confina a est con la provincia di Cagliari, anch'essa molto vulnerabile alla desertificazione e ancora più antropizzata. 







# Raccolta dati e metodologia

## Raccolta delle immagini
Lo shapefile della provincia è stato scaricato dal sito web di [ISTAT](https://www.istat.it/notizia/confini-delle-unita-amministrative-a-fini-statistici-al-1-gennaio-2018-2/). La definizione delle province della Sardegna tende a variare spesso, a seconda delle amministrazioni. Si è scaricata la cartella .zip dei limiti amministrativi del 2026, è stata esportata solo la provincia di Sulcis Iglesiente tramite Qgis.

Le immagini sono state scaricate attraverso il sito web di [Google Earth Engine](https://earthengine.google.com/), importando lo shapefile della provincia come cartella compressa .zip, contentente i formati .cpg, .dbf, .prj, .qmd, .shp, .shx. 

> [!NOTE]
>
> Il codice completo in JavaScript utilizzato per ottenere le immagini si trova nel file Gee.js

## Impostazione della working directory
````R
setwd("/home/erica/Documenti/RS_R") # set working directory
getwd() # get working directory
````

## Caricamento pacchetti
````R
library(terra)  
library(imageRy) # utile per alcune funzioni di visualizzazione o di calcolo degli indici
library(viridis) # visualizzazione mappe con colori adatti a colorblind
library(ggridges) 
library(ggplot2)  
library(patchwork)  
````

## Importazione raster Sentinel-2



# Bibliografia e Sitografia
Ministero dell’Ambiente e della Tutela del territorio e del Mare
Comitato Nazionale per la Lotta alla Siccità e alla Desertificazione (2006). La vulnerabilità
alla desertificazione in Italia:
raccolta, analisi, confronto
e verifica delle procedure
cartografiche di mappatura
e degli indicatori a scala
nazionale e locale. [link](https://www.isprambiente.gov.it/contentfiles/00003400/3468-manuali-2006-40.pdf/)
