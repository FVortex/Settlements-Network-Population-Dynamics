---
  title: "Dimensionality reduction for distance object describing settlement networks"
author: "Mikhail Orlov"
date: '6 ноября 2017 г '
output:
  html_document: default
pdf_document: default
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

Clearing workspace, setting working directory and loading R packages
```{r, message=FALSE}
rm(list=ls())



#loading data
load('/home/jane/Документы/Misha/sheludkov/Settlements-Network-Population-Dynamics/data/matrix_2002.Rdata')
load('/home/jane/Документы/Misha/sheludkov/Settlements-Network-Population-Dynamics/data/matrix_2010.Rdata')

#workspace loading
load("/home/jane/Документы/Misha/sheludkov/Settlements-Network-Population-Dynamics/data/Part2_output.RData")

#clusters labels

clusts_18_colors <- rainbow(18)[settlements_2002@data$clust_18]
clusts_6_colors <- rainbow(6)[settlements_2002@data$clust_6]

village_names <- settlements_2002@data$ShortName
#libraries

#1 MDS
fit_18_clusts <- cmdscale(dist_matrix_2002, eig = TRUE, k = 18)
x_18_clusts <- fit$points[, 1]
y_18_clusts <- fit$points[, 2]

fit_6_clusts <- cmdscale(dist_matrix_2002, eig = TRUE, k = 6)
x_6_clusts <- fit$points[, 1]
y_6_clusts <- fit$points[, 2]

#Then we visualise the result, which shows the positions of cities are very close to their relative locations on a map.
par(mfrow = c(2,1))
plot(x_18_clusts, y_18_clusts, pch = 19, xlim = range(x), col = clusts_18_colors, main = 'Multidimensional Scaling Visualization\n for 18 Clusters (2002 Data)')
#legend('topright', legend = paste('Cluster', 1:18), col = rainbow(18), lty = 1, cex= 0.5)
plot(x_6_clusts, y_6_clusts, pch = 19, xlim = range(x), col = clusts_6_colors, main = 'Multidimensional Scaling Visualization\n for 6 Clusters (2002 Data)')
#legend('topright', legend = paste('Cluster', 1:6), col = rainbow(6), lty = 1, cex= 0.5)
#text(x, y, pos = 4, labels = village_names)

#2 t-SNE

library(Rtsne)
tsne <- Rtsne(as.dist(dist_matrix_2002), dims = 2, perplexity=30, verbose=TRUE, max_iter = 500)

## Plotting
par(mfrow = c(2,1))
plot(tsne$Y, t='p',  col=clusts_18_colors, cex = 1, main = 't-SNE Visualization\n for 18 Clusters (2002 Data)')
plot(tsne$Y, t='p',  col=clusts_6_colors, cex = 1, main = 't-SNE Visualization\n for 6 Clusters (2002 Data)')
#text(tsne$Y, labels=village_names, col=clusts_6_colors, cex = 0.3)
