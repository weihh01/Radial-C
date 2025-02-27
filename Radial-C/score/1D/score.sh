for i in MNase-1min MNase-5min MNase-20min;do
	awk '{if($2==$5)print$2"\t"$3"\t"$3+1"\n"$5"\t"$6"\t"$6+1}' OFS='\t' /mnt/disk4/whh/Radial_Micro-C/merge/${i}.dedup.allValidPairs > /mnt/disk4/whh/score/data/dedup/${i}.bed
	sort -k1,1 -k2,2n -k3,3n /mnt/disk4/whh/score/data/dedup/${i}.bed -S 150G > /mnt/disk4/whh/score/data/dedup/${i}.sort.bed
	bedtools intersect -a MNase-20min_100000_abs.bed -b /mnt/disk4/whh/score/data/dedup/${i}.sort.bed -wao -sorted > Hs_100kb_${i}.bed
	num=$(cat /mnt/disk4/whh/score/data/dedup/${i}.sort.bed | awk 'END{print FNR}')
	bedtools groupby -i Hs_100kb_${i}.bed -g 4 -c 8 -o count | awk -va=$num '{print$1,$2/a}' OFS='\t' > ${i}_count_100kb.bed
done

paste MNase_100000_abs.bed MNase-1min_count_100kb.bed MNase-5min_count_100kb.bed MNase-20min_count_100kb.bed | awk '{print$1,$2,$3,$4,$6,$8,$10,($8/$6)+($10/$8)}' OFS='\t' > Hs_100kb_1min_5min_20min_score.bed
