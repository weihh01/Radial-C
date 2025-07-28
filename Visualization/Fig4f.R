library(circlize)
library(data.table)

options(scipen = 100)
compartment<-fread("/mnt/disk2/2/zqf/private/radial/radial_bed/trans_oe/MNase-20min_in5_top_500_PC1.bed")
compartment$type[compartment$V5=="A"&compartment$V10=="A"]<-"AA"
compartment$type[compartment$V5=="B"&compartment$V10=="B"]<-"BB"
compartment$type[(compartment$V5=="A"&compartment$V10=="B")|(compartment$V5=="B"&compartment$V10=="A")]<-"AB"
compartment$color[compartment$type=="AA"]<-"#ff0000"
compartment$color[compartment$type=="BB"]<-"#281713"
compartment$color[compartment$type=="AB"]<-"#00a0ff"

table(compartment$type)
compartment<-compartment[sample(1:nrow(compartment),50),]


bed1<-compartment[,c(1:3)]
bed2<-compartment[,c(6:8)]
#bed1$value<-runif(100,-1,1)
pdf("/mnt/disk2/2/zqf/private/radial/radial_bed/trans_oe/MNase-20min_in5_top_500_PC1.pdf", 
    width = 5,height = 5,bg = "white")
circos.clear()
#par(cex=3,mar = c(0.1, 0.1, 0.1, 0.1))

circos.par(start.degree=90,gap.after=2)
#circos.genomicText(cex = 3)
circos.initializeWithIdeogram(species = "hg38",chromosome.index = paste0("chr", c(1:22,"X")),plotType = c( "ideogram","labels"),
                              axis.labels.cex = 0.5,
                              labels.cex = 1)

# circos.genomicLink(bed1, bed2, col =compartment$color , 
#                    border = compartment$color)
circos.genomicLink(bed1, bed2, col =compartment$color , 
                   border = compartment$color )


text(0.3,0.6,"A-B",col="#00a0ff",cex=1.5)
text(0.7,-0.15,"B-B",col="#281713",cex=1.5)
text(0.2,-0.7,"A-A",col="#ff0000",cex=1.5)

dev.off()  

#######################################################################################################################################
########################################################################################################################################
compartment<-fread("/mnt/disk2/2/zqf/private/radial/radial_bed/trans_oe/MNase-20min_out5_top_500_PC1.bed")
compartment$type[compartment$V5=="A"&compartment$V10=="A"]<-"AA"
compartment$type[compartment$V5=="B"&compartment$V10=="B"]<-"BB"
compartment$type[(compartment$V5=="A"&compartment$V10=="B")|(compartment$V5=="B"&compartment$V10=="A")]<-"AB"
compartment$color[compartment$type=="AA"]<-"#ff0000"
compartment$color[compartment$type=="BB"]<-"#281713"
compartment$color[compartment$type=="AB"]<-"#00a0ff"

table(compartment$type)
compartment<-compartment[sample(1:nrow(compartment),50),]


bed1<-compartment[,c(1:3)]
bed2<-compartment[,c(6:8)]
#bed1$value<-runif(100,-1,1)
pdf("/mnt/disk2/2/zqf/private/radial/radial_bed/trans_oe/MNase-20min_out5_top_500_PC1.pdf", 
    width = 5,height = 5,bg = "white")
circos.clear()
#par(cex=3,mar = c(0.1, 0.1, 0.1, 0.1))

circos.par(start.degree=90,gap.after=2)
#circos.genomicText(cex = 3)
circos.initializeWithIdeogram(species = "hg38",chromosome.index = paste0("chr", c(1:22,"X")),plotType = c( "ideogram","labels"),
                              axis.labels.cex = 0.5,
                              labels.cex = 1)

# circos.genomicLink(bed1, bed2, col =compartment$color , 
#                    border = compartment$color)
circos.genomicLink(bed1, bed2, col =compartment$color , 
                   border = compartment$color )


text(0.1,0.6,"A-B",col="#00a0ff",cex=1.5)
text(-0.7,0.2,"B-B",col="#281713",cex=1.5)
text(0.35,-0.6,"A-A",col="#ff0000",cex=1.5)

dev.off()  
