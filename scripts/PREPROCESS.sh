#!/bin/sh
#Set Directory vars: CLF=ChromosomeLengthFile IBD=InputBedDir CMFT=CellMarksFileTable OBD=OutputBedDir
CLF="../ChromHMM/CHROMSIZES/hg19.txt"
IBD="../DATA/raw/"
CMFT="../DATA/CELLMARKFILETABLE/CMFT.txt"
OBD="../DATA/binarized/"

#Pull BED files from repositories; into ../DATA/compressed
wget -P ../DATA/compressed -i ../DATA/sources.config

#Extract BED files from compressed format; from ../DATA/compressed/ to ../DATA/raw/
for f in ../DATA/compressed/*.gz; do
  STEM=$(basename "${f}" .gz)
  gunzip -c "${f}" > ../DATA/raw/"${STEM}"
done

#Binarize BED files from raw format

java -mx4000M -jar ../ChromHMM/ChromHMM.jar BinarizeBed chromosomelengthfile $CLF inputbeddir $IBD cellmarkfiletable $CMFT outputbinarydir $OBD
