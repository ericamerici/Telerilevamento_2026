# Analisi Multitemporale dello Stato di Conservazione della Vegetazione nel Parco di Gutturu Mannu (2015–2025)


# set working directory
setwd("/home/erica/Documenti/RS_R")

# get the directory 
getwd()

list.files()

# caricamento pacchetti 
library(terra)  
library(imageRy)  
library(viridis)
library(ggridges)
library(ggplot2)  
library(patchwork) 


# importazione di tutti i file raster
    gutturu15 <- rast("S15.tif")
    gutturu20 <- rast("S20.tif")
    gutturu25 <- rast("S25.tif")

# 2015
# plot
plot(gutturu15)
dev.off()

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine uscente in .png
png("Bande15.png",
    width = 1600,
    height = 1200,
    res = 200)
im.multiframe(3,2)
plot(gutturu15[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu15[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu15[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu15[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu15[[5]], main = "B11 - SWIR", col=cividis(100))
dev.off()

png("RGB15.png",
    width = 1600,
    height = 1200,
    res = 200)
plot(gutturu15)
dev.off()
# plot RGB, colori naturali 
im.plotRGB(gutturu15, r=3, g=2, b=1)

# plot RGB, false color
im.plotRGB(gutturu15, r=4, g=3, b=2)

# plot RGB, blue in red
im.plotRGB(gutturu15, r=3, g=2, b=4)

# 2025
# import
S25 <- rast("S25.tif")

# plot
plot(S25)

# plot separate bands
im.multiframe(3,2)
plot(S25[[1]], main = "B2 - Blue", col=cividis(100))
plot(S25[[2]], main = "B3 - Green", col=cividis(100))
plot(S25[[3]], main = "B4 - Red", col=cividis(100))
plot(S25[[4]], main = "B8 - NIR", col=cividis(100))
plot(S25[[5]], main = "B11 - SWIR", col=cividis(100))


# plot RGB, colori naturali 
im.plotRGB(S25, r=3, g=2, b=1)

# plot RGB, false color
im.plotRGB(S25, r=4, g=2, b=1)

# plot RGB, blue in red
im.plotRGB(S25, r=3, g=2, b=4)

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
ndmi17 <- (S17[[4]]-S17[[5]])/(S17[[4]]+S17[[5]])
plot(ndmi17, main = "NDBI 2017", col=viridis(100))

ndmi25 <- (S25[[4]]-S25[[5]])/(S25[[4]]+S25[[5]])
plot(ndmi25, main = "NDBI 2025", col=viridis(100))

ndmi.diff <- ndmi17 - ndmi25
plot(ndmi.diff, main = "DELTA NDMI", col=viridis(100))
