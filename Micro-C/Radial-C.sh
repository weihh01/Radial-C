for i in MNase-1min_rep1;do
	trim_galore -q 20 -j 7 --phred33 --stringency 3 --length 20 -e 0.1 --paired ${i}_R*fq.gz -o ./
	~/miniconda3/bin/cutadapt -a file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker.fa -A file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker.fa --rename='{id};{r1.adapter_name} {comment}' -j 20 --minimum-length=10 -o trimLk/${i}_R1_val_1_trimlinker.fq.gz -p trimLk/${i}_R2_val_2_trimlinker.fq.gz ${i}_R1_val_1.fq.gz ${i}_R2_val_2.fq.gz > trimLk/${i}.txt
        ~/miniconda3/bin/cutadapt -a file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker.fa -A file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker.fa --rename='{id};{r1.adapter_name} {comment}' -j 20 --minimum-length=10 -o trimLk/${i}_R1_val_1_trimlinker2.fq.gz -p trimLk/${i}_R2_val_2_trimlinker2.fq.gz trimLk/${i}_R1_val_1_trimlinker.fq.gz trimLk/${i}_R2_val_2_trimlinker.fq.gz > trimLk/${i}2.txt
        ~/miniconda3/bin/cutadapt -a file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker_AT.fa -A file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker_AT.fa --rename='{id};{r1.adapter_name} {comment}' -j 20 --minimum-length=10 -o trimLk/${i}_R1_val_1_trimlinker3.fq.gz -p trimLk/${i}_R2_val_2_trimlinker3.fq.gz trimLk/${i}_R1_val_1_trimlinker2.fq.gz trimLk/${i}_R2_val_2_trimlinker2.fq.gz > trimLk/${i}3.txt
        #~/miniconda3/bin/cutadapt -a file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker_AT.fa -A file:/home/whh/private/linker_micro-c/linker/MicroC_S-linker_AT.fa --rename='{id};{r1.adapter_name} {comment}' -j 20 --minimum-length=10 -o trimLk/${i}_R1_val_1_trimlinker4.fq.gz -p trimLk/${i}_R2_val_2_trimlinker4.fq.gz trimLk/${i}_R1_val_1_trimlinker3.fq.gz trimLk/${i}_R2_val_2_trimlinker3.fq.gz > trimLk/${i}4.txt
	mkdir data_${i}
	cd data_${i}
	mkdir ${i}
	cd ..
	cp trimLk/${i}_R1_val_1_trimlinker3.fq.gz data_${i}/${i}/${i}_trimlinker3_1.fq.gz
	cp trimLk/${i}_R2_val_2_trimlinker3.fq.gz data_${i}/${i}/${i}_trimlinker3_2.fq.gz
	/opt/HiC-Pro-3.0.0/bin/HiC-Pro -c config-hicpro.txt -i data_${i}/ -o results_${i} -s mapping -s quality_checks
	/opt/HiC-Pro-3.0.0/bin/HiC-Pro -c config-hicpro.txt -i results_${i}/bowtie_results/bwt2 -o results_${i}/ -s proc_hic -s merge_persample -s quality_checks
	cat results_${i}/hic_results/data/${i}/${i}_trimlinker4_hg38XX.bwt2pairs.validPairs  | awk -F "\t|;" '{$11=$2;print $1";"$2"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12"\t"$13"\t"$14"\t"$15}' | sort -T tmp -S 10% -k2,2V -k3,3n -k5,5V -k6,6n -k8,8 | awk -F "\t|;" 'BEGIN{c1=0;c2=0;s1=0;s2=0;a1=0}(c1!=$3 || c2!=$6 || s1!=$4 || s2!=$7 || a1!= $2){print;c1=$3;c2=$6;s1=$4;s2=$7;a1=$2}' > ${i}.allValidPairs
done
