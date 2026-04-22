# R code for classifying images

library(terra)
library(imageRy)

# set wd
setwd("C:/Users/Erica/OneDrive/Documents/UNIVERSITA'/GEOGRAFIA/TELERILEVAMENTO IN R/data_ext")
getwd()

im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# classification

sunc <- im.classify(sun, num_clusters=3, seed=19)

# import Grand Canyon data
can <- im.import("dolansprings_oli_2013088_canyon_lrg.jpg")

# classify grand canyon data
cancc <- im.classify(can, num_clusters=4, seed=19)

# import data
getwd()
img <- rast("DSC_3747.JPG")
img <- flip(img)
plot(img)

# classify data

imgc <- im.classify(img, num_clusters=4, seed=19)

# Mato grosso examples
im.list()

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")    

im.multiframe(1,2)
plot(m1992)
plot(m2006)

m1992c <- im.classify(m1992, num_clusters=2, seed=19)

# Assign labels
levels(m1992c) <- data.frame(
  value = c(1, 2),
  label = c("forest", "human")
)

m2006c <- im.classify(m2006, num_clusters=2, seed=19)
                     
# Assign labels
levels(m2006c) <- data.frame(
  value = c(1, 2),
  label = c("forest", "human")
)

# Calculating frequencies

freq1992 <- freq(m1992c) 
perc1992 <- freq1992$count*100/ncell(m1992c)
perc1992

freq2006 <- freq(m2006c) 
perc2006 <- freq2006$count*100/ncell(m2006c)
perc2006

# Creating table

tabout <- data.frame(
  class=c("Forest", "Human"),
  perc1992=c(83,17),
  perc2006=c(45,55)
  )

  
