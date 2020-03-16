#!/bin/sh
#Set Directory vars: CLF=ChromosomeLengthFile IBD=InputBedDir CMFT=CellMarksFileTable OBD=OutputBedDir
CLF="/usr/src/app/ChromHMM/CHROMSIZES/hg19.txt"
IBD="/usr/src/app/DATA/raw/"
CMFT="/usr/src/app/DATA/CELLMARKFILETABLE/CMFT.txt"
OBD="/usr/src/app/DATA/binarized/"

#Pull BED files from repositories; into /usr/src/app/DATA/compressed
wget -P /usr/src/app/DATA/compressed -i /usr/src/app/DATA/sources.config

#Extract BED files from compressed format; from /usr/src/app/DATA/compressed/ to /usr/src/app/DATA/raw/
for f in /usr/src/app/DATA/compressed/*.gz; do
  STEM=$(basename "${f}" .gz)
  gunzip -c "${f}" > /usr/src/app/DATA/raw/"${STEM}"
done

#Binarize BED files from raw format

#java -mx4000M -jar /usr/src/app/ChromHMM/ChromHMM.jar BinarizeBed chromosomelengthfile $CLF inputbeddir $IBD cellmarkfiletable $CMFT outputbinarydir $OBD
