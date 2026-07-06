 Analisi multitemporale

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

# 2017
# import
L17 <- rast("L17.tif")

# plot
plot(L17)

# plot separate bands
im.multiframe(3,2)
plot(L17[[1]], main = "B2 - Blue", col=cividis(100))
plot(L17[[2]], main = "B3 - Green", col=cividis(100))
plot(L17[[3]], main = "B4 - Red", col=cividis(100))
plot(L17[[4]], main = "B8 - NIR", col=cividis(100))
plot(L17[[5]], main = "B11 - SWIR", col=cividis(100))


# plot RGB, colori naturali 
im.plotRGB(L17, r=3, g=2, b=1)

# plot RGB, false color
im.plotRGB(L17, r=4, g=2, b=1)

# plot RGB, blue in red
im.plotRGB(L17, r=3, g=2, b=4)

# 2025
# import
L25 <- rast("L25.tif")

# plot
plot(L25)

# plot separate bands
im.multiframe(3,2)
plot(L25[[1]], main = "B2 - Blue", col=cividis(100))
plot(L25[[2]], main = "B3 - Green", col=cividis(100))
plot(L25[[3]], main = "B4 - Red", col=cividis(100))
plot(L25[[4]], main = "B8 - NIR", col=cividis(100))
plot(L25[[5]], main = "B11 - SWIR", col=cividis(100))


# plot RGB, colori naturali 
im.plotRGB(L25, r=3, g=2, b=1)

# plot RGB, false color
im.plotRGB(L25, r=4, g=2, b=1)

# plot RGB, blue in red
im.plotRGB(L25, r=3, g=2, b=4)

# calcolo DVI
# 2017
dvi17 <- im.dvi(L17, 4, 3)

# 2025
dvi25 <- im.dvi(L25, 4, 3)


# plottaggio insieme
im.multiframe(1,2)
plot(dvi17, main = "DVI 2017", col=viridis(100))
plot(dvi25, main = "DVI 2025", col=viridis(100))

# differenza DVI
dvi.diff <- dvi17 - dvi25
plot(dvi.diff, main = "Delta DVI", col=magma(100))

#NDVI
#2017
ndvi17 <- im.ndvi(L17, 4, 3)

# 2025
ndvi25 <- im.ndvi(L25, 4, 3)


# plottaggio insieme
im.multiframe(1,2)
plot(ndvi17, main = "NDVI 2017", col=viridis(100))
plot(ndvi25, main = "NDVI 2025", col=viridis(100))

# differenza DVI
ndvi.diff <- ndvi17 - ndvi25
plot(ndvi.diff, main = "Delta NDVI", col=magma(100))

# differenza NBDI
ndbi17 <- (L17[[5]]-L17[[4]])/(L17[[5]]+L17[[4]])
plot(ndbi17, main = "NDBI 2017", col=viridis(100))

ndbi25 <- (L25[[5]]-L25[[4]])/(L25[[5]]+L25[[4]])
plot(ndbi25, main = "NDBI 2025", col=viridis(100))

ndbi.diff <- ndbi17 - ndbi25
plot(ndbi.diff, main = "DELTA NDBI", col=viridis(100))
