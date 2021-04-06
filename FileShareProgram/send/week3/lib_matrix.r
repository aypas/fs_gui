library(Cairo)
library(matlab)
setwd("C:\\Users\\tecim\\Desktop\\proj\\rr\\week3")
#matlab is for transforming matrices
#cairo is for exporting images as pdf

#by default, when you image a matrix, r rotates it counter-clockwise by 90 degrees!!!
#hence, if you want the image to be consistent with the data structure
#use rot90(data, 2)

mat <- matrix(seq(1,25), nrow=5)
cairo_pdf("matrices.pdf", height=10, width=10) #printing/exporting is always a two step process in r; this is part one
par(mfcol = c(2,2), pty="s")
image(mat)
image(rot90(flipud(mat),2))
image(rot90(mat))
image(rot90(fliplr(mat),2))
dev.off()#part 2