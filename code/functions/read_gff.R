read_gff <- function(gff_file_path) {

  # GFF files lack column names, so we need to add them here
  # skip first two comment lines, which are:
  # sequence-region NC_006273.2 1 235646
  # species https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=10359
  annotations <- read.table(file = gff_file_path,
                            skip = 7,
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
