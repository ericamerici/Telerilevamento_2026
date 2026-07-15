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


## Introduzione

La Sardegna risulta essere una regione particolarmente sensibile alla desertificazione. L’Isola, infatti, è tra le regioni d’Europa a maggior rischio. Le motivazioni sono legate ad un aumento dei processi di degrado del suolo e della vegetazione a seguito di variazioni climatiche, ma soprattutto di attività antropiche.

## Obiettivi

## Localizzazione
La provincia del Sulcis-Iglesiente si trova nella parte sud-occidentale dell'Isola. Si estende per un'area di circa 1 747 km^2 (ISTAT 2026), e comprende le isole di Sant'Antioco e San Pietro. 

### Raccolta delle immagini
Lo shapefile della provincia è stato scaricato dal sito web di [ISTAT](https://www.istat.it/notizia/confini-delle-unita-amministrative-a-fini-statistici-al-1-gennaio-2018-2/). La definizione delle province della Sardegna tende a variare spesso, a seconda delle amministrazioni. Si è scaricata la cartella .zip dei limiti amministrativi del 2026, è stata esportata solo la provincia di Sulcis Iglesiente tramite Qgis.

Le immagini sono state scaricate attraverso il sito web di [Google Earth Engine](https://earthengine.google.com/), importando lo shapefile della provincia come cartella compressa .zip, contentente i formati .cpg, .dbf, .prj, .qmd, .shp, .shx. 

> [!NOTE]
>
> Il codice completo in JavaScript utilizzato per ottenere le immagini si trova nel file Gee.js

## Impostazione della working directory
````md
setwd("C://Users/giuli/OneDrive/telexam/")
````

## Caricamento pacchetti
````md
library(terra)  
library(imageRy)  
library(viridis)
library(ggridges)
library(ggplot2)  
library(patchwork)  
````


