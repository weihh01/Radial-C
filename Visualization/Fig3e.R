library(ggplot2)
library(dplyr)
library(data.table)
library(RColorBrewer)
domain_AC<-fread("/mnt/disk2/2/zqf/private/radial/radial_bed/new/LAD/LaminAC_H3K9me3_score_layer_H3K9me3.bed")
domain_B1<-fread("/mnt/disk2/2/zqf/private/radial/radial_bed/new/LAD/LaminB1_H3K9me3_score_layer_H3K9me3.bed")
domain<-as.data.frame(rbind(cbind(domain_AC,Lamin_class="LaminAC"),cbind(domain_B1,Lamin_class="LaminB1")))

domain$Lamin_group<-paste(domain$Lamin_chrom,domain$Lamin_start,domain$Lamin_end,sep = "_")
domain_list<-split(domain,f=domain$Lamin_group)
domain_list<-domain_list[as.logical(lapply(domain_list, function(x){
  ifelse(sum((x[2:nrow(x),]$start-x[1:(nrow(x)-1),]$start)!=100000)==0,T,F)
}))]

domain<-rbindlist(domain_list)
domain<-domain[order(domain$Lamin_chrom,domain$Lamin_start,domain$chrom,domain$start),]

domain$order_num<-c(1:nrow(domain))
domain_1<-domain[,c(8,10,12,13,14)]

domain_1$score<-1-domain_1$score
Lamin_group_var<-as.data.frame(aggregate(domain_1$score,list(domain_1$Lamin_group),var))
Lamin_group_count<-as.data.frame(table(domain_1$Lamin_group))
domain_1<-merge(domain_1,Lamin_group_var,by.x = "Lamin_group",by.y = "Group.1")
domain_1<-merge(domain_1,Lamin_group_count,by.x = "Lamin_group",by.y = "Var1")

domain_2<-domain_1[between(domain_1$Freq,5,10),]
domain_2<-split(domain_2,domain_2$Lamin_group)

#
domain_3<-lapply(domain_2, function(x){
  if(mean(x$score[2:(nrow(x)-1)]) > x$score[1] & mean(x$score[2:(nrow(x)-1)]) > x$score[nrow(x)] & 
     mean(x$H3K9me3[2:(nrow(x)-1)]) > x$H3K9me3[1] & mean(x$H3K9me3[2:(nrow(x)-1)]) > x$H3K9me3[nrow(x)] ){
    as.data.frame(cbind(x,outward=T))
  }else {
    as.data.frame(cbind(x,outward=F))
  }
})

domain_3<-rbindlist(domain_3)

domain_3<-domain_3[domain_3$outward,]

domain_4<-domain_3[domain_3$x < 0.001,]


domain_4<-domain_4[order(domain_4$Lamin_group,domain_4$order_num),]
domain_4$order_num<-c(1:nrow(domain_4))
print(length(unique(domain_4$Lamin_group)))

print(quantile(domain_4$H3K9me3))
#domain_4$H3K9me3[domain_4$H3K9me3>0.1]<-0.1

domain_4_AC<-domain_4[domain_4$Lamin_class=="LaminAC",]
domain_4_B1<-domain_4[domain_4$Lamin_class=="LaminB1",]
domain_4_AC$order_num<-c(1:nrow(domain_4_AC))
domain_4_B1$order_num<-c(1:nrow(domain_4_B1))


domain_4_AC_avg<-aggregate(domain_4_AC$H3K9me3,by=list(domain_4_AC$Lamin_group),mean)
domain_4_B1_avg<-aggregate(domain_4_B1$H3K9me3,by=list(domain_4_B1$Lamin_group),mean)
domain_4_AC_avg<-domain_4_AC_avg[order(-domain_4_AC_avg$x),]
domain_4_B1_avg<-domain_4_B1_avg[order(domain_4_B1_avg$x),]


#domain_4_AC<-domain_4_AC[domain_4_AC$Lamin_group%in%unique(domain_4_AC$Lamin_group)[c(7,8,9)],]
domain_4_AC<-domain_4_AC[domain_4_AC$Lamin_group%in%domain_4_AC_avg$Group.1[1:3],]

domain_4_AC$order_num<-c(1:nrow(domain_4_AC))
#domain_4_B1<-domain_4_B1[domain_4_B1$Lamin_group%in%unique(domain_4_B1$Lamin_group)[c(2,3,4)],]

#domain_4_B1<-domain_4_B1[domain_4_B1$Lamin_group%in%unique(domain_4_B1$Lamin_group)[c(3,4,8)],]
domain_4_B1<-domain_4_B1[domain_4_B1$Lamin_group%in%domain_4_B1_avg$Group.1[4:6],]
domain_4_B1$order_num<-c(1:nrow(domain_4_B1))



domain_5<-as.data.frame(rbind(domain_4_AC,domain_4_B1))
domain_5$Lamin_group<-factor(domain_5$Lamin_group,levels =c(unique(domain_4_AC$Lamin_group)[1],unique(domain_4_B1$Lamin_group)[1],unique(domain_4_AC$Lamin_group)[2],
                                                        unique(domain_4_B1$Lamin_group)[2],unique(domain_4_AC$Lamin_group)[3],unique(domain_4_B1$Lamin_group)[3]) )
domain_5<-domain_5[order(domain_5$Lamin_group),]
a=0.8/6

c=0.2/6





domain_5$order_num<-c(seq(0,a,length.out=10),seq(a+c,2*a+c,length.out=6),seq(2*a+2*c,3*a+2*c,length.out=8),
                      seq(3*a+3*c,4*a+3*c,length.out=8),seq(4*a+4*c,5*a+4*c,length.out=8),seq(5*a+5*c,6*a+5*c,length.out=10))



ggplot(domain_4_AC, aes(order_num,score)) +
  geom_hline(yintercept=c(0,1),size=1,linetype="dotted",color="grey")+
  geom_line(aes(lty=Lamin_group),color="grey",size=1)+geom_point(aes(color=H3K9me3),size = 2.5,alpha=1)+
  coord_polar()+  scale_color_gradientn(breaks=seq(0,0.2,0.05),
                                        colours =colorRampPalette(brewer.pal(9,"Blues"))(5),
                                        labels=seq(0,0.2,0.05),limits=c(0,0.2))



ggplot(domain_5, aes(order_num,score)) +
  geom_hline(yintercept=c(0,1),size=1,linetype="dotted",color="grey")+
  geom_line(aes(lty=Lamin_group),color="#696969",size=1)+
  # geom_point(aes(color=H3K9me3,shape=Lamin_class),size = 3,alpha=1)+ 
  geom_point(aes(color=H3K9me3),size = 3,alpha=1)+
  #geom_vline(xintercept=domain_2$order_num,size=0.2,linetype="solid",color="black")+
  
  #ggpubr::theme_pubclean()+#
  theme_bw()+#scale_linetype_discrete(,guide="none")+
  scale_linetype_manual(values=rep("solid",length(unique(domain_1$Lamin_group))),guide="none")+
  scale_shape_manual(values=c(16,17),name="")+
  #scale_y_continuous(expand = c(0,4),limits = c(0,51))+
  #scale_color_viridis(option = "H")+
  scale_color_gradientn(breaks=seq(0,0.2,0.05),
                        colours =colorRampPalette(brewer.pal(9,"Blues"))(5),
                        labels=seq(0,0.2,0.05),limits=c(0,0.2))+
  # scale_color_gradientn(breaks=c(-2,-1,0,1,2,3,4),
  #                       colours = c("#191970","#00469b","#871674","#cc3766","#f67255","#ffb54f","#f9f871"),
  #                       labels=c(-2,"",0,"",2,"",4),limits=c(-2,4))+
  
  #scale_color_gradient2(low = "#191970",high = "#b30000",midpoint = 0)+
  labs(color="H3K9me3")+coord_polar()+ggtitle("LAD")+
  scale_y_continuous(limits = c(0,1))+
  
  scale_x_continuous(limits = c(0,1))+
  theme(plot.title = element_text( family="", colour="black", 
                                   size=22,hjust = 0.5,vjust = -5 ),
        legend.position = "right",
        panel.border = element_blank(),
        axis.ticks = element_blank(),
        axis.text=element_blank(),
        axis.title=element_blank(),
        panel.grid=element_blank(),
        legend.text=element_text( family="", colour="black", 
                                  size=18),
        legend.key.width = unit(20,"pt") ,
        legend.key.height = unit(20,"pt") ,
        legend.title = element_text( family="", colour="black", 
                                     size=18,vjust = 4),
        plot.margin=unit(c(0.1,0.1,0.1,0.1),'cm')
  )

ggsave("/mnt/disk2/2/zqf/private/radial/radial_bed/new/LAD/LAD_LaminAC_LaminB1_H3K9me3.pdf",width=6, height=5,units = "in",limitsize = F)

