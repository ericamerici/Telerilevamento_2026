# Script to import data from a computer or Github

library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)

# set working directory
setwd("C:/Users/Erica/OneDrive/Documents/UNIVERSITA'/GEOGRAFIA/TELERILEVAMENTO IN R/drone")

# get the directory 
getwd()

list.files()

rgb <- rast("DJI_20260331174728_0001_D.JPG")
plot(rgb)

red <- rast("DJI_20260331174728_0001_MS_R.TIF")
plot(red)

nir <- rast("DJI_20260331174728_0001_MS_NIR.TIF")
plot(nir)

gre <- rast("DJI_20260331174728_0001_MS_G.TIF")
plot(gre)

stack <- c(gre, red, nir)
plot(stack)

plotRGB(stack, r=3, g=2, b=1, stretch="lin")

plotRGB(stack, 2, 3, 1, stretch="lin")

plotRGB(stack, 2,1,3, stretch="lin") # suolo nudo ingiallito -> nir nel blu

# ndvi -> function (x, nir, red) 
ndvi <- im.ndvi(stack, 3,2)
plot(ndvi, col=magma(100))

# save the data -> function (x, filename, ...)
writeRaster(ndvi, "ndvi.tif")

# reimporting files
ndvi2 <- rast("ndvi.tif")
plot(ndvi2)

# save a plot
im.multiframe(2,2)
plotRGB(stack, r=3, g=2, b=1, stretch="lin")
plotRGB(stack, 2, 3, 1, stretch="lin")
plotRGB(stack, 2,1,3, stretch="lin")
plot(ndvi)

png("figura_per_tesi.png")
im.multiframe(2,2)
plotRGB(stack, r=3, g=2, b=1, stretch="lin")
plotRGB(stack, 2, 3, 1, stretch="lin")
plotRGB(stack, 2,1,3, stretch="lin")
plot(ndvi)
dev.off()

# patchwork
p1 <- im.ggplot(ndvi)
p2 <- im.ridgeline(stack, scale=1, palette="viridis")
p1+p2

png("grafico_statistico.png")
p1 <- im.ggplot(ndvi)
p2 <- im.ridgeline(stack, scale=1, palette="viridis")
p1+p2
dev.off()

# import from GitHub
# link to the data
# raw.githubusercontent.com per usare i DATI e non solo la pagina
nirgit <- rast("https://raw.githubusercontent.com/ducciorocchini/Telerilevamento_2026/main/Drone/DJI_20260331174728_0001_MS_NIR.TIF") 
