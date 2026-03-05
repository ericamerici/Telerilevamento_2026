# R code for visualizing satellite images

library(terra)
library(imageRy)

install.packages("viridis")
library(viridis)

install.packages("ggplot2")
library(ggplot2)

# Listing data
im.list()

# Importing images
b2 <- im.import("sentinel.dolomites.b2.tif")

# Changing colors
cl <- colorRampPalette(c("darkolivegreen", "brown1", "gold"))(100)
plot(b2, col=cl)

cl <- colorRampPalette(c("darkolivegreen", "brown1", "gold"))(3)
plot(b2, col=cl)

# Viridis palette
plot(b2, col=inferno(100))

# Exercise plot b2 with mako
plot(b2, col=mako(100))

# Exercise plot b2 with a grey scale palette
cl <- colorRampPalette(c("gray10", "gray47", "gray91"))(100)
plot(b2, col=cl)

# Multiframe
par(mfrow=c(1,2))
plot(b2, col=cl)
plot(b2, col=inferno(100))

# Kill the device
dev.off()

# Multiframe
im.multiframe(1,2)
plot(b2, col=cl)
plot(b2, col=inferno(100))

# Importing band 3
b3 <- im.import("sentinel.dolomites.b3.tif")

# Exercise changing colors in viridis
plot(b3, col=cividis(100))

# Importing band 4
b4 <- im.import("sentinel.dolomites.b4.tif")

# Importing band 8
b8 <- im.import("sentinel.dolomites.b8.tif")

# Exercise: multiframe with four bands, legends: in line with the wavelength
im.multiframe(2,2)

cl2 <- colorRampPalette(c("red4", "red2", "red"))(100)
plot(b2, col=cl2)

cl3 <- colorRampPalette(c("green4", "green2", "green"))(100)
plot(b3, col=cl3)

cl4 <- colorRampPalette(c("blue4", "blue2", "blue"))(100)
plot(b4, col=cl4)

cl8 <- colorRampPalette(c("orangered4", "orangered2", "orangered"))(100)
plot(b8, col=cl8)

im.multiframe(2,2)
plot(b2, col=inferno(100))
plot(b3, col=inferno(100))
plot(b4, col=inferno(100))
plot(b8, col=inferno(100))

sentinel <- c(b2, b3, b4, b8)
plot(sentinel)
plot(sentinel, col=inferno(100))

# Names bands sentinel images
names(sentinel)

plot(sentinel$sentinel.dolomites.b8)

# layer1=b2, layer2=b3, layer3=b4, layer4=b8
plot(sentinel[[4]])


