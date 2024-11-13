for i in MNase-1min_rep1;do
        trim_galore -q 20 -j 7 --phred33 --stringency 3 --length 20 -e 0.1 --paired ${i}_R*fq.gz -o ./
        cutadapt -a file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker.fa -A file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker.fa --rename='{id};{r1.adapter_name} {comment}' -j 10 --minimum-length=10 --json=trimLk/${i}.cutadapt.json --info-file=trimLk/${i}.tsv -o trimLk/${i}_R1_val_1_trimlinker.fq.gz -p trimLk/${i}_R2_val_2_trimlinker.fq.gz ${i}_R1_val_1.fq.gz ${i}_R2_val_2.fq.gz > trimLk/${i}.txt
        cutadapt -a file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker.fa -A file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker.fa --rename='{id};{r1.adapter_name} {comment}' -j 10 --minimum-length=10 --json=trimLk/${i}2.cutadapt.json --info-file=trimLk/${i}2.tsv -o trimLk/${i}_R1_val_1_trimlinker2.fq.gz -p trimLk/${i}_R2_val_2_trimlinker2.fq.gz trimLk/${i}_R1_val_1_trimlinker.fq.gz trimLk/${i}_R2_val_2_trimlinker.fq.gz > trimLk/${i}2.txt
        cutadapt -a file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker_AT.fa -A file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker_AT.fa --rename='{id};{r1.adapter_name} {comment}' -j 10 --minimum-length=10 --json=trimLk/${i}3.cutadapt.json --info-file=trimLk/${i}3.tsv -o trimLk/${i}_R1_val_1_trimlinker3.fq.gz -p trimLk/${i}_R2_val_2_trimlinker3.fq.gz trimLk/${i}_R1_val_1_trimlinker2.fq.gz trimLk/${i}_R2_val_2_trimlinker2.fq.gz > trimLk/${i}3.txt
        mkdir data_${i}
	cd data_${i}
	mkdir ${i}
	cd ..
	cp trimLk/${i}_R1_val_1_trimlinker3.fq.gz data_${i}/${i}/${i}_trimlinker3_1.fq.gz
	cp trimLk/${i}_R2_val_2_trimlinker3.fq.gz data_${i}/${i}/${i}_trimlinker3_2.fq.gz
	/opt/HiC-Pro-3.0.0/bin/HiC-Pro -c config-hicpro.txt -i data_${i}/ -o results_${i} -s mapping -s quality_checks
	/opt/HiC-Pro-3.0.0/bin/HiC-Pro -c config-hicpro.txt -i results_${i}/bowtie_results/bwt2 -o results_${i}/ -s proc_hic -s merge_persample -s quality_checks
done
