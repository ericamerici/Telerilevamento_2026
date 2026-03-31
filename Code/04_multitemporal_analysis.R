# Code for performing multitemporal analysis with satellite imagery

library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
install.packages("ggridges")
library(ggridges)

im.list()

EN_01 <- im.import("EN_01.png")
EN_01 <- flip(EN_01)
plot(EN_01)

EN_13 <- im.import("EN_13.png")
EN_13 <- flip(EN_13)
plot(EN_13)

# Plot the two images one on top of the other one
im.multiframe(2,1)
plot(EN_01)
plot(EN_13)

# Differencing
ENdif <- EN_01[[1]]-EN_13[[1]]
plot(ENdif)

#  Greenland example: import all the greenland data and create a stack
g2000 <- im.import("greenland.2000.tif")
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")
sg <- c(g2000, g2005, g2010, g2015)
plot(sg)

gr <- im.import("greenland") #per importare tutte le immagini che iniziano con questa parola
im.multiframe(1,2)
plot(gr[[1]], col=plasma(100))
plot(gr[[4]], col=plasma(100))

dif <- gr[[4]]-gr[[1]]
plot(dif)

# RGB
im.plotRGB(gr, r=1, g=2, b=4)

# ndvi 
ndvi <- im.import("Sentinel2_NDVI_2020")
plot(ndvi, col=magma(100))

# histograms
hist(ndvi)

# ridgeline plotting
im.ridgeline(ndvi, scale=1) #scale 1 é perché il picco sia al massimo a 1 rettangolo (quindi non si sovrappone agli altri)
# pero me ne viene solo 1, perché hanno tutti lo stesso nome (NDVI) quindi ogni volta sovrascrive il plot precedente. quindi cambio i nomi:

names(ndvi) <- c("02_feb", "05_may", "08_aug", "11_nov")
ndvi # ora vedo che hanno questi nomi
im.ridgeline(ndvi, scale=1, palette="viridis") 
im.ridgeline(ndvi, scale=2, palette="viridis") # si sovrappone ma non esageratamente, la più interessante
# da immagini a rappresentazioni statistiche

plot(ndvi[[1]], ndvi[[2]])
pairs(ndvi)

# y=x
# y=a+bx
# y=0+1x=x
# a=0
# b=1

#insert the line x=y
abline(0,1)

# mettiamo i limiti delle due variabili che siano gli stessi per ottenere una linea a 45
plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3,0.9), ylim=c(-0.3,0.9))
abline(0,1, col="red")


