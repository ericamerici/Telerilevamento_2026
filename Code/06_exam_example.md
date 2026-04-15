# Ice spread ovvero il titolo della presentazione

In questa riga scrivo l'intro alle mie analisi

<img width="370" height="208" alt="thwaites-glacier-2019-by-robert-larter-1-2053006010" src="https://github.com/user-attachments/assets/bf76a71c-0311-4ddb-bc3d-0beafb1ade06" />

## Immagine satellitare da internet

L'immagine è stata scaricata da [Earth Observatory](https://earthobservatory.nasa.gov/)

Pacchetti in R

```r
library(terra) # package to manage spatial data
```

Importazione dei dati tramite `setwd()`:

```r
setwd("C:/Users/Erica/OneDrive/Documents/UNIVERSITA'/GEOGRAFIA/TELERILEVAMENTO IN R")
getwd()
list.files()
```

Dati importati via `rast()`:

```r
ice <- rast("ISS074-E-417243.jpg")
```

## Plottaggio delle singole bande

Le singole bande sono state plottate usando un multiframe:

```r
im.multiframe(1,2)
plot(ice[[1]])
plot(ice[[2]])
```

Questo l'output del plottaggio

<img width="480" height="480" alt="prime_due_bande" src="https://github.com/user-attachments/assets/65759d8f-7ab6-4a42-9014-de247d6de62a" />

> Nota: l'immagine è già stata analizzata da Earth Observatory

Se vogliamo inserire un elenco puntato basta mettere +
+ punto 1
+ punto 2
+ punto 3



