library(ggplot2)
library(dplyr)
library(data.table)
library(RColorBrewer)
domain_0_02<-fread("/mnt/disk2/2/zqf/private/radial/radial_bed/new/SON/SON_0-0.5_H3K27ac_score_layer_H3K27ac.bed")
domain_05_1<-fread("/mnt/disk2/2/zqf/private/radial/radial_bed/new/SON/SON_0.5-1_H3K27ac_score_layer_H3K27ac.bed")
domain<-as.data.frame(rbind(cbind(domain_0_02,son_class=0),cbind(domain_05_1,son_class=5)))

domain$son_group<-paste(domain$SON_chrom,domain$SON_start,domain$SON_end,sep = "_")
domain_list<-split(domain,f=domain$son_group)
domain_list<-domain_list[as.logical(lapply(domain_list, function(x){
  ifelse(sum((x[2:nrow(x),]$start-x[1:(nrow(x)-1),]$start)!=100000)==0,T,F)
}))]

domain<-rbindlist(domain_list)
domain<-domain[order(domain$SON_chrom,domain$SON_start,domain$chrom,domain$start),]

domain$order_num<-c(1:nrow(domain))
domain_1<-domain[,c(8,10,12,13,14)]

domain_1$score<-1-domain_1$score
son_group_var<-as.data.frame(aggregate(domain_1$score,list(domain_1$son_group),var))
son_group_count<-as.data.frame(table(domain_1$son_group))
domain_1<-merge(domain_1,son_group_var,by.x = "son_group",by.y = "Group.1")
domain_1<-merge(domain_1,son_group_count,by.x = "son_group",by.y = "Var1")

domain_2<-domain_1[between(domain_1$Freq,5,10),]
domain_2<-split(domain_2,domain_2$son_group)

#& mean(x$H3K27ac[2:(nrow(x)-1)]) < x$H3K27ac[1] & mean(x$H3K27ac[2:(nrow(x)-1)]) < x$H3K27ac[nrow(x)]
domain_3<-lapply(domain_2, function(x){
  if(mean(x$score[2:(nrow(x)-1)]) < x$score[1] & mean(x$score[2:(nrow(x)-1)]) < x$score[nrow(x)] ){
    as.data.frame(cbind(x,inward=T))
  }else {
    as.data.frame(cbind(x,inward=F))
  }
})
domain_3<-rbindlist(domain_3)

domain_3<-domain_3[domain_3$inward,]

domain_4<-domain_3[domain_3$x < 0.015,]


domain_4<-domain_4[order(domain_4$son_group,domain_4$order_num),]
domain_4$order_num<-c(1:nrow(domain_4))
print(length(unique(domain_4$son_group)))

print(quantile(domain_4$H3K27ac))
domain_4$H3K27ac[domain_4$H3K27ac>0.2]<-0.2

domain_5<-domain_4[domain_4$son_group%in%unique(domain_4$son_group)[c(1,3,6,8,9,15)],]
domain_5$type<-ifelse(domain_5$son_group%in%unique(domain_4$son_group)[c(6,11)],"in","out")


domain_5$son_group<-factor(domain_5$son_group,levels = unique(domain_5$son_group)[c(1,2,5,3,6,4)])
domain_5<-domain_5[order(domain_5$son_group,domain_5$order_num),]
domain_5$order_num<-c(1:nrow(domain_5))

a=0.4
b=0.4
c=0.2
domain_5$order_num<-c(seq(0,a/3,length.out=6),seq(a/3+c/4,a/3+b/2+c/4,length.out=6),seq(a/3+b/2+c/4,2*a/3+b/2+c/4,length.out=7),
                      seq(2*a/3+b/2+2*c/4,2*a/3+b+2*c/4,length.out=6),seq(2*a/3+b+3*c/4,a+b+3*c/4,length.out=6))


domain_5$order_num<-c(seq(0,a/3,length.out=6),seq(a/3,a/3+b/2,length.out=6),seq(a/3+b/2,2*a/3+b/2,length.out=7),
                      seq(2*a/3+b/2,2*a/3+b,length.out=6),seq(2*a/3+b,a+b,length.out=6))


a=0.8/6

c=0.2/6

domain_5$order_num<-c(seq(0,a,length.out=6),seq(a+c,2*a+c,length.out=6),seq(2*a+2*c,3*a+2*c,length.out=6),
                      seq(3*a+3*c,4*a+3*c,length.out=7),seq(4*a+4*c,5*a+4*c,length.out=6),seq(5*a+5*c,6*a+5*c,length.out=6))



ggplot(domain_5, aes(order_num,score)) +
  geom_line(aes(lty=son_group),color="#696969",size=1)+
  #geom_line(aes(color=son_group),size=0.8)+
  geom_point(aes(color=H3K27ac),size = 3,alpha=1)+ 
  geom_hline(yintercept=c(0,1),size=1,linetype="dotted",color="grey")+
  #geom_vline(xintercept=domain_2$order_num,size=0.2,linetype="solid",color="black")+
  
  #ggpubr::theme_pubclean()+#
  theme_bw()+#scale_linetype_discrete(,guide="none")+
  scale_linetype_manual(values=rep("solid",length(unique(domain_1$son_group))),guide="none")+
  #scale_y_continuous(expand = c(0,4),limits = c(0,51))+
  #scale_color_viridis(option = "H")+
  scale_color_gradientn(breaks=seq(0,0.2,0.05),
                        colours =colorRampPalette(brewer.pal(9,"Blues"))(6)[2:6],
                        labels=seq(0,0.2,0.05),limits=c(0,0.2))+
  # scale_color_gradientn(breaks=c(-2,-1,0,1,2,3,4),
  #                       colours = c("#191970","#00469b","#871674","#cc3766","#f67255","#ffb54f","#f9f871"),
  #                       labels=c(-2,"",0,"",2,"",4),limits=c(-2,4))+
  
  #scale_color_gradient2(low = "#191970",high = "#b30000",midpoint = 0)+
  labs(color="H3K27ac")+coord_polar()+ggtitle("SON")+
  scale_y_continuous(limits = c(0,1))+
  scale_x_continuous(limits = c(0,1))+
  #scale_x_continuous(limits = c(0,42))+
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
ggsave("/mnt/disk2/2/zqf/private/radial/radial_bed/new/SON/son_H3K27ac.pdf",width=6, height=5,units = "in",limitsize = F)








