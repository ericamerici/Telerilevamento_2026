# R code for visualizing satellite images

library(terra)
library(imageRy)
install.packages("viridis")
library(viridis)
install.packages("ggplot2")
library(ggplot2)
install.packages("patchwork")
library(patchwork)

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

# Multiframe 1
par(mfrow=c(1,2))
plot(b2, col=cl)
plot(b2, col=inferno(100))

# Kill the device
dev.off()

# Multiframe 2
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

# Multiframe 3
sentinel <- c(b2, b3, b4, b8)
plot(sentinel)
plot(sentinel, col=inferno(100))

# Names bands sentinel images
names(sentinel)

plot(sentinel$sentinel.dolomites.b8)

# layer1=b2, layer2=b3, layer3=b4, layer4=b8
plot(sentinel[[4]])

# Multiframe 4
#ggplot
?im.ggplot
b2 <- im.import("sentinel.dolomites.b2.tif")
b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")

p1 <- im.ggplot(b8)
p2 <- im.ggplot(b4)

p1+p2

# Multiframe:
# 1. par(mfrow=c(1,2))
# 2. im.multiframe(1,2)
# 3. stack
# 4. ggplot2 patchwork

# RGB plotting
?im.plotRGB
sentinel <- c(b2, b3, b4, b8)

# 1=b2 blue
# 2=b3 green
# 3=b4 red
# 4=b8 nir

# 3 filters and 4 bands
im.plotRGB(sentinel, r=3, g=2, b=1) # natural colors
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors

im.multiframe(1,2)
im.plotRGB(sentinel, r=3, g=2, b=1) # natural colors
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors

plot(sentinel[[4]])
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors

# nir in green
im.plotRGB(sentinel, r=3, g=4, b=2) # false colors

# nir in blue
im.plotRGB(sentinel, r=3, g=2, b=4) # false colors

# Plot the four manners of RGB in a single multiframe
im.multiframe(2,2)
im.plotRGB(sentinel, r=3, g=2, b=1) # natural colors
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors red
im.plotRGB(sentinel, r=3, g=4, b=2) # false colors green
im.plotRGB(sentinel, r=3, g=2, b=4) # false colors blue

# Positioning of visible bands
im.multiframe(1,2)
im.plotRGB(sentinel, r=4, g=2, b=3)  
im.plotRGB(sentinel, r=4, g=3, b=2)  

# Scatter plot
pairs(sentinel)

# Simplifying the function
im.plotRGB(sentinel, 4, 2, 3) # false colors

# plotRGB() from terra
plotRGB(sentinel, 4, 2, 3) # non funziona
plotRGB(sentinel, 4, 2, 3, stretch="lin")
plotRGB(sentinel, 4, 2, 3, stretch="hist")


