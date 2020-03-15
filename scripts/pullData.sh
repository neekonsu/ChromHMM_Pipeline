#!/bin/sh

CLF="toBeDetermined"
IBD="../Data/raw/"
CMFT="toBeDetermined"
OBD="../Data/binarized/"

#Pull BED files from repositories
wget -P ../DATA/compressed -i ../DATA/sources.config

#Extract BED files from compressed format
for f in ../Data/compressed/*.gz; do
  STEM=$(basename "${f}" .gz)
  gunzip -c "${f}" > ../Data/raw/"${STEM}"
done

#Binarize BED files from raw format

java -mx4000M -jar ../ChromHMM/ChromHMM.jar BinarizeBed chromosomelengthfile $CLF inputbeddir $IBD cellmarkfiletable $CMFT outputbinarydir $OBD
