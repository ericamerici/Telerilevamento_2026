# Analisi Multitemporale dello Stato di Conservazione della Vegetazione nel Parco di Gutturu Mannu (2015–2025)


# set working directory
setwd("C:/Users/Erica/OneDrive/Documents/RS_R")

# get the directory 
getwd()

list.files()

# caricamento pacchetti 
library(terra)  
library(imageRy)  
library(viridis)
library(ggplot2)  
library(patchwork) 
library(ggridges)

# importazione di tutti i file raster
    gutturu15 <- rast("S15.tif")
    gutturu20 <- rast("S20.tif")
    gutturu25 <- rast("S25.tif")

################################ 2015

# plot
plot(gutturu15)
dev.off()

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine in .png

im.multiframe(2,3)
plot(gutturu15[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu15[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu15[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu15[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu15[[5]], main = "B11 - SWIR", col=cividis(100))
dev.off()

# visualizzazione dell'immagine in RGB

im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu15, r=3, g=2, b=1, title = "Colori naturali (2015)")

# plot RGB, nir in red
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)")

# plot RGB, nir in blue
im.plotRGB(gutturu15, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2015)")

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
im.plotRGB(gutturu20, r=3, g=2, b=1, title = "Colori naturali (2020)")

# plot RGB, nir in red
im.plotRGB(gutturu20, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2020)")

# plot RGB, nir in blue
im.plotRGB(gutturu20, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2020)")


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
im.plotRGB(gutturu25, r=3, g=2, b=1, title = "Colori naturali (2025)")

# plot RGB, nir in red
im.plotRGB(gutturu25, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2025)")

# plot RGB, nir in blue
im.plotRGB(gutturu25, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2025)")

###################################
# Calcolo indici

# Calcolo DVI

# 2015
dvi15 <- im.dvi(gutturu15, 4, 3)

# 2020
dvi20 <- im.dvi(gutturu20, 4, 3)

# 2025
dvi25 <- im.dvi(gutturu25, 4, 3)

# plottaggio insieme DVI

im.multiframe(1,3)
plot(dvi15, main = "DVI 2015", col=viridis(100))
plot(dvi20, main = "DVI 2020", col=viridis(100))
plot(dvi25, main = "DVI 2025", col=viridis(100))

# NDVI

# 2015
ndvi15 <- im.ndvi(gutturu15, 4, 3)

# 2020
ndvi20 <- im.ndvi(gutturu20, 4, 3)

# 2025
ndvi25 <- im.ndvi(gutturu25, 4, 3)

# plottaggio insieme NDVI

im.multiframe(1,3)
plot(ndvi15, main = "NDVI 2015", col=viridis(100))
plot(ndvi20, main = "NDVI 2020", col=viridis(100))
plot(ndvi25, main = "NDVI 2025", col=viridis(100))

# NDMI
#2015
ndmi15 <- (gutturu15[[4]]-gutturu15[[5]])/(gutturu15[[4]]+gutturu15[[5]])

#2020
ndmi20 <- (gutturu20[[4]]-gutturu20[[5]])/(gutturu20[[4]]+gutturu20[[5]])

#2025
ndmi25 <- (gutturu25[[4]]-gutturu25[[5]])/(gutturu25[[4]]+gutturu25[[5]])

# Plottaggio insieme NDMI
im.multiframe(1,3)
plot(ndmi15, main = "NDMI 2015", col=viridis(100))
plot(ndmi20, main = "NDMI 2020", col=viridis(100))
plot(ndmi25, main = "NDMI 2025", col=viridis(100))


#################################
# Analisi multitemporale

### Differenze spettrali degli indici tra il 2015 e il 2025 (Delta)

# differenza DVI
dvi.diff <- dvi15 - dvi25

# differenza NDVI
ndvi.diff <- ndvi15 - ndvi25

# differenza NDMI
ndmi.diff <- ndmi15 - ndmi25


# Visualizzazione dei tre risultati
im.multiframe(1,3)
plot(dvi.diff, main = "ΔDVI 2015-2025", col=magma(100))
plot(ndvi.diff, main = "ΔNDVI 2015-2025", col=magma(100))
plot(ndmi.diff, main = "ΔNDMI 2015-2025", col=magma(100))

### Ridge plot (per tutti gli indici e per tutti gli anni)
  
dvi_ridg=c(dvi15, dvi20, dvi25)  
names(dvi_ridg) =c("DVI 2015", "DVI 2020", "DVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(dvi_ridg, scale=2, palette="magma")

ndvi_ridg=c(ndvi15, ndvi20, ndvi25)  
names(ndvi_ridg)=c("NDVI 2015", "NDVI 2020", "NDVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndvi_ridg, scale=2, palette="magma")

ndmi_ridg=c(ndmi15, ndmi20, ndmi25)  
names(ndmi_ridg)=c("NDMI 2015", "NDMI 2020", "NDMI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndmi_ridg, scale=2, palette="magma")

##################################################
##################################################
# prova con rettangolo

# importazione

A15 <- rast("A15.tif")
A20 <- rast("A20.tif")
A25 <- rast("A25.tif")

# NDVI

# 2015
ndviA15 <- im.ndvi(A15, 4, 3)

# 2020
ndviA20 <- im.ndvi(A20, 4, 3)

# 2025
ndviA25 <- im.ndvi(A25, 4, 3)

ndviA.diff <- ndviA15 - ndviA25

#NDMI

#2015
ndmiA15 <- (A15[[4]]-A15[[5]])/(A15[[4]]+A15[[5]])

#2020
ndmiA20 <- (A20[[4]]-A20[[5]])/(A20[[4]]+A20[[5]])

#2025
ndmiA25 <- (A25[[4]]-A25[[5]])/(A25[[4]]+A25[[5]])

ndmiA.diff <- ndmiA15 - ndmiA25

ndmiA_ridg=c(ndmiA15, ndmiA20, ndmiA25)  
names(ndmiA_ridg)=c("NDMI 2015", "NDMI 2020", "NDMI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndmiA_ridg, scale=2, palette="magma")
