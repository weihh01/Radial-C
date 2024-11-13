for i in chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX;do
	java -jar /mnt/disk1/6/share/software/juicer_tools_1.22.01.jar dump oe NONE /mnt/disk4/whh/Radial_Micro-C/merge/MNase-1min.dedup.allValidPairs.hic ${i} ${i} BP 100000 MNase-1min_OE_${i}.txt
	java -jar /mnt/disk1/6/share/software/juicer_tools_1.22.01.jar dump observed NONE /mnt/disk4/whh/Radial_Micro-C/merge/MNase-1min.dedup.allValidPairs.hic ${i} ${i} BP 100000 MNase-1min_${i}.txt
        paste MNase-1min_OE_${i}.txt MNase-1min_${i}.txt | awk '{if($6>4)print int($1/100000),int($2/100000),$3}' OFS='\t' | grep -v NaN > MNase-1min_OE_${i}.bed
done


for i in chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX;do
	java -jar /mnt/disk1/6/share/software/juicer_tools_1.22.01.jar dump oe NONE /mnt/disk4/whh/Radial_Micro-C/merge/MNase-5min.dedup.allValidPairs.hic ${i} ${i} BP 100000 MNase-5min_OE_${i}.txt
	java -jar /mnt/disk1/6/share/software/juicer_tools_1.22.01.jar dump observed NONE /mnt/disk4/whh/Radial_Micro-C/merge/MNase-5min.dedup.allValidPairs.hic ${i} ${i} BP 100000 MNase-5min_${i}.txt
        paste MNase-5min_OE_${i}.txt MNase-5min_${i}.txt | awk '{if($6>4)print int($1/100000),int($2/100000),$3}' OFS='\t' | grep -v NaN > MNase-5min_OE_${i}.bed

done

for i in chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX;do
	java -jar /mnt/disk1/6/share/software/juicer_tools_1.22.01.jar dump oe NONE /mnt/disk4/whh/Radial_Micro-C/merge/MNase-20min.dedup.allValidPairs.hic ${i} ${i} BP 100000 MNase-20min_OE_${i}.txt
	java -jar /mnt/disk1/6/share/software/juicer_tools_1.22.01.jar dump observed NONE /mnt/disk4/whh/Radial_Micro-C/merge/MNase-20min.dedup.allValidPairs.hic ${i} ${i} BP 100000 MNase-20min_${i}.txt
        paste MNase-20min_OE_${i}.txt MNase-20min_${i}.txt | awk '{if($6>4)print int($1/100000),int($2/100000),$3}' OFS='\t' | grep -v NaN > MNase-20min_OE_${i}.bed
done
