#!/bin/sh

CLF="toBeDetermined"
IBD="../Data/raw/"
CMFT="toBeDetermined"
OBD="../Data/binarized/"

#Pull BED files from repositories
wget -P ../Data/compressed ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM621nnn/GSM621387/suppl/GSM621387_BI.Fetal_Lung.H3K36me3.UW_H-22727.bed.gz

#Extract BED files from compressed format
for f in ../Data/compressed/*.gz; do
  STEM=$(basename "${f}" .gz)
  gunzip -c "${f}" > ../Data/raw/"${STEM}"
done

#Binarize BED files from raw format

java -mx4000M -jar ../ChromHMM/ChromHMM.jar BinarizeBed chromosomelengthfile $CLF inputbeddir $IBD cellmarkfiletable $CMFT outputbinarydir $OBD
