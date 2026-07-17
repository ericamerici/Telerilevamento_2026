# Analisi Multitemporale dello Stato di Conservazione della Vegetazione nel Parco di Gutturu Mannu (2015–2025)


# set working directory
setwd("C:/Users/Erica/OneDrive/Documents/RS_R")

# get the directory 
getwd()

list.files()

# caricamento pacchetti 
library(terra)  
library(imageRy) # utile per alcune funzioni di visualizzazione o di calcolo degli indici
library(viridis) # visualizzazione mappe con colori adatti a colorblind
library(ggplot2)  # creazione grafici
library(patchwork) # combinazione grafici


# importazione di tutti i file raster
    gutturu15 <- rast("S15.tif")
    gutturu18 <- rast("S18.tif")
    gutturu20 <- rast("S20.tif")
    gutturu22 <- rast("S22.tif")
    gutturu25 <- rast("S25.tif")

################################ 2015

# per plottare
plot(gutturu15)
dev.off() # per eliminare il device appena creato

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine in .png

im.multiframe(2,3) # 2 righe e 3 colonne
plot(gutturu15[[1]], main = "B2 - Blue", col=cividis(100)) # [[]] corrisponde alla banda da plottare, alla quale si assegna un titolo "main" e una palette di colori; 100 è il numero di tonalità
plot(gutturu15[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu15[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu15[[4]], main = "B8 - NIR", col=cividis(100)) # Near Infrared
plot(gutturu15[[5]], main = "B11 - SWIR", col=cividis(100)) # Shortwave Infrared

# visualizzazione dell'immagine in RGB

im.multiframe(1,3) # 1 riga, 3 colonne

# plot RGB, colori naturali 
im.plotRGB(gutturu15, r=3, g=2, b=1, title = "Colori naturali (2015)")  # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 1 (BLUE) nel blu; title assegna un titolo all'uscita grafica.

# plot RGB, nir in red
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)")  # visualizza la banda 4 (NIR) nel rosso, la banda 3 (RED) nel verde e la banda 2 (GREEN) nel blu;

# plot RGB, nir in blue
im.plotRGB(gutturu15, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2015)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 4 (NIR) nel blu; accentua maggiormente il contrasto tra vegetazione e suolo nudo

dev.off()

################################ 2018

# plottaggio bande

plot(gutturu18)
dev.off()

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine in .png

im.multiframe(2,3)
plot(gutturu18[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu18[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu18[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu18[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu18[[5]], main = "B11 - SWIR", col=cividis(100))

dev.off()

# visualizzazione in RGB

im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu18, r=3, g=2, b=1, title = "Colori naturali (2018)")  # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 1 (BLUE) nel blu; title assegna un titolo all'uscita grafica.

# plot RGB, nir in red
im.plotRGB(gutturu18, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2018)") # visualizza la banda 4 (NIR) nel rosso, la banda 3 (RED) nel verde e la banda 2 (GREEN) nel blu;

# plot RGB, nir in blue
im.plotRGB(gutturu18, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2018)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 4 (NIR) nel blu; accentua maggiormente il contrasto tra vegetazione e suolo nudo


################################ 2020

# plot
plot(gutturu20)
dev.off()

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine in .png

im.multiframe(2,3)
plot(gutturu20[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu20[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu20[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu20[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu20[[5]], main = "B11 - SWIR", col=cividis(100))

# visualizzazione dell'immagine in RGB

im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu20, r=3, g=2, b=1, title = "Colori naturali (2020)")  # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 1 (BLUE) nel blu; title assegna un titolo all'uscita grafica.

# plot RGB, nir in red
im.plotRGB(gutturu20, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2020)") # visualizza la banda 4 (NIR) nel rosso, la banda 3 (RED) nel verde e la banda 2 (GREEN) nel blu;

# plot RGB, nir in blue
im.plotRGB(gutturu20, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2020)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 4 (NIR) nel blu; accentua maggiormente il contrasto tra vegetazione e suolo nudo

################################ 2022

# plot
plot(gutturu2022)
dev.off()

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine in .png

im.multiframe(2,3)
plot(gutturu22[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu22[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu22[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu22[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu22[[5]], main = "B11 - SWIR", col=cividis(100))

# visualizzazione dell'immagine in RGB

im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu22, r=3, g=2, b=1, title = "Colori naturali (2022)")  # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 1 (BLUE) nel blu; title assegna un titolo all'uscita grafica.

# plot RGB, nir in red
im.plotRGB(gutturu22, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2022)") # visualizza la banda 4 (NIR) nel rosso, la banda 3 (RED) nel verde e la banda 2 (GREEN) nel blu;


# plot RGB, nir in blue
im.plotRGB(gutturu22, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2022)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 4 (NIR) nel blu; accentua maggiormente il contrasto tra vegetazione e suolo nudo

dev.off()

################################ 2025

plot(gutturu25)
dev.off()

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine in .png

im.multiframe(2,3)
plot(gutturu25[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu25[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu25[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu25[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu25[[5]], main = "B11 - SWIR", col=cividis(100))

# visualizzazione dell'immagine in RGB

im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu25, r=3, g=2, b=1, title = "Colori naturali (2025)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 1 (BLUE) nel blu; title assegna un titolo all'uscita grafica.

# plot RGB, nir in red
im.plotRGB(gutturu25, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2025)") # visualizza la banda 4 (NIR) nel rosso, la banda 3 (RED) nel verde e la banda 2 (GREEN) nel blu;

# plot RGB, nir in blue
im.plotRGB(gutturu25, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2025)") # visualizza la banda 3 (RED) nel rosso, la banda 2 (GREEN) nel verde e la banda 4 (NIR) nel blu; accentua maggiormente il contrasto tra vegetazione e suolo nudo

###################################
# Calcolo indici

# Calcolo DVI con funzione im.dvi(x, NIR, Red), appartenente a imageRy

# 2015
dvi15 <- im.dvi(gutturu15, 4, 3) # 4 è la banda nir, 3 è la banda red

# 2018
dvi18 <- im.dvi(gutturu18, 4, 3)

# 2020
dvi20 <- im.dvi(gutturu20, 4, 3)

# 2022
dvi22 <- im.dvi(gutturu22, 4, 3)

# 2025
dvi25 <- im.dvi(gutturu25, 4, 3)

# stabilire range comune, affinché stessi colori siano assegnati a stessi valori nelle diverse immagini
lim_dvi <- range(values(c(dvi15, dvi18, dvi20, dvi22, dvi25)),
                 na.rm = TRUE) # values considera i DN; na.rm rimuove i no data

# plottaggio insieme DVI

im.multiframe(2,3)
plot(dvi15, main="DVI 2015", col=viridis(100), range=lim_dvi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(dvi18, main="DVI 2018", col=viridis(100), range=lim_dvi)
plot(dvi20, main="DVI 2020", col=viridis(100), range=lim_dvi)
plot(dvi22, main="DVI 2022", col=viridis(100), range=lim_dvi)
plot(dvi25, main="DVI 2025", col=viridis(100), range=lim_dvi)

# Calcolo NDVI con funzione im.dvi(x, NIR, Red), appartenente a imageRy

# 2015
ndvi15 <- im.ndvi(gutturu15, 4, 3)

# 2018
ndvi18 <- im.ndvi(gutturu18, 4, 3)

# 2020
ndvi20 <- im.ndvi(gutturu20, 4, 3)

# 2022
ndvi22 <- im.ndvi(gutturu22, 4, 3)

# 2025
ndvi25 <- im.ndvi(gutturu25, 4, 3)

# stabilire range comune
lim_ndvi <- range(values(c(ndvi15, ndvi18, ndvi20, ndvi22, ndvi25)),
                  na.rm = TRUE) # values considera i DN; na.rm rimuove i no data

# plottaggio insieme NDVI
im.multiframe(2,3)
plot(ndvi15, main="NDVI 2015", col=viridis(100), range=lim_ndvi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(ndvi18, main="NDVI 2018", col=viridis(100), range=lim_ndvi)
plot(ndvi20, main="NDVI 2020", col=viridis(100), range=lim_ndvi)
plot(ndvi22, main="NDVI 2022", col=viridis(100), range=lim_ndvi)
plot(ndvi25, main="NDVI 2025", col=viridis(100), range=lim_ndvi)
dev.off()

# Calcolo NDMI, considerando la formula (NIR-SWIR)/(NIR+SWIR).
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

# Range comune
lim_ndmi <- range(values(c(ndmi15, ndmi18, ndmi20, ndmi22, ndmi25)),
                  na.rm = TRUE) # values considera i DN; na.rm rimuove i no data

# Plottaggio insieme NDMI
im.multiframe(2,3)
plot(ndmi15, main="NDMI 2015", col=viridis(100), range=lim_ndmi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(ndmi18, main="NDMI 2018", col=viridis(100), range=lim_ndmi)
plot(ndmi20, main="NDMI 2020", col=viridis(100), range=lim_ndmi)
plot(ndmi22, main="NDMI 2022", col=viridis(100), range=lim_ndmi)
plot(ndmi25, main="NDMI 2025", col=viridis(100), range=lim_ndmi)

dev.off()

# Calcolo BSI, con la formula (SWIR+RED)-(NIR+BLUE)/(SWIR+RED)+(NIR+BLUE)

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


# Range Comune

lim_bsi <- range(values(c(bsi15, bsi18, bsi20, bsi22, bsi25)), na.rm = TRUE) # values considera i DN; na.rm rimuove i no data

# Plottaggio insieme BSI
im.multiframe(2,3)
plot(bsi15, main="BSI 2015", col=viridis(100), range=lim_bsi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(bsi18, main="BSI 2018", col=viridis(100), range=lim_bsi)
plot(bsi20, main="BSI 2020", col=viridis(100), range=lim_bsi)
plot(bsi22, main="BSI 2022", col=viridis(100), range=lim_bsi)
plot(bsi25, main="BSI 2025", col=viridis(100), range=lim_bsi)

dev.off()

#################################
# Analisi multitemporale

# Visualizzazione RGB

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
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)")

# plot RGB, nir in red 2018
im.plotRGB(gutturu18, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2018)")

# plot RGB, nir in red 2020
im.plotRGB(gutturu20, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2020)")

# plot RGB, nir in red 2022
im.plotRGB(gutturu22, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2022)")

# plot RGB, nir in red 2025
im.plotRGB(gutturu25, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2025)")


dev.off()

### Differenze spettrali degli indici tra il 2015 e il 2025 (Delta)

# differenza DVI
dvi.diff <- dvi15 - dvi25

# differenza NDVI
ndvi.diff <- ndvi15 - ndvi25

# differenza NDMI
ndmi.diff <- ndmi15 - ndmi25

# differenza BSI
bsi.diff <- bsi15 - bsi25


# Visualizzazione dei risultati
im.multiframe(2,2)
plot(dvi.diff, main = "ΔDVI 2015-2025", col=magma(100))
plot(ndvi.diff, main = "ΔNDVI 2015-2025", col=magma(100))
plot(ndmi.diff, main = "ΔNDMI 2015-2025", col=magma(100))
plot(bsi.diff, main = "ΔBSI 2015-2025", col=magma(100))

### Ridge plot (per tutti gli indici e per tutti gli anni)

# DVI
  
dvi_ridg=c(dvi15, dvi18, dvi20, dvi22, dvi25)  # creazione dello stack
names(dvi_ridg) =c("DVI 2015", "DVI 2018", "DVI 2020", "DVI 2022", "DVI 2025") # assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(dvi_ridg, scale=2, palette="magma")

# NDVI

ndvi_ridg=c(ndvi15, ndvi18, ndvi20, ndvi22, ndvi25)  
names(ndvi_ridg)=c("NDVI 2015", "NDVI 2018", "NDVI 2020", "NDVI 2022", "NDVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndvi_ridg, scale=2, palette="magma")

# NDMI

ndmi_ridg=c(ndmi15, ndmi18, ndmi20, ndmi22, ndmi25)  
names(ndmi_ridg)=c("NDMI 2015", "NDMI 2018", "NDMI 2020", "NDMI 2022", "NDMI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndmi_ridg, scale=2, palette="magma")

# BSI

bsi_ridg=c(bsi15, bsi18, bsi20, bsi22, bsi25)  
names(bsi_ridg)=c("BSI 2015", "BSI 2018", "BSI 2020", "BSI 2022", "BSI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(bsi_ridg, scale=2, palette="magma")

####################################################
####################################################
####################################################

# Creazione della matrice di classificazione per l'indice NDMI
# Ogni riga definisce un intervallo di valori NDMI e la classe assegnata

class_matrix <- matrix(c(
  -Inf, 0.00, 1,   # Classe 1: valori NDMI inferiori a 0 → elevato stress idrico / vegetazione molto secca
   0.00, 0.20, 2,  # Classe 2: valori NDMI tra 0 e 0.20 → stress idrico moderato
   0.20, 0.40, 3,  # Classe 3: valori NDMI tra 0.20 e 0.40 → buono stato idrico della vegetazione
   0.40, Inf, 4    # Classe 4: valori NDMI superiori a 0.40 → elevato contenuto idrico / vegetazione molto umida
), ncol = 3, byrow = TRUE) # ncol: la matrice ha tre colonne: valore minimo, valore massimo, classe assegnata; byrow: valori vengono inseriti riga per riga

# Classificazione 15-25
ndmi15_cl <- classify(ndmi15, class_matrix)
ndmi25_cl <- classify(ndmi25, class_matrix)

# plottaggio

im.multiframe(1,2)
plot(ndmi15_cl,
     col = c(
  "#8C510A",  # marrone: stress elevato
  "#D8B365",  # beige: stress moderato
  "#5AB4AC",  # turchese: buono stato idrico
  "#01665E"   # blu-verde scuro: elevato contenuto idrico
),
     main = "NDMI classificato 2015")

plot(ndmi25_cl,
      col = c(
  "#8C510A",  # marrone: stress elevato
  "#D8B365",  # beige: stress moderato
  "#5AB4AC",  # turchese: buono stato idrico
  "#01665E"   # blu-verde scuro: elevato contenuto idrico
),
     main = "NDMI classificato 2025")  

# Percentuali
freq_2015 <- freq(ndmi15_cl)
freq_2025 <- freq(ndmi25_cl)

perc_2015 <- freq_2015$count * 100 / ncell(ndmi15_cl)
perc_2025 <- freq_2025$count * 100 / ncell(ndmi25_cl)

# Creazione tabella

tabout <- data.frame(
  Classe = c("Stress elevato", "Stress moderato", "Buono stato idrico", "Elevato contenuto idrico"), # concatenazione delle 4 classi
  NDMI2015 = round(perc_2015, 2), # round arrotonda a 2 cifre decimali per semplificare la leggibilità
  NDMI2025 = round(perc_2025, 2)
)

tabout # visualizzazione della tabella in R


# Grafici

p15 <- ggplot(tabout, aes(x=Classe, y=NDMI2015, fill = Classe)) + # ggplot crea il grafico a partire dalla tabella; la variabile classe viene usata nelle ascisse, la variabile indice nelle ordinate; fill = Classe identifica che le barre vengono riempite in modo diverso a seconda della classe; 
   geom_bar(stat = "identity") + # creazione del grafico a barre; stat = "identity" indica a ggplot2 di non fare altri conteggi;
  scale_fill_manual(values = c(
    "Stress elevato" = "#8C510A",
    "Stress moderato" = "#D8B365",
    "Buono stato idrico" = "#5AB4AC",
    "Elevato contenuto idrico" = "#01665E"
      )) + # assegnazione colori di riempimento alle classi
  ylim(c(0,20)) + # limiti
  theme(legend.position="none")  # rimuovere la legenda

p25 <- ggplot(tabout, aes(x=Classe, y=NDMI2025, fill=Classe)) + # stessa cosa, con il 2025
   geom_bar(stat = "identity") +
  scale_fill_manual(values = c(
    "Stress elevato" = "#8C510A",
    "Stress moderato" = "#D8B365",
    "Buono stato idrico" = "#5AB4AC",
    "Elevato contenuto idrico" = "#01665E"
      )) + 
  ylim(c(0,20)) + 
  theme(legend.position="none")  

p15 + p25

p1 + p2 # si usa il pacchetto patchwork
















