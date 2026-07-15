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

## Raccolta delle immagini
Lo shapefile della provincia è stato scaricato dal sito web di [ISTAT](https://www.istat.it/notizia/confini-delle-unita-amministrative-a-fini-statistici-al-1-gennaio-2018-2/). La definizione delle province della Sardegna tende a variare spesso, a seconda delle amministrazioni. Si è scaricata la cartella .zip dei limiti amministrativi del 2026, è stata esportata solo la provincia di Sulcis Iglesiente tramite Qgis.

Le immagini sono state scaricate attraverso il sito web di [Google Earth Engine](https://earthengine.google.com/), importando lo shapefile della provincia come cartella compressa .zip, contentente i formati .cpg, .dbf, .prj, .qmd, .shp, .shx. 

> [!NOTE]
>
> Il codice completo in JavaScript utilizzato per ottenere le immagini si trova nel file Code.js
