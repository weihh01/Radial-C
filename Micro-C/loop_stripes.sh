/opt/HiC-Pro-3.0.0/bin/utils/hicpro2higlass.sh -i MNase-20min.dedup.allValidPairs -r 5000 -c hg38_chromsize_min.txt -p 30
mustache -f MNase-20min.dedup.cool -r 5000 --pThreshold 0.1 -p 20 -o MNase-20min_5kb.bedpe
stripenn compute --cool MNase-20min.dedup.cool --out MNase-20min/