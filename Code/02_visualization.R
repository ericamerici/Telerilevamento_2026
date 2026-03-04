# R code for visualizing satellite images

library(terra)
library(imageRy)

install.packages("viridis")
library(viridis)

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
