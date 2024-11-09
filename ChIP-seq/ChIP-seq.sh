for i in ChIP-DMSO ChIP-Flavo;do
	trim_galore -q 20 -j 7 --phred33 --stringency 3 --length 20 -e 0.1 --paired ${i}_R*fq.gz -o ./
	bowtie2 -p 60 --no-unal --no-mixed  --no-discordant --dovetail --very-sensitive --score-min L,0,-0.4 -X 1000 -x /mnt/disk4/bowtie2/hg38XY+mm10XY -1 ${i}_R1_val_1.fq.gz -2 ${i}_R2_val_2.fq.gz | samtools view -bh -q 10 > ${i}_q10.bam
	samtools sort -@ 40 -o ${i}_q10.sort.bam ${i}_q10.bam
	java -jar /mnt/disk1/6/share/software/picard.jar MarkDuplicates -REMOVE_DUPLICATES true --VALIDATION_STRINGENCY SILENT -I ${i}_q10.sort.bam -O ${i}_q10_markdup_DIS10k.bam -M ${i}_DIS10k.metrics --OPTICAL_DUPLICATE_PIXEL_DISTANCE 10000 --MAX_OPTICAL_DUPLICATE_SET_SIZE 300000 --TAGGING_POLICY All > ${i}_DIS10k.log 2>&1
	samtools sort -@ 30 -n -o ${i}_q10.sortn.bam ${i}_q10_markdup_DIS10k.bam
	bamToBed -bedpe -mate1 -i ${i}_q10.sortn.bam | awk '{if($9=="+"){print $1,int($2/2+$6/2)-100,int($2/2+$6/2)+100,$9} else{print $1,int($3/2+$5/2)-100,int($3/2+$5/2)+100,$9}}' OFS='\t' | awk '$1!~/chr[CLMTGKJ]/ && $2>=0' | sort -k1,1 -k2,2n -k4,4 -u -S 9G | cut -f 1-3 > ${i}_q10_all.bed
	grep -v 'Mm' ${i}_q10_all.bed > ${i}_q10.bed
	grep 'Mm' ${i}_q10_all.bed > ${i}_q10_Mm.bed
	num=$(cat ${i}_q10.bed | awk 'END{print FNR}')
	genomeCoverageBed -bg -i ${i}_q10.bed -g /ssd/genome/hg38_chromsize.txt | awk -va=$num '{$4=$4*1000000/a;print}' OFS='\t' > ${i}.bdg
	bedGraphToBigWig ${i}.bdg /ssd/genome/hg38_chromsize.txt ${i}.bw
done
computeMatrix reference-point -S ChIP-DMSO.bw ChIP-Flavo.bw -R /mnt/disk4/public/RefBed/refGene_hg38/hg38_TSS.bed --referencePoint center --beforeRegionStartLength 1000 --afterRegionStartLength 4000 --binSize 10 -o TSS.gz -p 40 --missingDataAsZero
plotProfile -m TSS.gz -o TSS.png --refPointLabel 'TSS' --samplesLabel  ChIP-DMSO ChIP-Flavo --perGroup
done
