library(ggplot2)
library(viridis)
library(data.table)
library(dplyr)

PC1<-fread("/mnt/disk2/2/zqf/private/radial/histone_bed/CTCFmotif_layer_score.bed")[,c(7:9,11,5)]
chromosome_size<-fread("/ssd/genome/hg38_chromsize.txt")
chromosome_size<-chromosome_size[!grepl("_|Y|M",chromosome_size$V1),]



colnames(PC1)<-c("chrom","start","end","score","signal")

PC1$chrom<-factor(PC1$chrom,levels = paste("chr",c(4,3,2,1,"X",rev(c(5:22))),sep = ""))
#PC1$score<-(51-PC1$score)*0.02
PC1$score<-1-PC1$score

chr<-chromosome_size
chr$V1<-factor(chr$V1,levels = paste("chr",c(4,3,2,1,"X",rev(c(5:22))),sep = ""))
colnames(chr)<-c("chr","Freq")

chr_bed<-as.data.frame(table(PC1$chrom))
chr_bed$Var1<-as.character(chr_bed$Var1)
chr_all<-merge(chr,chr_bed,by.x="chr",by.y = "Var1")
colnames(chr_all)<-c("chr","chrom_size","bed_size")
chr_all$chr<-factor(chr_all$chr,levels = paste("chr",c(4,3,2,1,"X",rev(c(5:22))),sep = ""))
chr_all<-chr_all[order(chr_all$chr),]
#######
parameter<-0.5
a2<-parameter*pi/23
chr_all$region_length<-(2*pi-parameter*pi)*chr_all$chrom_size/sum(chr_all$chrom_size)

angle<-list()

s1<-0
for (i in 1:23) {
  
  s2<-s1+chr_all$region_length[i]
  
  
  tmp<-seq(s1,s2,chr_all$region_length[i]/chr_all$bed_size[i])
  tmp1<-sample(tmp,length(tmp)-1)
  angle[[i]]<-as.data.frame(cbind(cos=cos(tmp1),
                                  sin=sin(tmp1),
                                  mid_sin=sin((s1+s2)/2),
                                  mid_cos=cos((s1+s2)/2)))
  
  s1<-s1+chr_all$region_length[i]+a2
}

angle_1<-cbind(PC1,rbindlist(angle))





text_position_cos<-1.3*unique(angle_1$mid_cos)
text_position_sin<-1.3*unique(angle_1$mid_sin)
#text_position_chr<-paste("chr",c(1:22,"X"),sep = "")
paste("annotate('text',x=",text_position_cos,",y=",text_position_sin,",label=\"",chr_all$chr,
      "\",size=6)",sep = "",collapse = "+")%>%print(., quote = FALSE)


library(RColorBrewer)
colorRampPalette(brewer.pal(9,"Blues"))(6)
#angle_1$signal<-log2(angle_1$signal+0.01)
angle_2<-angle_1
length(angle_1$signal[angle_1$signal>=10])
length(angle_1$signal[angle_1$signal<=1])


angle_2$signal[angle_2$signal>=10]<-10

#angle_2<-angle_2[angle_2$signal>=1,]


ggplot(angle_2[sample(1:nrow(angle_2),20000),], aes((score+0.1)*cos,(score+0.1)*sin)) +
  geom_point(aes(color=signal),size = 0.05,alpha=1)+ 
  #geom_hline(yintercept=c(1,51),size=1,linetype="dotted",color="black")+
  #ggpubr::theme_pubclean()+#
  theme_bw()+
  #scale_y_continuous(expand = c(0,4),limits = c(0,51))+
  
  scale_color_gradientn(breaks=seq(0,10,2.5),
                        colours = colorRampPalette(brewer.pal(9,"Blues"))(5),
                        labels=seq(0,10,2.5),limits=c(0,10))+
  labs(color="CTCF")+
  scale_y_continuous(limits = c(-1.3,1.3))+
  theme_bw()+
  theme(legend.position = "right",
        panel.border = element_blank(),
        axis.ticks = element_blank(),
        axis.text=element_blank(),
        axis.title=element_blank(),
        panel.grid=element_blank(),
        legend.text=element_text( family="", colour="black", 
                                  size=16),
        legend.key.width = unit(20,"pt") ,
        legend.key.height = unit(20,"pt") ,
        legend.title = element_text( family="", colour="black", 
                                     size=16,vjust = 4)
  )+annotate('text',x=1.28581499731421,y=0.191519692673807,label="chr4",size=6)+annotate('text',x=1.12935158823526,y=0.643867214688313,label="chr3",size=6)+annotate('text',x=0.778369376505932,y=1.04122097256911,label="chr2",size=6)+annotate('text',x=0.247881845666461,y=1.2761483419215,label="chr1",size=6)+annotate('text',x=-0.247126587080991,y=1.2762948131046,label="chrX",size=6)+annotate('text',x=-0.530519322415156,y=1.18682317492715,label="chr22",size=6)+annotate('text',x=-0.695471081718444,y=1.09832598735229,label="chr21",size=6)+annotate('text',x=-0.856409322004892,y=0.978040425127265,label="chr20",size=6)+annotate('text',x=-1.00457032491374,y=0.825129360950572,label="chr19",size=6)+annotate('text',x=-1.13374685622225,y=0.636095956602592,label="chr18",size=6)+annotate('text',x=-1.23571580407252,y=0.403740574583983,label="chr17",size=6)+annotate('text',x=-1.2917753181677,y=0.146001806059887,label="chr16",size=6)+annotate('text',x=-1.29280472826049,y=-0.136586729177197,label="chr15",size=6)+annotate('text',x=-1.22728240771972,y=-0.428693237294091,label="chr14",size=6)+annotate('text',x=-1.08991387431155,y=-0.708581503133689,label="chr13",size=6)+annotate('text',x=-0.870346948321138,y=-0.965658422812168,label="chr12",size=6)+annotate('text',x=-0.573197491775339,y=-1.16680959690194,label="chr11",size=6)+annotate('text',x=-0.231857516283811,y=-1.27915678950733,label="chr10",size=6)+annotate('text',x=0.130525300470868,y=-1.29343076580735,label="chr9",size=6)+annotate('text',x=0.493371762430592,y=-1.20274033109235,label="chr8",size=6)+annotate('text',x=0.831761675125094,y=-0.999085840052344,label="chr7",size=6)+annotate('text',x=1.1071935619637,y=-0.681265305403222,label="chr6",size=6)+annotate('text',x=1.27159920076158,y=-0.270250758782506,label="chr5",size=6)

ggsave("/mnt/disk2/2/zqf/private/radial/CTCF_cutoff_0_10.pdf",width=6, height=5,units = "in",limitsize = F)






