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
# calcolo DVI
# 2017
dvi15 <- im.dvi(gutturu15, 4, 3)

# 2025
dvi25 <- im.dvi(gutturu25, 4, 3)


# plottaggio insieme
im.multiframe(1,2)
plot(dvi15, main = "DVI 2015", col=viridis(100))
plot(dvi25, main = "DVI 2025", col=viridis(100))

# differenza DVI
dvi.diff <- dvi15 - dvi25
plot(dvi.diff, main = "Delta DVI", col=magma(100))

#NDVI
#2017
ndvi15 <- im.ndvi(gutturu15, 4, 3)

# 2025
ndvi25 <- im.ndvi(gutturu25, 4, 3)


# plottaggio insieme
im.multiframe(1,2)
plot(ndvi15, main = "NDVI 2015", col=viridis(100))
plot(ndvi25, main = "NDVI 2025", col=viridis(100))

# differenza DVI
ndvi.diff <- ndvi15 - ndvi25
plot(ndvi.diff, main = "Delta NDVI", col=magma(100))



# differenza NDMI
ndmi15 <- (gutturu15[[4]]-gutturu15[[5]])/(gutturu15[[4]]+gutturu15[[5]])
plot(ndmi15, main = "NDMI 2017", col=viridis(100))

ndmi25 <- (gutturu25[[4]]-gutturu25[[5]])/(gutturu25[[4]]+gutturu25[[5]])
plot(ndmi25, main = "NDMI 2025", col=viridis(100))

ndmi.diff <- ndmi15 - ndmi25
plot(ndmi.diff, main = "DELTA NDMI", col=viridis(100))
