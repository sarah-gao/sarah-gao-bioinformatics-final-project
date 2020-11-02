# This function reads in a gff genome annotation file and add appropriate
# column names. It takes a single argument, which is the path to the gff file

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# NOTE it's worth checking how many lines to skip in the file, since they may
# be formatted differently. This is for the SARS-CoV-2 annotation file from
# NCBI as of November 1, 2020

read_gff <- function(gff_file_path) {

  # GFF files lack column names, so we need to add them here
  # skip first seven comment lines
  annotations <- read.table(file = gff_file_path,
                            skip = 7, # can adjust if needed depending on file
                            header = FALSE,
                            sep = "\t",
                            col.names = c("seqname",
                                          "source",
                                          "feature",
                                          "start",
                                          "end",
                                          "score",
                                          "strand",
                                          "frame",
                                          "attribute"))

  return(annotations)
}
