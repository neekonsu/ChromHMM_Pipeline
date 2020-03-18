#!/bin/sh
#Set Directory vars: CLF=ChromosomeLengthFile IBD=InputBedDir CMFT=CellMarksFileTable OBD=OutputBedDir
COMPRESSED="/usr/src/app/DATA/compressed/"
CLF="/usr/src/app/ChromHMM/CHROMSIZES/hg19.txt"
IBD="/usr/src/app/DATA/raw/"
CMFT="/usr/src/app/DATA/CELLMARKFILETABLE/CMFT.txt"
OBD="/usr/src/app/DATA/binarized/"

#Check if compressed directory is empty
if [ "$(ls -A $COMPRESSED)" ]; then
  echo "✗ $COMPRESSED is not Empty, skipping dataset retreival"
  sleep 1
else
  echo "$DIR is Empty, retreiving dataset"
  sleep 1
  #Pull BED files from repositories; into /usr/src/app/DATA/compressed
  wget -P $COMPRESSED -i /usr/src/app/DATA/sources.config
  sleep .5
  echo "✓ Finished retreival, decompressing into $IBD"
  sleep 1
  #Extract BED files from compressed format; from /usr/src/app/DATA/compressed/ to /usr/src/app/DATA/raw/
  for f in /usr/src/app/DATA/compressed/*.gz; do
    STEM=$(basename "${f}" .gz)
    gunzip -c "${f}" > /usr/src/app/DATA/raw/"${STEM}"
    echo "✓ ${f} decompressed"
  done
fi


#Binarize BED files from raw format
java -mx4000M -jar /usr/src/app/ChromHMM/ChromHMM.jar BinarizeBed chromosomelengthfile "/usr/src/app/ChromHMM/CHROMSIZES/hg19.txt" inputbeddir "/usr/src/app/DATA/raw/" cellmarkfiletable "/usr/src/app/DATA/CELLMARKFILETABLE/CMFT.txt" outputbinarydir "/usr/src/app/DATA/binarized/"

#Learn ChromHMM model with default parameters
java -mx1600M -jar /usr/src/app/ChromHMM/ChromHMM.jar LearnModel /usr/src/app/DATA/BINARIZED/ OUTPUTSAMPLE 15 hg19