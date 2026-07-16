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


# importazione di tutti i file raster
    gutturu15 <- rast("S15.tif")
    gutturu18 <- rast("S18.tif")
    gutturu20 <- rast("S20.tif")
    gutturu22 <- rast("S22.tif")
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

################################ 2018

# plottaggio bande

plot(gutturu18)
dev.off()

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine in .png

im.multiframe(2,3)
plot(gutturu18[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu18[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu18[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu18[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu18[[5]], main = "B11 - SWIR", col=cividis(100))

dev.off()

# visualizzazione in RGB

im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu18, r=3, g=2, b=1, title = "Colori naturali (2018)")

# plot RGB, nir in red
im.plotRGB(gutturu18, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2018)")

# plot RGB, nir in blue
im.plotRGB(gutturu18, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2018)")


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

################################ 2022

# plot
plot(gutturu2022)
dev.off()

# visualizzazione dell'immagine importata in tutte le sue bande e scaricata l'immagine in .png

im.multiframe(2,3)
plot(gutturu22[[1]], main = "B2 - Blue", col=cividis(100))
plot(gutturu22[[2]], main = "B3 - Green", col=cividis(100))
plot(gutturu22[[3]], main = "B4 - Red", col=cividis(100))
plot(gutturu22[[4]], main = "B8 - NIR", col=cividis(100))
plot(gutturu22[[5]], main = "B11 - SWIR", col=cividis(100))

# visualizzazione dell'immagine in RGB

im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(gutturu22, r=3, g=2, b=1, title = "Colori naturali (2022)")

# plot RGB, nir in red
im.plotRGB(gutturu22, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2022)")

# plot RGB, nir in blue
im.plotRGB(gutturu22, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2022)")

dev.off()

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

# Calcolo DVI con funzione im.dvi(x, NIR, Red), appartenente a imageRy

# 2015
dvi15 <- im.dvi(gutturu15, 4, 3)

# 2018
dvi18 <- im.dvi(gutturu18, 4, 3)

# 2020
dvi20 <- im.dvi(gutturu20, 4, 3)

# 2022
dvi22 <- im.dvi(gutturu22, 4, 3)

# 2025
dvi25 <- im.dvi(gutturu25, 4, 3)

# stabilire range comune
lim_dvi <- range(values(c(dvi15, dvi18, dvi20, dvi22, dvi25)),
                 na.rm = TRUE) # values considera i DN; na.rm rimuove i no data

# plottaggio insieme DVI

im.multiframe(2,3)
plot(dvi15, main="DVI 2015", col=viridis(100), range=lim_dvi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(dvi18, main="DVI 2018", col=viridis(100), range=lim_dvi)
plot(dvi20, main="DVI 2020", col=viridis(100), range=lim_dvi)
plot(dvi22, main="DVI 2022", col=viridis(100), range=lim_dvi)
plot(dvi25, main="DVI 2025", col=viridis(100), range=lim_dvi)

# Calcolo NDVI con funzione im.dvi(x, NIR, Red), appartenente a imageRy

# 2015
ndvi15 <- im.ndvi(gutturu15, 4, 3)

# 2018
ndvi18 <- im.ndvi(gutturu18, 4, 3)

# 2020
ndvi20 <- im.ndvi(gutturu20, 4, 3)

# 2022
ndvi22 <- im.ndvi(gutturu22, 4, 3)

# 2025
ndvi25 <- im.ndvi(gutturu25, 4, 3)

# stabilire range comune
lim_ndvi <- range(values(c(ndvi15, ndvi18, ndvi20, ndvi22, ndvi25)),
                  na.rm = TRUE)

# plottaggio insieme NDVI
im.multiframe(2,3)
plot(ndvi15, main="NDVI 2015", col=viridis(100), range=lim_ndvi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(ndvi18, main="NDVI 2018", col=viridis(100), range=lim_ndvi)
plot(ndvi20, main="NDVI 2020", col=viridis(100), range=lim_ndvi)
plot(ndvi22, main="NDVI 2022", col=viridis(100), range=lim_ndvi)
plot(ndvi25, main="NDVI 2025", col=viridis(100), range=lim_ndvi)
dev.off()

# Calcolo NDMI, considerando la formula (NIR-SWIR)/(NIR+SWIR).
# 2015
ndmi15 <- (gutturu15[[4]]-gutturu15[[5]])/(gutturu15[[4]]+gutturu15[[5]]) # si sostituisce nella formula le bande corrispondenti: NIR=4, SWIR=5;

# 2018
ndmi18 <- (gutturu18[[4]]-gutturu18[[5]])/(gutturu18[[4]]+gutturu18[[5]])

# 2020
ndmi20 <- (gutturu20[[4]]-gutturu20[[5]])/(gutturu20[[4]]+gutturu20[[5]])

# 2022
ndmi22 <- (gutturu22[[4]]-gutturu22[[5]])/(gutturu22[[4]]+gutturu22[[5]])

# 2025
ndmi25 <- (gutturu25[[4]]-gutturu25[[5]])/(gutturu25[[4]]+gutturu25[[5]])

# Range comune
lim_ndmi <- range(values(c(ndmi15, ndmi18, ndmi20, ndmi22, ndmi25)),
                  na.rm = TRUE)

# Plottaggio insieme NDMI
im.multiframe(2,3)
plot(ndmi15, main="NDMI 2015", col=viridis(100), range=lim_ndmi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(ndmi18, main="NDMI 2018", col=viridis(100), range=lim_ndmi)
plot(ndmi20, main="NDMI 2020", col=viridis(100), range=lim_ndmi)
plot(ndmi22, main="NDMI 2022", col=viridis(100), range=lim_ndmi)
plot(ndmi25, main="NDMI 2025", col=viridis(100), range=lim_ndmi)

dev.off()

# Calcolo BSI, con la formula (SWIR+RED)-(NIR+BLUE)/(SWIR+RED)+(NIR+BLUE)

# 2015
bsi15 <- ((gutturu15[[5]] + gutturu15[[3]]) - (gutturu15[[4]] + gutturu15[[1]])) /
         ((gutturu15[[5]] + gutturu15[[3]]) + (gutturu15[[4]] + gutturu15[[1]])) # Corrispondenze: SWIR:5; RED:3; NIR:4; BLUE:1
# 2018
bsi18 <- ((gutturu18[[5]] + gutturu18[[3]]) - (gutturu18[[4]] + gutturu18[[1]])) /
         ((gutturu18[[5]] + gutturu18[[3]]) + (gutturu18[[4]] + gutturu18[[1]]))
# 2020

bsi20 <- ((gutturu20[[5]] + gutturu20[[3]]) - (gutturu20[[4]] + gutturu20[[1]])) /
         ((gutturu20[[5]] + gutturu20[[3]]) + (gutturu20[[4]] + gutturu20[[1]]))
# 2022

bsi22 <- ((gutturu22[[5]] + gutturu22[[3]]) - (gutturu22[[4]] + gutturu22[[1]])) /
         ((gutturu22[[5]] + gutturu22[[3]]) + (gutturu22[[4]] + gutturu22[[1]]))
# 2025

bsi25 <- ((gutturu25[[5]] + gutturu25[[3]]) - (gutturu25[[4]] + gutturu25[[1]])) /
         ((gutturu25[[5]] + gutturu25[[3]]) + (gutturu25[[4]] + gutturu25[[1]]))


# Range Comune

lim_bsi <- range(values(c(bsi15, bsi18, bsi20, bsi22, bsi25)), na.rm = TRUE)

# Plottaggio insieme BSI
im.multiframe(2,3)
plot(bsi15, main="BSI 2015", col=viridis(100), range=lim_bsi) # range inserisce il plottaggio nei limiti massimi e minimi in comune che sono stati precedentemente stabiliti
plot(bsi18, main="BSI 2018", col=viridis(100), range=lim_bsi)
plot(bsi20, main="BSI 2020", col=viridis(100), range=lim_bsi)
plot(bsi22, main="BSI 2022", col=viridis(100), range=lim_bsi)
plot(bsi25, main="BSI 2025", col=viridis(100), range=lim_bsi)

dev.off()

#################################
# Analisi multitemporale

# Visualizzazione RGB

im.multiframe (2,5)

# plot RGB, colori naturali 2015
im.plotRGB(gutturu15, r=3, g=2, b=1, title = "Colori naturali (2015)")

# plot RGB, colori naturali 2018
im.plotRGB(gutturu20, r=3, g=2, b=1, title = "Colori naturali (2020)")

# plot RGB, colori naturali 2020
im.plotRGB(gutturu18, r=3, g=2, b=1, title = "Colori naturali (2018)")

# plot RGB, colori naturali 2022
im.plotRGB(gutturu22, r=3, g=2, b=1, title = "Colori naturali (2022)")

# plot RGB, colori naturali 2025
im.plotRGB(gutturu25, r=3, g=2, b=1, title = "Colori naturali (2025)")

# plot RGB, nir in red 2015
im.plotRGB(gutturu15, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2015)")

# plot RGB, nir in red 2018
im.plotRGB(gutturu18, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2018)")

# plot RGB, nir in red 2020
im.plotRGB(gutturu20, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2020)")

# plot RGB, nir in red 2022
im.plotRGB(gutturu22, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2022)")

# plot RGB, nir in red 2025
im.plotRGB(gutturu25, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2025)")


dev.off()

### Differenze spettrali degli indici tra il 2015 e il 2025 (Delta)

# differenza DVI
dvi.diff <- dvi15 - dvi25

# differenza NDVI
ndvi.diff <- ndvi15 - ndvi25

# differenza NDMI
ndmi.diff <- ndmi15 - ndmi25

# differenza BSI
bsi.diff <- bsi15 - bsi25


# Visualizzazione dei tre risultati
im.multiframe(2,2)
plot(dvi.diff, main = "ΔDVI 2015-2025", col=magma(100))
plot(ndvi.diff, main = "ΔNDVI 2015-2025", col=magma(100))
plot(ndmi.diff, main = "ΔNDMI 2015-2025", col=magma(100))
plot(bsi.diff, main = "ΔBSI 2015-2025", col=magma(100))

### Ridge plot (per tutti gli indici e per tutti gli anni)

# DVI
  
dvi_ridg=c(dvi15, dvi18, dvi20, dvi22, dvi25)  
names(dvi_ridg) =c("DVI 2015", "DVI 2018", "DVI 2020", "DVI 2022", "DVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(dvi_ridg, scale=2, palette="magma")

# NDVI

ndvi_ridg=c(ndvi15, ndvi18, ndvi20, ndvi22, ndvi25)  
names(ndvi_ridg)=c("NDVI 2015", "NDVI 2018", "NDVI 2020", "NDVI 2022", "NDVI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndvi_ridg, scale=2, palette="magma")

# NDMI

ndmi_ridg=c(ndmi15, ndmi18, ndmi20, ndmi22, ndmi25)  
names(ndmi_ridg)=c("NDMI 2015", "NDMI 2018", "NDMI 2020", "NDMI 2022", "NDMI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndmi_ridg, scale=2, palette="magma")

# BSI

bsi_ridg=c(bsi15, bsi18, bsi20, bsi22, bsi25)  
names(bsi_ridg)=c("BSI 2015", "BSI 2018", "BSI 2020", "BSI 2022", "BSI 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(bsi_ridg, scale=2, palette="magma")

####################################################
####################################################
####################################################

# Analisi tra stagioni, anno 2025

# ripeto lo stesso procedimento, con il file riguardante il periodo di aprile-maggio 2025

# importare il raster

p25 <-rast("p25.tif")

# visualizzazione delle bande singole con funzione im.multiframe()
im.multiframe(2,3)
plot(p25[[1]], main = "B2 - Blue", col=cividis(100))
plot(p25[[2]], main = "B3 - Green", col=cividis(100))
plot(p25[[3]], main = "B4 - Red", col=cividis(100))
plot(p25[[4]], main = "B8 - NIR", col=cividis(100))
plot(p25[[5]], main = "B11 - SWIR", col=cividis(100))

dev.off()

# visualizzazione in RGB

im.multiframe(1,3)

# plot RGB, colori naturali 
im.plotRGB(p25, r=3, g=2, b=1, title = "Colori naturali (2025)")

# plot RGB, nir in red
im.plotRGB(p25, r=4, g=3, b=2, title = "Falsi colori: NIR in red (2025)")

# plot RGB, nir in blue
im.plotRGB(p25, r=3, g=2, b=4, title = "Falsi colori: NIR in blue (2025)")

dev.off()

ndmip <- (p25[[4]]-p25[[5]])/(p25[[4]]+p25[[5]])

lim_ndmi2 <- range(values(c(ndmip, ndmi25)),
                  na.rm = TRUE)

# Plottaggio insieme NDMI
im.multiframe(1,2)
plot(ndmip, main="NDMI primavera 2025", col=viridis(100), range=lim_ndmi2)
plot(ndmi25, main="NDMI estate 2025", col=viridis(100), range=lim_ndmi2)

ndmi.diff <- ndmip-ndmi25
plot(ndmi.diff, main = "ΔNDMI primavera-estate", col=magma(100))

ndmip_ridg=c(ndmip, ndmi25)  
names(ndmip_ridg)=c("NDMI primavera 2025", "NDMI estate 2025") # Per assegnare i nomi alle due immagini del vettore
# Applicazione della funzione im.ridgeline del pacchetto imageRy
im.ridgeline(ndmip_ridg, scale=2, palette="magma")


# Matrice di classificazione NDMI
class_matrix <- matrix(c(
  -Inf, 0.00, 1,   # Stress idrico elevato
   0.00, 0.20, 2,  # Stress idrico moderato
   0.20, 0.40, 3,  # Buono stato idrico
   0.40, Inf, 4    # Elevato contenuto idrico
), ncol = 3, byrow = TRUE)

# Classificazione 15-25
ndmi15_cl <- classify(ndmi15, class_matrix)
ndmi25_cl <- classify(ndmi25, class_matrix)

# plottaggio

im.multiframe(1,2)
plot(ndmi15_cl,
     col = c("red", "orange", "yellowgreen", "darkgreen"),
     main = "NDMI classificato 2015")

plot(ndmi25_cl,
     col = c("red", "orange", "yellowgreen", "darkgreen"),
     main = "NDMI classificato 2025")  

# Percentuali
freq_2015 <- freq(ndmi15_cl)
freq_2025 <- freq(ndmi25_cl)

perc_2015 <- freq_2015$count * 100 / ncell(ndmi15_cl)
perc_2025 <- freq_2025$count * 100 / ncell(ndmi25_cl)

# Creazione tabella
tabout <- data.frame(
  Classe = c("Stress elevato",
             "Stress moderato",
             "Buono stato idrico",
             "Elevato contenuto idrico"),
  NDMI2015 = round(perc_2015, 2),
  NDMI2025 = round(perc_2025, 2)
)

tabout

# Grafici

# 2015
ggplot(tabout, aes(x = Classe, y = NDMI2015, fill = Classe)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c(
    "Stress elevato" = "red",
    "Stress moderato" = "orange",
    "Buono stato idrico" = "yellowgreen",
    "Elevato contenuto idrico" = "darkgreen"
  )) +
  labs(title = "Classi NDMI 2015",
       x = "Classe",
       y = "Percentuale (%)")

# 2025
ggplot(tabout, aes(x = Classe, y = NDMI2025, fill = Classe)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c(
    "Stress elevato" = "red",
    "Stress moderato" = "orange",
    "Buono stato idrico" = "yellowgreen",
    "Elevato contenuto idrico" = "darkgreen"
      )) +
  labs(title = "Classi NDMI 2025",
       x = "Classe",
       y = "Percentuale (%)")


p1 <- ggplot(tabout, aes(x=Classe, y=NDMI2015, fill = Classe)) + # structure
   geom_bar(stat = "identity") +
  scale_fill_manual(values = c(
    "Stress elevato" = "red",
    "Stress moderato" = "orange",
    "Buono stato idrico" = "yellowgreen",
    "Elevato contenuto idrico" = "darkgreen"
      )) + # bar plot 
  ylim(c(0,20)) + # limits
  theme(legend.position="none")  # removing legend

p2 <- ggplot(tabout, aes(x=Classe, y=NDMI2025, fill=Classe)) + # structure
   geom_bar(stat = "identity") +
  scale_fill_manual(values = c(
    "Stress elevato" = "red",
    "Stress moderato" = "orange",
    "Buono stato idrico" = "yellowgreen",
    "Elevato contenuto idrico" = "darkgreen"
      )) + # bar plot
  ylim(c(0,20)) + # limits
  theme(legend.position="none")  # removing legend

p1 + p2 # si usa il pacchetto patchwork

















# Tabella
tabella <- data.frame(
  Classe = c("Stress elevato",
             "Stress moderato",
             "Buono stato idrico",
             "Elevato contenuto idrico"),
  NDMI_2015 = round(perc_2015, 2),
  NDMI_2025 = round(perc_2025, 2)
)

print(tabella)

# Grafico comparativo

library(reshape2)
library(ggplot2)

df_long <- melt(tabella,
                id.vars = "Classe",
                variable.name = "Anno",
                value.name = "Percentuale")

ggplot(df_long,
       aes(x = Classe,
           y = Percentuale,
           fill = Anno)) +

  geom_bar(stat = "identity",
           position = "dodge") +

  geom_text(aes(label = round(Percentuale,1)),
            position = position_dodge(width = 0.9),
            vjust = -0.25,
            size = 3) +

  scale_fill_manual(values = c("NDMI_2015" = "steelblue",
                               "NDMI_2025" = "darkgreen")) +

  ylim(0,100) +

  labs(title = "Confronto delle classi NDMI",
       x = "Classi NDMI",
       y = "Percentuale (%)") +

  theme_minimal()

im.multiframe(2,3)
hist(ndmi15,
     main = "NDMI 2015",
     xlab = "NDMI",
     col = "steelblue")

hist(ndmi18,
     main = "NDMI 2018",
     xlab = "NDMI",
     col = "steelblue")

hist(ndmi20,
     main = "NDMI 2020",
     xlab = "NDMI",
     col = "steelblue")

hist(ndmi22,
     main = "NDMI 2022",
     xlab = "NDMI",
     col = "steelblue")

hist(ndmi25,
     main = "NDMI 2025",
     xlab = "NDMI",
     col = "steelblue")

