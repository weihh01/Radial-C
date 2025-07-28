library(circlize)
library(data.table)
options(scipen = 100)
#SON
bed_temp = generateRandomBed(nr = 1000)

path <- "/mnt/disk2/2/zqf/private/radial/radial_bed/trans_oe/bed/SON" ##文件目录
fileNames <- dir(path)  ##获取该路径下的文件名
filePath <- sapply(fileNames, function(x){ 
  paste(path,x,sep='/')})   ##生成读取文件路径

bed_all <- lapply(filePath, function(x){
  fread(file = x,header = F)
})

SON<-bed_all[[8]]


SON<-SON[SON$V1%in%c("chr1","chr2","chr3")&SON$V6%in%c("chr1","chr2","chr3"),]



SON_bed = bed_all[[9]][bed_all[[9]]$V1%in%c("chr1","chr2","chr3"),c(1:3,5)]

colnames(SON_bed)<-colnames(bed_temp)


H3K27ac_bed =bed_all[[1]][bed_all[[1]]$V1%in%c("chr1","chr2","chr3"),c(1:3,5)]


colnames(H3K27ac_bed)<-colnames(bed_temp)

H3K36me3_bed =bed_all[[3]][bed_all[[3]]$V1%in%c("chr1","chr2","chr3"),c(1:3,5)]


colnames(H3K36me3_bed)<-colnames(bed_temp)

H3K4me3_bed =bed_all[[4]][bed_all[[4]]$V1%in%c("chr1","chr2","chr3"),c(1:3,5)]


colnames(H3K4me3_bed)<-colnames(bed_temp)

bed1<-SON[,c(1:3)]
bed2<-SON[,c(6:8)]


#bed1$value<-runif(100,-1,1)
pdf("/mnt/disk2/2/zqf/private/radial/radial_bed/trans_oe/SON_AA.pdf", 
    width = 5,height = 5,bg = "white")
circos.clear()
#par(cex=3,mar = c(0.1, 0.1, 0.1, 0.1))

circos.par(start.degree=90,gap.after=2,track.margin=c(0.01,0.01))
#circos.genomicText(cex = 3)
circos.initializeWithIdeogram(species = "hg38",chromosome.index = paste0("chr", c(1:22,"X")),plotType ="labels",#plotType = c( "ideogram","labels"),
                              axis.labels.cex = 0.5,
                              labels.cex = 1)
circos.genomicTrack(bed,bg.border="grey", 
                    panel.fun = function(region, value, ...) {
                      circos.genomicRect(region, value, ytop.column = 1, ybottom = 0, 
                                         col = ifelse(value[[1]] > 0, "#FF8C00", "#4169E1"),
                                         border = ifelse(value[[1]] > 0, "#FF8C00", "#4169E1"), ...)
                      circos.lines(CELL_META$cell.xlim, c(0, 0), lty = 2, col = "#00000040")
                    })

circos.genomicLink(bed1, bed2, col ="#ff0000" , 
                   border = "#ff0000" )

dev.off() 

#LaminB1
bed_temp = generateRandomBed(nr = 100)

path <- "/mnt/disk2/2/zqf/private/radial/radial_bed/trans_oe/bed/LaminB1" ##文件目录
fileNames <- dir(path)  ##获取该路径下的文件名
filePath <- sapply(fileNames, function(x){ 
  paste(path,x,sep='/')})   ##生成读取文件路径

bed_all <- lapply(filePath, function(x){
  fread(file = x,header = F)
})

LaminB1<-bed_all[[1]]


LaminB1<-LaminB1[LaminB1$V1%in%paste0("chr", c(3,13,"X")) &
                   LaminB1$V6%in%paste0("chr", c(3,13,"X")),]



LaminB1_bed =bed_all[[6]][bed_all[[6]]$V1%in%paste0("chr", c(3,13,"X")),c(1:3,5)]


colnames(LaminB1_bed)<-colnames(bed_temp)


H3K27me3_bed =bed_all[[3]][bed_all[[3]]$V1%in%paste0("chr", c(3,13,"X")),c(1:3,5)]

colnames(H3K27me3_bed)<-colnames(bed_temp)

H3K9me3_bed =bed_all[[4]][bed_all[[4]]$V1%in%paste0("chr", c(3,13,"X")),c(1:3,5)]


colnames(H3K9me3_bed)<-colnames(bed_temp)

bed1<-LaminB1[,c(1:3)]
bed2<-LaminB1[,c(6:8)]

pdf("/mnt/disk2/2/zqf/private/radial/radial_bed/trans_oe/LaminB1_BB.pdf",
    width = 5,height = 5,bg = "white")
circos.clear()
#par(cex=3,mar = c(0.1, 0.1, 0.1, 0.1))

circos.par(start.degree=105,gap.degree=10,track.margin=c(0.01,0.01))
#circos.genomicText(cex = 3)
circos.initializeWithIdeogram(species = "hg38",chromosome.index = paste0("chr", c(21,3,13,"X")),plotType ="labels",#plotType = c( "ideogram","labels"),
                              axis.labels.cex = 0.5,
                              labels.cex = 1)

circos.genomicTrack(H3K9me3_bed,bg.border=NA, track.height=0.1,
                    panel.fun = function(region, value, ...) {
                      circos.genomicRect(region, value, ytop.column = 1, ybottom = 0,
                                         col = ifelse(value[[1]] >= 0, "#4d8075","#F5F5F5"),
                                         border = ifelse(value[[1]] >= 0, "#4d8075","#F5F5F5"), ...)
                      #circos.lines(CELL_META$cell.xlim, c(0, 0), lty = 2, col = "#00000040")
                    })
circos.genomicTrack(H3K27me3_bed,bg.border=NA, track.height=0.1,
                    panel.fun = function(region, value, ...) {
                      circos.genomicRect(region, value, ytop.column = 1, ybottom = 0,
                                         col = ifelse(value[[1]] >= 0, "#FF8C00","#F5F5F5"),
                                         border = ifelse(value[[1]] >= 0, "#FF8C00","#F5F5F5"), ...)
                      #circos.lines(CELL_META$cell.xlim, c(0, 0), lty = 2, col = "#00000040")
                    })
circos.genomicTrack(LaminB1_bed,bg.border=NA,
                    panel.fun = function(region, value, ...) {
                      circos.genomicRect(region, value, ytop.column = 1, ybottom = 0,
                                         col = ifelse(value[[1]] >= 0, "#000080","#F5F5F5"),
                                         border = ifelse(value[[1]] >= 0, "#000080","#F5F5F5"), ...)
                      #circos.lines(CELL_META$cell.xlim, c(0, 0), lty = 2, col = "#00000040")
                    })
circos.genomicLink(bed1, bed2, col ="#281713" ,
                   border = "#281713" )

dev.off()
