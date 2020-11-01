# ChromHMM_Pipeline
Docker Environment and file-structure for ChromHMM Pipeline
## To Run:
`$  docker pull neekonsu/pipeline:latest`
`$  docker run -it neekonsu/pipeline:latest`
`$  cd /usr/src/app/scripts`
`$  chmod +x PREPROCESSING.sh`
`$  ./PREPROCESSING.sh`

# This project is an implementation of the following submodule
# metadata_to_cmft: prepare IHEC and Roadmap data for ChromHMM
(Scrape BED filenames and hyperlinks from GEO-NCBI ftp server)


In my project to format metadata downloaded from the IHEC portal, I created a tool for converting the rich metadata to concise tables listing relevant information to analyze datasets downloaded through the portal with common tools. In this project, I go one layer deeper and use the `LeanContext` tables from the `IHEC` repository to create Cell Mark File Tables (CMFTs), which are a dense representation of assays for binarizing data in ChromHMM (see <http://compbio.mit.edu/ChromHMM/ChromHMM_manual.pdf> for more information of CMFTs and binarization).

## Problem Statement
The ChromHMM pipeline has specific metadata requirements in order to function properly. The Cell Mark File Table, which it requires to condense ChIP-Seq datasets for analysis, is described as the following in ChromHMM's man page: 

    cellmarkfiletable – A tab delimited file each row contains the cell type or other identifier for a groups of marks,
    then the associated mark, then the name of a bed file, and optionally a corresponding control bed file
`
    (Cell) (Mark) (Assay File)    (Control File) ~> Hence "Cell Mark File Table"
    cell1  mark1 cell1_mark1.bed cell1_control.bed
    cell1  mark2 cell1_mark2.bed cell1_control.bed
    cell2  mark1 cell2_mark1.bed cell2_control.bed
    cell2  mark2 cell2_mark2.bed cell2_control.bed

In order to generate this metadata format, we need to sort our datasets by tissue type and pull the corresponding `.bed` files to determine the assay type (mark), the assay file, and the control file. Using the links from the `LeanContext` file that the `IHEC` script generates, we can select the data accession links to retreive our data repositories and thereby feed this program the information it needs to strip all the required metadata to generate a CMFT based on the `LeanContext`. This is a tedious process to execute manually, so I built this script both to help me as I use this data source for my research and to help others using the same, popular sources by saving substantial amounts of time.  

## To Run
    go build metadata_to_cmft.go && ./metadata_to_cmft "path/to/LeanContext.csv"

